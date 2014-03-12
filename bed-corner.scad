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


// RENDER FOR PRINTING

// FRONT LEFT
* rotate([90,0,0]) bed_corner(back=0);

// FRONT RIGHT
* rotate([90,0,0]) mirror([1,0,0]) bed_corner(back=0);

// BACK LEFT
* rotate([-90,0,0]) mirror([0,1,0]) bed_corner(back=1);

// BACK RIGHT
* rotate([-90,0,0]) mirror([1,0,0]) mirror([0,1,0]) bed_corner(back=1);

// CENTER
* bed_corner_center();


module bed_corner(back=0){
	difference(){
		// main body
		union(){
			translate([-clearance-wall,-clearance-wall,-clearance-bed_bottom_thickness])
				hull(){
					translate([wall,wall,bed_corner_body_height/2])
						rotate([0,0,90])
							rotate([0,-90,0])
								teardrop(wall,bed_corner_body_height);
					translate([bed_corner_body_side-wall,wall,bed_corner_body_height/2])
						rotate([0,0,90])
							rotate([0,-90,0])
								teardrop(wall,bed_corner_body_height);
					translate([wall,bed_corner_body_side-wall,bed_corner_body_height/2])
						rotate([0,0,90])
							rotate([0,-90,0])
								teardrop(wall,bed_corner_body_height);
					translate([bed_corner_body_side-wall,bed_corner_body_side-wall,bed_corner_body_height/2])
						rotate([0,0,90])
							rotate([0,-90,0])
								teardrop(wall,bed_corner_body_height);
				}
			if(back==1)
				translate([-clearance-wall,-clearance-wall,-clearance-bed_bottom_thickness])
					hull(){
						translate([wall,wall,(bed_corner_body_height+bed_surface_thickness+bed_clamp_angle_thickness)/2])
							rotate([0,0,90])
								rotate([0,-90,0])
									teardrop(wall,bed_corner_body_height+bed_surface_thickness+bed_clamp_angle_thickness);
						translate([bed_corner_body_side-wall,wall,(bed_corner_body_height+bed_surface_thickness+bed_clamp_angle_thickness)/2])
							rotate([0,0,90])
								rotate([0,-90,0])
									teardrop(wall,bed_corner_body_height+bed_surface_thickness+bed_clamp_angle_thickness);
						translate([0,bed_clamp_angle_length-wall,0])
							cube([bed_corner_body_side,wall,bed_corner_body_height+bed_surface_thickness+bed_clamp_angle_thickness]);
					}
		}

		// bed heatbed countersink
		translate([(bed_bottom_side-bed_heatbed_side)/2-wall_thin/2,(bed_bottom_side-bed_heatbed_side)/2-wall_thin/2,bed_heatbed_bottom_clearance-clearance])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_heatbed_thickness+clearance]);

		// bed glass countersink
		translate([(bed_bottom_side-bed_glass_side)/2-wall_thin,(bed_bottom_side-bed_glass_side)/2-wall_thin,bed_heatbed_bottom_clearance+bed_heatbed_thickness])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_glass_thickness+wall_thin]);

		// bed surface countersink
		if(back==0)
			translate([(bed_bottom_side-bed_surface_side)/2-wall_thin,(bed_bottom_side-bed_surface_side)/2-wall_thin,bed_heatbed_bottom_clearance])
				cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_heatbed_thickness+bed_glass_thickness+bed_surface_thickness]);

		// bed bottom countersink
		translate([-clearance,-clearance,-(bed_bottom_thickness+clearance+1)])
			cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_bottom_thickness+clearance+1]);

		// bed clamp recess
		if(back==0)
			translate([wall-wall_thin,-bed_corner_body_side-clearance-wall+bed_clamp_angle_length+clearance,-(bed_clamp_angle_thickness+wall_thin)+bed_corner_body_height-clearance-bed_bottom_thickness-bed_clamp_width+wall_thin])
				cube([bed_clamp_length+2*wall_thin,bed_corner_body_side,bed_clamp_angle_thickness+wall_thin]);
		if(back==1)
			difference(){
				translate([(bed_bottom_side-bed_surface_side)/2-wall_thin,(bed_bottom_side-bed_surface_side)/2-wall_thin,bed_heatbed_bottom_clearance])
					cube([bed_corner_body_side+1,bed_corner_body_side+1,bed_heatbed_thickness+bed_glass_thickness+bed_surface_thickness+wall_thin]);
				translate([-1-clearance-wall,-clearance-wall+bed_clamp_angle_length-wall,bed_heatbed_bottom_clearance+bed_heatbed_thickness+bed_glass_thickness+bed_surface_thickness+wall-clearance])
					rotate([0,90,0])
						cylinder(r=wall,h=bed_corner_body_side+2);
			}

		// bed corner screw hole and nut trap
		translate([(bed_corner_body_side-wall-clearance)/2,(bed_corner_body_side-wall-clearance)/2,-1-clearance-bed_bottom_thickness])
			translate([0,0,(bed_corner_body_height+2)/2])
				rotate([0,0,-90])
					rotate([0,-90,0])
						teardrop(bed_corner_screw_dia/2+clearance,bed_corner_body_height+2);
		translate([(bed_corner_body_side-wall-clearance)/2,(bed_corner_body_side-wall-clearance)/2,(bed_corner_body_height+1)/2+wall])
			translate([0,0,0])
				nut_trap_square(bed_corner_screw_nut_wrench,bed_corner_body_height+1);
	}
}



module bed_corner_center(){
	difference(){
		// main body
		cylinder(r=bed_corner_body_side/2,h=bed_heatbed_bottom_clearance);

		// heat bed thermistor clearance
		hull(){
			translate([0,0,bed_heatbed_bottom_clearance-wall])
				cylinder(r=bed_corner_body_side/2-wall,h=bed_heatbed_bottom_clearance);
			translate([0,-bed_corner_body_side,bed_heatbed_bottom_clearance-wall])
				cylinder(r=bed_corner_body_side/2-wall,h=bed_heatbed_bottom_clearance);
		}

		// bed corner screw hole and nut trap
		translate([0,0,-1])
			cylinder(r=bed_corner_screw_dia/2+clearance,h=bed_heatbed_bottom_clearance+2);
		translate([0,0,(bed_corner_body_height+1)/2+wall])
			nut_trap_square(bed_corner_screw_nut_wrench,bed_corner_body_height+1);
	}
}