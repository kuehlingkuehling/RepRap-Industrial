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

// BEAGLEBONE BLACK LEFT
* rotate([0,-90,0])
    difference(){
        pcb_mount(controller_beagleboneblack_height,controller_beagleboneblack_hole_left_bottom_pos_z,controller_beagleboneblack_hole_left_top_pos_z,controller_beagleboneblack_screw_dia,controller_beagleboneblack_screw_nut_height,controller_beagleboneblack_screw_nut_wrench);
        translate([pcb_mount_body_width/2,0,wall])
            label("12",orientation="right");
    }

// BEAGLEBONE BLACK RIGHT
* rotate([0,-90,0])
    difference(){
        pcb_mount(controller_beagleboneblack_height,controller_beagleboneblack_hole_right_bottom_pos_z,controller_beagleboneblack_hole_right_top_pos_z,controller_beagleboneblack_screw_dia,controller_beagleboneblack_screw_nut_height,controller_beagleboneblack_screw_nut_wrench);
        translate([pcb_mount_body_width/2,0,wall])
            label("6.",orientation="right");
    }

// RUMBA LEFT
* rotate([0,-90,0])
    difference(){
        pcb_mount(mainboard_height,mainboard_hole_left_bottom_pos_z,mainboard_hole_left_top_pos_z,mainboard_screw_dia,mainboard_screw_nut_height,mainboard_screw_nut_wrench);
        translate([pcb_mount_body_width/2,0,wall])
            label("25",orientation="right");
    }

// RUMBA RIGHT
* rotate([0,-90,0])
    difference(){
        pcb_mount(mainboard_height,mainboard_hole_right_bottom_pos_z,mainboard_hole_right_top_pos_z,mainboard_screw_dia,mainboard_screw_nut_height,mainboard_screw_nut_wrench);
        translate([pcb_mount_body_width/2,0,wall])
            label("44",orientation="right");
    }




module pcb_mount(pcb_height,hole_bottom_pos,hole_top_pos,screw_dia,nut_height,nut_wrench){

	pcb_mount_body_height = 2*wall+wall+pcb_height+wall;

	difference(){

		// main body
		union(){
			intersection(){
				union(){
					hull(){
						translate([-pcb_mount_body_width/2+wall,-frame_width/2+wall,wall])
							rotate([0,-90,0])
								teardrop(wall,2*wall);
						translate([pcb_mount_body_width/2-wall,-frame_width/2+wall,wall])
							rotate([0,-90,0])
								teardrop(wall,2*wall);
						translate([-pcb_mount_body_width/2,-frame_width/2+pcb_mount_body_length-wall,0])
							cube([pcb_mount_body_width,wall,2*wall]);
					}
					hull(){
						translate([-pcb_mount_body_width/2+wall,-frame_width/2+pcb_mount_body_length-wall,pcb_mount_body_height-wall])
							rotate([90,0,0])
								rotate([0,-90,0])
									teardrop(wall,2*wall);
						translate([pcb_mount_body_width/2-wall,-frame_width/2+pcb_mount_body_length-wall,pcb_mount_body_height-wall])
							rotate([90,0,0])
								rotate([0,-90,0])
									teardrop(wall,2*wall);
						translate([-pcb_mount_body_width/2,-frame_width/2+pcb_mount_body_length-2*wall,0])
							cube([pcb_mount_body_width,2*wall,wall]);
					}
					translate([-pcb_mount_body_width/2,-frame_width/2+wall,0])
						cube([pcb_mount_body_width,pcb_mount_body_length-wall,pcb_mount_body_height-wall]);
				}
				union(){
					difference(){
						hull(){
							translate([0,-frame_width/2+pcb_mount_body_length-wall,wall])
								rotate([0,90,0])
									cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
							translate([0,-frame_width/2+pcb_mount_body_length-wall,pcb_mount_body_height+wall])
								rotate([0,90,0])
									cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
							translate([0,-frame_width/2-wall,wall])
								rotate([0,90,0])
									cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
							translate([0,-frame_width/2-wall,pcb_mount_body_height+wall])
								rotate([0,90,0])
									cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
						}
						translate([0,-2*wall,2*wall])
							hull(){
								translate([0,-frame_width/2+pcb_mount_body_length-wall,wall])
									rotate([0,90,0])
										cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
								translate([0,-frame_width/2+pcb_mount_body_length-wall,pcb_mount_body_height+wall])
									rotate([0,90,0])
										cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
								translate([0,-frame_width/2-wall,wall])
									rotate([0,90,0])
										cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
								translate([0,-frame_width/2-wall,pcb_mount_body_height+wall])
									rotate([0,90,0])
										cylinder(r=wall,h=pcb_mount_body_width+2,center=true);
							}
					}
					translate([0,-frame_width/2+pcb_mount_body_length-2*wall+1,2*wall+wall+hole_bottom_pos])
						rotate([90,0,0])
							cylinder(r1=screw_dia/2+clearance+wall_thin+wall+1,r2=screw_dia/2+clearance+wall_thin,h=wall+1);
					translate([0,-frame_width/2+pcb_mount_body_length-2*wall+1,2*wall+wall+hole_top_pos])
						rotate([90,0,0])
							cylinder(r1=screw_dia/2+clearance+wall_thin+wall+1,r2=screw_dia/2+clearance+wall_thin,h=wall+1);
				}
			}
		}

		// frame mount screw hole
		translate([0,0,wall])
			rotate([0,90,0])
				teardrop(frame_screw_dia/2+clearance,2*wall+2);

		// pcb mount screw holes and nut traps
		translate([0,-frame_width/2+pcb_mount_body_length-wall-wall/2,2*wall+wall+hole_bottom_pos])
			rotate([90,0,0])
				rotate([0,90,0])
					teardrop(screw_dia/2+clearance,3*wall+2);
		translate([0,-frame_width/2+pcb_mount_body_length-wall-wall/2,2*wall+wall+hole_top_pos])
			rotate([90,0,0])
				rotate([0,90,0])
					teardrop(screw_dia/2+clearance,3*wall+2);
		translate([0,(nut_height+clearance+1)/2-frame_width/2+pcb_mount_body_length-(nut_height+clearance),2*wall+wall+hole_bottom_pos])
			rotate([90,0,0])
				nut_trap_square(nut_wrench,nut_height+clearance+1);
		translate([0,(nut_height+clearance+1)/2-frame_width/2+pcb_mount_body_length-(nut_height+clearance),2*wall+wall+hole_top_pos])
			rotate([90,0,0])
				nut_trap_square(nut_wrench,nut_height+clearance+1);
	}
}


