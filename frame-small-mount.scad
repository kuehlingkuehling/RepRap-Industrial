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
	frame_small_mount();
    translate([0,-frame_center_screw_head_length-clearance-wall,frame_small_mount_body_height/4])
        label("14",orientation="front");
}




module frame_small_mount(){
	difference(){

		// main body
		hull(){
			translate([frame_small_mount_body_width/2-wall,-frame_small_mount_body_length/2,-frame_small_mount_body_height/2+wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,frame_small_mount_body_length);
			translate([-frame_small_mount_body_width/2+wall,-frame_small_mount_body_length/2,-frame_small_mount_body_height/2+wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,frame_small_mount_body_length);
			translate([frame_small_mount_body_width/2-wall,-frame_small_mount_body_length/2,frame_small_mount_body_height/2-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,frame_small_mount_body_length);
			translate([-frame_small_mount_body_width/2+wall,-frame_small_mount_body_length/2,frame_small_mount_body_height/2-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,frame_small_mount_body_length);
		}

		// extrusion center mount hole
		translate([0,-(frame_small_mount_body_length)/2+wall,0])
			rotate([0,0,90])
				teardrop(frame_center_screw_dia/2+clearance,frame_small_mount_body_length+2);
		translate([0,frame_small_mount_body_length/2-frame_center_screw_head_length-clearance,0])
			rotate([0,0,90])
				teardrop(frame_center_screw_washer_dia/2+clearance,frame_small_mount_body_length);

		// extrusion clearance
		translate([-(frame_width_small+2*clearance)/2,-frame_small_mount_body_length-frame_center_screw_head_length-clearance-wall,-frame_small_mount_body_height/2-1])
			cube([frame_width_small+2*clearance,frame_small_mount_body_length,frame_small_mount_body_height+2]);

		// frame mount screw holes
		for(i=[0,1])
			mirror([i,0,0]){
				translate([frame_small_mount_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,-frame_small_mount_body_length/2,0])
					rotate([0,0,90])
						teardrop(frame_screw_dia/2+clearance,frame_small_mount_body_length+2);
				translate([frame_small_mount_body_width/2-wall_thin-clearance-frame_screw_washer_dia/2,-frame_small_mount_body_length/2-frame_center_screw_head_length-clearance-wall,0])
					rotate([0,0,90])
						teardrop(frame_screw_head_flange_dia/2+clearance,frame_small_mount_body_length);
				}
	}
}
