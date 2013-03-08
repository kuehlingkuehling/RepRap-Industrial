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

///// RENDER RIGHT HOTEND ADAPTER /////
//rotate([90,0,0]) translate([0,-clearance-wall,0])		// for printing
//extruder_hotend();

///// RENDER LEFT EXTRUDER /////
rotate([90,0,0]) translate([0,-clearance-wall,0])		// for printing
mirror([1,0,0]) extruder_hotend();




module extruder_hotend(){

	difference(){

		// main body
		translate([0,clearance+wall,-extruder_hotend_body_height])
			hull(){
				translate([-extruder_hotend_body_width/2+clearance/2,0,extruder_hotend_body_height-wall])
					cube([extruder_hotend_body_width-clearance/2,extruder_hotend_body_length-clearance-wall,wall]);
				translate([-extruder_hotend_body_width/2+clearance/2,0,0])
					cube([wall,extruder_hotend_body_length-clearance-wall,wall]);
				translate([extruder_hotend_body_width/2-wall,0,wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_hotend_body_length-clearance-wall);
			}


		// hotend countersink
		translate([extruder_drivegear_dia/2,extruder_hotend_body_length-extruder_gearbox_drivegear_dist,-(extruder_hotend_body_height+2)/2+1])
			rotate([0,0,90]) rotate([0,90,0])
				teardrop(extruder_hotend_insulator_dia/2+clearance,extruder_hotend_body_height+2);

		// mount and adjustment screw holes
		hull(){
			translate([extruder_hotend_body_width/2-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
			translate([extruder_hotend_body_width/2-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
		}
		hull(){
			translate([extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2-clearance-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
			translate([extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2-clearance-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
		}

		// hotend insulator mount screw holes and nut traps
		translate([extruder_drivegear_dia/2+extruder_hotend_insulator_dia/2,-1,-extruder_hotend_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([-90,0,0])
				cylinder(r=extruder_hotend_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
		translate([extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2,-1,-extruder_hotend_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([-90,0,0])
				cylinder(r=extruder_hotend_mount_screw_dia/2+clearance,h=extruder_hotend_body_length+2);
		translate([extruder_drivegear_dia/2+extruder_hotend_insulator_dia/2,(extruder_hotend_body_length)/2+extruder_hotend_body_length-extruder_gearbox_drivegear_dist+extruder_hotend_insulator_dia/2+clearance+2*wall,-extruder_hotend_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([90,0,0])
				nut_trap(extruder_hotend_mount_screw_nut_wrench,extruder_hotend_body_length);
		translate([extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2,(extruder_hotend_body_length)/2+extruder_hotend_body_length-extruder_gearbox_drivegear_dist+extruder_hotend_insulator_dia/2+clearance+2*wall,-extruder_hotend_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([90,0,0])
				nut_trap(extruder_hotend_mount_screw_nut_wrench,extruder_hotend_body_length);

		// hotend cable channel
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2-wall_thin/2,wall_thin,-extruder_hotend_body_height-1])
			cube([extruder_watercoolingtube_dia,extruder_watercoolingtube_dia-wall_thin+wall,extruder_hotend_body_height+2]);
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2,-1,-extruder_hotend_body_height-1])
			cube([extruder_watercoolingtube_dia-wall_thin,wall_thin+2,extruder_hotend_body_height+2]);
/*
		// hotend cable channel
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2-wall_thin/2,wall_thin,-extruder_front_body_z_addition_bottom-1])
			cube([extruder_watercoolingtube_dia,extruder_watercoolingtube_dia-wall_thin+wall,extruder_front_body_height+extruder_front_body_z_addition_bottom+2]);
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2,-1,-extruder_front_body_z_addition_bottom-1])
			cube([extruder_watercoolingtube_dia-wall_thin,wall_thin+2,extruder_front_body_height+extruder_front_body_z_addition_bottom+2]);
*/

	}

}
