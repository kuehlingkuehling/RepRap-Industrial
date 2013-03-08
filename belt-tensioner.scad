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

/***** IDLER SIDE (RIGHT) ************/
mirror([1,0,0]) belt_tensioner();

/***** MOTOR SIDE (LEFT) ************/
//belt_tensioner();

module belt_tensioner(){
	difference(){
		// main body
		translate([-belt_tensioner_width/2,0,0])
			cube([belt_tensioner_width,belt_tensioner_length,belt_tensioner_height]);

		// belt grip
		translate([belt_thickness_max/2,0,0]){
			translate([-belt_thickness_min,-1,belt_tensioner_height/2-belt_width/2-clearance])
				cube([2*belt_thickness_min+2*clearance,4*belt_tooth_periode+1,belt_tensioner_height+1]);
			for(i=[0:3])
				translate([-belt_thickness_max-clearance,belt_tooth_periode/2+i*belt_tooth_periode,belt_tensioner_height/2-belt_width/2-clearance])
					cube([2*belt_thickness_max+2*clearance,belt_tooth_periode/2,belt_tensioner_height+1]);
			translate([0,belt_tooth_periode+3*belt_tooth_periode,belt_tensioner_height/2-belt_width/2-clearance])
				cylinder(r=belt_thickness_max+clearance,h=belt_tensioner_height+1);
		}

		// tensioning screw trap
		translate([0,4.5*belt_tooth_periode+wall,belt_tensioner_height/2]){
			translate([0,(2*wall+2*belt_tensioning_screw_head_wrench_length+3*clearance+1)/2,0])
				rotate([0,0,90])
					teardrop(belt_tensioning_screw_dia/2+clearance,2*wall+2*belt_tensioning_screw_head_wrench_length+3*clearance+1);
			translate([0,(belt_tensioning_screw_head_wrench_length+2*clearance+belt_tensioning_screw_head_wrench_length+clearance)/2,0])
				rotate([0,0,90])
					nut_trap(belt_tensioning_screw_head_wrench,belt_tensioning_screw_head_wrench_length+2*clearance+belt_tensioning_screw_head_wrench_length+clearance,vertical=1);
			translate([-belt_tensioning_screw_dia/2-clearance,0,0])
				cube([belt_tensioning_screw_dia+2*clearance,2*wall+2*belt_tensioning_screw_head_length+2*clearance+1,belt_tensioner_height]);
			translate([-belt_tensioning_screw_head_wrench/2-clearance,0,0])
				cube([belt_tensioning_screw_head_wrench+2*clearance,belt_tensioning_screw_head_wrench_length+2*clearance,belt_tensioner_height]);
		}

		// round corners
		for(m=[0,1])
			mirror([m,0,0]){
				translate([belt_tensioner_width/2,0,0])
					rotate([0,0,90])
						roundcorner_tear(wall,5*belt_tooth_periode+wall+belt_tensioning_range+belt_tensioning_nut_height+2*wall);
				translate([belt_tensioner_width/2,0,belt_tensioner_height])
					rotate([-90,0,0])
						rotate([0,0,90])
							roundcorner(wall,5*belt_tooth_periode+wall+belt_tensioning_range+belt_tensioning_nut_height+2*wall);
			}


	}


}
