// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function GetInputs(deviceNumber, controls = undefined){
	inputs.moveRight = gamepad_axis_value(deviceNumber,gp_axislh) > .5;
	inputs.moveLeft = gamepad_axis_value(deviceNumber,gp_axislh) < -.5;
	inputs.moveDown = gamepad_axis_value(deviceNumber,gp_axislv) > .5;
	inputs.moveUp = gamepad_axis_value(deviceNumber,gp_axislv) < -.5;
	inputs.use = gamepad_button_check_pressed(deviceNumber,gp_face1); //A
	inputs.attack = gamepad_button_check_pressed(deviceNumber,gp_face3); //X
	
	if(controls != undefined) {
	inputs.moveRight |= keyboard_check(controls.moveRight);
	inputs.moveLeft |= keyboard_check(controls.moveLeft);
	inputs.moveDown |= keyboard_check(controls.moveDown);
	inputs.moveUp |= keyboard_check(controls.moveUp);
	inputs.use |= keyboard_check(controls.use);
	inputs.attack |= keyboard_check(controls.attack);
	}
}

global.myfriction = 3;
global.precision = 0.1;
function HandleMovement () {
	var additionalVsp = (inputs.moveDown - inputs.moveUp) * spd;
	var additionalHsp = (inputs.moveRight - inputs.moveLeft) * spd;


    var loopindex = ceil(global.deltaTime / global.precision);

    for (var i = 0; i < loopindex; i++) {
        var dT = global.deltaTime / loopindex;

		ax = -vx * global.myfriction;
		ay = -vy * global.myfriction;
		vx += (ax + additionalHsp) * dT ;
		vy += (ay + additionalVsp) * dT ;
		
		if (IsNear (vx))
			vx = 0;
		if (IsNear (vy))
			vy = 0;


	var maxDisplace = 5;
	var speedMultiplier = 50;
	
	if (vx !=0) {
		var tmpY = 0;
		if (place_meeting(x + vx * dT,y,Solid)) {
			if(!place_meeting(x+vx * dT,y+maxDisplace,Solid)) {
				tmpY = 2;
				while(place_meeting(x+vx * dT,y+tmpY,Solid)) {
					tmpY++;
				}
			} else if(!place_meeting(x+vx * dT,y-maxDisplace,Solid)) {
				tmpY = -2;
				while(place_meeting(x+vx * dT,y+tmpY,Solid)) {
					tmpY--;
				}
			} else
				vx = 0;
				
			if (tmpY != 0) {
				len = speedMultiplier*point_distance(0,0,vx * dT,tmpY);
				var dir = point_direction(0,0,vx * dT,tmpY);
				vx = lengthdir_x(len,dir) / 2 ;
				vy = lengthdir_y(len,dir) / 2 ;
			}
		}
	}

	if (vy != 0) {
		var tmpX = 0;
		if (place_meeting(x,y+vy * dT,Solid)) {
			if(!place_meeting(x+maxDisplace,y+vy * dT,Solid)) {
				tmpX = 2;
				while(place_meeting(x+tmpX,y+vy * dT,Solid)) {
					tmpX++;
				}
			} else if(!place_meeting(x-maxDisplace,y+vy * dT,Solid)) {
				tmpX = -2;
				while(place_meeting(x+tmpX,y+vy * dT,Solid)) {
					tmpX--;
				}
			} else
				vy = 0;
				
			if (tmpX != 0) {
				len = speedMultiplier*point_distance(0,0,tmpX,vy * dT);
				var dir = point_direction(0,0,tmpX,vy * dT);
				vx = lengthdir_x(len,dir) / 2;
				vy = lengthdir_y(len,dir) / 2;
			}
		}
	}
		if (vx != 0 && vy != 0) 
			lastDir = point_direction(0,0,vx,vy);
		x += vx * dT;
		y += vy * dT;
	}
}


function Unstuck () {
	var o = instance_place(x, y, Solid);
	if (o) {
		dir = point_direction (o.x,o.y,x,y);
		x += lengthdir_x (1,dir);
		y += lengthdir_y (1,dir);
	}
}



function HandleButtons () {
	if (inputs.use) {
		var button = instance_place(x, y, Button);
		if (button) {
		    with (button) {
			event_user(0);
			}
		}
	}

}


function HandleAttack () {
	if (inputs.attack && canAttack) {
		canAttack = false;
		alarm_set(0,room_speed)
		bullet = instance_create_depth(x,y,depth-1,BulletFriendly);
		bullet.dir = lastDir;
	}
}