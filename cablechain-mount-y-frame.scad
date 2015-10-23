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

// FRONT
* rotate([-90,0,0])
    difference(){
        cablechain_mount_y_frame(back=0);
        translate([0,-cablechain_mount_y_frame_body_length/4,0])
            label("42",orientation="left");
    }

// BACK
* rotate([-90,0,0])
    difference(){
        cablechain_mount_y_frame(back=1);
        translate([0,0,0])
            label("56",orientation="left");
    }




module cablechain_mount_y_frame(back=0){
	difference(){

		// main body
		union(){
			hull(){
				translate([cablechain_mount_y_frame_body_width/2,cablechain_mount_y_frame_body_length/2-wall,cablechain_mount_y_frame_body_height/2-wall])
					rotate([-90,0,0])
						teardrop(wall,cablechain_mount_y_frame_body_width);
				translate([cablechain_mount_y_frame_body_width/2,-cablechain_mount_y_frame_body_length/2+wall,cablechain_mount_y_frame_body_height/2-wall])
					rotate([-90,0,0])
						teardrop(wall,cablechain_mount_y_frame_body_width);
				translate([cablechain_mount_y_frame_body_width/2,-cablechain_mount_y_frame_body_length/2+wall,-max(cablechain_mount_y_frame_body_height/2,back*(-y_cablechain_rail_profile_side/2+wall+clearance+frame_screw_nut_height+clearance+wall_thin+clearance+frame_screw_washer_dia+clearance+wall_thin))+wall])
					rotate([-90,0,0])
						teardrop(wall,cablechain_mount_y_frame_body_width);
				translate([cablechain_mount_y_frame_body_width/2,cablechain_mount_y_frame_body_length/2-wall,-max(cablechain_mount_y_frame_body_height/2,back*(-y_cablechain_rail_profile_side/2+wall+clearance+frame_screw_nut_height+clearance+wall_thin+clearance+frame_screw_washer_dia+clearance+wall_thin))+wall])
					rotate([-90,0,0])
						teardrop(wall,cablechain_mount_y_frame_body_width);			}

		}

		// y cablechain rail profile mount
		translate([-(y_cablechain_rail_profile_side+2*clearance)/2+cablechain_mount_y_frame_body_width/2,-cablechain_mount_y_frame_body_length-cablechain_mount_y_frame_body_length/2+(y_cablechain_rail_profile_length-frame_extrusion_length_horizontal)/2+clearance,-(y_cablechain_rail_profile_side+2*clearance)/2])
			cube([y_cablechain_rail_profile_side+2*clearance,cablechain_mount_y_frame_body_length,y_cablechain_rail_profile_side+2*clearance]);

		// y cablechain mount
		if(back==1){
			translate([-1,-cablechain_mount_y_frame_body_length/2-1,cablechain_mount_y_frame_body_height/2-wall-clearance])
				cube([cablechain_mount_y_frame_body_width+2,cablechain_mount_y_frame_body_length+2,cablechain_mount_y_frame_body_height]);
			translate([cablechain_mount_y_frame_body_width/2,0,0])
				rotate([0,90,0])
					rotate([90,0,0])
						teardrop(frame_screw_dia/2+clearance,cablechain_mount_y_frame_body_height+2);
			translate([cablechain_mount_y_frame_body_width/2,0,-(-y_cablechain_rail_profile_side/2+wall+clearance+frame_screw_nut_height/2)])
				rotate([0,0,-90])
				nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,cablechain_mount_y_frame_body_length);
		}

		// front body cut off
		if(back==0)
			translate([cablechain_mount_y_frame_body_width/2+y_cablechain_rail_profile_side/2+clearance+wall,-cablechain_mount_y_frame_body_length/2-1,-cablechain_mount_y_frame_body_height/2-1])
				cube([cablechain_mount_y_frame_body_width,cablechain_mount_y_frame_body_length+2,cablechain_mount_y_frame_body_height+2]);


		// frame mount screw hole
		if(back==0){
			translate([cablechain_mount_y_frame_body_width/2,0,0])
				rotate([90,0,0])
					teardrop(frame_screw_dia/2+clearance,cablechain_mount_y_frame_body_width+2);
			translate([cablechain_mount_y_frame_body_width/2+wall,0,0])
				rotate([90,0,0])
					teardrop(frame_screw_head_flange_dia/2+clearance,cablechain_mount_y_frame_body_width);
		}
		if(back==1){
			translate([cablechain_mount_y_frame_body_width/2,0,-(-y_cablechain_rail_profile_side/2+wall+clearance+frame_screw_nut_height+clearance+wall_thin+clearance+frame_screw_washer_dia/2)])
				rotate([90,0,0])
					teardrop(frame_screw_dia/2+clearance,cablechain_mount_y_frame_body_width+2);
			translate([cablechain_mount_y_frame_body_width/2+wall,0,-(-y_cablechain_rail_profile_side/2+wall+clearance+frame_screw_nut_height+clearance+wall_thin+clearance+frame_screw_washer_dia/2)])
				rotate([90,0,0])
					teardrop(frame_screw_head_flange_dia/2+clearance,cablechain_mount_y_frame_body_width);
		}
	}
}


