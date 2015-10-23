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

// RENDER //////////////////////

// Y RIGHT SIDE, X CARRIAGE
* difference(){
    belt_tensioner();
    translate([0,belt_tensioner_length/2,0])
        label("17",orientation="bottom");
}

// Y LEFT SIDE
* mirror([1,0,0])
    difference(){
        belt_tensioner();
        mirror([1,0,0])
            translate([0,belt_tensioner_length/2,0])
                label("75",orientation="bottom");
    }




module belt_tensioner(){
	difference(){
		// main body
		hull(){
			translate([-belt_tensioner_width/2+wall,belt_tensioner_length/2,wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,belt_tensioner_length);
			translate([belt_tensioner_width/2-wall,belt_tensioner_length/2,wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,belt_tensioner_length);
			translate([-belt_tensioner_width/2+wall,belt_tensioner_length/2,belt_tensioner_height-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,belt_tensioner_length);
			translate([belt_tensioner_width/2-wall,belt_tensioner_length/2,belt_tensioner_height-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,belt_tensioner_length);
		}

		// belt grip
		translate([belt_thickness_min,0,0]){
			translate([-(2*belt_thickness_min+2*clearance)/2,-1,belt_tensioner_height/2-belt_width/2-clearance])
				cube([2*belt_thickness_min+2*clearance,belt_grip_length*belt_tooth_periode+1,belt_tensioner_height+1]);
			for(i=[0:(belt_grip_length-1)])
				translate([-(2*belt_thickness_max+2*clearance)/2,belt_tooth_periode/2+i*belt_tooth_periode,belt_tensioner_height/2-belt_width/2-clearance])
					cube([2*belt_thickness_max+2*clearance,belt_tooth_periode/2,belt_tensioner_height+1]);
			translate([0,belt_tooth_periode+(belt_grip_length-1)*belt_tooth_periode,belt_tensioner_height/2-belt_width/2-clearance])
				cylinder(r=belt_thickness_max+clearance,h=belt_tensioner_height+1);
		}

		// tensioning screw trap
		translate([0,(belt_grip_length+0.5)*belt_tooth_periode+wall,belt_tensioner_height/2]){
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
	}
}
