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

// FRONT LEFT, BACK RIGHT
* difference(){
    bed_corner();
    translate([bed_corner_body_width/2,bed_corner_body_length/2,0])
        label("334",orientation="bottom");
}

// FRONT RIGHT, BACK LEFT
* mirror([1,0,0])
    difference(){
        bed_corner();
        translate([bed_corner_body_width/2,bed_corner_body_length/2,0])
            mirror([1,0,0])
                label("335",orientation="bottom");
    }




module bed_corner(){
	difference(){
		// main body
		hull(){
			translate([wall,wall,0])
				cylinder(r=wall,h=bed_corner_body_height);
			translate([bed_corner_body_width-wall,wall,0])
				cylinder(r=wall,h=bed_corner_body_height);
			translate([wall,bed_corner_body_length-wall,0])
				cylinder(r=wall,h=bed_corner_body_height);
			translate([bed_corner_body_width-wall,bed_corner_body_length-wall,0])
				cylinder(r=wall,h=bed_corner_body_height);
		}

		// bed heatbed countersink
		translate([wall,wall,wall+bed_clamp_angle_thickness+wall_thin+wall_thin])
			cube([bed_corner_body_width+1,bed_corner_body_length+1,bed_heatbed_thickness+1]);

		// bed surface countersink
		translate([wall,wall,wall+bed_clamp_angle_thickness+wall_thin+wall_thin+bed_heatbed_thickness])
			cube([bed_corner_body_width+1,bed_corner_body_length+1,bed_surface_thickness+1]);

		// bed clamp recess
		translate([-(bed_clamp_length+2*wall_thin)/2+bed_corner_body_width/2,-1,wall])
			cube([bed_clamp_length+2*wall_thin,bed_clamp_angle_length+1,bed_clamp_angle_thickness+wall_thin]);
	}
}
