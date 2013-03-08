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



angle();



module angle(){
	difference(){
		union(){

			// main body
			cube([frame_angle_side,frame_angle_side,frame_angle_width]);
		}

		// cut off
		hull(){
			translate([2*wall+wall,2*wall+(frame_screw_dia+2*clearance)+(((frame_screw_dia/2+clearance)+wall)/sin(45))+((frame_screw_dia/2+clearance)/sin(45)-(frame_screw_dia/2+clearance)),-1])
				cylinder(r=wall,h=frame_angle_width+2);
			translate([2*wall+(frame_screw_dia+2*clearance)+(((frame_screw_dia/2+clearance)+wall)/sin(45))+((frame_screw_dia/2+clearance)/sin(45)-(frame_screw_dia/2+clearance)),2*wall+wall,-1])
				cylinder(r=wall,h=frame_angle_width+2);
			translate([2*wall+wall,frame_angle_side+wall,-1])
				cylinder(r=wall,h=frame_angle_width+2);
			translate([frame_angle_side+wall,2*wall+wall,-1])
				cylinder(r=wall,h=frame_angle_width+2);
			translate([frame_angle_side+wall,frame_angle_side+wall,-1])
				cylinder(r=wall,h=frame_angle_width+2);

		}

		// frame mount screw holes
		for(i=[0,1])
			rotate([0,0,i*(-90)])
				mirror([i,0,0]){
					translate([frame_angle_side/2,frame_angle_side-(wall+clearance+frame_screw_dia/2),frame_angle_width-frame_width/2])
						teardrop(frame_screw_dia/2+clearance,frame_angle_side+2);
// for OLD version with two screws for each side
//					translate([frame_angle_side/2,frame_angle_side-(wall+clearance+frame_screw_dia/2+frame_screw_washer_dia/2+wall+frame_screw_washer_dia/2),frame_angle_width-frame_width/2])
//						teardrop(frame_screw_dia/2+clearance,frame_angle_side+2);
				}

		// frame enclosure mount hole + nut trap
		translate([2*wall+clearance+frame_screw_dia/2,2*wall+clearance+frame_screw_dia/2,frame_angle_width-frame_width-frame_screw_washer_thickness])
			cylinder(r=frame_screw_dia/2+clearance,h=frame_enclosure_screw_length);
		translate([2*wall+clearance+frame_screw_dia/2,2*wall+clearance+frame_screw_dia/2,frame_angle_width-frame_width+frame_enclosure_screw_length-frame_screw_washer_thickness-(frame_screw_nut_height+clearance+1)/2+1])
			rotate([0,0,-90])
				nut_trap(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
		translate([2*wall+clearance+frame_screw_dia/2,2*wall+clearance+frame_screw_dia/2,frame_angle_width-frame_width+frame_enclosure_screw_length-frame_screw_washer_thickness+(frame_screw_nut_height+2*clearance)/2])
			rotate([0,0,-90])
				nut_slot(frame_screw_nut_wrench,frame_screw_nut_height,frame_angle_side);

		// round corners
		for(i=[0,1])
			rotate([0,0,i*(-90)])
				mirror([i,0,0])
					translate([0,frame_angle_side,frame_angle_width])
						rotate([-90,0,0]) rotate([0,90,0])
							roundcorner(wall,frame_angle_side);

	}


}
