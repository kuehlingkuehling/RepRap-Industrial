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

// BOTTOM HALF LEFT
//frame_enclosure_door_hinge(top=0);

// TOP HALF LEFT
//translate([2*frame_width,0,frame_enclosure_door_hinge_body_height]) rotate([0,180,0]) // ASSEMBLING TEST
//frame_enclosure_door_hinge(top=1);

// BOTTOM HALF RIGHT
//mirror([1,0,0]) frame_enclosure_door_hinge(top=0);

// TOP HALF RIGHT
mirror([1,0,0]) frame_enclosure_door_hinge(top=1);


module frame_enclosure_door_hinge(top=0){

	difference(){

		// main body
		union(){
			hull(){
				translate([wall,frame_enclosure_door_hinge_body_width/2,wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_hinge_body_width);
				translate([wall,frame_enclosure_door_hinge_body_width/2,frame_enclosure_door_hinge_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_hinge_body_width);
				translate([frame_width-wall_thin-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall)-wall,0,0])
					cube([wall,frame_enclosure_door_hinge_body_width,frame_enclosure_door_hinge_body_height]);
			}
			hull(){
				translate([wall,frame_enclosure_door_hinge_body_width/2,wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_hinge_body_width);
				translate([wall,frame_enclosure_door_hinge_body_width/2,frame_enclosure_door_hinge_body_height/2-frame_enclosure_door_hinge_bolt_washer_thickness/2-clearance-wall])
					rotate([180,0,90])
						teardrop(wall,frame_enclosure_door_hinge_body_width);
				translate([frame_width-wall,0,0])
					cube([wall,frame_enclosure_door_hinge_body_width,frame_enclosure_door_hinge_body_height/2-frame_enclosure_door_hinge_bolt_washer_thickness/2-clearance]);
			}
			translate([frame_width,frame_enclosure_door_hinge_body_width-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall)-wall_thin,0])
				cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance+wall,h=frame_enclosure_door_hinge_body_height/2-frame_enclosure_door_hinge_bolt_washer_thickness/2-clearance);

				translate([frame_width-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall),frame_enclosure_door_hinge_body_width-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall)-wall_thin,0])
					cube([frame_enclosure_door_hinge_bolt_dia/2+clearance+wall,frame_enclosure_door_hinge_bolt_dia/2+clearance+wall,frame_enclosure_door_hinge_body_height/2-frame_enclosure_door_hinge_bolt_washer_thickness/2-clearance]);

		}


		// hinge bolt hole and nut trap
		translate([frame_width,frame_enclosure_door_hinge_body_width-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall)-wall_thin,-1])
			cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance,h=frame_enclosure_door_hinge_body_height+2);
		if (top == 0)
			translate([frame_width,frame_enclosure_door_hinge_body_width-(frame_enclosure_door_hinge_bolt_dia/2+clearance+wall)-wall_thin,(frame_enclosure_door_hinge_bolt_nut_height+clearance+1)/2+frame_enclosure_door_hinge_body_height/2-frame_enclosure_door_hinge_bolt_washer_thickness/2-clearance-frame_enclosure_door_hinge_bolt_nut_height-clearance])
				nut_trap(frame_enclosure_door_hinge_bolt_nut_wrench, frame_enclosure_door_hinge_bolt_nut_height+clearance+1);

		// frame mount screw holes
		translate([frame_width/2,frame_enclosure_door_hinge_body_width/2,wall+frame_screw_dia/2+clearance])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_enclosure_door_hinge_body_width+2);
		translate([frame_width/2,frame_enclosure_door_hinge_body_width/2,frame_enclosure_door_hinge_body_height-(wall+frame_screw_dia/2+clearance)])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_enclosure_door_hinge_body_width+2);

			
	}

}
