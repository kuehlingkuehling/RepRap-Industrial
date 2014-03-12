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

// BELT TENSIONER THUMBWHEEL
belt_tensioner_thumbwheel(square=1,bed=0);




/*** DEPRECATED *****************************
// BED LEVELING THUMBWHEEL
//belt_tensioner_thumbwheel(square=0,bed=1);
********************************************/



module belt_tensioner_thumbwheel(square=1,bed=0){

	radius = cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall;
	height = belt_tensioning_nut_height+clearance+wall_thin+bed*(wall-wall_thin);

	intersection(){

		// wheel
		difference(){

			// main body
			cylinder(r=radius,h=height);

			// square nut trap/hex-head trap
			if(square==0)
				translate([0,0,(belt_tensioning_nut_height+clearance+1)/2+height-(belt_tensioning_nut_height+clearance)])
					nut_trap(belt_tensioning_nut_wrench,belt_tensioning_nut_height+clearance+1);
			if(square==1)
				translate([0,0,(belt_tensioning_nut_height+clearance+1)/2+height-(belt_tensioning_nut_height+clearance)])
					nut_trap_square(belt_tensioning_nut_wrench,belt_tensioning_nut_height+clearance+1);

			// screw hole
			translate([0,0,-1])
				cylinder(r=belt_tensioning_screw_dia/2+clearance,h=height+2);

			// thumb grip
			for(i=[0:11])
				rotate([0,0,i*(360/12)])
					translate([radius,0,-1])
						cylinder(r=wall_thin*(radius/(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall)),height+2);
		}

		// radial bevel
		union(){
			translate([0,0,-wall_thin/2])
				cylinder(r1=radius-wall_thin,r2=radius+wall_thin/2,h=1.5*wall_thin);
			translate([0,0,-((belt_tensioning_nut_height+wall_thin+clearance)-wall_thin)/2+(belt_tensioning_nut_height+wall_thin+clearance)/2])
				cylinder(r=radius+wall_thin/2,height-wall_thin);
			translate([0,0,height-wall_thin])
				cylinder(r1=radius+wall_thin/2,r2=radius-wall_thin,h=1.5*wall_thin);
		}
	}
}
