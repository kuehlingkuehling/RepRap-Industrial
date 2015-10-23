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
	frame_enclosure_angle();
    translate([frame_enclosure_angle_body_width/2,frame_enclosure_angle_body_length/2,-frame_enclosure_angle_body_height/2])
        label("46",orientation="right");
}





module frame_enclosure_angle(){
	difference(){

		// main body
		hull(){
			translate([-frame_enclosure_angle_body_width/2+wall,frame_enclosure_angle_body_length-wall,-frame_enclosure_angle_body_height])
				cylinder(r=wall,h=frame_enclosure_angle_body_height);
			translate([frame_enclosure_angle_body_width/2-wall,frame_enclosure_angle_body_length-wall,-frame_enclosure_angle_body_height])
				cylinder(r=wall,h=frame_enclosure_angle_body_height);
			translate([-frame_enclosure_angle_body_width/2,clearance,-frame_enclosure_angle_body_height])
				cube([frame_enclosure_angle_body_width,wall,frame_enclosure_angle_body_height]);
		}

		// frame screw hole
		translate([0,frame_width/2,-frame_enclosure_angle_body_height-1])
			cylinder(r=frame_screw_dia/2+clearance,h=frame_enclosure_angle_body_height+2);

		// frame base enclosure screw hole and nut trap
		translate([0,clearance+(frame_enclosure_angle_body_length-wall-clearance-frame_screw_dia-clearance-wall_thin+1)/2-1,frame_enclosure_thickness-frame_width/2])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_enclosure_angle_body_length-wall-clearance-frame_screw_dia-clearance-wall_thin+1);
		translate([0,clearance+(frame_screw_nut_height+2*clearance)/2+wall,frame_enclosure_thickness-frame_width/2])
			rotate([0,0,90])
				nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,frame_enclosure_angle_body_width,vertical=1);
	}
}
