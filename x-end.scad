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


// X-END MOTOR
* rotate([90,0,0])
    difference(){
        x_end(motor=1);
        translate([0,x_end_body_length,-x_end_body_height/2])
            label("76",orientation="back");
    }

// X-END IDLER
* rotate([90,0,0]) mirror([1,0,0])
    difference(){
        x_end(motor=0);
        translate([0,x_end_body_length,-x_end_body_height/2])
            mirror([1,0,0]) label("51",orientation="back");
    }

// X-IDLER SHAFT (2x)
* difference(){
    x_idler_shaft();
    translate([0,-(x_idler_bolt_dia/2+clearance)-((bearing_center_dia/2-clearance_tight+wall_thin)-(x_idler_bolt_dia/2+clearance))/2,0])
        label("59",orientation="bottom",size=3);
}



/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
X ROD LENGTH = frame_extrusion_length_horizontal (see configuration.scad)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */




module x_end(motor=1){
	difference(){

		// main body
		union(){
			translate([-linear_bearing_dia/2-clearance-motor*(wall_thin+clearance+nema17_screw_hex_wrench_dia/2+nema17_screw_dia/2+clearance)-wall,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				hull(){
					translate([wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([wall,0,x_end_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([x_end_body_width+motor*x_end_body_width_motor_addition-wall,0,x_end_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([x_end_body_width+motor*x_end_body_width_motor_addition-wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
				}
			if(motor==1){

				// y endstop mount
				translate([0,x_end_body_length-(wall+clearance+endstop_screw_dia/2)-endstop_hole_sensor_dist+(clearance+endstop_screw_nut_height+clearance+wall+endstop_height),linear_bearing_dia/2+clearance+wall])
					endstop_mount(teardrop=1,teardrop_angle=90,top=0);

				// x endstop support (prevent crushing of x endstop when bouncing against y-end)
				translate([0,clearance+endstop_screw_nut_height+clearance+wall,0])
					hull(){
						translate([-rod_dia/2+wall,0,-wall])
							rotate([-90,0,0])
								cylinder(r=wall, h=x_end_body_length);
						translate([-rod_dia/2+wall,0,-rod_dia/2-clearance-wall_thin-clearance-frame_screw_dia-clearance-wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall, h=x_end_body_length);
						translate([rod_dia/2-wall,0,-wall])
							rotate([-90,0,0])
								cylinder(r=wall, h=x_end_body_length);
						translate([rod_dia/2-wall,0,-rod_dia/2-clearance-wall_thin-clearance-frame_screw_dia-clearance-wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall, h=x_end_body_length);
					}

				// x endstop mount
				translate([-linear_bearing_dia/2-clearance-wall+x_end_body_width-(wall+clearance+endstop_screw_dia/2)-endstop_hole_sensor_dist,x_end_body_length,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,-90])
							endstop_mount(teardrop=0,top=1);

				// y cablechain mount
				translate([-rod_dia/2-clearance-wall,0,linear_bearing_dia/2+clearance+wall-x_end_body_height-wall])
					cube([(y_cablechain_width+4*y_cablechain_wall+2*clearance+y_cablechain_dividers*wall_thin),wall+clearance+frame_screw_dia/2+frame_width/2,2*wall]);
			}
		}

		// linear bearing mounts
		difference(){
			translate([0,-x_end_body_length/2,0])
				rotate([-90,0,0])
					cylinder(r=linear_bearing_dia/2+clearance_tight, h=2*x_end_body_length);

			// linear bearing push in stop
			translate([-linear_bearing_dia/2-clearance-wall_thin,x_end_body_length/2-(x_end_body_length-2*linear_bearing_length-2*clearance)/2,-linear_bearing_dia/2-clearance-wall_thin])
				cube([2*wall_thin,x_end_body_length-2*linear_bearing_length-2*clearance,linear_bearing_dia+2*clearance+2*wall_thin]);
		}
		hull(){
			translate([0,linear_bearing_length-2*wall,x_end_body_height/2])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(wall/2,x_end_body_height);
			translate([0,linear_bearing_length+2*wall,x_end_body_height/2])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(wall/2,x_end_body_height);
		}
		hull(){
			translate([0,x_end_body_length-(linear_bearing_length-2*wall),x_end_body_height/2])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(wall/2,x_end_body_height);
			translate([0,x_end_body_length-(linear_bearing_length+2*wall),x_end_body_height/2])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(wall/2,x_end_body_height);
		}

		// x rod mount holes
		for(j=[-1,1]){
			translate([(x_end_body_width+x_end_body_width_motor_addition)/2-rod_dia/2-clearance-wall-clearance-wall/2,x_end_body_length/2+j*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
				rotate([-90,0,0])
					teardrop(rod_dia/2+clearance,x_end_body_width+x_end_body_width_motor_addition);
		}

		// x motor mount
		if(motor==1)
			translate([-linear_bearing_dia/2-clearance-wall_thin-clearance-nema17_screw_hex_wrench_dia/2+nema17_hole_dist/2,x_end_body_length/2,-x_end_body_height+linear_bearing_dia/2+clearance+wall-1]){
				translate([0,0,(rod_dia/2+clearance+2*wall+1)/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(x_belt_pulley_dia/2+wall_thin+wall_thin,rod_dia/2+clearance+2*wall+1);
				for(j=[-1,1])
					for(k=[-1,1])
						translate([j*nema17_hole_dist/2,k*nema17_hole_dist/2,(rod_dia/2+clearance+2*wall+1)/2])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_dia/2+clearance,rod_dia/2+clearance+2*wall+1);
				for(j=[-1,1])
					for(k=[-1,1])
						translate([j*nema17_hole_dist/2,k*nema17_hole_dist/2,(2*x_end_body_height)/2])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_hex_wrench_dia/2+clearance,2*x_end_body_height);
				for(k=[-1,1])
					hull(){
						translate([-nema17_hole_dist/2,k*nema17_hole_dist/2,(rod_dia+2*clearance)/2+1+2*wall])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_washer_dia/2+clearance,rod_dia+2*clearance);
						translate([-nema17_hole_dist/2-x_end_body_width,k*nema17_hole_dist/2,(rod_dia+2*clearance)/2+1+2*wall])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_washer_dia/2+clearance,rod_dia+2*clearance);
					}
				for(k=[-1,1])
					hull(){
						translate([nema17_hole_dist/2,k*nema17_hole_dist/2,(rod_dia+2*clearance)/2+1+2*wall])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_washer_dia/2+clearance,rod_dia+2*clearance);
						translate([nema17_hole_dist/2+x_end_body_width,k*nema17_hole_dist/2,(rod_dia+2*clearance)/2+1+2*wall])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_washer_dia/2+clearance,rod_dia+2*clearance);
					}
				for(j=[-1,1])
					for(k=[-1,1])
						translate([j*nema17_hole_dist/2,k*nema17_hole_dist/2,(rod_dia+2*clearance)/2+1+wall])
							rotate([-90,0,0])
								rotate([0,0,90])
									teardrop(nema17_screw_washer_dia/2+clearance,rod_dia+2*clearance);

				// nema17 shaft clearance
				translate([0,0,(nema17_shaft_length+wall_thin)/2+1])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(nema17_shaft_dia/2+wall_thin,nema17_shaft_length+wall_thin);
			}

		// x belt idler mount
		if(motor==0){
			translate([(-linear_bearing_dia/2-clearance-wall)+x_end_body_width-(x_belt_pulley_dia/2+wall_thin),x_end_body_length/2,-linear_bearing_dia/2-clearance-wall+3*wall-x_end_body_height/2+wall])
				rotate([-90,0,0])
					rotate([0,0,90])
						teardrop(x_idler_bolt_dia/2+clearance,x_end_body_height);
			translate([(-linear_bearing_dia/2-clearance-wall)+x_end_body_width-(x_belt_pulley_dia/2+wall_thin),x_end_body_length/2,-x_end_body_height/2+linear_bearing_dia/2+clearance+wall-x_end_body_height+wall])
				rotate([-90,0,0])
					rotate([0,0,90])
						teardrop(x_idler_bolt_head_flange_dia/2+clearance,x_end_body_height);
			translate([(-linear_bearing_dia/2-clearance-wall)+x_end_body_width-(x_belt_pulley_dia/2+belt_thickness_max),x_end_body_length/2,(x_idler_bolt_nut_height+2*clearance)/2-linear_bearing_dia/2-clearance-wall+wall])
				rotate()
					nut_slot_square(x_idler_bolt_wrench,x_idler_bolt_nut_height,x_end_body_width);
		}

		// x belt clearance
		if(motor==1)
			hull(){
				translate([(-linear_bearing_dia/2-clearance-wall_thin-clearance-nema17_screw_hex_wrench_dia/2+nema17_hole_dist/2),x_end_body_length/2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(x_belt_pulley_dia/2+wall_thin+belt_thickness_max+wall_thin,rod_dia+2*clearance);
				translate([x_end_body_width,x_end_body_length/2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(x_belt_pulley_dia/2+wall_thin+belt_thickness_max+wall_thin,rod_dia+2*clearance);
			}
		if(motor==0)
			hull(){
				translate([(-linear_bearing_dia/2-clearance-wall)+x_end_body_width-(x_belt_pulley_dia/2+wall_thin),x_end_body_length/2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(x_belt_pulley_dia/2+wall_thin+belt_thickness_max+wall_thin,rod_dia+2*clearance);
				translate([x_end_body_width,x_end_body_length/2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(x_belt_pulley_dia/2+wall_thin+belt_thickness_max+wall_thin,rod_dia+2*clearance);
			}

		// y belt grip
		translate([y_rod_y_belt_x_dist-belt_width/2-clearance,0,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2])
			translate([0,0,-belt_thickness_min])
				difference(){
					union(){
						translate([0,-1,-(2*belt_thickness_min+2*clearance)/2])
							cube([y_rod_y_belt_x_dist,belt_grip_length*belt_tooth_periode+1,2*belt_thickness_min+2*clearance]);
						for(i=[0:(belt_grip_length-1)])
							translate([0,belt_tooth_periode/2+i*belt_tooth_periode,-(2*belt_thickness_max+2*clearance)/2])
								cube([y_rod_y_belt_x_dist,belt_tooth_periode/2,2*belt_thickness_max+2*clearance]);
						translate([y_rod_y_belt_x_dist/2,belt_tooth_periode+(belt_grip_length-1)*belt_tooth_periode,0])
							rotate([-90,0,0])
								teardrop(belt_thickness_max+clearance,y_rod_y_belt_x_dist);
					}
					if(support) for(l=[0:(belt_grip_length-2)])
						translate([-1,belt_tooth_periode+l*belt_tooth_periode,-(2*belt_thickness_max+2*clearance+2)/2])
							cube([y_rod_y_belt_x_dist+2,layer_height,2*belt_thickness_max+2*clearance+2]);
				}

		// y belt tensioner
		difference(){
			translate([y_rod_y_belt_x_dist,x_end_body_length-belt_tensioner_length-belt_tensioning_range,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2]){
				translate([0,-(belt_tensioning_range-1+2*wall+belt_tensioning_knurled_nut_height),0])
					rotate([-90,0,0])
						cylinder(r=belt_tensioning_screw_dia/2+clearance,h=belt_tensioning_range+2*wall+belt_tensioning_knurled_nut_height+1);
				translate([0,-(2*wall+belt_tensioning_knurled_nut_height+wall_thin),0])
					rotate([-90,0,0])
						cylinder(r=belt_tensioning_knurled_nut_dia/2+wall_thin,h=belt_tensioning_knurled_nut_height+wall_thin);
				translate([0,-(2*wall+belt_tensioning_knurled_nut_height+wall_thin),-(belt_tensioning_knurled_nut_dia+2*wall_thin)/2])
						cube([belt_tensioning_knurled_nut_dia+2*wall_thin,belt_tensioning_knurled_nut_height+wall_thin,belt_tensioning_knurled_nut_dia+2*wall_thin]);
			}
			if(support) intersection(){
				translate([x_end_body_width_motor_addition+x_end_body_width-linear_bearing_dia/2-clearance-wall_thin-clearance-nema17_screw_hex_wrench_dia/2-nema17_screw_dia/2-clearance-wall-wall,-2,linear_bearing_dia/2+clearance])
					cube([2*wall,x_end_body_length+4,2*wall]);
				difference(){
					translate([x_end_body_width_motor_addition+x_end_body_width-linear_bearing_dia/2-clearance-wall_thin-clearance-nema17_screw_hex_wrench_dia/2-nema17_screw_dia/2-clearance-wall-wall,0,linear_bearing_dia/2+clearance])
						rotate([-90,0,0])
							cylinder(r=wall,h=x_end_body_length);
					translate([x_end_body_width_motor_addition+x_end_body_width-linear_bearing_dia/2-clearance-wall_thin-clearance-nema17_screw_hex_wrench_dia/2-nema17_screw_dia/2-clearance-wall-wall,0,linear_bearing_dia/2+clearance])
						rotate([-90,0,0])
							cylinder(r=wall-1.5*wall_thin,h=x_end_body_length+2);
				}
			}

			// y belt tensioner screw hole printability support
			if(support) translate([y_rod_y_belt_x_dist,x_end_body_length-belt_tensioner_length-belt_tensioning_range,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2])
				translate([0,-2*wall,0])
					rotate([-90,0,0])
						cylinder(r=belt_tensioning_screw_dia/2+clearance+1,layer_height);
		}

		// y belt tensioning cutoff
		hull(){
			translate([y_rod_y_belt_x_dist,x_end_body_length-belt_tensioner_length-belt_tensioning_range,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2])
				rotate([0,0,90])
					rotate([-90,0,0])
						hull(){
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,belt_tensioner_width/2+wall_thin-wall,belt_tensioner_height/2+wall_thin-wall])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,-(belt_tensioner_width/2+wall_thin-wall),belt_tensioner_height/2+wall_thin-wall])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,belt_tensioner_width/2+wall_thin-wall,-(belt_tensioner_height/2+wall_thin-wall)])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,-(belt_tensioner_width/2+wall_thin-wall),-(belt_tensioner_height/2+wall_thin-wall)])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
						}
			translate([y_rod_y_belt_x_dist,x_end_body_length-belt_tensioner_length-belt_tensioning_range,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2+x_end_body_height/2])
				rotate([0,0,90])
					rotate([-90,0,0])
						hull(){
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,belt_tensioner_width/2+wall_thin-wall,belt_tensioner_height/2+wall_thin-wall])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,-(belt_tensioner_width/2+wall_thin-wall),belt_tensioner_height/2+wall_thin-wall])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,belt_tensioner_width/2+wall_thin-wall,-(belt_tensioner_height/2+wall_thin-wall)])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
							translate([(belt_tensioner_length+belt_tensioning_range+1)/2,-(belt_tensioner_width/2+wall_thin-wall),-(belt_tensioner_height/2+wall_thin-wall)])
								teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
						}
		}

		// y cablechain mount hole and nut trap
		if(motor==1){
			translate([-rod_dia/2-clearance-wall+(y_cablechain_width+4*y_cablechain_wall+2*clearance+y_cablechain_dividers*wall_thin)/2,wall+clearance+frame_screw_dia/2,linear_bearing_dia/2+clearance+wall-x_end_body_height-wall+(wall+clearance+frame_screw_nut_height+clearance+wall)/2-1])
				rotate([0,90,0])
					rotate([-90,0,0])
						teardrop(frame_screw_dia/2+clearance,wall+clearance+frame_screw_nut_height+clearance+wall+1);
			translate([-rod_dia/2-clearance-wall+(y_cablechain_width+4*y_cablechain_wall+2*clearance+y_cablechain_dividers*wall_thin)/2,wall+clearance+frame_screw_dia/2,linear_bearing_dia/2+clearance+wall-x_end_body_height+(frame_screw_nut_height+2*clearance)/2])
				rotate([0,0,-90])
					rotate([0,0,0])
						nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,frame_screw_dia/2+clearance+wall+1);
		}
	}
}


module x_idler_shaft(){
	difference(){
		union(){
			cylinder(r=bearing_center_dia/2-clearance_tight+wall_thin,h=rod_dia/2-bearing_width/2);
			cylinder(r=bearing_center_dia/2-clearance_tight,h=rod_dia/2-clearance/2);
		}
		translate([0,0,-1])
			cylinder(r=x_idler_bolt_dia/2+clearance,h=rod_dia+2);
	}
}



module endstop_mount(teardrop=1,teardrop_angle=-90,top=1){
	difference(){

		// main body
		union(){
			hull(){
				translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,endstop_screw_nut_height+2*clearance+2*wall-wall-wall])
					cube([endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall,2*wall+2*clearance+endstop_screw_dia,wall]);
				translate([endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance,0,0])
					rotate([-90,0,0])
						cylinder(r=wall,h=2*wall+2*clearance+endstop_screw_dia);
				translate([-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance),0,0])
					rotate([-90,0,0])
						cylinder(r=wall,h=2*wall+2*clearance+endstop_screw_dia);
			}
			if(top==1)
			hull(){
				translate([endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance,0,0])
					rotate([-90,0,0])
						cylinder(r=wall,h=2*wall+2*clearance+endstop_screw_dia);
				translate([-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance),0,0])
					rotate([-90,0,0])
						cylinder(r=wall,h=2*wall+2*clearance+endstop_screw_dia);
				translate([0,0,-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance)])
					rotate([-90,0,0])
						cylinder(r=wall,h=2*wall+2*clearance+endstop_screw_dia);
			}
			if(top==0)
			hull(){
				translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,endstop_screw_nut_height+2*clearance])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall);
				translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,-(endstop_screw_nut_height+2*clearance+wall)-wall,(endstop_screw_nut_height+2*clearance)-(endstop_screw_nut_height+2*clearance+wall)-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall);
				translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,(endstop_screw_nut_height+2*clearance)-(endstop_screw_nut_height+2*clearance+wall)-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall);
			}
		}
		for(k=[-1,1])
			translate([-(endstop_screw_nut_wrench+2*clearance)/2+k*endstop_hole_dist/2,-1-(2*wall+2*clearance+endstop_screw_dia+2),0])
				cube([endstop_screw_nut_wrench+2*clearance,2*(2*wall+2*clearance+endstop_screw_dia+2),endstop_screw_nut_height+2*clearance]);
		if(teardrop==1)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,(endstop_screw_nut_height+2*clearance+wall+1)/2])
					rotate([0,0,teardrop_angle])
						rotate([0,90,0])
							teardrop(endstop_screw_dia/2+clearance,endstop_screw_nut_height+2*clearance+wall+1);
		if(teardrop==0)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,0])
					cylinder(r=endstop_screw_dia/2+clearance,h=endstop_screw_nut_height+2*clearance+wall+1);
	}

	// hole printability support layer for top surface use of endstop_mount (no teardrop)
	if(support) if(teardrop==0) if(top==1)
		for(j=[-1,1])
			translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,endstop_screw_nut_height+2*clearance])
				cylinder(r=endstop_screw_dia/2+clearance+wall_thin,h=layer_height);
}


