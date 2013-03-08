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

y_motor_mount_body_width = (frame_width-frame_enclosure_thickness-clearance)+clearance+y_end_body_width/2+y_rod_y_belt_x_dist+y_belt_pulley_width/2+wall_thin+nema17_shaft_length+nema17_center_pitch;
y_motor_mount_body_length = nema17_hole_dist+nema17_screw_washer_dia+2*clearance+wall;
y_motor_mount_body_height = nema17_hole_dist+nema17_screw_washer_dia+2*clearance+wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+2*wall;



rotate([180,0,0]) y_motor_mount();




module y_motor_mount(){

	difference(){

		// main body
		translate([0,-y_motor_mount_body_length,-y_motor_mount_body_height])
			cube([y_motor_mount_body_width,y_motor_mount_body_length,y_motor_mount_body_height]);

		// body cut offs
		translate([(frame_width-frame_enclosure_thickness-clearance)+clearance+2*wall,-y_motor_mount_body_length-wall,-y_motor_mount_body_height-(wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+2*wall)])
			cube([y_motor_mount_body_width-3*wall-(frame_width-frame_enclosure_thickness-clearance)-clearance-2*wall,y_motor_mount_body_length,y_motor_mount_body_height]);
		translate([-3*wall,-y_motor_mount_body_length-(frame_width-frame_enclosure_thickness-clearance)-clearance-2*wall,-y_motor_mount_body_height-(wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+2*wall)])
			cube([y_motor_mount_body_width,y_motor_mount_body_length,y_motor_mount_body_height]);
		translate([-1,-(frame_width-frame_enclosure_thickness-clearance)-clearance,-y_motor_mount_body_height-1])
			cube([(frame_width-frame_enclosure_thickness-clearance)+clearance+1,(frame_width-frame_enclosure_thickness-clearance)+clearance+1,y_motor_mount_body_height+2]);

		// round corners
		translate([0,-y_motor_mount_body_length,-y_motor_mount_body_height])
			rotate([90,0,0]) rotate([0,90,0])
				roundcorner(wall,y_motor_mount_body_width);
//		translate([0,-y_motor_mount_body_length,-y_motor_mount_body_height])
//			roundcorner(wall,y_motor_mount_body_height);
		translate([0,0,-y_motor_mount_body_height])
			rotate([90,0,0])
				roundcorner(wall,y_motor_mount_body_length);
//		translate([0,0,0])
//			rotate([0,90,0]) rotate([90,0,0])
//				roundcorner(wall,y_motor_mount_body_length);

		// nema17 mount
		translate([y_motor_mount_body_width-1.5*wall,-y_motor_mount_body_length+clearance+nema17_screw_washer_dia/2+nema17_hole_dist/2,-y_motor_mount_body_height+clearance+nema17_screw_washer_dia/2+nema17_hole_dist/2]){
			rotate([180,0,0])
				teardrop(nema17_center_dia/2+clearance,3*wall+2);
			for(i=[0:3])
				rotate([i*90,0,0])
					translate([0,nema17_hole_dist/2,nema17_hole_dist/2])
						rotate([180-i*90,0,0])
							teardrop(nema17_screw_dia/2+clearance,3*wall+2);
		}

		// frame screw holes
		translate([(frame_width-frame_enclosure_thickness-clearance)-frame_width/2,-y_motor_mount_body_length/2,-y_motor_mount_body_height+frame_washer_wall+clearance+frame_screw_dia/2])
			rotate([0,0,90]) rotate([180,0,0])
				teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
		translate([(frame_width-frame_enclosure_thickness-clearance)-frame_width/2,-y_motor_mount_body_length/2,-(wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+2*wall)/2])
			rotate([0,0,90]) rotate([180,0,0])
				teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2+2);

		// belt tensioner
		translate([y_motor_mount_body_width-wall-clearance-belt_tensioning_screw_dia/2,-(frame_width-frame_enclosure_thickness-clearance)-clearance-wall-cornerdiameter(belt_tensioning_screw_head_wrench+2*clearance)/2,0]) rotate([0,0,90]) rotate([90,0,0]){
			difference(){
				translate([0,-(belt_tensioning_range+2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
					rotate([-90,0,0])
						cylinder(r=belt_tensioning_screw_dia/2+clearance,belt_tensioning_range+2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+1);

				// printability support layer
				translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance)-layer_height,0])
					rotate([-90,0,0])
						cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall+2*clearance,h=layer_height*2);
			}
			translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
				rotate([-90,0,0])
					cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall+2*clearance,h=belt_tensioning_nut_height+2*clearance+wall_thin+clearance);
			translate([-((cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance)/2),-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
					cube([cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance,belt_tensioning_nut_height+2*clearance+wall_thin+clearance,(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+2*clearance)]);
		}
	}
}




