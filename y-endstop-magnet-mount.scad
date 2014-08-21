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






// RENDERING
rotate([-90,0,0]) y_endstop_magnet_mount();






module y_endstop_magnet_mount(){
	difference(){

		// main body
		union(){
			hull(){
				translate([0,y_endstop_magnet_mount_body_length/2-wall,y_endstop_magnet_mount_body_height-wall])
					rotate([-90,0,0])
						teardrop(wall,y_endstop_magnet_mount_body_width);
				translate([0,y_endstop_magnet_mount_body_length/2-wall,wall])
					rotate([-90,0,0])
						teardrop(wall,y_endstop_magnet_mount_body_width);
				translate([0,-y_endstop_magnet_mount_body_length/2+wall,y_endstop_magnet_mount_body_height-wall])
					rotate([-90,0,0])
						teardrop(wall,y_endstop_magnet_mount_body_width);
				translate([0,-y_endstop_magnet_mount_body_length/2+wall,wall])
					rotate([-90,0,0])
						teardrop(wall,y_endstop_magnet_mount_body_width);
			}
		}

		// y rod clamp
		translate([0,0,wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia/2])
			rotate([-90,0,0])
				cylinder(r=rod_dia/2+clearance_tight,h=y_endstop_magnet_mount_body_length+2,center=true);
		cube([wall_thin,y_endstop_magnet_mount_body_length+2,2*(wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia/2)],center=true);

		// rod clamp screw hole and nut trap
		translate([0,0,wall+clearance+frame_screw_dia/2])
			rotate([90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_endstop_magnet_mount_body_width+2);
		translate([(frame_screw_nut_height+clearance+1)/2-y_endstop_magnet_mount_body_width/2-1,0,wall+clearance+frame_screw_dia/2])
			rotate([0,90,0])
				nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);

		// endstop magnet hole
		translate([0,-y_endstop_magnet_mount_body_length/2-1,wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia/2+linear_bearing_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall])
			rotate([-90,0,0])
				cylinder(r=endstop_magnet_dia/2+clearance,h=endstop_magnet_length+1);
	}
}



