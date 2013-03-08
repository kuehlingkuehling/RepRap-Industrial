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

cablechain_rail_profile_side_long = 15;			// aluminium L-profile
cablechain_rail_profile_side_short = 10;			// aluminium L-profile
cablechain_rail_profile_thickness = 2;			// aluminium L-profile


// RENDER FOR PRINTING
mirror([0,1,0])
translate([0,0,cablechain_rail_profile_thickness+2*wall]) rotate([0,180,0]) cabelchain_rail_mount();


module cabelchain_rail_mount(){
	difference(){

		// main body
		hull(){
			translate([0,-frame_width/2+frame_enclosure_thickness+clearance,0])
				cube([wall,frame_width-frame_enclosure_thickness-clearance,cablechain_rail_profile_thickness+2*wall]);
			translate([cablechain_rail_profile_side_short-cablechain_rail_profile_thickness+wall_thin+2*clearance+frame_screw_dia+wall-wall,-frame_width/2+frame_enclosure_thickness+clearance+wall,0])
				cylinder(r=wall,h=cablechain_rail_profile_thickness+2*wall);
			translate([cablechain_rail_profile_side_short-cablechain_rail_profile_thickness+wall_thin+2*clearance+frame_screw_dia+wall-wall,frame_width/2-wall,0])
				cylinder(r=wall,h=cablechain_rail_profile_thickness+2*wall);
		}

		// frame mount screw hole
		translate([cablechain_rail_profile_side_short-cablechain_rail_profile_thickness+wall_thin+clearance+frame_screw_dia/2,0,-1])
			cylinder(r=frame_screw_dia/2+clearance,h=cablechain_rail_profile_thickness+2*wall+2);

		// cablechain rail profile clearance
		translate([-1,-frame_width/2-1,-1])
			cube([cablechain_rail_profile_side_short-cablechain_rail_profile_thickness+1,frame_width+2,cablechain_rail_profile_thickness+1]);
		
	}
}
