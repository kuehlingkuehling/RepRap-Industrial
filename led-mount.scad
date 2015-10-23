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

// RIGHT
* rotate([180,0,0])
    difference(){
        led_mount();
        translate([frame_width/4,0,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)/2])
            label("290",orientation="front");
    }

// LEFT
* rotate([180,0,0]) mirror([1,0,0])
    difference(){
        led_mount();
        translate([frame_width/4,0,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)/2])
            mirror([1,0,0]) label("289",orientation="front");
    }






module led_mount(){
	difference(){

		// main body
		union(){
			hull(){
				translate([-frame_width/2+wall,wall+wall,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)])
					cylinder(r=wall,h=wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin);
				translate([-frame_width/2+wall,wall,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)])
					cylinder(r=wall,h=wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin);
				translate([frame_width/2-wall,wall+(frame_width-2*wall)+wall,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)])
					cylinder(r=wall,h=wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin);
				translate([frame_width/2-wall,wall,led_mount_body_height-(wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin)])
					cylinder(r=wall,h=wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin);
			}
			hull(){
				translate([0,frame_width/2+wall,0])
					rotate([0,0,45]){
						translate([frame_width/2-wall,0,0])
							cylinder(r=wall,h=led_mount_body_height);
						translate([-frame_width/2+wall,0,0])
							cylinder(r=wall,h=led_mount_body_height);
					}
			}
		}

		// led mount screw holes and nut traps
		translate([0,frame_width/2+wall,0])
			rotate([0,0,45]){
				translate([0,0,wall+clearance+led_screw_dia/2])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(led_screw_dia/2+clearance,2*wall+2);
				translate([0,0,wall+clearance+led_screw_dia/2+led_hole_dist])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(led_screw_dia/2+clearance,2*wall+2);
				translate([0,0,wall+clearance+led_screw_dia/2+led_hole_dist/2])
					cube([watercooling_cooler_side+2*wall_thin,2*wall+2,watercooling_cooler_side+2*wall_thin+2*wall],center=true);
				translate([0,(led_screw_nut_height+clearance+1)/2-wall-1,wall+clearance+led_screw_dia/2])
					rotate([90,0,0])
						nut_trap_square(led_screw_nut_wrench,led_screw_nut_height+clearance+1);
				translate([0,(led_screw_nut_height+clearance+1)/2-wall-1,wall+clearance+led_screw_dia/2+led_hole_dist])
					rotate([90,0,0])
						nut_trap_square(led_screw_nut_wrench,led_screw_nut_height+clearance+1);
			}

		// frame screw hole
		translate([0,wall,led_mount_body_height-(frame_screw_head_flange_dia/2+clearance+wall_thin)])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_screw_dia/2+clearance,2*wall+2);
		translate([0,(frame_width+2)/2+wall,led_mount_body_height-(frame_screw_head_flange_dia/2+clearance+wall_thin)])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_screw_head_flange_dia/2+clearance,frame_width+2);
	}
}


