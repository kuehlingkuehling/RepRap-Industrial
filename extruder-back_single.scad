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
rotate([90,0,0]) 
    difference(){
        extruder_back();
        translate([-extruder_back_body_width/2,extruder_back_body_length/2,0])
            label("38 SINGLE",orientation="bottom");
    }




module extruder_back(){
	difference(){

		// main body
		union(){

			// extruder body
			for(i=[1,1]) translate([extruder_back_body_width/2-i*extruder_back_body_width,0,0]) mirror([i,0,0]) hull(){
				translate([-extruder_back_body_width/2-(extruder_mount_screw_dia/2+clearance),0,extruder_back_body_height-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_back_body_length);
				translate([extruder_back_body_width/2-wall,0,extruder_back_body_height-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_back_body_length);
				translate([-extruder_back_body_width/2-(extruder_mount_screw_dia/2+clearance)-wall,0,clearance])
					cube([extruder_back_body_width+(extruder_mount_screw_dia/2+clearance)+wall,extruder_back_body_length,wall]);
			}

			// cablechain mount body
			hull(){
				translate([(2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall)/2-extruder_back_body_width,wall,extruder_back_body_height-wall])
					rotate([90,0,0])
						teardrop(wall,2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall);
				translate([(2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall)/2-extruder_back_body_width,wall,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-wall-(extruder_back_body_length-2*wall)])
					rotate([90,0,0])
						teardrop(wall,2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall);
				translate([(2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall)/2-extruder_back_body_width,extruder_back_body_length-wall,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-wall])
					rotate([90,0,0])
						teardrop(wall,2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall);
				translate([(2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall)/2-extruder_back_body_width,extruder_back_body_length-wall,extruder_back_body_height-wall])
					rotate([90,0,0])
						teardrop(wall,2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall);
				translate([-extruder_back_body_width,extruder_back_body_length-wall,extruder_back_body_height-wall])
					cube([2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall,wall,(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)+wall]);
			}
		}

		for(i=[1,1]) translate([extruder_back_body_width/2-i*extruder_back_body_width,0,0]) mirror([i,0,0]){
			// extruder mount x-carriage clearance
			translate([-extruder_back_body_width/2-(extruder_mount_screw_dia/2+clearance)-wall-1,extruder_back_body_length-(wall+clearance+extruder_mount_screw_nut_height+clearance+wall),-1])
				cube([extruder_back_body_width+(extruder_mount_screw_dia/2+clearance)+wall+2,wall+clearance+extruder_mount_screw_nut_height+clearance+wall+1,extruder_mount_screw_washer_dia+clearance+1]);
	
			// extruder stepper gearbox clearance and mount holes
			translate([0,wall,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=nema17_gearbox_dia/2+clearance,h=extruder_back_body_length+1);
			translate([0,-1,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=nema17_gearbox_center_dia/2+clearance,h=extruder_back_body_length+2);
			translate([0,0,extruder_back_body_height/2])
				for(i=[0:3])
					rotate([0,45+i*90,0])
						translate([0,-1,nema17_gearbox_hole_pos_dia/2])
							rotate([-90,0,0])
								cylinder(r=nema17_screw_dia/2+clearance,h=extruder_back_body_length+2);
	
			// extruder idler bolt hole and hex head trap
			translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,-1,extruder_back_body_height-extruder_mount_screw_washer_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_idler_hinge_screw_dia/2+clearance,h=extruder_back_body_length+2);
			translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,extruder_back_body_length/2+(extruder_idler_hinge_screw_length-extruder_idler_hinge_screw_nut_height-clearance-extruder_idler_body_length-clearance),extruder_back_body_height-extruder_mount_screw_washer_dia/2])
				rotate([90,0,0])
					nut_trap(extruder_idler_hinge_screw_head_wrench,extruder_back_body_length);
	
			// extruder mount screw holes
			translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,-1,extruder_mount_screw_washer_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_back_body_length+2);
			translate([-extruder_back_body_width/2,-1,extruder_mount_screw_washer_dia/2])
				rotate([-90,0,0])
					cylinder(r=extruder_mount_screw_dia/2+clearance,h=extruder_back_body_length+2);
		}

		// cablechain mount holes and nut traps
		difference(){
			union(){
				translate([-extruder_back_body_width+2*wall+clearance+x_cablechain_mount_screw_dia/2,-1,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-x_cablechain_width_outside/2+x_cablechain_mount_hole_dist/2])
					rotate([-90,0,0])
						cylinder(r=x_cablechain_mount_screw_dia/2+clearance,h=extruder_back_body_length+2);
				translate([-extruder_back_body_width+2*wall+clearance+x_cablechain_mount_screw_dia/2,-1,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-x_cablechain_width_outside/2-x_cablechain_mount_hole_dist/2])
					rotate([-90,0,0])
						cylinder(r=x_cablechain_mount_screw_dia/2+clearance,h=extruder_back_body_length+2);
			}
			if(support)
				translate([-extruder_back_body_width,extruder_back_body_length-wall,extruder_back_body_height-wall])
					cube([2*wall+clearance+x_cablechain_mount_screw_dia+clearance+2*wall,layer_height,(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)+wall]);
		}
		translate([-extruder_back_body_width+2*wall+clearance+x_cablechain_mount_screw_dia/2,extruder_back_body_length/2-wall,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-x_cablechain_width_outside/2+x_cablechain_mount_hole_dist/2])
			rotate([-90,0,0])
				nut_trap_square(x_cablechain_mount_nut_wrench,extruder_back_body_length);
		translate([-extruder_back_body_width+2*wall+clearance+x_cablechain_mount_screw_dia/2,extruder_back_body_length/2-wall,extruder_back_body_height+(-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top)-x_cablechain_width_outside/2-x_cablechain_mount_hole_dist/2])
			rotate([-90,0,0])
				nut_trap_square(x_cablechain_mount_nut_wrench,extruder_back_body_length);
	}
}


