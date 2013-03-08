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

///// RENDER RIGHT EXTRUDER /////
translate([extruder_back_body_width/2,0,0])
rotate([90,0,0])			// for printing
extruder_back();

///// RENDER LEFT EXTRUDER /////
translate([-extruder_back_body_width/2,0,0])
rotate([90,0,0])			// for printing
mirror([1,0,0]) extruder_back();




module extruder_back(){

	difference(){

		// main body
		hull(){
			translate([-extruder_back_body_width/2,0,extruder_back_body_height-wall])
				cube([wall,extruder_back_body_length,wall]);
//				rotate([-90,0,0])
//%					cylinder(r=wall,h=extruder_back_body_length);
			translate([extruder_back_body_width/2-wall,0,extruder_back_body_height-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_back_body_length);
			translate([-extruder_back_body_width/2,0,0])
				cube([extruder_back_body_width,extruder_back_body_length,wall]);
		}

		// extruder stepper gearbox clamp
		translate([0,-1,extruder_drivegear_elevation])
			rotate([-90,0,0])
				cylinder(r=nema17_gearbox_dia/2+clearance,h=extruder_back_body_length+2);
		translate([-wall_thin/2,-1,extruder_drivegear_elevation])
			cube([wall_thin,extruder_back_body_length+2,extruder_back_body_height]);

		// extruder stepper gearbox clamp screw hole and nut trap
		translate([0,nema17_gearbox_length/2,extruder_back_body_height-wall-clearance-extruder_gearbox_clamp_screw_washer_dia/2])
			rotate([-90,0,0])
				teardrop(extruder_gearbox_clamp_screw_dia/2+clearance,extruder_back_body_width+2);
		translate([-(clearance+extruder_gearbox_clamp_screw_washer_thickness+extruder_gearbox_clamp_screw_head_length+1)/2+extruder_back_body_width/2+1,nema17_gearbox_length/2,extruder_back_body_height-wall-clearance-extruder_gearbox_clamp_screw_washer_dia/2])
			rotate([-90,0,0])
				teardrop(extruder_gearbox_clamp_screw_washer_dia/2+clearance,clearance+extruder_gearbox_clamp_screw_washer_thickness+extruder_gearbox_clamp_screw_head_length+1);
		translate([-(extruder_gearbox_clamp_screw_nut_height+2*clearance)/2-2*wall,nema17_gearbox_length/2,extruder_back_body_height-wall-clearance-extruder_gearbox_clamp_screw_washer_dia/2])
			rotate([0,0,0])
				nut_slot(extruder_gearbox_clamp_screw_nut_wrench,extruder_gearbox_clamp_screw_nut_height,wall+clearance+extruder_gearbox_clamp_screw_washer_dia/2,vertical=1);


		// extruder stepper body clearance
		translate([-extruder_back_body_width/2-1,nema17_gearbox_length,extruder_mount_screw_nut_height+clearance+wall])
			cube([extruder_back_body_width+2,extruder_back_body_length,extruder_back_body_height+1]);

		// round corners
		translate([extruder_back_body_width/2,extruder_back_body_length,0])
			rotate([0,0,180])
				roundcorner(wall,extruder_back_body_height);
/*
		translate([-extruder_back_body_width/2,extruder_back_body_length,0])
			rotate([0,0,-90])
				roundcorner(wall,extruder_back_body_height);
*/

		// extruder mount screw holes and nut traps
		// back
		translate([0,extruder_back_body_length-(extruder_mount_screw_nut_wrench/2+clearance+wall),(extruder_mount_screw_nut_height+clearance+1)/2+wall])
			rotate()
				nut_trap(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height+clearance+1);
		translate([0,extruder_back_body_length-(extruder_mount_screw_nut_wrench/2+clearance+wall),(extruder_mount_screw_nut_height+clearance+wall+2)/2-1])
			rotate([0,0,90]) rotate([0,90,0])
				teardrop(extruder_mount_screw_dia/2+clearance,extruder_mount_screw_nut_height+clearance+wall+2);

		// front
		translate([extruder_back_body_width/2-wall-2*clearance-extruder_mount_screw_dia-wall-clearance-extruder_mount_screw_dia/2,clearance+wall+clearance+extruder_mount_screw_dia/2,(extruder_mount_screw_nut_height+clearance+1)/2+wall])
			rotate([0,0,-90])
				nut_slot(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,clearance+wall+clearance+extruder_mount_screw_dia/2);
		translate([extruder_back_body_width/2-wall-2*clearance-extruder_mount_screw_dia-wall-clearance-extruder_mount_screw_dia/2,clearance+wall+clearance+extruder_mount_screw_dia/2,(extruder_mount_screw_nut_height+clearance+3*wall+1)/2-1])
			rotate([0,0,90]) rotate([0,90,0])
				teardrop(extruder_mount_screw_dia/2+clearance,extruder_mount_screw_nut_height+clearance+4*wall+1);

		// extruder front mount screw holes and nut traps
		translate([-extruder_back_body_width/2,wall+clearance+extruder_mount_screw_nut_height/2,extruder_drivegear_elevation+nema17_gearbox_dia/2+clearance+wall+clearance+extruder_mount_screw_dia/2])
			rotate([0,0,-90])
				nut_slot(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,extruder_back_body_height,vertical=1);
		translate([-extruder_back_body_width/2,wall+clearance+extruder_mount_screw_nut_height/2,wall+clearance+extruder_mount_screw_dia/2])
			rotate([0,180,0]) rotate([0,0,-90])
				nut_slot(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,extruder_back_body_height,vertical=1);
		difference(){
			union(){
				translate([-extruder_back_body_width/2,-1,extruder_drivegear_elevation+nema17_gearbox_dia/2+clearance+wall+clearance+extruder_mount_screw_dia/2])
					rotate([-90,0,0])
						cylinder(r=extruder_mount_screw_dia/2+clearance,h=wall+2*clearance+extruder_mount_screw_nut_height+wall+1);
				translate([-extruder_back_body_width/2,-1,wall+clearance+extruder_mount_screw_dia/2])
					rotate([-90,0,0])
						cylinder(r=extruder_mount_screw_dia/2+clearance,h=wall+2*clearance+extruder_mount_screw_nut_height+3*wall+1);
			}
			translate([-extruder_back_body_width/2,wall+2*clearance+extruder_mount_screw_nut_height,extruder_drivegear_elevation+nema17_gearbox_dia/2+clearance+wall+clearance+extruder_mount_screw_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance+1,h=layer_height);
			translate([-extruder_back_body_width/2,wall+2*clearance+extruder_mount_screw_nut_height,wall+clearance+extruder_mount_screw_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance+1,h=layer_height);
		}

		// cablechain bolt mount hole and nut trap
		translate([-extruder_back_body_width/2,nema17_gearbox_length-wall-clearance-extruder_cablechain_mount_screw_dia/2,extruder_back_body_height-extruder_cablechain_mount_screw_nut_height/2-clearance-5*wall])
			rotate([0,0,90])
				nut_slot(extruder_cablechain_mount_screw_nut_wrench,extruder_cablechain_mount_screw_nut_height,extruder_cablechain_mount_screw_dia/2+clearance+wall);
		translate([-extruder_back_body_width/2,nema17_gearbox_length-wall-clearance-extruder_cablechain_mount_screw_dia/2,extruder_back_body_height+(extruder_cablechain_mount_screw_nut_height+2*clearance+5*wall+1)/2-(extruder_cablechain_mount_screw_nut_height+2*clearance+5*wall)])
			rotate([0,0,90]) rotate([0,90,0])
				teardrop(extruder_cablechain_mount_screw_dia/2+clearance,extruder_cablechain_mount_screw_nut_height+2*clearance+5*wall+1);
		
	}
/*
	// stepper dummy
%	translate([-nema17_width/2,nema17_gearbox_length,-nema17_width/2+extruder_drivegear_elevation])
		cube([nema17_width,nema17_length,nema17_width]);
*/
}


