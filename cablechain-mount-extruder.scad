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
rotate([0,-90,0])	 cablechain_mount_extruder();




module cablechain_mount_extruder(){
	difference(){

		// main body
		hull(){
			translate([-cablechain_mount_extruder_body_width/2,0,0])
				cube([cablechain_mount_extruder_body_width,wall,wall]);
			translate([0,cablechain_mount_extruder_body_length-wall,wall])
				rotate([0,90,0])
					cylinder(r=wall,h=cablechain_mount_extruder_body_width,center=true);
			translate([0,wall,2*wall])
				rotate([0,90,0])
					cylinder(r=wall,h=cablechain_mount_extruder_body_width,center=true);
			translate([0,cablechain_mount_extruder_body_length-wall,2*wall])
				rotate([0,90,0])
					cylinder(r=wall,h=cablechain_mount_extruder_body_width,center=true);
			translate([0,cablechain_mount_extruder_body_length-frame_screw_nut_height-clearance-wall-clearance-(x_cablechain_height+2*x_cablechain_wall)-clearance-wall+wall,cablechain_mount_extruder_body_height-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=cablechain_mount_extruder_body_width,center=true);
			translate([0,cablechain_mount_extruder_body_length-wall,cablechain_mount_extruder_body_height-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=cablechain_mount_extruder_body_width,center=true);
		}

		// cable chain clearance
		translate([-cablechain_mount_extruder_body_width/2-1,cablechain_mount_extruder_body_length-frame_screw_nut_height-clearance-wall-clearance-(x_cablechain_height+2*x_cablechain_wall)-clearance,-clearance-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top-clearance-(x_cablechain_width+4*x_cablechain_wall+2*clearance+x_cablechain_dividers*wall_thin)-clearance])
			cube([cablechain_mount_extruder_body_width+2,clearance+(x_cablechain_height+2*x_cablechain_wall)+clearance,clearance+(x_cablechain_width+4*x_cablechain_wall+2*clearance+x_cablechain_dividers*wall_thin)+clearance]);

		// extruder back mount holes
		translate([0,extruder_back_body_length-wall-clearance-extruder_cablechain_mount_screw_dia/2,cablechain_mount_extruder_body_height/2])
			rotate([0,90,0])
				teardrop(extruder_cablechain_mount_screw_dia/2+clearance,cablechain_mount_extruder_body_height+2);
		translate([0,wall+clearance+extruder_cablechain_mount_screw_dia/2,cablechain_mount_extruder_body_height/2])
			rotate([0,90,0])
				teardrop(extruder_cablechain_mount_screw_dia/2+clearance,cablechain_mount_extruder_body_height+2);
		translate([0,extruder_back_body_length-wall-clearance-extruder_cablechain_mount_screw_dia/2,cablechain_mount_extruder_body_height/2+2*wall])
			rotate([0,90,0])
				teardrop(extruder_cablechain_mount_screw_head_flange_dia/2+clearance,cablechain_mount_extruder_body_height);
		translate([0,wall+clearance+extruder_cablechain_mount_screw_dia/2,cablechain_mount_extruder_body_height/2+2*wall])
			rotate([0,90,0])
				teardrop(extruder_cablechain_mount_screw_head_flange_dia/2+clearance,cablechain_mount_extruder_body_height);

		// cablechain mount screw holes and nut traps
		translate([0,-(frame_screw_nut_height+clearance+wall+2)/2+cablechain_mount_extruder_body_length+1,(-clearance-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top-clearance-(x_cablechain_width+4*x_cablechain_wall+2*clearance+x_cablechain_dividers*wall_thin)-clearance)+(clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([0,90,0])
				rotate([0,0,90])
					teardrop(frame_screw_dia/2+clearance,frame_screw_nut_height+clearance+wall+2);
		translate([0,cablechain_mount_extruder_body_length/2,(-clearance-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top-clearance-(x_cablechain_width+4*x_cablechain_wall+2*clearance+x_cablechain_dividers*wall_thin)-clearance)+(clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([0,90,0])
				rotate([0,0,90])
					teardrop(frame_screw_hex_wrench_dia/2+clearance,cablechain_mount_extruder_body_length+2);
		translate([0,-(frame_screw_nut_height+clearance+wall+2)/2+cablechain_mount_extruder_body_length+1,cablechain_mount_extruder_body_height-(wall+clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([0,90,0])
				rotate([0,0,90])
					teardrop(frame_screw_dia/2+clearance,frame_screw_nut_height+clearance+wall+2);
		translate([0,cablechain_mount_extruder_body_length/2,cablechain_mount_extruder_body_height-(wall+clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([0,90,0])
				rotate([0,0,90])
					teardrop(frame_screw_hex_wrench_dia/2+clearance,cablechain_mount_extruder_body_length+2);
		translate([0,-(frame_screw_nut_height+clearance+1)/2+cablechain_mount_extruder_body_length+1,(-clearance-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top-clearance-(x_cablechain_width+4*x_cablechain_wall+2*clearance+x_cablechain_dividers*wall_thin)-clearance)+(clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([90,0,0])
					nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
		translate([0,-(frame_screw_nut_height+clearance+1)/2+cablechain_mount_extruder_body_length+1,cablechain_mount_extruder_body_height-(wall+clearance+2*x_cablechain_wall+clearance+clearance+frame_screw_head_flange_dia/2)])
			rotate([90,0,0])
					nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
	}
}


