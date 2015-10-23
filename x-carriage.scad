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



// RENDER X CARRIAGE
rotate([0,-90,0])
    difference(){
        x_carriage();
        translate([0,0,x_carriage_body_height/2-2*wall])
            label("72",orientation="bottom");
    }


module x_carriage(){
	difference(){

		// main body
		union(){
			hull(){
				translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
			}
			mirror([0,1,0]) hull(){
				translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,x_carriage_body_height/2-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
				translate([-x_carriage_body_length/2,x_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,-x_carriage_body_height/2+wall])
					rotate([0,90,0])
						cylinder(r=wall,h=x_carriage_body_length);
			}
			mirror([0,1,0])
				hull(){
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-wall,x_carriage_body_height/2-wall])
						cube([x_carriage_body_length,wall,wall]);
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,-(belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
				}
			difference(){
				translate([-x_carriage_body_length/2,-x_rod_dist/2,-x_carriage_body_height/2])
					cube([x_carriage_body_length,x_rod_dist,x_carriage_body_height]);
				hull(){
					translate([-x_carriage_body_length/2-1,x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,x_carriage_body_height/2-2*wall-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length+2);
					translate([-x_carriage_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),x_carriage_body_height/2-2*wall-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length+2);
					translate([-x_carriage_body_length/2-1,x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,-x_carriage_body_height/2+2*wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length+2);
					translate([-x_carriage_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),-x_carriage_body_height/2+2*wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length+2);
				}
			}

			// extruder mount flanges
			translate([-x_carriage_body_length/2,-x_carriage_body_width/2,x_carriage_body_height/2-wall-1])
				cube([x_carriage_body_length,wall,extruder_mount_screw_washer_dia+wall+1]);
			translate([-x_carriage_body_length/2,-x_carriage_body_width/2+wall+extruder_back_body_length-wall-clearance-extruder_mount_screw_nut_height-clearance-wall,x_carriage_body_height/2-wall-1])
				cube([x_carriage_body_length,wall+clearance+extruder_mount_screw_nut_height+clearance+wall,extruder_mount_screw_washer_dia+wall+1]);

			// endstop magnet countersink extension
			hull(){
				translate([-x_carriage_body_length/2,x_rod_dist/2+rod_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall+endstop_magnet_dia/2+clearance+wall-wall,endstop_magnet_dia/2+clearance+wall-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_magnet_length+clearance+wall);
				translate([-x_carriage_body_length/2,x_rod_dist/2+rod_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall+endstop_magnet_dia/2+clearance+wall-wall,-(endstop_magnet_dia/2+clearance+wall-wall)])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_magnet_length+clearance+wall);
				translate([-x_carriage_body_length/2,x_rod_dist/2,endstop_magnet_dia/2+clearance+wall-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_magnet_length+clearance+wall);
				translate([-x_carriage_body_length/2,x_rod_dist/2,-(endstop_magnet_dia/2+clearance+wall-wall)])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_magnet_length+clearance+wall);
			}

			// zip tie slot for hot end cable fixation
			translate([0,x_rod_dist/2,0])
				for(i=[0,1])
					mirror([0,i,0])
						rotate([-i*90,0,0])
							translate([0,-linear_bearing_dia/2-clearance-wall+(frame_cable_mount_zip_tie_width+2*wall)/2,-x_carriage_body_height/2])
								difference(){
									hull(){
										translate([-frame_width/2+(frame_cable_mount_zip_tie_thickness+wall_thin),0,0])
											rotate([0,0,90])
												rotate([-90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([frame_width/2-(frame_cable_mount_zip_tie_thickness+wall_thin),0,0])
											rotate([0,0,90])
												rotate([90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([-frame_width/2+(frame_cable_mount_zip_tie_thickness+wall_thin)-wall,0,wall])
											rotate([0,0,90])
												rotate([-90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
										translate([frame_width/2-(frame_cable_mount_zip_tie_thickness+wall_thin)+wall,0,wall])
											rotate([0,0,90])
												rotate([90,0,0])
													teardrop(frame_cable_mount_zip_tie_thickness+wall_thin,frame_cable_mount_zip_tie_width+2*wall,fulldrop=1);
									}
									translate([-x_carriage_body_length/2,-frame_cable_mount_zip_tie_width/2,-frame_cable_mount_zip_tie_thickness])
										cube([x_carriage_body_length,frame_cable_mount_zip_tie_width,frame_cable_mount_zip_tie_thickness]);
								}
		}

		// endstop magnet countersink
		translate([-x_carriage_body_length/2-1,x_rod_dist/2+rod_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall,0])
			rotate([0,90,0])
				cylinder(r=endstop_magnet_dia/2+clearance,h=endstop_magnet_length+clearance+1);

		// belt tensioner accessability
		hull(){
			translate([x_carriage_body_length/2-wall-2*wall,x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,wall+1-x_carriage_body_height/2-1])
				rotate([0,90,0])
					teardrop(wall,2*wall+2);
			translate([x_carriage_body_length/2-wall-2*wall,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),wall+1-x_carriage_body_height/2-1])
				rotate([0,90,0])
					teardrop(wall,2*wall+2);
			translate([-(x_carriage_body_length/2-wall-2*wall),x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall,wall+1-x_carriage_body_height/2-1])
				rotate([0,90,0])
					teardrop(wall,2*wall+2);
			translate([-(x_carriage_body_length/2-wall-2*wall),-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-wall),wall+1-x_carriage_body_height/2-1])
				rotate([0,90,0])
					teardrop(wall,2*wall+2);

		}

		// linear bearing mounts
		difference(){
			for(i=[0,1])
				mirror([0,i,0]){
					translate([-x_carriage_body_length/2-1,x_rod_dist/2,0])
						rotate([0,90,0])
							cylinder(r=linear_bearing_dia/2+clearance_tight,h=x_carriage_body_length+2);
					hull(){
						translate([x_carriage_body_length/2-linear_bearing_length+2*wall-wall/2,x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
						translate([x_carriage_body_length/2-linear_bearing_length-2*wall+wall/2,x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
					}
					hull(){
						translate([-(x_carriage_body_length/2-linear_bearing_length+2*wall-wall/2),x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
						translate([-(x_carriage_body_length/2-linear_bearing_length-2*wall+wall/2),x_rod_dist/2,-(x_carriage_body_height/2+1)/2])
							rotate([0,90,0])
								teardrop(wall/2,x_carriage_body_height/2+1);
					}
				}

			// linear bearing push in stop
			translate([-(x_carriage_body_length-2*linear_bearing_length-2*clearance)/2,-(x_carriage_body_width-2*wall)/2,linear_bearing_dia/2+clearance-wall_thin])
				cube([x_carriage_body_length-2*linear_bearing_length-2*clearance,x_carriage_body_width-2*wall,2*wall_thin]);
		}

		mirror([0,1,0]){
			// x belt tensioning cutoff
			translate([0,x_belt_pulley_dia/2,0])
				rotate([90,0,0])
					hull(){
						translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,belt_tensioner_height/2-wall+wall_thin,belt_tensioner_width/2-wall+wall_thin])
							rotate([0,90,0])
								rotate([0,-90,0])
									rotate([-90,0,0])
										translate([(belt_tensioner_length+belt_tensioning_range+1)/2,0,0])
											teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
						translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,-belt_tensioner_height/2-(-wall+wall_thin),belt_tensioner_width/2-wall+wall_thin])
							rotate([0,90,0])
								cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
						translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,belt_tensioner_height/2-wall+wall_thin,-belt_tensioner_width/2-(-wall+wall_thin)])
							rotate([0,90,0])
								rotate([0,-90,0])
									rotate([-90,0,0])
										translate([(belt_tensioner_length+belt_tensioning_range+1)/2,0,0])
											teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
						translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,-belt_tensioner_height/2-(-wall+wall_thin),-belt_tensioner_width/2-(-wall+wall_thin)])
							rotate([0,90,0])
								cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
					}
	
			// belt grip
			translate([-x_carriage_body_length/2,x_belt_pulley_dia/2,belt_width/2+clearance])
				rotate([90,0,0]) rotate([0,0,-90])
					translate([0,0,-belt_thickness_min])
						difference(){
							union(){
								translate([0,-1,-(2*belt_thickness_min+2*clearance)/2])
									cube([(belt_tensioner_height/2+belt_width/2+clearance+1),belt_grip_length*belt_tooth_periode+1,2*belt_thickness_min+2*clearance]);
								for(i=[0:(belt_grip_length-1)])
									translate([0,belt_tooth_periode/2+i*belt_tooth_periode,-(2*belt_thickness_max+2*clearance)/2])
										cube([(belt_tensioner_height/2+belt_width/2+clearance+1),belt_tooth_periode/2,2*belt_thickness_max+2*clearance]);
								translate([(belt_tensioner_height/2+belt_width/2+clearance+1)/2,belt_tooth_periode+(belt_grip_length-1)*belt_tooth_periode,0])
									rotate([-90,0,0])
										teardrop(belt_thickness_max+clearance,(belt_tensioner_height/2+belt_width/2+clearance+1));
							}
							if(support) for(l=[0:(belt_grip_length-2)])
								translate([-1,belt_tooth_periode+l*belt_tooth_periode,-(2*belt_thickness_max+2*clearance+2)/2])
									cube([(belt_tensioner_height/2+belt_width/2+clearance+1)+2,layer_height,2*belt_thickness_max+2*clearance+2]);
						}
	
			// belt tensioner screw hole
			translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2)-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+belt_tensioning_range),x_belt_pulley_dia/2,0])
				rotate([0,90,0])
					cylinder(r=belt_tensioning_screw_dia/2+clearance,h=(belt_tensioner_length+belt_tensioning_range)+(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+belt_tensioning_range)+1);
	
			// belt tensioner thumb wheel trap
			difference(){
				translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2),x_belt_pulley_dia/2,0])
						rotate([180,0,0]) rotate([0,0,-90]){
							translate([0,-(2*wall+belt_tensioning_knurled_nut_height+wall_thin),0])
								rotate([-90,0,0])
									cylinder(r=belt_tensioning_knurled_nut_dia/2+wall_thin,h=belt_tensioning_knurled_nut_height+wall_thin);
						}
				if(support) intersection(){
					translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-2*wall,-(belt_tensioning_screw_dia/2+clearance)-2*wall])
						cube([x_carriage_body_length+2,2*wall,2*wall]);
					difference(){
						translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(belt_tensioning_screw_dia/2+clearance)])
							rotate([0,90,0])
								cylinder(r=wall,h=x_carriage_body_length);
						translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(belt_tensioning_screw_dia/2+clearance)])
							rotate([0,90,0])
								cylinder(r=wall-1.5*wall_thin,h=x_carriage_body_length+2);
					}
				}
			}
		}

		// stepper motor gearbox and stepper mount screw clearance
		for(e=[1,-1])
			translate([e*x_carriage_body_length/4,0,x_carriage_body_height/2]){
				translate([0,wall+1,extruder_back_body_height/2])
					rotate([0,90,0])
						rotate([0,0,90])
							teardrop(nema17_gearbox_dia/2+clearance,x_carriage_body_width,fulldrop=true);
				translate([0,extruder_back_body_length/4-x_carriage_body_width/2+wall-nema17_screw_lens_head_length-clearance,extruder_back_body_height/2])
					for(i=[0:3])
						rotate([0,45+i*90,0])
							translate([0,0,nema17_gearbox_hole_pos_dia/2])
								rotate([0,45-i*90,0])
									rotate([0,0,90])
										teardrop(nema17_screw_washer_dia/2+clearance,extruder_back_body_length/2,fulldrop=true);
			}

		// extruder mount screw holes and nut traps
		for(e=[1,-1])
			translate([e*(x_carriage_body_length/2-extruder_mount_screw_washer_dia/2),(wall+clearance+nema17_gearbox_length+clearance+wall+2)/2-x_carriage_body_width/2-1,x_carriage_body_height/2+extruder_mount_screw_washer_dia/2])
				rotate([90,0,0]) rotate([0,90,0])
					teardrop(extruder_mount_screw_dia/2+clearance,wall+clearance+nema17_gearbox_length+clearance+wall+2);
		translate([0,(wall+clearance+nema17_gearbox_length+clearance+wall+2)/2-x_carriage_body_width/2-1,x_carriage_body_height/2+extruder_mount_screw_washer_dia/2])
			rotate([90,0,0]) rotate([0,90,0])
				teardrop(extruder_mount_screw_dia/2+clearance,wall+clearance+nema17_gearbox_length+clearance+wall+2);
		for(e=[0,1])
			mirror([e,0,0])
				translate([x_carriage_body_length/2-extruder_mount_screw_washer_dia/2,extruder_mount_screw_nut_height/2+clearance-x_carriage_body_width/2+wall+wall+nema17_gearbox_length-wall-clearance-extruder_mount_screw_nut_height-clearance,x_carriage_body_height/2+extruder_mount_screw_washer_dia/2])
					rotate([0,-90-45,0])
						rotate([90,0,0])
							nut_slot_square(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,nema17_width);
		translate([0,extruder_mount_screw_nut_height/2+clearance-x_carriage_body_width/2+wall+wall+nema17_gearbox_length-wall-clearance-extruder_mount_screw_nut_height-clearance,x_carriage_body_height/2+extruder_mount_screw_washer_dia/2])
			rotate([0,-90,0])
				rotate([90,0,0])
					nut_slot_square(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,nema17_width);

		// hot end water cooler clearance
		for(i=[-1,1])
			translate([i*(extruder_front_body_width/2+extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2+extruder_hotend_heatsink_width/2+extruder_hotend_heatsink_watercooler_thickness/2),-x_carriage_body_width/2,extruder_back_body_height/2-extruder_front_body_height])
			hull(){
				translate([wall_thin/2,0,0])
					rotate([0,90,0])
						teardrop(extruder_hotend_heatsink_watercooler_steelball_dia/2+clearance,x_carriage_body_height,fulldrop=1);
				translate([-wall_thin/2,0,0])
					rotate([0,90,0])
						rotate([180,0,0])
							teardrop(extruder_hotend_heatsink_watercooler_steelball_dia/2+clearance,x_carriage_body_height,fulldrop=1);
			}
	}

	if(support) mirror([0,1,0]){
		// belt tensioner screw hole printability support layer
		translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2)+(belt_tensioning_nut_height+2*clearance+wall_thin+clearance),x_belt_pulley_dia/2,0])
				rotate([180,0,0]) rotate([0,0,-90])
					translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
						rotate([-90,0,0])
							cylinder(r=belt_tensioning_screw_dia/2+clearance+wall_thin,h=layer_height);
	}
}




