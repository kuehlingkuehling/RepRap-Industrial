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

/*
///// RENDER HOTEND ADAPTER /////
use <extruder_hotend.scad>
translate([0,0,-wall_thin]) union(){
	translate([extruder_front_body_width/2,0,0]) extruder_hotend();
	translate([-extruder_front_body_width/2,0,0]) mirror([1,0,0]) extruder_hotend();
}
*/

///// RENDER EXTRUDER /////
//rotate([90,0,0])	// for printing
//union(){
//	translate([extruder_front_body_width/2,0,0]) extruder_front();
//	translate([-extruder_front_body_width/2,0,0]) mirror([1,0,0]) extruder_front();
//}

///// RENDER IDLERS /////
//for(i=[0,1]) mirror([i,0,0]) translate([extruder_front_body_width/2,0,0])	// for assembling
//translate([-extruder_front_body_width/2-wall_thin,-3*wall-wall_thin,0]) rotate([0,-90,0]) translate([-extruder_drivegear_dia/2-filament_dia/2-wall_thin,0,0]) rotate([90,0,0])	// for printing
//extruder_idler();



///// RENDER FILAMENT TUBE CONNECTORS /////
//for(i=[0,1]) mirror([i,0,0]) translate([extruder_front_body_width/2,0,-extruder_front_body_z_addition_bottom])	// for assembling
rotate([0,-90,0]) translate([-extruder_drivegear_dia/2+wall_thin/2+extruder_idler_screw_washer_dia/2,0,-(extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall)])	// for printing
extruder_filamenttubeconnector();


///// RENDER IDLER SCREW BAR /////
//for(i=[0,1]) mirror([i,0,0]) translate([extruder_front_body_width/2,0,0])	// for assembling
//rotate([0,90,0]) translate([-(extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall+extruder_idler_screw_washer_dia/2-wall_thin),0,0])	// for printing
//extruder_idler_screwbar();


///// RENDER WATERCOOLINGTUBEMOUNT TOP
//extruder_watercoolingtubemount_top();

///// RENDER WATERCOOLINGTUBEMOUNT BOTTOM
//extruder_watercoolingtubemount_bottom();





module extruder_front(){
	difference(){

		// main body
		translate([0,0,-extruder_front_body_z_addition_bottom])
			hull(){
				translate([-extruder_front_body_width/2,0,extruder_front_body_height-wall])
					cube([wall,extruder_front_body_length,wall]);
				translate([extruder_front_body_width/2-wall,0,extruder_front_body_height-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_front_body_length);
				translate([extruder_front_body_width/2-wall,0,wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_front_body_length);
				translate([-extruder_front_body_width/2,0,0])
					cube([wall,extruder_front_body_length,wall]);
			}

		// extruder hotend adapter clearance
		translate([-extruder_front_body_width/2-1,wall,-extruder_front_body_z_addition_bottom-1])
			cube([extruder_front_body_width+2,extruder_front_body_length-wall+1,extruder_front_body_z_addition_bottom+1]);

		// extruder stepper gearbox center and idler bearing clearance
		translate([0,extruder_front_body_length-nema17_gearbox_center_pitch-nema17_gearbox_shaft_length-wall_thin,extruder_drivegear_elevation])
			rotate([-90,0,0])
				cylinder(r=max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin),h=extruder_front_body_length);
		translate([-wall_thin/2,-1,extruder_drivegear_elevation-(max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin))])
			cube([extruder_front_body_width/2+wall_thin/2+1,extruder_front_body_length+2,extruder_front_body_height]);
		translate([extruder_front_body_width/2,0,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)])
			rotate([-90,0,0]) rotate([0,0,90])
				roundcorner(wall,extruder_front_body_length);

		// filament hole
		translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,(extruder_drivegear_elevation+extruder_front_body_z_addition_bottom+1)/2-extruder_front_body_z_addition_bottom-1])
			rotate([0,0,90]) rotate([0,90,0])
				teardrop(filament_dia/2+extruder_filament_hole_clearance,extruder_drivegear_elevation+extruder_front_body_z_addition_bottom+1);

		// idler trap
		difference(){
			translate([0,-1,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall])
				hull(){
					translate([wall-wall_thin/2,0,extruder_front_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=extruder_front_body_length+2);
					translate([extruder_front_body_width/2-2*wall,0,extruder_front_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=extruder_front_body_length+2);
					translate([wall-wall_thin/2,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=extruder_front_body_length+2);
					translate([extruder_front_body_width/2-2*wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=extruder_front_body_length+2);
				}
			translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-filament_dia/2-wall_thin-wall,-extruder_front_body_z_addition_bottom])
				hull(){
					translate([-extruder_front_body_width/2+wall,0,extruder_front_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=filament_dia+2*wall_thin+2*wall);
					translate([extruder_front_body_width/2-wall,0,extruder_front_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=filament_dia+2*wall_thin+2*wall);
					translate([-extruder_front_body_width/2+wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=filament_dia+2*wall_thin+2*wall);
					translate([extruder_front_body_width/2-wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=filament_dia+2*wall_thin+2*wall);
				}
			translate([extruder_front_body_width/2-wall,-2,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-wall+clearance/2])
				rotate([-90,0,0])
					cylinder(r=wall-clearance/2,h=extruder_front_body_length+4);
		}


		// extruder front mount screw holes
		translate([-extruder_back_body_width/2,-1,extruder_drivegear_elevation+nema17_gearbox_dia/2+clearance+wall+clearance+extruder_mount_screw_dia/2])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);
		translate([-extruder_back_body_width/2,-1,wall+clearance+extruder_mount_screw_dia/2])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);

		// extruder hotend adapter mount screw holes
		translate([extruder_back_body_width/2-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);
		translate([extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2-clearance-wall-clearance-extruder_mount_screw_dia/2,-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
			rotate([-90,0,0])
				cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_front_body_length+2);

		// hotend cable channel
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2-wall_thin/2,wall_thin,-extruder_front_body_z_addition_bottom-1])
			cube([extruder_watercoolingtube_dia,extruder_watercoolingtube_dia-wall_thin+wall,extruder_front_body_height+extruder_front_body_z_addition_bottom+2]);
		translate([-extruder_front_body_width/2+extruder_mount_screw_washer_dia/2,-1,-extruder_front_body_z_addition_bottom-1])
			cube([extruder_watercoolingtube_dia-wall_thin,wall_thin+2,extruder_front_body_height+extruder_front_body_z_addition_bottom+2]);

		// idler screw holes and nut traps
		hull(){
			translate([-wall_thin/2-wall+extruder_front_body_width/2-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22)),extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_washer_dia/2])
				rotate([-90,0,0])
					teardrop(extruder_idler_screw_dia/2+clearance,extruder_front_body_width);
			translate([-wall_thin/2-wall+extruder_front_body_width/2-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22)),extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_dia/2])
				rotate([-90,0,0])
					teardrop(extruder_idler_screw_dia/2+clearance,extruder_front_body_width);
		}
		hull(){
			translate([-wall_thin/2-wall+extruder_front_body_width/2-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22)),extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_washer_dia/2])
				rotate([-90,0,0])
					teardrop(extruder_idler_screw_dia/2+clearance,extruder_front_body_width);
			translate([-wall_thin/2-wall+extruder_front_body_width/2-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22)),extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_dia/2])
				rotate([-90,0,0])
					teardrop(extruder_idler_screw_dia/2+clearance,extruder_front_body_width);
		}
		translate([-wall_thin/2-wall-clearance-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22))/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,-90,0])
				nut_slot(extruder_idler_screw_nut_wrench,cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22),extruder_front_body_height);
		translate([-wall_thin/2-wall-clearance-(cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22))/2,extruder_front_body_length-extruder_gearbox_drivegear_dist+(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-extruder_front_body_z_addition_bottom-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,-90,0])
				nut_slot(extruder_idler_screw_nut_wrench,cornerdiameter(extruder_idler_screw_nut_wrench)*sin(22)+extruder_idler_screw_nut_height*cos(22),extruder_front_body_height);
	}

/*
	// drive gear dummy
	translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2,extruder_drivegear_elevation])
		rotate([-90,0,0])
%			cylinder(r=extruder_drivegear_dia/2,h=bearing_width);
*/
/*
	// idler bearing dummy
%	difference(){
		translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2,extruder_drivegear_elevation])
			rotate([-90,0,0])
				cylinder(r=bearing_dia/2,h=bearing_width);
		translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-1,extruder_drivegear_elevation])
			rotate([-90,0,0])
				cylinder(r=4,h=bearing_width+2);
	}
*/
/*
	// filament tube dummy
%	translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height-10])
		cylinder(r=filament_tube_dia/2,h=50);
%	translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-wall])
		cylinder(r=filament_tube_dia/2+wall,h=extruder_idler_screw_dia+2*wall);

	// filament dummy
%	translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,-10])
		cylinder(r=filament_dia/2,h=extruder_front_body_height+50);
*/

}


module extruder_idler(){
	difference(){

		// main body
		union(){
			translate([0,0,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall])
				hull(){
					translate([extruder_drivegear_dia/2+filament_dia/2+wall_thin,0,extruder_front_body_height-wall-(extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall)-extruder_front_body_z_addition_bottom])
						cube([wall,(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2,wall]);
					translate([extruder_front_body_width/2-2*wall-clearance,0,extruder_front_body_height-wall-(extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall)-extruder_front_body_z_addition_bottom])
						rotate([-90,0,0])
							cylinder(r=wall,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
					translate([extruder_drivegear_dia/2+filament_dia/2+wall_thin,0,clearance])
						cube([wall,(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2,wall]);
/*
						rotate([-90,0,0])
							cylinder(r=wall,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
*/
					translate([extruder_front_body_width/2-2*wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall-clearance,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
				}
			translate([0,0,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall])
				hull(){
					translate([extruder_drivegear_dia/2+filament_dia/2+wall_thin,0,extruder_front_body_height-wall-(extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall)-extruder_front_body_z_addition_bottom])
						cube([wall,(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2,wall]);
					translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall-wall,0,extruder_front_body_height-wall-(extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-3*wall)-extruder_front_body_z_addition_bottom])
						rotate([-90,0,0])
							cylinder(r=wall,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
					translate([extruder_drivegear_dia/2+filament_dia/2+wall_thin+wall,0,wall+clearance+3*wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
					translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall-wall,0,3*wall+clearance+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
				}
		}
		translate([extruder_front_body_width/2-wall,-2,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)-wall+clearance/2])
			rotate([-90,0,0])
				cylinder(r=wall+clearance/2,h=extruder_front_body_length+4);

		// idler hinge clearance
		translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-filament_dia/2-wall_thin-wall-clearance,-extruder_front_body_z_addition_bottom])
			cube([extruder_front_body_width,filament_dia+2*wall_thin+2*wall+2*clearance,extruder_drivegear_elevation-max(nema17_gearbox_center_dia/2+clearance,bearing_dia/2+wall_thin)+wall_thin+extruder_front_body_z_addition_bottom]);

		// idler bearing clearance
		difference(){
			translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin,-extruder_front_body_z_addition_bottom])
				cube([extruder_front_body_width,bearing_width+2*clearance+2*wall_thin,extruder_drivegear_elevation+bearing_dia/2+wall_thin+extruder_front_body_z_addition_bottom]);
			hull(){
				translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin/2-wall+(bearing_width+2*clearance+2*wall_thin+2*wall)/2,extruder_drivegear_elevation])
					rotate([0,90,0]) rotate([0,0,90])
						teardrop(bearing_center_dia/2+clearance+wall_thin,bearing_width+2*clearance+2*wall_thin+2*wall);
	//					cylinder(r=bearing_center_dia/2+clearance,h=bearing_width+2*clearance+2*wall_thin+2*wall);
				translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin/2-wall+(bearing_width+2*clearance+2*wall_thin+2*wall)/2,extruder_drivegear_elevation])
					rotate([0,90,0]) rotate([0,0,90])
						teardrop(bearing_center_dia/2+clearance+wall_thin,bearing_width+2*clearance+2*wall_thin+2*wall);
			}
		}


		// idler screw slots
		hull(){
			translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_front_body_z_addition_bottom])
				rotate([0,90,0])
					cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
			translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2+extruder_front_body_height-extruder_front_body_z_addition_bottom])
				rotate([0,90,0])
					cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
		}
		hull(){
			translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_front_body_z_addition_bottom])
				rotate([0,90,0])
					cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
			translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2+extruder_front_body_height-extruder_front_body_z_addition_bottom])
				rotate([0,90,0])
					cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
		}

		// idler screw bar recess
		translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall+extruder_idler_screw_washer_dia/2-wall_thin,-1,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_front_body_z_addition_bottom])
			rotate([-90,0,0])
				cylinder(r=extruder_idler_screw_washer_dia/2,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2+2);

		// bearing bolt slot
		translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin/2-wall+(bearing_width+2*clearance+2*wall_thin+2*wall)/2,extruder_drivegear_elevation])
			rotate([0,90,0]) rotate([0,0,90])
				teardrop(bearing_center_dia/2+clearance,bearing_width+2*clearance+2*wall_thin+2*wall);
		hull(){
			translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2-bearing_center_dia/16*7,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin/2-wall+(bearing_width+2*clearance+2*wall_thin+2*wall)/2,extruder_drivegear_elevation])
				rotate([0,90,0]) rotate([0,0,90])
					teardrop(bearing_center_dia/2+clearance,bearing_width+2*clearance+2*wall_thin+2*wall);
			translate([0,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin/2-wall+(bearing_width+2*clearance+2*wall_thin+2*wall)/2,extruder_drivegear_elevation])
				rotate([0,90,0]) rotate([0,0,90])
					teardrop(bearing_center_dia/2+clearance,bearing_width+2*clearance+2*wall_thin+2*wall);
		}
		difference(){
			hull(){
				translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin,extruder_drivegear_elevation])
					rotate([-90,0,0])
						cylinder(r=bearing_dia/2,h=bearing_width+2*clearance+2*wall_thin);
				translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2-bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall_thin,extruder_drivegear_elevation])
					rotate([-90,0,0])
						cylinder(r=bearing_dia/2,h=bearing_width+2*clearance+2*wall_thin);
			}
			translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist-bearing_width/2-clearance-wall,extruder_drivegear_elevation])
				rotate([-90,0,0])
					cylinder(r1=bearing_center_dia/2+clearance+wall_thin+wall,r2=bearing_center_dia/2+clearance+wall_thin,h=wall);
			translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist+bearing_width/2+clearance,extruder_drivegear_elevation])
				rotate([-90,0,0])
					cylinder(r1=bearing_center_dia/2+clearance+wall_thin,r2=bearing_center_dia/2+clearance+wall_thin+wall,h=wall);
		}
	}
}


module extruder_filamenttubeconnector(){
	difference(){
		union(){
			// main body
/*
			hull(){
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2)+wall,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2)+wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,-90,0])
						teardrop(wall,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2)+wall,extruder_front_body_length-extruder_gearbox_drivegear_dist+(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,-90,0])
						teardrop(wall,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
				translate([extruder_drivegear_dia/2+(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2)+wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,-90,0])
						teardrop(wall,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
				translate([extruder_drivegear_dia/2+(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_length-extruder_gearbox_drivegear_dist+(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,-90,0])
						teardrop(wall,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
			}
*/
////////////////// EXPERIMENTAL ///////////////////////
			// idler screw surrounding
			hull(){
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2+wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2+(extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=wall_thin+extruder_idler_screw_washer_dia);
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2+wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=wall_thin+extruder_idler_screw_washer_dia);
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2+(extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=wall_thin+extruder_idler_screw_washer_dia);
				translate([extruder_drivegear_dia/2-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2)-wall,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=wall_thin+extruder_idler_screw_washer_dia);
			}
//////////////////////////////////////////////////////
		}

		// idler clearance
		translate([extruder_drivegear_dia/2+filament_dia/2+wall_thin-clearance,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin+extruder_idler_screw_washer_dia+extruder_idler_screw_dia+2*clearance+2*wall+2)/2,extruder_front_body_height+clearance-(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)])
		cube([wall_thin+extruder_idler_screw_washer_dia,wall_thin+extruder_idler_screw_washer_dia+extruder_idler_screw_dia+2*clearance+2*wall+2,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink]);

		// filament clearance
		translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
			rotate([0,0,180]) rotate([0,-90,0])
				teardrop(filament_dia/2+clearance,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink+2);
		translate([0,0,-extruder_filamenttube_countersink-wall])
			hull(){
				translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,0,180]) rotate([0,-90,0])
						teardrop(filament_dia/2+clearance,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
				translate([extruder_drivegear_dia/2+extruder_front_body_width/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2-extruder_idler_screw_dia/2-clearance-wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
					rotate([0,0,180]) rotate([0,-90,0])
						teardrop(filament_dia/2+clearance,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink);
			}

		// filament tube countersink
		translate([extruder_drivegear_dia/2,extruder_front_body_length-extruder_gearbox_drivegear_dist,extruder_front_body_height+clearance+wall+(wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink)/2])
			rotate([0,0,180]) rotate([0,-90,0])
				teardrop(extruder_filamenttube_dia/2+clearance,wall+clearance+extruder_idler_screw_dia/2+extruder_idler_screw_washer_dia/2+wall+clearance+wall+extruder_filamenttube_countersink+2);

		// idler screw holes
		translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,90,0])
				cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
		translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,90,0])
				cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
	}
}


module extruder_watercoolingtubemount_top(){
	difference(){

		// main body
		hull(){
			translate([extruder_mount_screw_washer_dia/2+wall/2+extruder_watercoolingtube_dia/2+clearance+wall-wall,wall,0])
				cylinder(r=wall,h=extruder_mount_screw_washer_dia);
			translate([-(extruder_mount_screw_washer_dia/2+wall/2+extruder_watercoolingtube_dia/2+clearance+wall-wall),wall,0])
				cylinder(r=wall,h=extruder_mount_screw_washer_dia);
			translate([-(extruder_mount_screw_washer_dia/2+wall/2+extruder_watercoolingtube_dia/2+clearance+wall),extruder_watercoolingtube_dia+2*clearance+wall-wall,0])
				cube([2*(extruder_mount_screw_washer_dia/2+wall/2+extruder_watercoolingtube_dia/2+clearance+wall),wall,extruder_mount_screw_washer_dia]);
	
		}

		// watercoolingtube clearance
		translate([extruder_mount_screw_washer_dia/2+wall/2,extruder_watercoolingtube_dia/2+clearance+wall,-1])
			cylinder(r=extruder_watercoolingtube_dia/2+clearance,h=extruder_mount_screw_washer_dia+2);
		translate([-(extruder_mount_screw_washer_dia/2+wall/2),extruder_watercoolingtube_dia/2+clearance+wall,-1])
			cylinder(r=extruder_watercoolingtube_dia/2+clearance,h=extruder_mount_screw_washer_dia+2);
		translate([extruder_mount_screw_washer_dia/2+wall/2-extruder_watercoolingtube_dia/2-clearance,wall+clearance+extruder_watercoolingtube_dia/2,-1])
			cube([extruder_watercoolingtube_dia+2*clearance+wall+1,extruder_watercoolingtube_dia/2+clearance+1,extruder_mount_screw_washer_dia+2]);
		mirror([1,0,0]) translate([extruder_mount_screw_washer_dia/2+wall/2-extruder_watercoolingtube_dia/2-clearance,wall+clearance+extruder_watercoolingtube_dia/2,-1])
			cube([extruder_watercoolingtube_dia+2*clearance+wall+1,extruder_watercoolingtube_dia/2+clearance+1,extruder_mount_screw_washer_dia+2]);

		// extruder mount screw hole
		translate([0,(wall+2*clearance+extruder_watercoolingtube_dia)/2,extruder_mount_screw_washer_dia/2])
			rotate([0,0,90])
				teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_watercoolingtube_dia+2);
	}
}


module extruder_watercoolingtubemount_bottom(){
	difference(){

		// main body
		hull(){
			translate([extruder_back_body_width/4+wall+extruder_mount_screw_washer_dia/2+wall-wall,wall,0])
				cylinder(r=wall,h=extruder_mount_screw_washer_dia);
			translate([-(extruder_back_body_width/4+wall+extruder_mount_screw_washer_dia/2+wall-wall),wall,0])
				cylinder(r=wall,h=extruder_mount_screw_washer_dia);
			translate([-(extruder_back_body_width/4+wall+extruder_mount_screw_washer_dia/2+wall),extruder_watercoolingtube_dia+2*clearance+wall-wall,0])
				cube([2*(extruder_back_body_width/4+wall+extruder_mount_screw_washer_dia/2+wall),wall,extruder_mount_screw_washer_dia]);
	
		}

		// watercoolingtube clearance
		translate([extruder_mount_screw_washer_dia/2+wall/2,extruder_watercoolingtube_dia/2+clearance+wall,-1])
			cylinder(r=extruder_watercoolingtube_dia/2+clearance,h=extruder_mount_screw_washer_dia+2);
		translate([-(extruder_mount_screw_washer_dia/2+wall/2),extruder_watercoolingtube_dia/2+clearance+wall,-1])
			cylinder(r=extruder_watercoolingtube_dia/2+clearance,h=extruder_mount_screw_washer_dia+2);
		translate([extruder_mount_screw_washer_dia/2+wall/2-extruder_watercoolingtube_dia/2-clearance,wall+clearance+extruder_watercoolingtube_dia/2,-1])
			cube([extruder_watercoolingtube_dia+2*clearance,extruder_watercoolingtube_dia/2+clearance+1,extruder_mount_screw_washer_dia+2]);
		mirror([1,0,0]) translate([extruder_mount_screw_washer_dia/2+wall/2-extruder_watercoolingtube_dia/2-clearance,wall+clearance+extruder_watercoolingtube_dia/2,-1])
			cube([extruder_watercoolingtube_dia+2*clearance,extruder_watercoolingtube_dia/2+clearance+1,extruder_mount_screw_washer_dia+2]);

		// extruder mount screw hole
		hull(){
			translate([extruder_back_body_width/4+wall,(wall+2*clearance+extruder_watercoolingtube_dia)/2,extruder_mount_screw_washer_dia/2])
				rotate([0,0,90])
					teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_watercoolingtube_dia+2);
			translate([extruder_back_body_width/4+wall,(wall+2*clearance+extruder_watercoolingtube_dia)/2,-extruder_mount_screw_washer_dia/2])
				rotate([0,0,90])
					teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_watercoolingtube_dia+2);
		}
		hull(){
			translate([-(extruder_back_body_width/4+wall),(wall+2*clearance+extruder_watercoolingtube_dia)/2,extruder_mount_screw_washer_dia/2])
				rotate([0,0,90])
					teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_watercoolingtube_dia+2);
			translate([-(extruder_back_body_width/4+wall),(wall+2*clearance+extruder_watercoolingtube_dia)/2,-extruder_mount_screw_washer_dia/2])
				rotate([0,0,90])
					teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_watercoolingtube_dia+2);
		}
	}
}


module extruder_idler_screwbar(){
	difference(){

		// main body
		intersection(){
			translate([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall+extruder_idler_screw_washer_dia/2-wall_thin,0,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_idler_screw_washer_dia/2,h=(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2);
			cube([extruder_drivegear_dia/2+filament_dia/2-clearance+bearing_dia/2+bearing_center_dia/2+clearance+wall+extruder_idler_screw_washer_dia/2-wall_thin,(extruder_front_body_length-extruder_gearbox_drivegear_dist)*2,extruder_front_body_height*2]);
		}

	
		// idler screw holes
		translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist+wall_thin/2+extruder_idler_screw_washer_dia/2,extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,90,0])
				cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
		translate([-wall_thin/2-wall-wall_thin,extruder_front_body_length-extruder_gearbox_drivegear_dist-(wall_thin/2+extruder_idler_screw_washer_dia/2),extruder_front_body_height-wall-extruder_idler_screw_washer_dia/2])
			rotate([0,90,0])
				cylinder(r=extruder_idler_screw_dia/2+clearance,h=extruder_front_body_width);
	}
}

