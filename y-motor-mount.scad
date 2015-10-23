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
rotate([0,-90,0])
    difference(){
        y_motor_mount();
        translate([0,-(y_motor_mount_body_length-frame_width)/2,0])
            label("2",orientation="left");
    }




module y_motor_mount(){
	difference(){

		// main body
		translate([0,frame_width,-y_motor_mount_body_height+frame_width+wall])
			hull(){
				translate([0,-wall,y_motor_mount_body_height-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-wall,wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-y_motor_mount_body_length+wall,y_motor_mount_body_height-wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
				translate([0,-y_motor_mount_body_length+wall,wall])
					rotate([0,90,0])
						cylinder(r=wall,h=y_motor_mount_body_width);
			}

		// cut excess material
		translate([2*wall,0,-y_motor_mount_body_height+frame_width+wall])
			rotate([0,45,0])
				translate([0,-(y_motor_mount_body_length+2)+frame_width+1,-y_motor_mount_body_height])
					cube([y_motor_mount_body_height,y_motor_mount_body_length+2,2*y_motor_mount_body_height]);
			

		// frame clearance
		translate([-1,0,0])
			cube([y_motor_mount_body_width+2,frame_width+1,frame_width+wall+1]);

		// y motor belt tensioning thumbwheel and stud bolt clearance
		translate([wall+clearance+frame_screw_dia/2,frame_width/2,y_motor_mount_body_height/2-2*wall-1])
			rotate([0,90,0])
				teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_height);
		hull(){
			translate([wall+clearance+frame_screw_dia/2,frame_width/2,(m4_flat_knurled_nut_height+1)/2-1-2*wall])
				rotate([0,90,0])
					teardrop(m4_flat_knurled_nut_dia/2+wall_thin,m4_flat_knurled_nut_height+1);
			translate([-wall,frame_width/2,(m4_flat_knurled_nut_height+1)/2-1-2*wall])
				rotate([0,90,0])
					teardrop(m4_flat_knurled_nut_dia/2+wall_thin,m4_flat_knurled_nut_height+1);
		}


		// nema17 mount
		translate([2*wall,-nema17_width+frame_width-wall,-nema17_width-2*wall])
			cube([y_motor_mount_body_width,nema17_width,nema17_width]);
		translate([-1,frame_width-wall-nema17_width/2,-nema17_width/2-2*wall])
			rotate([0,90,0])
				cylinder(r=nema17_center_dia/2+clearance,h=y_motor_mount_body_width+2);
		translate([-1,frame_width-wall-nema17_width/2,-nema17_width/2-2*wall])
			for(j=[0:3])
				rotate([j*90,0,0])
					translate([0,nema17_hole_dist/2,nema17_hole_dist/2])
						rotate([0,90,0])
							cylinder(r=nema17_screw_dia/2+clearance,h=y_motor_mount_body_width+2);

		// frame mount holes
		translate([y_motor_mount_body_width/2,0,0])
			for(i=[-1,1])
				translate([i*(y_motor_mount_body_width/2-(wall+clearance+frame_screw_head_flange_dia/2)),0,0]){
					hull(){
						translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2])
							rotate([0,0,90])
								rotate([90,0,0])
									teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
						translate([0,-y_motor_mount_body_length/2+frame_width,frame_width/2+2*wall+wall])
							rotate([0,0,90])
								rotate([90,0,0])
									teardrop(frame_screw_dia/2+clearance,y_motor_mount_body_length+2);
					}
					hull(){
						translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2])
							rotate([0,0,90])
								rotate([90,0,0])
									teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
						translate([0,-y_motor_mount_body_length/2-2*wall,frame_width/2+2*wall+wall])
							rotate([0,0,90])
								rotate([90,0,0])
									teardrop(frame_screw_head_flange_dia/2+clearance,y_motor_mount_body_length);
					}
				}
	}
}


