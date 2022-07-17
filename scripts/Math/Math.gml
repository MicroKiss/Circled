function IsNear(n1, n2 = 0){
	return abs (n1 - n2) < 0.005;
}

/// @function               Distance(n1, n2);
/// @param  {Array<Real>} n1
/// @param  {Array<Real>} n2
function Distance(n1, n2){
	return point_distance (n1[0], n1[1], n2[0],n2[1]);
}


function Direction(n1, n2){
	return point_direction (n1[0], n1[1], n2[0],n2[1]);
}
