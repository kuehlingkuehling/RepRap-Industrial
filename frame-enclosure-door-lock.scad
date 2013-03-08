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



// RENDER FOR PRINTING
// INNER PART BOTTOM
//rotate([-90,0,0]) translate([0,-frame_enclosure_door_lock_inside_body_width,0])
//frame_enclosure_door_lock_inside();

// INNER PART TOP
//mirror([0,1,0]) rotate([-90,0,0]) translate([0,-frame_enclosure_door_lock_inside_body_width,0])
//frame_enclosure_door_lock_inside();

// OUTER PART BOTTOM
//rotate([90,0,0])
//frame_enclosure_door_lock_outside();

// OUTER PART TOP
mirror([0,1,0]) rotate([90,0,0])
frame_enclosure_door_lock_outside();


module frame_enclosure_door_lock_inside(){
	difference(){

		// main body
		union(){
			hull(){
				translate([wall,frame_enclosure_door_lock_inside_body_width/2,wall])
					rotate([0,0,90])
						teardrop(wall,frame_enclosure_door_lock_inside_body_width);
				translate([wall,frame_enclosure_door_lock_inside_body_width/2,frame_enclosure_door_lock_inside_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_lock_inside_body_width);
				translate([frame_enclosure_door_lock_inside_body_length-wall,frame_enclosure_door_lock_inside_body_width/2,wall])
					rotate([0,0,90])
						teardrop(wall,frame_enclosure_door_lock_inside_body_width);
				translate([frame_enclosure_door_lock_inside_body_length-wall,frame_enclosure_door_lock_inside_body_width/2,frame_enclosure_door_lock_inside_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_lock_inside_body_width);
			}
		}

		// frame groove clearance
		translate([-1,-1,-1])
			cube([frame_enclosure_door_lock_inside_body_length+2,(frame_width/2-frame_enclosure_thickness-clearance)-(frame_groove_width/2-clearance)+1,frame_groove_depth-wall_thin+1]);

		// rotation clearance
		translate([(wall+clearance+frame_screw_dia/2)-(frame_enclosure_door_lock_inside_body_height-(frame_screw_dia/2+clearance+wall)-(frame_groove_depth-wall_thin)),(frame_width/2-frame_enclosure_thickness-clearance)-(frame_groove_width/2-clearance),frame_groove_depth-wall_thin])
			rotate([90,0,0])
				translate([0,0,1])
					roundcorner(frame_enclosure_door_lock_inside_body_height-(frame_screw_dia/2+clearance+wall)-(frame_groove_depth-wall_thin),frame_enclosure_door_lock_inside_body_width);
		translate([wall+clearance+frame_screw_dia/2-(frame_enclosure_door_lock_inside_body_height-wall-clearance-frame_screw_dia/2),frame_enclosure_door_lock_inside_body_width+1,0])
			rotate([90,0,0])
				translate([0,0,1])
					roundcorner(frame_enclosure_door_lock_inside_body_height-wall-clearance-frame_screw_dia/2,frame_enclosure_door_lock_inside_body_width);

		// lock bolt hole, washer countersink, nut trap
		translate([wall+clearance+frame_screw_dia/2,frame_enclosure_door_lock_inside_body_width/2,frame_enclosure_door_lock_inside_body_height-wall-clearance-frame_screw_dia/2])
			rotate([180,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_enclosure_door_lock_inside_body_width+2,alpha=90);
		translate([wall+clearance+frame_screw_dia/2,-(frame_screw_washer_thickness+1)/2+frame_screw_washer_thickness,frame_enclosure_door_lock_inside_body_height-wall-clearance-frame_screw_dia/2])
			rotate([180,0,90])
				teardrop(frame_screw_washer_dia/2+clearance,frame_screw_washer_thickness+1,alpha=90);
		translate([wall+clearance+frame_screw_dia/2,-(frame_screw_nut_height+clearance+1)/2+frame_screw_washer_thickness+frame_screw_nut_height,frame_enclosure_door_lock_inside_body_height-wall-clearance-frame_screw_dia/2])
			rotate([90,0,0])
				nut_trap(frame_screw_nut_wrench, frame_screw_nut_height+clearance+1);
	}
}


module frame_enclosure_door_lock_outside(){
	difference(){

		// main body
		union(){
			hull(){
				translate([wall,frame_enclosure_door_lock_outside_body_width/2,wall])
					rotate([0,0,90])
						teardrop(wall,frame_enclosure_door_lock_outside_body_width);
				translate([wall,frame_enclosure_door_lock_outside_body_width/2,frame_enclosure_door_lock_outside_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_lock_outside_body_width);
				translate([frame_enclosure_door_lock_outside_body_length-wall,frame_enclosure_door_lock_outside_body_width/2,wall])
					rotate([0,0,90])
						teardrop(wall,frame_enclosure_door_lock_outside_body_width);
				translate([frame_enclosure_door_lock_outside_body_length-wall,frame_enclosure_door_lock_outside_body_width/2,frame_enclosure_door_lock_outside_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_lock_outside_body_width);
			}
		}


		// lock bolt hole, washer countersink, nut trap
		translate([wall+clearance+frame_screw_dia/2,-1,frame_enclosure_door_lock_outside_body_height/2])
			rotate([-90,0,0])
				cylinder(r=frame_screw_dia/2+clearance,h=frame_enclosure_door_lock_outside_body_width+2);
		translate([wall+clearance+frame_screw_dia/2,frame_enclosure_door_lock_outside_body_width-frame_screw_washer_thickness,frame_enclosure_door_lock_outside_body_height/2])
			rotate([-90,0,0])
				cylinder(r=frame_screw_washer_dia/2+clearance,h=frame_screw_washer_thickness+1);
		translate([wall+clearance+frame_screw_dia/2,(frame_screw_nut_height+clearance+1)/2+frame_enclosure_door_lock_outside_body_width-frame_screw_washer_thickness-frame_screw_nut_height-clearance,frame_enclosure_door_lock_outside_body_height/2])
			rotate([90,0,0])
				nut_trap(frame_screw_nut_wrench, frame_screw_nut_height+clearance+1);

		// bevel
		translate([frame_enclosure_door_lock_outside_body_length-frame_enclosure_door_lock_outside_body_height/2,frame_enclosure_door_lock_outside_body_width,0])
			rotate([0,-45,0])
			rotate([-45/2,0,0])
				rotate([0,0,90])
					translate([0,-frame_enclosure_door_lock_outside_body_length/2,-frame_enclosure_door_lock_outside_body_length/2])
						cube([wall,frame_enclosure_door_lock_outside_body_length,frame_enclosure_door_lock_outside_body_length]);

	}
}

