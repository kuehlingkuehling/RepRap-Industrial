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

// FAN DUCT
* difference(){
    air_filter_fan_duct();
    translate([0,-air_filter_fan_duct_body_length/4,0])
        label("41",orientation="bottom");
}

// ACTIVATED CARBON CONTAINER
* difference(){
    air_filter_activatedcarbon_container();
    translate([0,-air_filter_activatedcarbon_container_body_length/2+wall,air_filter_activatedcarbon_container_body_height/4*3])
        label("20",orientation="back");
}

// ACTIVATED CARBON CONTAINER LID
* difference(){
    air_filter_activatedcarbon_container_lid();
    translate([-air_filter_activatedcarbon_container_body_width/2+wall_thin+clearance,0,wall/2])
        label("18",orientation="left");
}




module air_filter_fan_duct(){
	difference(){

		// main body
		intersection(){
			hull(){
				translate([-air_filter_fan_duct_body_width/2+wall,air_filter_fan_duct_body_length/2-wall,0])
					cylinder(r=wall,h=air_filter_fan_duct_body_height);
				translate([-air_filter_fan_duct_body_width/2+wall,-air_filter_fan_duct_body_length/2+wall,0])
					cylinder(r=wall,h=air_filter_fan_duct_body_height);
				translate([air_filter_fan_duct_body_width/2-wall,air_filter_fan_duct_body_length/2-wall,0])
					cylinder(r=wall,h=air_filter_fan_duct_body_height);
				translate([air_filter_fan_duct_body_width/2-wall,-air_filter_fan_duct_body_length/2+wall,0])
					cylinder(r=wall,h=air_filter_fan_duct_body_height);
			}
			union(){
				hull(){
					translate([0,-air_filter_fan_duct_body_length/2+wall,air_filter_fan_duct_body_length-wall])
						rotate([180,0,0])
							teardrop(air_filter_fan_duct_body_length-wall,air_filter_fan_duct_body_width+2);
					translate([0,-air_filter_fan_duct_body_length/2+wall,air_filter_fan_duct_body_length-wall+air_filter_fan_duct_body_height])
						rotate([180,0,0])
							teardrop(air_filter_fan_duct_body_length-wall,air_filter_fan_duct_body_width+2);
				}
				for(h=[0,1])
					mirror([h,0,0])
						hull(){
							translate([-air_filter_fan_duct_body_width/2+wall,air_filter_fan_duct_body_length/2-wall,0])
								cylinder(r=wall,h=air_filter_fan_duct_body_height);
							translate([-air_filter_fan_duct_body_width/2+wall,-air_filter_fan_duct_body_length/2+wall,0])
								cylinder(r=wall,h=air_filter_fan_duct_body_height);
							translate([-air_filter_fan_hole_dist/2-wall,air_filter_fan_duct_body_length/2-wall,0])
								cylinder(r=wall,h=air_filter_fan_duct_body_height);
							translate([-air_filter_fan_hole_dist/2-wall,-air_filter_fan_duct_body_length/2+wall,0])
								cylinder(r=wall,h=air_filter_fan_duct_body_height);
						}
				for(h=[0,1])
					mirror([h,0,0])
						hull(){
							translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2])
								rotate([0,0,90])
									rotate([180,0,0])
										teardrop(air_filter_fan_screw_washer_dia/2+clearance+wall_thin,air_filter_fan_duct_body_length+2);
							translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2-air_filter_fan_duct_body_height])
								rotate([0,0,90])
									rotate([180,0,0])
										teardrop(air_filter_fan_screw_washer_dia/2+clearance+wall_thin,air_filter_fan_duct_body_length+2);
						}
			}
		}

		// inner clearance
		difference(){
			intersection(){
				hull(){
					translate([-air_filter_fan_duct_body_width/2+wall,air_filter_fan_duct_body_length/2-wall,wall_thin])
						cylinder(r=wall-wall_thin,h=air_filter_fan_duct_body_height);
	
					translate([air_filter_fan_duct_body_width/2-wall,air_filter_fan_duct_body_length/2-wall,wall_thin])
						cylinder(r=wall-wall_thin,h=air_filter_fan_duct_body_height);
					translate([-air_filter_fan_duct_body_width/2+wall,-air_filter_fan_duct_body_length/2+wall+wall-wall_thin,wall_thin])
						cylinder(r=wall-wall_thin,h=air_filter_fan_duct_body_height);
					translate([air_filter_fan_duct_body_width/2-wall,-air_filter_fan_duct_body_length/2+wall+wall-wall_thin,wall_thin])
						cylinder(r=wall-wall_thin,h=air_filter_fan_duct_body_height);
				}
				hull(){
					translate([0,-air_filter_fan_duct_body_length/2+wall,air_filter_fan_duct_body_length-wall])
						rotate([0,90,0])
							cylinder(r=air_filter_fan_duct_body_length-wall-wall_thin,h=air_filter_fan_duct_body_width-2*wall_thin,center=true);
					translate([0,-air_filter_fan_duct_body_length/2+wall,air_filter_fan_duct_body_length-wall+air_filter_fan_duct_body_height])
						rotate([0,90,0])
							cylinder(r=air_filter_fan_duct_body_length-wall_thin,h=air_filter_fan_duct_body_width-2*wall_thin,center=true);
				}
			}

			for(h=[0,1])
				mirror([h,0,0]){
					hull(){
						translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(air_filter_fan_screw_washer_dia/2+clearance+wall_thin,air_filter_fan_duct_body_length+2);
						translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2-air_filter_fan_duct_body_height])
							rotate([0,0,90])
								rotate([180,0,0])
									teardrop(air_filter_fan_screw_washer_dia/2+clearance+wall_thin,air_filter_fan_duct_body_length+2);
					}
					translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2+air_filter_fan_hole_dist/2])
						rotate([0,0,90])
							rotate([180,0,0])
								teardrop(air_filter_fan_screw_washer_dia/2+clearance+wall_thin,air_filter_fan_duct_body_length+2);
				}
			for(h=[0,1])
				mirror([h,0,0]){
					hull(){
						translate([-air_filter_fan_duct_body_width/2+wall,air_filter_fan_duct_body_length/2-wall,0])
							cylinder(r=wall,h=(wall+air_filter_fan_side/2)-(air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin));
						translate([-air_filter_fan_duct_body_width/2+wall,-air_filter_fan_duct_body_length/2+wall,0])
							cylinder(r=wall,h=(wall+air_filter_fan_side/2)-(air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin));
						translate([-air_filter_fan_hole_dist/2-wall,air_filter_fan_duct_body_length/2-wall,0])
							cylinder(r=wall,h=(wall+air_filter_fan_side/2)-(air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin));
						translate([-air_filter_fan_hole_dist/2-wall,-air_filter_fan_duct_body_length/2+wall,0])
							cylinder(r=wall,h=(wall+air_filter_fan_side/2)-(air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin));
					}
					hull(){
						translate([air_filter_fan_duct_body_width/2,frame_screw_dia/2+clearance+wall-wall,air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2])
							cylinder(r=wall,h=air_filter_fan_duct_body_height/2-air_filter_fan_hole_dist/2+1);
						translate([air_filter_fan_duct_body_width/2,-(frame_screw_dia/2+clearance+wall-wall),air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2])
							cylinder(r=wall,h=air_filter_fan_duct_body_height/2-air_filter_fan_hole_dist/2+1);
						translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,frame_screw_dia/2+clearance+wall-wall,air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2])
							cylinder(r=wall,h=air_filter_fan_duct_body_height/2-air_filter_fan_hole_dist/2+1);
						translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,-(frame_screw_dia/2+clearance+wall-wall),air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2])
							cylinder(r=wall,h=air_filter_fan_duct_body_height/2-air_filter_fan_hole_dist/2+1);
					}
					hull(){
						translate([air_filter_fan_duct_body_width/2,frame_screw_dia/2+clearance+wall-wall,air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin+wall])
							cylinder(r=wall,h=wall_thin+clearance+air_filter_fan_screw_washer_dia+clearance+wall_thin-wall);
						translate([air_filter_fan_duct_body_width/2,-(frame_screw_dia/2+clearance+wall-wall),air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin+wall])
							cylinder(r=wall,h=wall_thin+clearance+air_filter_fan_screw_washer_dia+clearance+wall_thin-wall);
						translate([air_filter_fan_hole_dist/2,-(frame_screw_dia/2+clearance+wall),air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin+wall])
							cube([wall,2*(frame_screw_dia/2+clearance+wall),wall_thin+clearance+air_filter_fan_screw_washer_dia+clearance+wall_thin-wall]);
					}
				}
		}

		// fan mount
		intersection(){
			translate([0,-air_filter_fan_duct_body_length/2+wall/2,wall+air_filter_fan_side/2])
				rotate([0,0,90])
					teardrop(air_filter_fan_dia/2,wall+2);
			translate([0,-air_filter_fan_duct_body_length/2+wall/2,wall+air_filter_fan_side/2])
				cube([air_filter_fan_cutout_side,wall+2,air_filter_fan_cutout_side],center=true);
		}
		for(h=[0,1])
			mirror([h,0,0]){
				translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_filter_fan_screw_dia/2+clearance,air_filter_fan_duct_body_length+2);
				translate([air_filter_fan_hole_dist/2,0,wall+air_filter_fan_side/2+air_filter_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_filter_fan_screw_dia/2+clearance,air_filter_fan_duct_body_length+2);
				translate([air_filter_fan_hole_dist/2,wall,wall+air_filter_fan_side/2-air_filter_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_filter_fan_screw_washer_dia/2+clearance,air_filter_fan_duct_body_length);
				translate([air_filter_fan_hole_dist/2,wall,wall+air_filter_fan_side/2+air_filter_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_filter_fan_screw_washer_dia/2+clearance,air_filter_fan_duct_body_length);
			}

		// frame mount screw holes, activated carbon container mount screw holes and nut trap
		for(h=[0,1])
			mirror([h,0,0]){
				difference(){
					translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,-1])
						cylinder(r=frame_screw_dia/2+clearance,h=air_filter_fan_duct_body_height+2);
					if(support) translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,air_filter_fan_duct_body_height-wall])
						cylinder(r=frame_screw_dia/2+clearance+1,h=layer_height);
					if(support) translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,air_filter_fan_duct_body_height/2+air_filter_fan_hole_dist/2-air_filter_fan_screw_washer_dia/2-clearance-wall_thin+wall])
						cylinder(r=frame_screw_dia/2+clearance+1,h=layer_height);
				}
				translate([air_filter_fan_duct_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,-(frame_screw_nut_height+2*clearance)/2+air_filter_fan_duct_body_height-wall])
					nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,air_filter_fan_duct_body_width);
			}
	}
}



module air_filter_activatedcarbon_container(){
	difference(){

		// main body
		hull(){
			translate([-air_filter_activatedcarbon_container_body_width/2+wall,air_filter_activatedcarbon_container_body_length/2-wall,0])
				cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height);
			translate([-air_filter_activatedcarbon_container_body_width/2+wall,-air_filter_activatedcarbon_container_body_length/2+wall,0])
				cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height);
			translate([air_filter_activatedcarbon_container_body_width/2-wall,air_filter_activatedcarbon_container_body_length/2-wall,0])
				cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height);
			translate([air_filter_activatedcarbon_container_body_width/2-wall,-air_filter_activatedcarbon_container_body_length/2+wall,0])
				cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height);
		}

		// inner clearance
		difference(){
			union(){
				hull(){
					translate([-air_filter_activatedcarbon_container_body_width/2+wall,air_filter_activatedcarbon_container_body_length/2-wall,-1])
						cylinder(r=wall-wall_thin,h=air_filter_activatedcarbon_container_body_height+2);
					translate([air_filter_activatedcarbon_container_body_width/2-wall,air_filter_activatedcarbon_container_body_length/2-wall,-1])
						cylinder(r=wall-wall_thin,h=air_filter_activatedcarbon_container_body_height+2);
					translate([-air_filter_activatedcarbon_container_body_width/2+wall,-air_filter_activatedcarbon_container_body_length/2+wall+wall-wall_thin,-1])
						cylinder(r=wall-wall_thin,h=air_filter_activatedcarbon_container_body_height+2);
					translate([air_filter_activatedcarbon_container_body_width/2-wall,-air_filter_activatedcarbon_container_body_length/2+wall+wall-wall_thin,-1])
						cylinder(r=wall-wall_thin,h=air_filter_activatedcarbon_container_body_height+2);
				}
				hull(){
					translate([-air_filter_activatedcarbon_container_body_width/2+wall,air_filter_activatedcarbon_container_body_length/2-wall,air_filter_activatedcarbon_container_body_height-wall-clearance])
						cylinder(r=wall-wall_thin,h=wall+clearance+1);
					translate([air_filter_activatedcarbon_container_body_width/2-wall,air_filter_activatedcarbon_container_body_length/2-wall,air_filter_activatedcarbon_container_body_height-wall-clearance])
						cylinder(r=wall-wall_thin,h=wall+clearance+1);
					translate([-air_filter_activatedcarbon_container_body_width/2+wall,-air_filter_activatedcarbon_container_body_length/2+wall,air_filter_activatedcarbon_container_body_height-wall-clearance])
						cylinder(r=wall-wall_thin,h=wall+clearance+1);
					translate([air_filter_activatedcarbon_container_body_width/2-wall,-air_filter_activatedcarbon_container_body_length/2+wall,air_filter_activatedcarbon_container_body_height-wall-clearance])
						cylinder(r=wall-wall_thin,h=wall+clearance+1);
				}
			}
			for(j=[0,1])
				mirror([j,0,0])
					for(i=[0:round((air_filter_activatedcarbon_container_body_width/2)/(air_filter_activatedcarbon_container_grid_bar+air_filter_activatedcarbon_container_grid_space))])
						translate([-air_filter_activatedcarbon_container_grid_bar/2+i*(air_filter_activatedcarbon_container_grid_bar+air_filter_activatedcarbon_container_grid_space),-air_filter_activatedcarbon_container_body_length/2-1,-2])
							cube([air_filter_activatedcarbon_container_grid_bar,air_filter_activatedcarbon_container_body_length+2,wall+2]);
			for(h=[0,1])
				mirror([h,0,0])
					hull(){
						translate([air_filter_activatedcarbon_container_body_width/2,frame_screw_dia/2+clearance+wall-wall,-1])
							cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height-wall-clearance+1);
						translate([air_filter_activatedcarbon_container_body_width/2,-(frame_screw_dia/2+clearance+wall-wall),-1])
							cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height-wall-clearance+1);
						translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,frame_screw_dia/2+clearance+wall-wall,-1])
							cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height-wall-clearance+1);
						translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,-(frame_screw_dia/2+clearance+wall-wall),-1])
							cylinder(r=wall,h=air_filter_activatedcarbon_container_body_height-wall-clearance+1);
					}
		}

		// container mount screw holes
		for(h=[0,1])
			mirror([h,0,0])
				translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,-1])
					cylinder(r=frame_screw_dia/2+clearance,h=air_filter_activatedcarbon_container_body_height+2);
	}
}



module air_filter_activatedcarbon_container_lid(){
	difference(){

		// main body
		hull(){
			translate([-air_filter_activatedcarbon_container_body_width/2+wall,air_filter_activatedcarbon_container_body_length/2-wall,0])
				cylinder(r=wall-wall_thin-clearance,h=wall);
			translate([-air_filter_activatedcarbon_container_body_width/2+wall,-air_filter_activatedcarbon_container_body_length/2+wall,0])
				cylinder(r=wall-wall_thin-clearance,h=wall);
			translate([air_filter_activatedcarbon_container_body_width/2-wall,air_filter_activatedcarbon_container_body_length/2-wall,0])
				cylinder(r=wall-wall_thin-clearance,h=wall);
			translate([air_filter_activatedcarbon_container_body_width/2-wall,-air_filter_activatedcarbon_container_body_length/2+wall,0])
				cylinder(r=wall-wall_thin-clearance,h=wall);
		}

		// inner clearance
		difference(){
			hull(){
				translate([-air_filter_activatedcarbon_container_body_width/2+wall,air_filter_activatedcarbon_container_body_length/2-wall,-1])
					cylinder(r=wall-wall_thin-clearance-wall_thin,h=wall+2);
				translate([air_filter_activatedcarbon_container_body_width/2-wall,air_filter_activatedcarbon_container_body_length/2-wall,-1])
					cylinder(r=wall-wall_thin-clearance-wall_thin,h=wall+2);
				translate([-air_filter_activatedcarbon_container_body_width/2+wall,-air_filter_activatedcarbon_container_body_length/2+wall,-1])
					cylinder(r=wall-wall_thin-clearance-wall_thin,h=wall+2);
				translate([air_filter_activatedcarbon_container_body_width/2-wall,-air_filter_activatedcarbon_container_body_length/2+wall,-1])
					cylinder(r=wall-wall_thin-clearance-wall_thin,h=wall+2);
			}
			for(j=[0,1])
				mirror([j,0,0])
					for(i=[0:round((air_filter_activatedcarbon_container_body_width/2)/(air_filter_activatedcarbon_container_grid_bar+air_filter_activatedcarbon_container_grid_space))])
						translate([-air_filter_activatedcarbon_container_grid_bar/2+i*(air_filter_activatedcarbon_container_grid_bar+air_filter_activatedcarbon_container_grid_space),-air_filter_activatedcarbon_container_body_length/2-1,-2])
							cube([air_filter_activatedcarbon_container_grid_bar,air_filter_activatedcarbon_container_body_length+2,wall+4]);
			for(h=[0,1])
				mirror([h,0,0])
					hull(){
						translate([air_filter_activatedcarbon_container_body_width/2,frame_screw_dia/2+clearance+wall-wall,-1])
							cylinder(r=wall,h=wall+2);
						translate([air_filter_activatedcarbon_container_body_width/2,-(frame_screw_dia/2+clearance+wall-wall),-1])
							cylinder(r=wall,h=wall+2);
						translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,frame_screw_dia/2+clearance+wall-wall,-1])
							cylinder(r=wall,h=wall+2);
						translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2-frame_screw_dia/2-clearance-wall+wall,-(frame_screw_dia/2+clearance+wall-wall),-1])
							cylinder(r=wall,h=wall+2);
					}
		}

		// container mount screw holes
		for(h=[0,1])
			mirror([h,0,0])
				translate([air_filter_activatedcarbon_container_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,0,-1])
					cylinder(r=frame_screw_dia/2+clearance,h=wall+2);
	}
}





