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
difference(){
    z_elevator();
    translate([z_elevator_body_width/4,0,0])
        label("39",orientation="bottom");
}





module z_elevator(){
	difference(){

		// main body
		union(){
			for(h=[0,1])
				mirror([h,0,0])
					hull(){
						translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,linear_bearing_dia/2+clearance+wall-wall,0])
							cylinder(r=wall,h=z_elevator_body_height);
						translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall+wall,-linear_bearing_dia/2-clearance-wall+wall,0])
							cylinder(r=wall,h=z_elevator_body_height);
						translate([z_elevator_body_width/2-wall,linear_bearing_dia/2+clearance+wall-wall,0])
							cylinder(r=wall,h=z_elevator_body_height);
						translate([z_elevator_body_width/2-wall,-linear_bearing_dia/2-clearance-wall+wall,0])
							cylinder(r=wall,h=z_elevator_body_height);
					}
			difference(){
				hull(){
					for(h=[0,1])
						mirror([h,0,0]){
							translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,z_elevator_body_length/2-wall,0])
								cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
							translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,-z_elevator_body_length/2+wall,0])
								cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
							translate([z_elevator_body_width/2-wall,linear_bearing_dia/2+clearance+wall-wall,0])
								cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
							translate([z_elevator_body_width/2-wall,-linear_bearing_dia/2-clearance-wall+wall,0])
								cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
						}
				}
				for(h=[0,1])
					mirror([h,0,0])
						translate([-1,-(z_elevator_body_length-2*wall)/2,z_spindle_nut_height+clearance+wall])
							cube([(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small-clearance-wall)+1,z_elevator_body_length-2*wall,z_elevator_body_height]);
			}

			intersection(){
				hull(){
					hull(){
						for(h=[0,1])
							mirror([h,0,0]){
								translate([z_elevator_body_width/2-wall,linear_bearing_dia/2+clearance+wall-wall,0])
									cylinder(r=wall,h=z_elevator_body_height);
								translate([z_elevator_body_width/2-wall,-linear_bearing_dia/2-clearance-wall+wall,0])
									cylinder(r=wall,h=z_elevator_body_height);
							}
					}
					hull(){
						for(h=[0,1])
							mirror([h,0,0]){
								translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,z_elevator_body_length/2-wall,0])
									cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
								translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,-z_elevator_body_length/2+wall,0])
									cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
								translate([z_elevator_body_width/2-wall,linear_bearing_dia/2+clearance+wall-wall,0])
									cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
								translate([z_elevator_body_width/2-wall,-linear_bearing_dia/2-clearance-wall+wall,0])
									cylinder(r=wall,h=wall+clearance+frame_width+clearance+wall);
							}
					}
				}
				union(){
					for(h=[0,1])
						mirror([h,0,0]){
							translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin,-z_elevator_body_length/2-1,-1])
								cube([z_elevator_body_width/2,z_elevator_body_length+2,z_elevator_body_height+2]);
							translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small-clearance-wall,-z_elevator_body_length/2-1,-1])
								cube([wall,z_elevator_body_length+2,z_elevator_body_height+2]);
						}
					for(h=[0,1])
						mirror([0,h,0])
							translate([-z_elevator_body_width/2-1,linear_bearing_dia/2+clearance,-1])
								cube([z_elevator_body_width+2,wall,z_elevator_body_height+2]);
				}
			}



			// z endstop mount
			difference(){
				translate([-z_elevator_body_width/2,0,-(wall+clearance+endstop_screw_dia/2)+endstop_hole_sensor_dist])
					rotate([0,-90,0])
						rotate([0,0,-90])
							endstop_mount(teardrop_angle=90,top=0);
				translate([0,0,-z_elevator_body_height/2])
					cube([2*z_elevator_body_width,z_elevator_body_length+2,z_elevator_body_height],center=true);
			}
		}

		// spindle nut mount
		difference(){
			translate([0,0,-1])
				cylinder(r=z_spindle_nut_dia/2+clearance,h=z_elevator_body_height+2);
			for(n=[0,1])
				mirror([0,n,0])
					translate([-z_elevator_body_width/2,z_spindle_dia/2+wall_thin,z_spindle_nut_height+clearance])
						cube([z_elevator_body_width,z_elevator_body_length/2,z_elevator_body_height]);
		}
		translate([0,0,z_spindle_nut_height/2])
			rotate([0,0,90])
				teardrop(z_spindle_nut_screw_dia/2+clearance,z_elevator_body_length+2);
		for(m=[1,-1])
			translate([0,m*(z_spindle_nut_dia/2+wall_thin+clearance+z_spindle_nut_screw_nut_height/2),z_spindle_nut_height/2])
				rotate([0,180,0])
					rotate([0,0,90])
						nut_slot_square(z_spindle_nut_screw_nut_wrench,z_spindle_nut_screw_nut_height,z_spindle_nut_height/2,vertical=1);

		for(i=[0,1])
			mirror([i,0,0]){

				// linear bearing mounts
				difference(){
					translate([z_rod_dist/2,0,-1])
						cylinder(r=linear_bearing_dia/2+clearance_tight,h=z_elevator_body_height+2);

					// linear bearing push in stop
					translate([0,linear_bearing_dia/2+clearance-wall_thin,z_elevator_body_height/2-linear_bearing_dist_min/2+clearance])
						cube([z_elevator_body_width/2,2*wall_thin,linear_bearing_dist_min-2*clearance]);
				}
				hull(){
					translate([linear_bearing_dia/2+z_rod_dist/2,0,z_elevator_body_height-linear_bearing_length+2*wall])
							teardrop(wall/2,linear_bearing_dia);
					translate([linear_bearing_dia/2+z_rod_dist/2,0,linear_bearing_length-2*wall])
							teardrop(wall/2,linear_bearing_dia);
				}

				// platform frame mount
				translate([-frame_width_small-2*clearance+z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin,-(z_elevator_body_length-2*wall+1)+z_elevator_body_length/2-2*wall,wall+clearance])
					cube([frame_width_small+2*clearance,z_elevator_body_length-2*wall+1,frame_width+2*clearance]);
				difference(){
					union(){
						translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,-(z_elevator_body_length/2-wall-clearance-frame_screw_washer_dia/2),-1])
							cylinder(r=frame_screw_dia/2+clearance,h=z_elevator_body_height+2);
						translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,-(z_elevator_body_length/2-wall-clearance-frame_screw_washer_dia/2),wall+clearance+frame_width+clearance+wall])
							cylinder(r=frame_screw_washer_dia/2+clearance,h=z_elevator_body_height);
					}
					if(support) translate([0,0,layer_height/2+wall+clearance+frame_width+clearance])
						cube([z_elevator_body_width+2,z_elevator_body_length+2,layer_height],center=true);
				}
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,0,wall+clearance+frame_width/2])
					rotate([0,0,90])
						teardrop(frame_center_screw_dia/2+clearance,z_elevator_body_length+2);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,z_elevator_body_length-wall,wall+clearance+frame_width/2])
					rotate([0,0,90])
						teardrop(frame_center_screw_washer_dia/2+clearance,z_elevator_body_length);
			}
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
				intersection(){
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
					translate([0,-(2*wall+2*clearance+endstop_screw_dia),0])
						hull(){
							translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,endstop_screw_nut_height+2*clearance+2*wall-wall-wall])
								cube([endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall,2*(2*wall+2*clearance+endstop_screw_dia),wall]);
							translate([endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance,0,0])
								rotate([-90,0,0])
									cylinder(r=wall,h=2*(2*wall+2*clearance+endstop_screw_dia));
							translate([-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance),0,0])
								rotate([-90,0,0])
									cylinder(r=wall,h=2*(2*wall+2*clearance+endstop_screw_dia));
							translate([endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance,0,0])
								rotate([-90,0,0])
									cylinder(r=wall,h=2*(2*wall+2*clearance+endstop_screw_dia));
							translate([-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance),0,0])
								rotate([-90,0,0])
									cylinder(r=wall,h=2*(2*wall+2*clearance+endstop_screw_dia));
							translate([0,0,-(endstop_hole_dist/2+endstop_screw_nut_wrench/2+clearance)])
								rotate([-90,0,0])
									cylinder(r=wall,h=2*(2*wall+2*clearance+endstop_screw_dia));
						}
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
	if(teardrop==0) if(top==1)
		for(j=[-1,1])
			translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,endstop_screw_nut_height+2*clearance])
				cylinder(r=endstop_screw_dia/2+clearance+wall_thin,h=layer_height);
}




