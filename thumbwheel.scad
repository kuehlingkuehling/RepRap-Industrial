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

// BELT TENSIONER THUMBWHEEL
//belt_tensioner_thumbwheel();

// BED LEVELING THUMBWHEEL
translate([0,0,belt_tensioning_nut_height+wall_thin+clearance]) rotate([180,0,0]) belt_tensioner_thumbwheel(long=1);



module belt_tensioner_thumbwheel(long=0){

	radius = max((cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall),(long * thumbwheel_long_dia/2));

	intersection(){

		// wheel
		difference(){
			union(){

				// main body
				cylinder(r=radius,h=belt_tensioning_nut_height+wall_thin+clearance);
	
				// shaft for bed-leveling thumbwheels
				if(long==1)
					translate([0,0,-belt_tensioning_screw_head_length-wall_thin])
						cylinder(r=belt_tensioning_washer_dia/2,h=belt_tensioning_screw_head_length+wall_thin);
			}

			// nut trap/hex-head trap
			translate([0,0,wall_thin+(belt_tensioning_nut_height+1)/2])
				nut_trap(belt_tensioning_nut_wrench, belt_tensioning_nut_height+1);

			// screw hole
			translate([0,0,-belt_tensioning_screw_head_length-wall_thin-1])
				cylinder(r=belt_tensioning_screw_dia/2+clearance,h=belt_tensioning_nut_height+wall_thin+clearance+belt_tensioning_screw_head_length+wall_thin+2);

			// thumb grip
			for(i=[0:11])
				rotate([0,0,i*(360/12)])
					translate([radius,0,-1])
						cylinder(r=wall_thin*(radius/(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall)),belt_tensioning_nut_height+wall_thin+clearance+2);
		}

		// radial bevel
		union(){
			translate([0,0,-wall_thin/2])
				cylinder(r1=radius-wall_thin,r2=radius+wall_thin/2,h=1.5*wall_thin);
			translate([0,0,-((belt_tensioning_nut_height+wall_thin+clearance)-wall_thin)/2+(belt_tensioning_nut_height+wall_thin+clearance)/2])
				cylinder(r=radius+wall_thin/2,(belt_tensioning_nut_height+wall_thin+clearance)-wall_thin);
			translate([0,0,(belt_tensioning_nut_height+wall_thin+clearance)-wall_thin])
				cylinder(r1=radius+wall_thin/2,r2=radius-wall_thin,h=1.5*wall_thin);

			// leave thumbwheel shaft
			translate([0,0,-belt_tensioning_screw_head_length-wall_thin])
				cylinder(r=belt_tensioning_washer_dia/2,belt_tensioning_screw_head_length+wall_thin);
		}
	}

	// printability support for screw hole when printing shaft-version of thumbwheel
	if(long==1)
		translate([0,0,wall_thin-layer_height])
			cylinder(r=belt_tensioning_washer_dia/2,layer_height);
}
