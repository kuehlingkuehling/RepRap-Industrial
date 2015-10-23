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
difference(){
    controller_touchscreen_housing_frame();
    translate([0,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_top/2,controller_touchscreen_housing_body_length])
        label("50",orientation="top");
}





module controller_touchscreen_housing_frame(){
	difference(){

		// main body
		hull(){
			for(i=[0,1])
				mirror([i,0,0]){
					translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
						cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
					translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
						cylinder(r=controller_touchscreen_cornerradius,h=controller_touchscreen_housing_body_length);
				}
		}

		// inner housing clearance
		hull(){
			for(i=[0,1])
				mirror([i,0,0]){
					translate([-(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance_side)+wall,-(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_bottom)+wall,-1])
						cylinder(r=wall,h=controller_touchscreen_housing_body_length+2);
					translate([-(controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance_side)+wall,(controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_top)-wall,-1])
						cylinder(r=wall,h=controller_touchscreen_housing_body_length+2);
				}
		}

		// housing back recess
		translate([0,0,-controller_touchscreen_housing_body_length+controller_touchscreen_housing_back_thickness+clearance])
			hull(){
				for(i=[0,1])
					mirror([i,0,0]){
						translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
							cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
						translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
							cylinder(r=controller_touchscreen_cornerradius-wall_thin,h=controller_touchscreen_housing_body_length);
					}
			}

		// housing mount screw holes and nut traps
		difference(){
			for(h=[0,1])
				mirror([h,0,0]){
					for(v=[0,1])
						mirror([0,v,0]){
							translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance_side/2,controller_touchscreen_housing_body_height/4,-1])
								cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length+2);
							translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance_side/2,controller_touchscreen_housing_body_height/4,-(controller_touchscreen_housing_back_screw_nut_height+clearance+1)/2+controller_touchscreen_housing_body_length+1])
								nut_trap_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_back_screw_nut_height+clearance+1);
						}
						translate([controller_touchscreen_housing_body_width/4,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_top/2,-1])
							cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length+2);
						translate([controller_touchscreen_housing_body_width/4,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_top/2,-(controller_touchscreen_housing_back_screw_nut_height+clearance+1)/2+controller_touchscreen_housing_body_length+1])
							nut_trap_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_back_screw_nut_height+clearance+1);
				}
			if(support) translate([0,0,controller_touchscreen_housing_body_length-controller_touchscreen_housing_back_screw_nut_height-clearance-layer_height])
				hull(){
					for(i=[0,1])
						mirror([i,0,0]){
							translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
								cylinder(r=controller_touchscreen_cornerradius,h=layer_height);
							translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
								cylinder(r=controller_touchscreen_cornerradius,h=layer_height);
						}
				}
		}
	}
}