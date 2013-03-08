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


/***** Y END FRONT (LEFT) ************************/
//rotate([90,0,0]) y_end_body(front=1);

/***** Y END FRONT (RIGHT) ************************/
//mirror([1,0,0]) rotate([90,0,0]) y_end_body(front=1);

/***** Y END BACK (LEFT) ************************/
//mirror([1,0,0]) rotate([90,0,0]) y_end_body(front=0);

/***** Y END BACK (RIGHT) ************************/
rotate([90,0,0]) y_end_body(front=0);


module y_end_body(front=0){
	difference(){

		// main body
		hull(){
			translate([front*y_end_body_width_idler/2,wall,y_end_body_height-wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler);
			translate([y_end_body_width/2+front*y_end_body_width_idler,frame_width-frame_enclosure_thickness-clearance,y_end_body_height-wall])
				rotate([0,-90,0])
					cylinder(r=wall, h=y_end_body_width+front*y_end_body_width_idler);
			translate([y_end_body_width/2+front*y_end_body_width_idler,y_end_body_length-wall,y_end_body_height-(y_end_body_length-(frame_width-frame_enclosure_thickness-clearance))])
				rotate([0,-90,0])
					cylinder(r=wall, h=y_end_body_width+front*y_end_body_width_idler);
			translate([y_end_body_width/2+front*y_end_body_width_idler,y_end_body_length-wall,wall])
				rotate([0,-90,0])
					cylinder(r=wall, h=y_end_body_width+front*y_end_body_width_idler);
			translate([front*y_end_body_width_idler/2,wall,wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler);
		}

		// y rod clamp
		translate([0,-1,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia/2+clearance])
			rotate([-90,0,0])
				cylinder(r=rod_dia/2+clearance,h=y_end_body_length+2);
		translate([-wall_thin/2,-1,-1])
			cube([wall_thin,y_end_body_length+2,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia/2+clearance+1]);

		// y rod clamp body cut off
		difference(){
			translate([y_end_body_width/2,-1,-1])
				cube([y_rod_y_belt_x_dist,y_end_body_length+2, frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+clearance+bearing_dia/2-y_idler_bolt_washer_dia/2-clearance+1]);
			translate([y_end_body_width/2,0,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+clearance+bearing_dia/2-y_idler_bolt_washer_dia/2-clearance])
				rotate([-90,0,0])
					roundcorner(wall,y_end_body_length);
		}

		// y end body top cut off
		difference(){
			translate([y_end_body_width/2,-1,y_end_body_height-(frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+clearance+bearing_dia/2)+y_idler_bolt_washer_dia/2+clearance])
				cube([y_rod_y_belt_x_dist,y_end_body_length+2,(frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+clearance+bearing_dia/2)-y_idler_bolt_washer_dia/2-clearance+1]);
			translate([y_end_body_width/2,0,y_end_body_height-(frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall)-wall])
				rotate([0,-90,0])
					rotate([-90,0,0])
						roundcorner(wall,y_end_body_length);
		}

		// screw holes
		translate([0,(frame_width-2*frame_enclosure_thickness)/2,frame_washer_wall+frame_screw_dia/2+clearance])
			rotate([-90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_end_body_width+2);
		translate([(front*y_end_body_width_idler)/2,(frame_width-2*frame_enclosure_thickness)/2,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia+2*clearance+frame_washer_wall+frame_screw_dia/2+clearance])
			rotate([-90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_end_body_width+front*y_end_body_width_idler+2);
		translate([(y_end_body_width+front*y_end_body_width_idler+2)/2+y_end_body_width/2,(frame_width-2*frame_enclosure_thickness)/2,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia+2*clearance+frame_washer_wall+frame_screw_dia/2+clearance])
			rotate([-90,0,0])
				teardrop(frame_screw_washer_dia/2+clearance,y_end_body_width+front*y_end_body_width_idler+2);
		translate([0,y_end_body_length-(frame_width-2*frame_enclosure_thickness)/2,frame_washer_wall+frame_screw_dia/2+clearance])
			rotate([-90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_end_body_width+2);

		// nut trap
		translate([-y_end_body_width/2+frame_screw_nut_height/2-0.5,y_end_body_length-(frame_width-2*frame_enclosure_thickness)/2,frame_washer_wall+frame_screw_dia/2+clearance])
			rotate([0,90,0])
				nut_trap(frame_screw_nut_wrench,frame_screw_nut_height+1);

		if(front==0)
			// y belt arbor bearing trap
			y_belt_arbor_bearing_trap(front);
		if(front==1)
			// y belt idler bolt trap
			y_belt_idler_trap(front);
	}
}


module y_belt_arbor_bearing_trap(front){
	// y belt arbor bearing trap
	translate([(bearing_width+clearance+1)/2+y_end_body_width/2-bearing_width-clearance,y_belt_arbor_frame_enclosure_dist-clearance,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia/2+clearance])
		rotate([-90,0,0])
			teardrop(bearing_dia/2+clearance,bearing_width+clearance+1);

	translate([0,y_belt_arbor_frame_enclosure_dist-clearance,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia/2+clearance])
		rotate([-90,0,0])
			teardrop(bearing_dia/2+clearance-wall_thin,y_end_body_width+front*y_end_body_width_idler+2);
}


module y_belt_idler_trap(front){
	// y belt idler bolt trap
	translate([-y_end_body_width/2+(y_idler_bolt_head+clearance)/2-0.5,y_belt_arbor_frame_enclosure_dist-clearance,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia/2+clearance])
		rotate([0,90,0])
			nut_trap(y_idler_bolt_wrench,y_idler_bolt_head+clearance+1);

	translate([(front*y_end_body_width_idler)/2,y_belt_arbor_frame_enclosure_dist-clearance,frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia/2+clearance])
		rotate([-90,0,0])
			teardrop(y_idler_bolt_dia/2+clearance,y_end_body_width+front*y_end_body_width_idler+2);
}
