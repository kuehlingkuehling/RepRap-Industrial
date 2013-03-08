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


///// RENDER Z-TOP /////
//z_top(0);


//// RENDER Z-MIDDLE /////
z_top_body_height = frame_width;
z_top(1);



module z_top(middle=0){

	difference(){

		// main body
		union(){
			translate([-z_top_body_width/2,-z_rod_frame_enclosure_dist-frame_enclosure_thickness+frame_width+clearance,0])	
				hull(){
					translate([0,0,0])
						cube([wall,wall,z_top_body_height]);
					translate([wall,z_top_body_length-wall,0])
						cylinder(r=wall,h=z_top_body_height);
					translate([z_top_body_width-wall,0,0])
						cube([wall,wall,z_top_body_height]);
					translate([z_top_body_width-wall,z_top_body_length-wall,0])
						cylinder(r=wall,h=z_top_body_height);
				}
		}

		// rod clamps
		for(i=[0,1])
			mirror([i,0,0]){
				translate([z_rod_dist/2,0,-1])
					cylinder(r=rod_dia/2+clearance,h=z_top_body_height+2);
				translate([z_rod_dist/2-rod_dia/2-clearance-wall-clearance-frame_screw_dia/2,z_top_body_length/2-z_rod_frame_enclosure_dist-frame_enclosure_thickness+frame_width+clearance,frame_width/2])
					rotate([0,0,90])
							teardrop(frame_screw_dia/2+clearance,z_top_body_length+2);
				translate([-z_rod_dist/2,-wall_thin/2,-1])
					cube([rod_dia/2+clearance+wall+2*clearance+frame_screw_dia+frame_washer_wall+wall_thin,wall_thin,z_top_body_height+2]);
/*
				translate([-z_rod_dist/2+(rod_dia/2+clearance+wall+2*clearance+frame_screw_dia+frame_washer_wall),-wall_thin/2,-1])
%					cube([z_rod_dist/2-rod_dia/2-clearance-wall-2*clearance-frame_screw_dia-frame_washer_wall+1,rod_dia/2+clearance+wall+1,z_top_body_height+2]);
*/

			}

			// body cutoff
			hull(){
				translate([z_rod_dist/2-rod_dia/2-clearance-wall-frame_screw_dia-2*clearance-frame_washer_wall-wall,rod_dia/2+clearance+1,-1])
					cube([wall,wall,z_top_body_height+2]);
				translate([-(z_rod_dist/2-rod_dia/2-clearance-wall-frame_screw_dia-2*clearance-frame_washer_wall),rod_dia/2+clearance+1,-1])
					cube([wall,wall,z_top_body_height+2]);
				translate([z_rod_dist/2-rod_dia/2-clearance-wall-frame_screw_dia-2*clearance-frame_washer_wall-wall,-(z_top_body_length-rod_dia/2-clearance-wall)+2*wall,-1])
					cylinder(r=wall,h=z_top_body_height+2);
				translate([-(z_rod_dist/2-rod_dia/2-clearance-wall-frame_screw_dia-2*clearance-frame_washer_wall-wall),-(z_top_body_length-rod_dia/2-clearance-wall)+2*wall,-1])
					cylinder(r=wall,h=z_top_body_height+2);
			}


		// frame screw hole
		if(middle==0)
			translate([0,z_top_body_length/2-z_rod_frame_enclosure_dist-frame_enclosure_thickness+frame_width+clearance,frame_width/2])
				rotate([0,0,90])
						teardrop(frame_screw_dia/2+clearance,z_top_body_length+2);
	}
}
