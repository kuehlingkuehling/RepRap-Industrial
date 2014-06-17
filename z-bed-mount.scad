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
rotate([0,180,0]) z_bed_mount();





module z_bed_mount(){
	difference(){

		// main body
		union(){
*			hull(){
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall),wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall),z_bed_mount_body_length-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,z_bed_mount_body_length-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
			}
			hull(){
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall-wall-clearance),wall,z_bed_mount_body_height/2-wall])
						cylinder(r=wall,h=wall);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall-wall-clearance,wall,z_bed_mount_body_height/2-wall])
						cylinder(r=wall,h=wall);
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall-wall-clearance),z_bed_mount_body_length-wall,z_bed_mount_body_height/2-wall])
						cylinder(r=wall,h=wall);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall-wall-clearance,z_bed_mount_body_length-wall,z_bed_mount_body_height/2-wall])
						cylinder(r=wall,h=wall);
			}
			hull(){
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall),wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([-(z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall),wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2+z_bed_bolt_screw_head_dia/2+wall_thin+clearance+wall-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall-wall,wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2+z_bed_bolt_screw_head_dia/2+wall_thin+clearance+wall-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
			}
			hull(){
				translate([-z_bed_mount_body_width/2+wall,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia-wall_thin-wall+wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_bed_mount_body_width/2-wall,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia-wall_thin-wall+wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([-z_bed_mount_body_width/2+wall,z_bed_mount_body_length-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
				translate([z_bed_mount_body_width/2-wall,z_bed_mount_body_length-wall,-z_bed_mount_body_height/2])
						cylinder(r=wall,h=z_bed_mount_body_height);
			}
		}

		for(i=[0,1])
			mirror([i,0,0]){

				// platform frame mount
				translate([-frame_width_small-2*clearance+z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin,2*wall,-frame_width/2-clearance])
					cube([frame_width_small+2*clearance,z_bed_mount_body_length+1,frame_width+2*clearance]);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,z_bed_mount_body_length/2,0])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(frame_center_screw_dia/2+clearance,z_bed_mount_body_length+2);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small/2,-z_bed_mount_body_length/2+wall,0])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(frame_center_screw_washer_dia/2+clearance,z_bed_mount_body_length);


				// body cut off
				hull(){
					translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small-wall,wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2+z_bed_bolt_screw_head_dia/2+wall_thin+clearance+wall+wall,-z_bed_mount_body_height/2-1])
						cylinder(r=wall,h=z_bed_mount_body_height+2);
					translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin-clearance-frame_width_small-wall,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia-wall_thin-wall-wall,-z_bed_mount_body_height/2-1])
						cylinder(r=wall,h=z_bed_mount_body_height+2);
					translate([-1,wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2+z_bed_bolt_screw_head_dia/2+wall_thin+clearance+wall+wall,-z_bed_mount_body_height/2-1])
						cylinder(r=wall,h=z_bed_mount_body_height+2);
					translate([-1,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia-wall_thin-wall-wall,-z_bed_mount_body_height/2-1])
						cylinder(r=wall,h=z_bed_mount_body_height+2);
				}

				// bed bolt clamps
				// bolt hole front
				translate([0,wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin/2+z_bed_bolt_screw_dia/2,0])
					cylinder(r=z_bed_bolt_screw_dia/2+wall_thin/2,h=z_bed_mount_body_height+2,center=true);
				translate([0,wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2,-wall-clearance-z_bed_bolt_clamp_screw_dia-clearance-wall])
					cylinder(r=z_bed_bolt_screw_head_dia/2+wall_thin,h=z_bed_mount_body_height,center=true);
				// bolt holes back
				translate([z_bed_bolt_dist/2+wall_thin/2,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia/2,0])
					cylinder(r=z_bed_bolt_screw_dia/2+wall_thin/2,h=z_bed_mount_body_height+2,center=true);
				translate([z_bed_bolt_dist/2,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia/2,-wall-clearance-z_bed_bolt_clamp_screw_dia-clearance-wall])
					cylinder(r=z_bed_bolt_screw_head_dia/2+wall_thin,h=z_bed_mount_body_height,center=true);
				// bolt clamp front
				translate([0,-z_bed_mount_body_length/2+wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin/2+z_bed_bolt_screw_dia/2,z_bed_mount_body_height/2-wall-clearance-z_bed_bolt_clamp_screw_dia/2])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(z_bed_bolt_clamp_screw_dia/2+clearance,z_bed_mount_body_length);
				translate([0,z_bed_bolt_clamp_screw_nut_height/2+clearance+wall,z_bed_mount_body_height/2-wall-clearance-z_bed_bolt_clamp_screw_dia/2])
					rotate([0,0,-90])
						nut_slot_square(z_bed_bolt_clamp_screw_nut_wrench,z_bed_bolt_clamp_screw_nut_height,z_bed_mount_body_length,vertical=1);
				// bolt clamp back
				translate([z_bed_mount_body_length/2+z_bed_bolt_dist/2,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia/2,z_bed_mount_body_height/2-wall-clearance-z_bed_bolt_clamp_screw_dia/2])
					rotate([180,0,0])
						teardrop(z_bed_bolt_clamp_screw_dia/2+clearance,z_bed_mount_body_length);
				translate([-z_bed_bolt_clamp_screw_nut_height/2-clearance+z_bed_mount_body_width/2-wall,z_bed_mount_body_length-wall-wall_thin-z_bed_bolt_screw_head_dia/2,z_bed_mount_body_height/2-wall-clearance-z_bed_bolt_clamp_screw_dia/2])
					rotate([0,0,0])
						nut_slot_square(z_bed_bolt_clamp_screw_nut_wrench,z_bed_bolt_clamp_screw_nut_height,z_bed_mount_body_length,vertical=1);
			}

		// z cablechain mount
		translate([0,z_bed_mount_body_length,clearance+wall])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_screw_dia/2+clearance,z_bed_mount_body_length);
		translate([0,-(frame_screw_nut_height/2-clearance)+z_bed_mount_body_length-wall,clearance+wall])
			rotate([0,-90,0])
				rotate([90,0,0])
					nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,z_bed_mount_body_height);

	}
}



