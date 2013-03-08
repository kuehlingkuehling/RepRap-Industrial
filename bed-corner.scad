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


// RENDER FOR PRINTING

// FRONT LEFT
//rotate([0,-90,0]) translate([wall+clearance,wall+clearance,bed_bottom_thickness+clearance]) bed_corner();

// FRONT RIGHT
//rotate([0,90,0]) mirror([1,0,0]) translate([wall+clearance,wall+clearance,bed_bottom_thickness+clearance]) bed_corner();

// BACK LEFT
//rotate([0,-90,0]) mirror([0,1,0]) translate([wall+clearance,wall+clearance,bed_bottom_thickness+clearance]) bed_corner();

// BACK RIGHT
rotate([0,90,0]) mirror([1,0,0]) mirror([0,1,0]) translate([wall+clearance,wall+clearance,bed_bottom_thickness+clearance]) bed_corner();


module bed_corner(){
	difference(){
		// main body
		translate([-clearance-wall,-clearance-wall,-clearance-bed_bottom_thickness])
			hull(){
				translate([wall,wall,0])
					translate([0,0,bed_corner_body_height/2])
						rotate([0,-90,0])
							teardrop(wall,bed_corner_body_height);
				translate([bed_corner_body_side-wall,wall,0])
					cylinder(r=wall, h=bed_corner_body_height);
				translate([wall,bed_corner_body_side-wall,0])
					translate([0,0,bed_corner_body_height/2])
						rotate([0,-90,0])
							teardrop(wall,bed_corner_body_height);
				translate([bed_corner_body_side-wall,bed_corner_body_side-wall,0])
					cylinder(r=wall, h=bed_corner_body_height);
			}

		// bed heatbed countersink
		translate([(bed_bottom_side-bed_heatbed_side)/2-wall_thin/2,(bed_bottom_side-bed_heatbed_side)/2-wall_thin/2,bed_insulation_thickness])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_heatbed_thickness+wall_thin]);

		// bed glass countersink
		translate([(bed_bottom_side-bed_glass_side)/2-wall_thin,(bed_bottom_side-bed_glass_side)/2-wall_thin,bed_insulation_thickness+bed_heatbed_thickness])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_glass_thickness+wall_thin]);

		// bed surface countersink
		translate([(bed_bottom_side-bed_surface_side)/2-wall_thin,(bed_bottom_side-bed_surface_side)/2-wall_thin,bed_insulation_thickness+bed_heatbed_thickness+bed_glass_thickness])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_glass_thickness+wall_thin]);

		// bed bottom countersink
		translate([0,0,-(bed_bottom_thickness+clearance+1)])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_bottom_thickness+clearance+1]);

		// bed clamp recess
		translate([(bed_bottom_side-bed_surface_side)/2-wall_thin,-bed_corner_body_side,-(bed_clamp_angle_thickness+wall_thin)+bed_corner_body_height-clearance-bed_bottom_thickness-bed_clamp_width])
			cube([bed_clamp_length+2*wall_thin,(bed_bottom_side-bed_glass_side)/2+wall+bed_corner_body_side,bed_clamp_angle_thickness+wall_thin]);

		// bed corner screw hole and nut trap
		translate([(-clearance-wall)/2,(-clearance-wall)/2,0]){
			translate([bed_corner_body_side/2,bed_corner_body_side/2,-1-clearance-bed_bottom_thickness])
				translate([0,0,(bed_corner_body_height+2)/2])
					rotate([0,0,180])
						rotate([0,-90,0])
							teardrop(bed_corner_screw_dia/2+clearance,bed_corner_body_height+2);
			translate([bed_corner_body_side/2,bed_corner_body_side/2,(bed_corner_body_height+1)/2+wall])
				translate([0,0,0])
					rotate([0,0,30])
						nut_trap(bed_corner_screw_nut_wrench,bed_corner_body_height+1);
		}


	}


}
