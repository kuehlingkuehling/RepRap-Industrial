/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

Licensed under:
	Creative Commons Attribution-ShareAlike
	CC BY-SA 3.0
	http://creativecommons.org/licenses/by-sa/3.0/

*******************************************************************/

include <configuration.scad>

y_motor_top_body_width = 2*frame_washer_wall+2*clearance+2*frame_screw_dia+2*wall+2*clearance+belt_tensioning_screw_head_wrench;
y_motor_top_body_length = wall+cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)+wall;
y_motor_top_body_height = frame_width-frame_enclosure_thickness-clearance;



rotate([-90,0,0])
y_motor_top();




module y_motor_top(){

	difference(){

		// main body
		hull(){
			translate([-y_motor_top_body_width/2+wall,0,wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_motor_top_body_length);
			translate([y_motor_top_body_width/2-wall,0,wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_motor_top_body_length);
			translate([-y_motor_top_body_width/2+wall,0,y_motor_top_body_height-wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_motor_top_body_length);
			translate([y_motor_top_body_width/2-wall,0,y_motor_top_body_height-wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_motor_top_body_length);
		}

		// frame screw holes
		translate([-y_motor_top_body_width/2+frame_washer_wall+clearance+frame_screw_dia/2,1,frame_width/2])
			rotate([90,0,0])
				cylinder(r=frame_screw_dia/2+clearance,h=y_motor_top_body_length+2);
		translate([-(-y_motor_top_body_width/2+frame_washer_wall+clearance+frame_screw_dia/2),1,frame_width/2])
			rotate([90,0,0])
				cylinder(r=frame_screw_dia/2+clearance,h=y_motor_top_body_length+2);

		// belt tensioner screw head trap
		translate([0,-wall-cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,2*wall])
			rotate([0,0,30])
				cylinder(r=cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,h=clearance+belt_tensioning_screw_head_wrench_length+clearance+belt_tensioning_screw_head_wrench_length+clearance,$fn=6);
		translate([-(belt_tensioning_screw_head_wrench+2*clearance)/2,-y_motor_top_body_length-wall-cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,2*wall+clearance+belt_tensioning_screw_head_wrench_length])
			cube([belt_tensioning_screw_head_wrench+2*clearance,y_motor_top_body_length,2*clearance+belt_tensioning_screw_head_wrench_length]);
		translate([0,-wall-cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,-1])
			cylinder(r=belt_tensioning_screw_dia/2+clearance,h=clearance+belt_tensioning_screw_head_wrench_length+clearance+belt_tensioning_screw_head_wrench_length+clearance+2*wall+1);
		translate([-(belt_tensioning_screw_dia+2*clearance)/2,-y_motor_top_body_length-wall-cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,-1])
			cube([belt_tensioning_screw_dia+2*clearance,y_motor_top_body_length,clearance+belt_tensioning_screw_head_wrench_length+clearance+belt_tensioning_screw_head_wrench_length+clearance+2*wall+1]);

	}
}


