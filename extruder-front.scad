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



// RENDER EXTRUDER
rotate([90,0,0])
    difference(){
       	union(){
            translate([extruder_front_body_width/2,0,0])
                extruder_front();
            translate([-extruder_front_body_width/2,0,0]) mirror([1,0,0]) extruder_front();
        }
        translate([0,0,(extruder_back_body_height/8*3)])
            label("22",orientation="back");
    }



// DEBUG
echo("extruder nozzle tip dist: ",extruder_front_body_width+2*(extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2));


module extruder_front(){
	difference(){

		// main body
		union(){
			hull(){
				translate([-extruder_front_body_width/2,-extruder_front_body_length,extruder_back_body_height/2-wall])
					cube([wall,extruder_front_body_length,wall]);
				translate([0,-extruder_front_body_length,extruder_back_body_height/2-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_front_body_length);
				translate([0,-extruder_front_body_length,extruder_back_body_height/2-extruder_front_body_height+wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_front_body_length);
				translate([-extruder_front_body_width/2,-extruder_front_body_length,extruder_back_body_height/2-extruder_front_body_height])
					cube([wall,extruder_front_body_length,wall]);
			}
			hull(){
				translate([-extruder_front_body_width/2,-extruder_front_body_length,extruder_mount_screw_washer_dia-wall])
					cube([wall,extruder_front_body_length,wall]);
				translate([extruder_front_body_width/2-wall,-extruder_front_body_length,extruder_mount_screw_washer_dia-wall])
					cube([wall,extruder_front_body_length,wall]);
//					rotate([-90,0,0])
//						cylinder(r=wall,h=extruder_front_body_length);
				translate([extruder_front_body_width/2-wall,-extruder_front_body_length,extruder_back_body_height/2-extruder_front_body_height+wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_front_body_length);
				translate([-extruder_front_body_width/2,-extruder_front_body_length,extruder_back_body_height/2-extruder_front_body_height])
					cube([wall,extruder_front_body_length,wall]);
			}
		}

		// filament drive gear clearance
		hull(){
			translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_front_body_length-1,extruder_back_body_height/2+1])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_front_body_length+2);
			translate([extruder_front_body_width/2+1,-extruder_front_body_length-1,extruder_back_body_height/2+1])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_front_body_length+2);
			translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_front_body_length-1,extruder_mount_screw_washer_dia+wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_front_body_length+2);
			translate([extruder_front_body_width/2+1,-extruder_front_body_length-1,extruder_mount_screw_washer_dia+wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_front_body_length+2);
		}

		// extruder mount x-carriage clearance
		translate([-extruder_front_body_width/2-1,-wall-clearance,-extruder_front_body_height+extruder_mount_screw_washer_dia+clearance])
			cube([extruder_front_body_width+2,wall+clearance+1,extruder_front_body_height]);

		// stepper motor gearbox mount screw clearance
		translate([0,-nema17_screw_lens_head_length-clearance,extruder_back_body_height/2])
			for(i=[0:3])
				rotate([0,45+i*90,0])
					translate([0,0,nema17_gearbox_hole_pos_dia/2])
						rotate([-90,0,0])
							cylinder(r=nema17_screw_washer_dia/2+clearance,h=extruder_front_body_length);

		// extruder mount screw holes
		translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,-extruder_front_body_length-1,extruder_mount_screw_washer_dia/2])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);
		translate([-extruder_back_body_width/2,-extruder_front_body_length-1,extruder_mount_screw_washer_dia/2])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);

		// hot end insulator mount
		translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,-(extruder_front_body_height+2)/2+extruder_back_body_height/2+1])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(r=extruder_hotend_insulator_dia/2+clearance,h=extruder_front_body_height+2);
		translate([(extruder_front_body_width)/2+extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,extruder_back_body_height/2-extruder_front_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([-90,0,0])
				teardrop(r=extruder_hotend_mount_screw_dia/2+clearance,h=extruder_front_body_width);
		translate([(extruder_hotend_mount_screw_nut_height+2*clearance)/2+extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2+extruder_hotend_insulator_dia/2+clearance+wall_thin,-extruder_front_body_length+wall+wall_thin+bearing_width/2,extruder_back_body_height/2-extruder_front_body_height+extruder_hotend_insulator_countersink-extruder_hotend_insulator_groove_pos])
			rotate([0,90,0])
				nut_slot_square(extruder_hotend_mount_screw_nut_wrench,extruder_hotend_mount_screw_nut_height,extruder_front_body_height);

		// idler spring recess and tensioner
		translate([-extruder_drivegear_dia/2-wall_thin-wall_thin-clearance-extruder_idler_spring_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,(extruder_front_body_height)/2+extruder_back_body_height/2-2*wall-extruder_idler_spring_tensioning_range])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(r=extruder_idler_spring_dia/2+clearance,h=extruder_front_body_height);
		translate([-extruder_drivegear_dia/2-wall_thin-wall_thin-clearance-extruder_idler_spring_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,-(extruder_front_body_height+2)/2+extruder_back_body_height/2+1])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(r=extruder_idler_spring_tensioner_screw_dia/2+clearance,h=extruder_front_body_height+2);
		translate([-extruder_drivegear_dia/2-wall_thin-wall_thin-clearance-extruder_idler_spring_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,(extruder_idler_spring_tensioner_screw_nut_height+2*clearance)/2+extruder_back_body_height/2-extruder_front_body_height+wall])
			rotate([0,0,-90])
				nut_slot_square(extruder_idler_spring_tensioner_screw_nut_wrench,extruder_idler_spring_tensioner_screw_nut_height,extruder_front_body_length);
	}
}



