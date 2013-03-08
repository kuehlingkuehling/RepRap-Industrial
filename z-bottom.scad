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


//translate([0,0,z_bottom_body_height])
//	rotate([0,180,0])
		z_bottom();

module z_bottom(){

	difference(){
		union(){
			translate([-z_bottom_body_width/2,-z_rod_frame_enclosure_dist+clearance,0])	
				hull(){
					translate([wall,wall,0])
						cylinder(r=wall,h=z_bottom_body_height);
					translate([wall,z_bottom_body_length-wall,0])
						cylinder(r=wall,h=z_bottom_body_height);
					translate([z_bottom_body_width-wall,wall,0])
						cylinder(r=wall,h=z_bottom_body_height);
					translate([z_bottom_body_width-wall,z_bottom_body_length-wall,0])
						cylinder(r=wall,h=z_bottom_body_height);
				}
			cylinder(r=bearing_dia/2+clearance+wall,h=z_bottom_body_height);
		}

		// frame cut off
		translate([-z_bottom_body_width/2-1,-(frame_width+2*clearance)-(z_rod_frame_enclosure_dist-clearance)+(frame_width-frame_enclosure_thickness-clearance)+clearance,-(frame_width+2*clearance)+(frame_width-frame_enclosure_thickness-clearance)+clearance])
			cube([z_rod_dist+rod_dia+2*clearance+2*wall+2,frame_width+2*clearance,frame_width+2*clearance]);

		// spindle bearing trap
		translate([0,0,z_bottom_body_height-bearing_width-clearance])
			cylinder(r=bearing_dia/2+clearance,h=bearing_width+clearance+1);
		translate([0,0,-1])
			cylinder(r=z_spindle_dia/2+clearance+wall_thin,h=z_bottom_body_height+2);

		// rod clamps
		for(i=[0,1])
			mirror([i,0,0]){
				translate([z_rod_dist/2,0,-1])
					cylinder(r=rod_dia/2+clearance,h=z_bottom_body_height+2);
				translate([z_rod_dist/2-rod_dia/2-clearance-wall-clearance-frame_screw_dia/2,z_bottom_body_length/2-z_rod_frame_enclosure_dist+clearance,-clearance-frame_enclosure_thickness+frame_width/2])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(frame_screw_dia/2+clearance,z_bottom_body_length+2);
				translate([-z_rod_dist/2,-wall_thin/2,-1])
					cube([rod_dia/2+clearance+wall+2*clearance+frame_screw_dia+frame_washer_wall+wall_thin,wall_thin,z_bottom_body_height+2]);
				translate([-z_rod_dist/2+(rod_dia/2+clearance+wall+2*clearance+frame_screw_dia+frame_washer_wall),-wall_thin/2,-1])
					cube([wall_thin,rod_dia/2+clearance+wall+1,z_bottom_body_height+2]);
			}

		// frame screw holes
		for(i=[0,1])
			mirror([i,0,0])
				translate([z_rod_dist/4,-z_rod_frame_enclosure_dist-frame_enclosure_thickness+frame_width/2,-1])
					cylinder(r=frame_screw_dia/2+clearance,h=z_bottom_body_height+2);

	}

	// spindle bearing trap print support
	translate([0,0,z_bottom_body_height-bearing_width-clearance-layer_height])
		cylinder(r=bearing_dia/2+clearance,h=layer_height);

}
