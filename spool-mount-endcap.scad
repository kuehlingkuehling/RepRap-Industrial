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
	spool_mount_endcap();
    translate([0,0,spool_mount_endcap_body_height/4])
        label("27",orientation="back");
}




module spool_mount_endcap(){
	difference(){

		// main body
		hull(){
			translate([spool_mount_endcap_body_width/2-wall,-(spool_mount_endcap_body_length)/2+wall,-frame_width/2-clearance-wall+wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,spool_mount_endcap_body_length);
			translate([-spool_mount_endcap_body_width/2+wall,-(spool_mount_endcap_body_length)/2+wall,-frame_width/2-clearance-wall+wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,spool_mount_endcap_body_length);
			translate([spool_mount_endcap_body_width/2-wall,-(spool_mount_endcap_body_length)/2+wall,-frame_width/2-clearance-wall+spool_mount_endcap_body_height-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,spool_mount_endcap_body_length);
			translate([-spool_mount_endcap_body_width/2+wall,-(spool_mount_endcap_body_length)/2+wall,-frame_width/2-clearance-wall+spool_mount_endcap_body_height-wall])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(wall,spool_mount_endcap_body_length);
		}

		// extrusion center mount hole
		translate([0,-(spool_mount_endcap_body_length)/2+wall,0])
			rotate([0,0,90])
				teardrop(frame_center_screw_dia/2+clearance,spool_mount_endcap_body_length+2);
		translate([0,-(spool_mount_endcap_body_length)/2+wall-spool_mount_endcap_body_length+wall,0])
			rotate([0,0,90])
				teardrop(frame_center_screw_washer_dia/2+clearance,spool_mount_endcap_body_length);

		// extrusion clearance
		translate([-(frame_width_small+2*clearance)/2,0,-(frame_width+2*clearance)/2])
			cube([frame_width_small+2*clearance,spool_mount_endcap_body_length,frame_width+2*clearance]);

		// frame mount screw holes
*		for(i=[0,1])
			mirror([0,i,0])
				translate([(2*wall+1)/2-1,filament_spool_mount_dia/2-wall/2+clearance+frame_screw_washer_dia/2,frame_width/2])
					teardrop(frame_screw_dia/2+clearance,2*wall+2);


	}
}
