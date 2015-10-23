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

// TOP
* difference(){
    z_end(top=1);
    translate([-z_end_body_width/4,0,0])
        label("23",orientation="bottom");
}

// BOTTOM
* difference(){
    z_end(top=0);
    translate([-z_end_body_width/4,0,0])
        label("24",orientation="bottom");
}




module z_end(top=0){
	difference(){

		// main body
		union(){
			hull(){
				for(i=[0,1])
					mirror([i,0,0]){
						translate([z_end_body_width/2-wall,-rod_dia/2-clearance-wall+wall,0])
							cylinder(r=wall,h=z_end_body_height);
						translate([z_end_body_width/2-wall,set_collar_body_dia/2+wall_thin+wall-wall,0])
							cube([wall,wall,z_end_body_height]);
					}
			}
			cylinder(r=set_collar_body_dia/2+wall_thin+wall,h=z_end_body_height);

			// endstop magnet countersink extension
			if(top==0)
				intersection(){
					hull(){
						translate([-z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-endstop_screw_nut_height-clearance-wall-endstop_magnet_dia/2-clearance-wall+wall,endstop_magnet_dia/2+clearance+wall-wall,0])
							cylinder(r=wall,h=z_end_body_height);
						translate([-z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-endstop_screw_nut_height-clearance-wall-endstop_magnet_dia/2-clearance-wall+wall,-(endstop_magnet_dia/2+clearance+wall-wall),0])
							cylinder(r=wall,h=z_end_body_height);
						translate([-z_rod_dist/2,endstop_magnet_dia/2+clearance+wall-wall,0])
							cylinder(r=wall,h=z_end_body_height);
						translate([-z_rod_dist/2,-(endstop_magnet_dia/2+clearance+wall-wall),0])
							cylinder(r=wall,h=z_end_body_height);
					}
					hull(){
						translate([-z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-endstop_screw_nut_height-clearance-wall-endstop_magnet_dia/2-clearance-wall+wall,0,z_end_body_height+1])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(wall,2*z_end_body_length);
						translate([-z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-endstop_screw_nut_height-clearance-wall-endstop_magnet_dia/2-clearance-wall+wall,0,z_end_body_height-endstop_magnet_length-clearance-wall])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(wall,2*z_end_body_length);
						translate([-z_rod_dist/2,0,z_end_body_height-endstop_magnet_length-clearance-wall-(linear_bearing_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall+endstop_magnet_dia/2+clearance+wall-wall)])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(wall,2*z_end_body_length);
						translate([-z_rod_dist/2,0,z_end_body_height+1])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(wall,2*z_end_body_length);
					}
				}

			// cablechain mount
			if(top==1)
				difference(){
					union(){
						intersection(){
							difference(){
								cylinder(r=z_elevator_body_length/2+wall,h=z_end_body_height);
								translate([0,0,-1])
									cylinder(r=z_elevator_body_length/2+wall-wall,h=z_end_body_height+2);
							}
							translate([-z_end_body_width/2,-(z_elevator_body_length/2+wall+1),0])
								cube([z_end_body_width,z_elevator_body_length/2+wall+1,z_end_body_height]);
						}	
						translate([-((z_cablechain_width+4*z_cablechain_wall+2*clearance+z_cablechain_dividers*wall_thin))/2,-(z_elevator_body_length/2+wall),0])
							cube([(z_cablechain_width+4*z_cablechain_wall+2*clearance+z_cablechain_dividers*wall_thin),wall+clearance+frame_screw_nut_height,z_end_body_height]);
					}
				translate([0,-(z_elevator_body_length/2+wall-wall/2),z_end_body_height/2])
					rotate([0,0,90])
						teardrop(frame_screw_dia/2+clearance,wall+2);
					translate([0,(frame_screw_nut_height+clearance+1)/2-(z_elevator_body_length/2+wall-wall),z_end_body_height/2])
						rotate([90,0,0])
							nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
				}
		}

		// spindle clearance
		translate([0,0,-1])
			cylinder(r=bearing_dia/2+clearance-wall,h=z_end_body_height+2);

		// spindle bearing trap
		translate([0,0,z_end_body_height-set_collar_body_height-bearing_width-clearance])
			cylinder(r=bearing_dia/2+clearance_tight,h=z_end_body_height);
		if(top==0)
			hull(){
				translate([0,-z_end_body_length/2,z_end_body_height-set_collar_body_height-wall_thin-clearance-bearing_width-wall/2])
					rotate([0,0,90])
						teardrop(wall/2,z_end_body_length);
				translate([0,-z_end_body_length/2,z_end_body_height-set_collar_body_height-wall_thin-clearance-bearing_width/2-wall/2])
					rotate([0,0,90])
						teardrop(wall/2,z_end_body_length);
			}
		for(i=[0,1])
			mirror([i,0,0])
				translate([bearing_dia/2,0,-1])
					cylinder(r=wall/2,h=z_end_body_height+2);

		// set collar clearance and set collar screw accessability
		translate([0,0,z_end_body_height-set_collar_body_height])
			cylinder(r=set_collar_body_dia/2+wall_thin,h=z_end_body_height);
		translate([set_collar_screw_pos_radius,-z_elevator_body_length/2,z_end_body_height-set_collar_body_height/2])
			rotate([0,0,90])
				teardrop(set_collar_screw_hex_wrench_dia/2+wall_thin,z_elevator_body_length);

		// center marking for easier positioning during assembly
		translate([0,-rod_dia/2-clearance-wall+z_end_body_length-wall/2,z_end_body_height-wall_thin])
			cylinder(r=wall_thin/2,h=wall);
		translate([0,-rod_dia/2-clearance-wall+z_end_body_length-wall/2,-wall+wall_thin])
			cylinder(r=wall_thin/2,h=wall);

		// rod clamps
		for(i=[0,1])
			mirror([i,0,0]){
				translate([z_rod_dist/2,0,-1])
					cylinder(r=rod_dia/2+clearance_tight,h=z_end_body_height+2);
				translate([z_rod_dist/2-rod_dia/2-clearance-wall_thin-clearance-frame_screw_dia/2,0,z_end_body_height/2])
					rotate([0,0,90])
						teardrop(frame_screw_dia/2+clearance,2*z_end_body_length);
				translate([-(rod_dia/2+clearance+wall_thin+clearance+frame_screw_dia+clearance+wall+wall_thin)+z_rod_dist/2,-wall_thin/2,-1])
					cube([rod_dia/2+clearance+wall_thin+clearance+frame_screw_dia+clearance+wall+wall_thin,wall_thin,z_end_body_height+2]);
				translate([-wall_thin+z_rod_dist/2-rod_dia/2-clearance-wall_thin-clearance-frame_screw_dia-clearance-wall,-(rod_dia/2+clearance+wall+1)+wall_thin/2,-1])
					cube([wall_thin,rod_dia/2+clearance+wall+1,z_end_body_height+2]);
			}

		// endstop magnet countersink
		if(top==0)
			translate([-z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-endstop_screw_nut_height-clearance-wall,0,z_end_body_height-endstop_magnet_length-clearance])
				cylinder(r=endstop_magnet_dia/2+clearance,h=endstop_magnet_length+clearance+1);
	}
}
