/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

License:
	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
	https://creativecommons.org/licenses/by-sa/4.0/

*******************************************************************/

include <configuration.scad>




// RENDER
rotate([0,-90,0]) y_motor_mount();




module y_motor_mount(){
	difference(){

		// main body
		translate([0,frame_width,-y_motor_mount_body_height+frame_width])
			hull(){
				translate([0,-wall,y_motor_mount_body_height-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-wall,wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-y_motor_mount_body_length+wall,y_motor_mount_body_height-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-y_motor_mount_body_length+wall,wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
			}

		// frame clearance
		translate([-1,0,0])
			cube([y_motor_mount_body_width+2,frame_width+1,frame_width+1]);

		// nema17 mount
		translate([2*wall,-nema17_width+frame_width-wall,-nema17_width-2*wall])
			cube([y_motor_mount_body_width,nema17_width,nema17_width]);
		translate([-1,frame_width-wall-nema17_width/2,-nema17_width/2-2*wall])
			rotate([0,90,0])
				cylinder(r=nema17_center_dia/2+clearance,h=y_motor_mount_body_width+2);
		translate([-1,frame_width-wall-nema17_width/2,-nema17_width/2-2*wall])
			for(j=[0:3])
				rotate([j*90,0,0])
					translate([0,nema17_hole_dist/2,nema17_hole_dist/2])
						rotate([0,90,0])
							cylinder(r=nema17_screw_dia/2+clearance,h=y_motor_mount_body_width+2);

		// frame mount holes
		translate([wall+clearance+frame_screw_head_flange_dia/2,0,0]){
			hull(){
				translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
				translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2+2*wall])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
			}
			hull(){
				translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
				translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2+2*wall])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
			}
		}
		translate([y_motor_mount_body_width-(wall+clearance+frame_screw_head_flange_dia/2),0,0]){
			hull(){
				translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
				translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2+2*wall])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
			}
			hull(){
				translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
				translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2+2*wall])
					rotate([0,0,90])
						rotate([90,0,0])
							teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
			}
		}
	}
}


