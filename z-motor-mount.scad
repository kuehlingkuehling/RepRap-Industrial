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
rotate([180,0,0]) 
    difference(){
        z_motor_mount();
        translate([0,0,0])
            label("33",orientation="bottom");
    }



module z_motor_mount(){
	intersection(){

		// z motor mount rotational clearance around left frame mount screw (avoid enclosure collision) for belt tensioning
		hull(){
			translate([-(z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2),0,-1])
				cylinder(r=frame_width/2,h=z_motor_mount_body_height+2);
			translate([z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2,0,-1])
				cylinder(r=frame_screw_dia/2+clearance+wall,h=z_motor_mount_body_height+2);
			for(i=[0,1])
				mirror([i,0,0])
					translate([z_motor_mount_body_width/2-wall,frame_width/2-z_motor_mount_body_length+wall-frame_width,-1])
						cylinder(r=frame_width/2,h=z_motor_mount_body_height+2);
		}

		difference(){
	
			// main body
			hull()
				for(i=[0,1])
					mirror([i,0,0]){
						translate([z_motor_mount_body_width/2-wall,frame_width/2-wall,0])
							cylinder(r=wall,h=z_motor_mount_body_height);
						translate([z_motor_mount_body_width/2-wall,frame_width/2-z_motor_mount_body_length+wall-frame_width,0])
							cylinder(r=wall,h=z_motor_mount_body_height);
					}
	
			// nema17 mount
			translate([0,-frame_width,0])
			for(i=[0,1])
				mirror([i,0,0]){
					translate([0,frame_width/2-z_motor_mount_body_length/2,-1])
						cylinder(r=nema17_center_dia/2+clearance,h=z_motor_mount_body_height+2);
					translate([0,frame_width/2-z_motor_mount_body_length/2,-1])
						for(j=[0,1])
							mirror([0,j,0]){
								translate([nema17_hole_dist/2,nema17_hole_dist/2,0])
									cylinder(r=nema17_screw_dia/2+clearance,h=z_motor_mount_body_height+2);
								translate([nema17_hole_dist/2,nema17_hole_dist/2,-wall])
									cylinder(r=nema17_screw_washer_dia/2+clearance,h=z_motor_mount_body_height+1);
							}
				}
	
			// belt clearance
			translate([0,-frame_width,0])
			hull(){
				translate([0,frame_width/2-z_motor_mount_body_length/2,-1])
					cylinder(r=z_belt_pulley_dia/2+2*wall_thin,h=z_motor_mount_body_height-2*wall+1);
				translate([-z_motor_mount_body_width,frame_width/2-z_motor_mount_body_length/2,-1])
					cylinder(r=z_belt_pulley_dia/2+2*wall_thin,h=z_motor_mount_body_height-2*wall+1);
				translate([-z_motor_mount_body_width,frame_width/2-z_motor_mount_body_length/2+2*(nema17_width/2-(z_belt_pulley_dia/2+wall_thin)),-1])
					cylinder(r=z_belt_pulley_dia/2+2*wall_thin,h=z_motor_mount_body_height-2*wall+1);
			}
	
			// frame mount holes
			// left
			translate([-(z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2),0,-1])
				cylinder(r=frame_screw_dia/2+clearance,h=z_motor_mount_body_height+2);

			// right (slot hole for rotational tensioning)
			translate([-(z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2),0,0])
				for(i=[0:19])
					hull(){
						rotate([0,0,-i*(2*asin((frame_width/2-frame_screw_dia/2-clearance-wall)/(4*(z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2))))/20])
							translate([z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2,0,0])
								translate([z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2,0,-1])
									cylinder(r=frame_screw_dia/2+clearance,h=z_motor_mount_body_height+2);
						rotate([0,0,-(i+1)*(2*asin((frame_width/2-frame_screw_dia/2-clearance-wall)/(4*(z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2))))/20])
							translate([z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2,0,0])
								translate([z_motor_mount_body_width/2-wall-clearance-frame_screw_dia/2,0,-1])
									cylinder(r=frame_screw_dia/2+clearance,h=z_motor_mount_body_height+2);
					}
		}
	}
}


