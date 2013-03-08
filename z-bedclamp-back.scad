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

z_bed_bolt_screw_dia = m4_screw_dia;

z_bedclamp_back_body_height = frame_width;
z_bedclamp_back_body_width = wall+2*clearance+z_bed_bolt_screw_dia+wall;
z_bedclamp_back_body_length = frame_washer_wall+2*clearance+frame_screw_dia+wall+2*clearance+z_bed_bolt_screw_dia+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall;


z_bedclamp_back();


module z_bedclamp_back(){
	difference(){

		// main body
		hull(){
			translate([z_bedclamp_back_body_width/2,wall,wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_back_body_width);
			translate([z_bedclamp_back_body_width/2,z_bedclamp_back_body_length-wall,wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_back_body_width);
			translate([z_bedclamp_back_body_width/2,wall,z_bedclamp_back_body_height-wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_back_body_width);
			translate([z_bedclamp_back_body_width/2,z_bedclamp_back_body_length-wall,z_bedclamp_back_body_height-wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_back_body_width);
		}

		// bed bolt clamp
		translate([z_bedclamp_back_body_width/2,z_bedclamp_back_body_length-(z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall),-1])
			cylinder(r=z_bed_bolt_screw_dia/2+clearance,h=frame_width+2);
		translate([z_bedclamp_back_body_width/2-wall_thin/2,z_bedclamp_back_body_length-(z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall),-1])
			cube([wall_thin,z_bedclamp_back_body_length,z_bedclamp_back_body_height+2]);

		// clamp and frame screw holes
		translate([z_bedclamp_back_body_width/2,frame_washer_wall+clearance+frame_screw_dia/2,z_bedclamp_back_body_height/2])
			teardrop(frame_screw_dia/2+clearance,z_bedclamp_back_body_width+2);
		translate([z_bedclamp_back_body_width/2,z_bedclamp_back_body_length-(frame_washer_wall+clearance+frame_screw_dia/2),z_bedclamp_back_body_height/2])
			teardrop(frame_screw_dia/2+clearance,z_bedclamp_back_body_width+2);

	}
}



