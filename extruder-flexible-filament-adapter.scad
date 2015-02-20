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



// RENDER

// left
* mirror([1,0,0]) rotate([90,0,0]) extruder_flexible_filament_adapter();

// right
* rotate([90,0,0]) extruder_flexible_filament_adapter();


module extruder_flexible_filament_adapter(){
	translate([extruder_front_body_width/2,0,0])
		difference(){
			union(){
				translate([-extruder_front_body_width/2,-(extruder_front_body_length+wall),0])
					cube([extruder_front_body_width,wall-clearance,extruder_back_body_height/2-wall_thin]);
				hull(){
					translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_front_body_length-1,extruder_back_body_height/2-wall+clearance-wall_thin])
						rotate([-90,0,0])
							cylinder(r=wall-clearance,h=(wall+wall_thin+bearing_width/2)+2*wall+1);
					translate([extruder_front_body_width/2+1,-extruder_front_body_length-1,extruder_back_body_height/2-wall+clearance-wall_thin])
						rotate([-90,0,0])
							cylinder(r=wall-clearance,h=(wall+wall_thin+bearing_width/2)+2*wall+1);
					translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_front_body_length-1,extruder_mount_screw_washer_dia+wall])
						rotate([-90,0,0])
							cylinder(r=wall-clearance,h=(wall+wall_thin+bearing_width/2)+2*wall+1);
					translate([extruder_front_body_width/2+1,-extruder_front_body_length-1,extruder_mount_screw_washer_dia+wall])
						rotate([-90,0,0])
							cylinder(r=wall-clearance,h=(wall+wall_thin+bearing_width/2)+2*wall+1);
				}
			}
		
			// excess body crop
			translate([extruder_front_body_width/2,-(extruder_front_body_length+wall)-1,extruder_back_body_height/2-extruder_front_body_height])
					cube([extruder_front_body_width,extruder_front_body_length+wall+2,extruder_front_body_height]);
		
			// extruder drive gear clearance
			hull(){
				translate([-extruder_front_body_width/2,-extruder_front_body_length-wall-1,extruder_back_body_height/2+1])
					rotate([-90,0,0])
						cylinder(r=extruder_drivegear_dia/2+clearance,h=extruder_front_body_length+2);
				translate([0,-extruder_front_body_length-wall-1,extruder_back_body_height/2+1])
					rotate([-90,0,0])
						cylinder(r=extruder_drivegear_dia/2+clearance,h=extruder_front_body_length+2);
			}
		
			// extruder idler clearance
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_front_body_length-wall-1,extruder_back_body_height/2])
					translate([-(-(extruder_back_body_width/2-extruder_mount_screw_washer_dia/2)+(extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2)),0,-(extruder_back_body_height-extruder_mount_screw_washer_dia/2)])
						for(i=[0:2])
							hull(){
								rotate([0,-i*1,0])
									translate([-(extruder_back_body_width/2-extruder_mount_screw_washer_dia/2)+(extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2),0,extruder_back_body_height-extruder_mount_screw_washer_dia/2])
										rotate([-90,0,0])
											cylinder(r=bearing_dia/2+clearance,h=extruder_front_body_length+2);
								rotate([0,-(i+1)*1,0])
									translate([-(extruder_back_body_width/2-extruder_mount_screw_washer_dia/2)+(extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2),0,extruder_back_body_height-extruder_mount_screw_washer_dia/2])
										rotate([-90,0,0])
											cylinder(r=bearing_dia/2+clearance,h=extruder_front_body_length+2);
							}
		
			// filament clearance
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,-(extruder_front_body_height+2)/2+extruder_back_body_height/2+1])
					rotate([0,90,0])
						rotate([-90,0,0])
							teardrop(r=filament_dia/2+filament_tolerance+clearance,h=extruder_front_body_height+2);
		
				// extruder mount screw holes
				translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,-extruder_front_body_length-wall-1,extruder_mount_screw_washer_dia/2])
					rotate([-90,0,0])
						cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);
				translate([-extruder_back_body_width/2,-extruder_front_body_length-wall-1,extruder_mount_screw_washer_dia/2])
					rotate([-90,0,0])
						cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);
		}
}




