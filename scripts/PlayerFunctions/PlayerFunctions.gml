// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetInputs(deviceNumber, controls = undefined){
	inputs.moveRight = gamepad_axis_value(deviceNumber,gp_axislh) > .5;
	inputs.moveLeft = gamepad_axis_value(deviceNumber,gp_axislh) < -.5;
	inputs.moveDown = gamepad_axis_value(deviceNumber,gp_axislv) > .5;
	inputs.moveUp = gamepad_axis_value(deviceNumber,gp_axislv) < -.5;
	inputs.use = gamepad_button_check_pressed(deviceNumber,gp_face1) //A
	
	if(controls != undefined) {
	inputs.moveRight |= keyboard_check(controls.moveRight);
	inputs.moveLeft |= keyboard_check(controls.moveLeft);
	inputs.moveDown |= keyboard_check(controls.moveDown);
	inputs.moveUp |= keyboard_check(controls.moveUp);
	inputs.use |= keyboard_check(controls.use);
	}
}


function HandleMovement () {
	var additionalVsp = (inputs.moveDown - inputs.moveUp) * attributes.movSpeed;
	var additionalHsp = (inputs.moveRight - inputs.moveLeft) * attributes.movSpeed;

	var myfriction = 200;
	ax = -vx * myfriction * global.deltaTime;
	ay = -vy * myfriction * global.deltaTime;
	vx += (ax + additionalHsp) * global.deltaTime;
	vy += (ay + additionalVsp) * global.deltaTime;

	if (IsNear (vx))
		vx = 0;
	if (IsNear (vy))
		vy = 0;


	var maxDisplace = 5;
	
	if (vx !=0) {
		var tmpY = 0;
		if (place_meeting(x+vx,y,Solid)) {
			if(!place_meeting(x+vx,y+maxDisplace,Solid)) {
				tmpY = 2;
				while(place_meeting(x+vx,y+tmpY,Solid)) {
					tmpY++;
				}
			} else if(!place_meeting(x+vx,y-maxDisplace,Solid)) {
				tmpY = -2;
				while(place_meeting(x+vx,y+tmpY,Solid)) {
					tmpY--;
				}
			} else
				vx = 0;
				
			if (tmpY != 0) {
				len = point_distance(0,0,vx,tmpY);
				var dir = point_direction(0,0,vx,tmpY);
				vx = lengthdir_x(len,dir) / 2 * global.deltaTime;
				vy = lengthdir_y(len,dir) / 2 * global.deltaTime;
			}
		}
	}


	if (vy != 0) {
		var tmpX = 0;
		if (place_meeting(x,y+vy,Solid)) {
			if(!place_meeting(x+maxDisplace,y+vy,Solid)) {
				tmpX = 2;
				while(place_meeting(x+tmpX,y+vy,Solid)) {
					tmpX++;
				}
			} else if(!place_meeting(x-maxDisplace,y+vy,Solid)) {
				tmpX = -2;
				while(place_meeting(x+tmpX,y+vy,Solid)) {
					tmpX--;
				}
			} else
				vy = 0;
				
			if (tmpX != 0) {
				len = point_distance(0,0,tmpX,vy);
				var dir = point_direction(0,0,tmpX,vy);
				vx = lengthdir_x(len,dir) / 2 * global.deltaTime;
				vy = lengthdir_y(len,dir) / 2 * global.deltaTime;
			}
		}
	}

	x += vx;
	y += vy;
}


function HandleButtons () {
	if(inputs.use) {
		var button = instance_place(x, y, Button);
		if (button) {
		    with (button) {
			event_user(0);
			}
		}
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