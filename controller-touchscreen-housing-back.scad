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




// RENDER FOR LASER CUTTING (.DXF EXPORT)
projection(cut=false) touchscreen_housing_back();





module touchscreen_housing_back(){
	difference(){

		// main body
		hull(){
			for(i=[0,1])
				mirror([i,0,0]){
					translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,-controller_touchscreen_housing_body_height/2+controller_touchscreen_cornerradius,0])
						cylinder(r=controller_touchscreen_cornerradius-wall_thin-clearance,h=controller_touchscreen_housing_back_thickness);
					translate([-controller_touchscreen_housing_body_width/2+controller_touchscreen_cornerradius,controller_touchscreen_housing_body_height/2-controller_touchscreen_cornerradius,0])
						cylinder(r=controller_touchscreen_cornerradius-wall_thin-clearance,h=controller_touchscreen_housing_back_thickness);
				}
		}

		// housing frame mount screw holes
			for(h=[0,1])
				mirror([h,0,0]){
					for(v=[0,1])
						mirror([0,v,0])
							translate([controller_touchscreen_housing_body_width/2-controller_touchscreen_glasssideclearance_side/2,controller_touchscreen_housing_body_height/4,-1])
								cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length+2);
						translate([controller_touchscreen_housing_body_width/4,controller_touchscreen_housing_body_height/2-controller_touchscreen_glasssideclearance_top/2,-1])
							cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance,h=controller_touchscreen_housing_body_length+2);
				}

		// housing mount screw holes
		for(h=[0,1])
			mirror([h,0,0])
				for(v=[0,1])
					mirror([0,v,0])
						translate([controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2,controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2,-1])
							cylinder(r=controller_touchscreen_housing_back_screw_dia/2+clearance_laser,h=controller_touchscreen_housing_back_thickness+2);

		// touchscreen cable clearance
		translate([0,0,-1])
			cylinder(r=controller_touchscreen_cable_clearance_dia/2,h=controller_touchscreen_housing_back_thickness+2);
	}
}
