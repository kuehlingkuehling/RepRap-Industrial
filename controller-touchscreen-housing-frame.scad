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

// FRAME HALF 2x
rotate([180,0,0])
	intersection(){
		controller_touchscreen_housing_frame();
		mirror([1,0,0])
			translate([clearance,-controller_touchscreen_height,-1])
				cube([controller_touchscreen_width,2*controller_touchscreen_height,wall+wall_thin+controller_touchscreen_thickness+2]);
	}





module controller_touchscreen_housing_frame(){
	difference(){

		// main body
		hull(){
			translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
				cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
			translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
				cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
			translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
				cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
			translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
				cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
		}

		// inner housing clearance
		hull(){
			translate([-(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance)+wall,-(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance)+wall,-1])
				cylinder(r=wall,h=controller_touchscreen_housing_body_length+2);
			translate([-(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance)+wall,(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance)-wall,-1])
				cylinder(r=controller_touchscreen_cornerradius-2*wall,h=controller_touchscreen_housing_body_length+2);
			translate([(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance)-wall,-(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance)+wall,-1])
				cylinder(r=controller_touchscreen_cornerradius-2*wall,h=controller_touchscreen_housing_body_length+2);
			translate([(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance)-wall,(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance)-wall,-1])
				cylinder(r=controller_touchscreen_cornerradius-2*wall,h=controller_touchscreen_housing_body_length+2);
		}

		// housing back recess
		hull(){
			translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_length+controller_touchscreen_housing_back_thickness+clearance])
				cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
			translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_length+controller_touchscreen_housing_back_thickness+clearance])
				cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
			translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_length+controller_touchscreen_housing_back_thickness+clearance])
				cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
			translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_length+controller_touchscreen_housing_back_thickness+clearance])
				cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
		}

		// housing mount screw holes and nut traps
		for(h=[0,1])
			mirror([h,0,0])
				for(v=[0,1])
					mirror([0,v,0]){
						translate([controller_touchscreen_housing_body_width/4,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance/2,-controller_touchscreen_housing_back_screw_nut_height-clearance-layer_height])
							cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length);
						translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance/2,controller_touchscreen_housing_body_height/4,-controller_touchscreen_housing_back_screw_nut_height-clearance-layer_height])
							cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length);
						translate([controller_touchscreen_housing_body_width/4,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance/2,controller_touchscreen_housing_body_length+controller_touchscreen_housing_body_length/2-controller_touchscreen_housing_back_screw_nut_height-clearance])
							nut_trap_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_body_length);
						translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance/2,controller_touchscreen_housing_body_height/4,controller_touchscreen_housing_body_length+controller_touchscreen_housing_body_length/2-controller_touchscreen_housing_back_screw_nut_height-clearance])
							nut_trap_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_body_length);
					}
	}
}