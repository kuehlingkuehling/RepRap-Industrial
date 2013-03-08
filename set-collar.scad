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



set_collar();



module set_collar(){
	difference(){
	
		// main body
		union(){
			cylinder(r=set_collar_body_dia/2, h=set_collar_body_height);
			translate([0,0,set_collar_body_height])
				cylinder(r1=z_spindle_dia/2+clearance+2*wall_thin, r2=z_spindle_dia/2+clearance+wall_thin, h=wall_thin);
		}
	
		// spindle hole
		translate([0,0,-1])
			cylinder(r=z_spindle_dia/2+clearance, h=set_collar_body_height+wall_thin+2);
	
		// slot
		translate([0,-wall_thin/2,-1])
			cube([set_collar_body_dia/2+1,wall_thin,set_collar_body_height+wall_thin+2]);
	
		// screw hole and nut trap
		translate([set_collar_body_dia/2-(set_collar_body_dia/2-z_spindle_dia/2-clearance)/2,0,set_collar_body_height/2]){
			rotate([0,0,90])
				teardrop(set_collar_screw_dia/2+clearance,set_collar_body_dia+2);
			translate([0,(set_collar_body_dia/2+1)/2+wall_thin/2+wall,0])
				rotate([0,0,90])
					teardrop(set_collar_screw_washer_dia/2+clearance,set_collar_body_dia/2+1);
			translate([0,-(set_collar_body_dia/2+1)/2-wall_thin/2-wall,0])
				rotate([90,0,0])
					rotate([0,0,30])
						nut_trap(set_collar_screw_nut_wrench,set_collar_body_dia/2+1);
		}
	
	}
}
