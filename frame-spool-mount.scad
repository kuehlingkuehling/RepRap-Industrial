/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

Licensed under:
	Creative Commons Attribution-ShareAlike
	CC BY-SA 3.0
	http://creativecommons.org/licenses/by-sa/3.0/

*******************************************************************/

include <configuration.scad>

filament_spool_mount_width = 95;
filament_spool_mount_dia = 30;


spool_mount();


module spool_mount(){
	difference(){

		// main body
		union(){
			rotate([0,90,0])
				cylinder(r=filament_spool_mount_dia/2,h=2*wall+frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width+2*wall);
			translate([2*wall+frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width,0,0])
				rotate([0,90,0])
					cylinder(r=filament_spool_mount_dia/2+wall,h=2*wall);
			translate([2*wall,0,0])
				rotate([0,90,0])
					cylinder(r=filament_spool_mount_dia/2+wall,h=frame_screw_washer_thickness+frame_screw_head_length+wall_thin);
			hull(){
				translate([0,-filament_spool_mount_dia/2+wall/2-clearance-frame_screw_washer_dia+wall,frame_width-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=2*wall);
				translate([0,filament_spool_mount_dia/2-wall/2+clearance+frame_screw_washer_dia-wall,frame_width-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=2*wall);
				translate([wall,-filament_spool_mount_dia/2+wall/2-clearance-frame_screw_washer_dia+wall,wall])
					rotate([180,0,0])
						teardrop(wall,2*wall);
				translate([wall,filament_spool_mount_dia/2-wall/2+clearance+frame_screw_washer_dia-wall,wall])
					rotate([180,0,0])
						teardrop(wall,2*wall);
			}
		}

		// cylinder cut off
		translate([-1,-(filament_spool_mount_dia+2*wall+2)/2,-filament_spool_mount_dia/2-wall-1])
			cube([2*wall+frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width+2*wall+2,filament_spool_mount_dia+2*wall+2,filament_spool_mount_dia/2+wall+1]);
		for(i=[0,1])
			mirror([0,i,0])
				translate([2*wall,filament_spool_mount_dia/2-wall/2,-1])
					cube([frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width+2*wall+2,filament_spool_mount_dia+2*wall+2,filament_spool_mount_dia/2+wall+2]);
		translate([(frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width)/2+2*wall,0,0])
			teardrop(filament_spool_mount_dia/2-2*wall,frame_screw_washer_thickness+frame_screw_head_length+wall_thin+filament_spool_mount_width);

		// frame mount screw holes
		for(i=[0,1])
			mirror([0,i,0])
				translate([(2*wall+1)/2-1,filament_spool_mount_dia/2-wall/2+clearance+frame_screw_washer_dia/2,frame_width/2])
					teardrop(frame_screw_dia/2+clearance,2*wall+2);


	}
}
