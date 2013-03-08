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

echo(cornerdiameter(z_spindle_nut_wrench+2*clearance)/2);

z_elevator_body_height = 2*linear_bearing_length+2*clearance+linear_bearing_dist_min;

z_elevator();


module z_elevator(){
	difference(){

		// main body
		union(){

			// bearing clamp body
			for(i=[0,1])
				mirror([i*1,0,0])
					translate([z_rod_dist/2,0,0])
						hull(){
							translate([linear_bearing_dia/2+clearance,-linear_bearing_dia/2-clearance,0])
								cylinder(r=wall,h=z_elevator_body_height);
							translate([linear_bearing_dia/2+clearance,linear_bearing_dia/2+clearance,0])
								cube([wall,wall,z_elevator_body_height]);
							translate([-linear_bearing_dia/2-clearance-wall-z_bearing_clamp_screw_dia-2*clearance-frame_washer_wall+wall,linear_bearing_dia/2+clearance,0])
								cylinder(r=wall,h=z_elevator_body_height);
							translate([-linear_bearing_dia/2-clearance-wall-z_bearing_clamp_screw_dia-2*clearance-frame_washer_wall,-linear_bearing_dia/2-clearance-wall,0])
								cube([wall,wall,z_elevator_body_height]);
						}

			// spindle nut trap body
			cylinder(r=cornerdiameter(z_spindle_nut_wrench+2*clearance+2*wall)/2,h=z_elevator_body_height,$fn=6);

			// bearing clamp to spindle nut trap wall
			translate([-z_rod_dist/2,0,0])
				cube([z_rod_dist,wall,z_elevator_body_height]);

			// platform frame holders body
			for(i=[0,1])
				mirror([i*1,0,0])
					translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall,linear_bearing_dia/2+clearance+wall,0])
						rotate([0,-90,0])
							linear_extrude(height=2*wall+2*clearance+frame_width+wall)
								polygon(points=[[0,-1],[z_elevator_body_height,-1],[z_elevator_body_height,0],[wall,z_elevator_body_height-wall],[0,z_elevator_body_height-wall]]);

			// material for inner rounded corners
			for(j=[0,1])
				mirror([j*1,0,0]){
					translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall-2*clearance-z_bearing_clamp_screw_dia-wall-wall,wall,0])
						cube([wall,wall,z_elevator_body_height]);
				}

			// z endstop mount
			translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall,0,0])
				rotate([0,0,90])
					rotate([90,0,0])
						endstop_mount(teardrop=1,teardrop_angle=90,top=0);
		}

		// bearing clamps
		for(i=[0,1])
			mirror([i*1,0,0])
				translate([z_rod_dist/2,0,0])
					translate([0,0,-1]){
						cylinder(r=linear_bearing_dia/2+clearance,h=z_elevator_body_height+2);
						translate([-(linear_bearing_dia/2+clearance+wall+z_bearing_clamp_screw_dia+2*clearance+wall+1),-wall_thin,0])
						cube([linear_bearing_dia/2+clearance+wall+z_bearing_clamp_screw_dia+2*clearance+wall+1,wall_thin,z_elevator_body_height+2]);
					}

		// bearing clamp screw holes
		for(i=[0,1])
			mirror([i*1,0,0])
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-z_bearing_clamp_screw_dia/2,0,z_elevator_body_height-linear_bearing_length/2]){
					rotate([0,0,90])
						teardrop(z_bearing_clamp_screw_dia/2,wall+clearance+linear_bearing_dia+clearance+wall+2);
					translate([0,linear_bearing_dia/2+clearance-clearance-z_bearing_clamp_nut_height/2,0])
						rotate([0,-90,0])
							rotate([0,0,90])
								nut_slot(z_bearing_clamp_nut_wrench,z_bearing_clamp_nut_height,wall+z_bearing_clamp_screw_dia/2+1,vertical=1);
				}
		for(i=[0,1])
			mirror([i*1,0,0])
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall-clearance-z_bearing_clamp_screw_dia/2,0,linear_bearing_length/2]){
					rotate([0,0,90])
						teardrop(z_bearing_clamp_screw_dia/2,wall+clearance+linear_bearing_dia+clearance+wall+2);
					translate([0,linear_bearing_dia/2+clearance-clearance-z_bearing_clamp_nut_height/2,0])
						rotate([0,-90,0])
							rotate([0,0,90])
								nut_slot(z_bearing_clamp_nut_wrench,z_bearing_clamp_nut_height,wall+z_bearing_clamp_screw_dia/2+1,vertical=1);
				}					

		// spindle nut trap
		translate([0,0,-1])
			cylinder(r=cornerdiameter(z_spindle_nut_wrench+2*clearance)/2,h=z_elevator_body_height+2,$fn=6);

/*
		translate([0,0,-1])
%			cylinder(r=cornerdiameter(z_spindle_nut_wrench+2*clearance)/2,h=z_elevator_body_height+2,$fn=6);
*/

		// platform frame holders
		for(i=[0,1])
			mirror([i*1,0,0]){
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-wall-2*clearance-frame_width,linear_bearing_dia/2+clearance+wall,wall])
					cube([frame_width+2*clearance,z_elevator_body_height,z_elevator_body_height]);

				// leave edge material for inner round corner
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-2*wall-2*clearance-frame_width-wall-1,linear_bearing_dia/2+clearance+wall+wall,-1])
					cube([wall+1,z_elevator_body_height,z_elevator_body_height+2]);
			}

		// inner round corners
		for(i=[0,1])
			mirror([i*1,0,0]){
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-2*wall-2*clearance-frame_width-wall,linear_bearing_dia/2+clearance+wall+wall,-1])
					cylinder(r=wall,h=z_elevator_body_height+2);
				translate([z_rod_dist/2-linear_bearing_dia/2-clearance-wall-2*clearance-z_bearing_clamp_screw_dia-wall-wall,wall+wall,-1])
					cylinder(r=wall,h=z_elevator_body_height+2);

				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-2*wall-2*clearance-frame_width,linear_bearing_dia/2+clearance+wall+z_elevator_body_height-wall,0])
					rotate([0,0,-90])
						roundcorner(wall,z_elevator_body_height);
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall,linear_bearing_dia/2+clearance+wall+z_elevator_body_height-wall,0])
					rotate([0,0,-180])
						roundcorner(wall,z_elevator_body_height);
			}

		// platform frame mount screw holes
		for(i=[0,1])
			mirror([i*1,0,0]){
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-wall-clearance-frame_width/2,linear_bearing_dia/2+clearance+wall+max((frame_washer_wall+clearance+frame_screw_dia/2),(frame_groove_nut_length/2)),-1])
					cylinder(r=frame_screw_dia/2,h=wall+2);
				translate([z_rod_dist/2+linear_bearing_dia/2+clearance+wall-wall-clearance-frame_width/2,linear_bearing_dia/2+clearance+wall+z_elevator_body_height-wall-frame_washer_wall-clearance-frame_screw_dia/2,-1])
					cylinder(r=frame_screw_dia/2,h=wall+2);
			}
	}

	// spindle nut support
	for(k=[0:2])
		rotate([0,0,k*60])
			translate([0,0,z_spindle_nut_height+clearance+k*layer_height])
				difference(){
						cylinder(r=cornerdiameter(z_spindle_nut_wrench+2*clearance)/2,h=wall-k*layer_height,$fn=6);
						translate([-(cornerdiameter(z_spindle_nut_wrench+2*clearance)+2)/2,-(z_spindle_dia+2*wall_thin)/2,-1])
							cube([cornerdiameter(z_spindle_nut_wrench+2*clearance)+2,z_spindle_dia+2*wall_thin,wall-k*layer_height+2]);
				}

	// linear bearing push in stop
	for(i=[0,1])
		mirror([i*1,0,0])
			translate([z_rod_dist/2-linear_bearing_dia/2-clearance,linear_bearing_dia/2+clearance-wall_thin,z_elevator_body_height/2-linear_bearing_dist_min/2])
				cube([linear_bearing_dia+2*clearance,2*wall_thin,linear_bearing_dist_min]);
}




module endstop_mount(teardrop=1,teardrop_angle=-90,top=1){
	difference(){

		// main body
		union(){
			translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,-wall])
				cube([endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall,2*wall+2*clearance+endstop_screw_dia,endstop_screw_nut_height+2*clearance+2*wall]);

			translate([0,0,-wall])
				rotate([-90,0,0])
					linear_extrude(height=2*wall+2*clearance+endstop_screw_dia)
						polygon(points=[[-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0],[-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2+2*wall,2*wall],[(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2-2*wall,2*wall],[(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0]]);
		}
		for(k=[-1,1])
			translate([-(endstop_screw_nut_wrench+2*clearance)/2+k*endstop_hole_dist/2,-1,0])
				cube([endstop_screw_nut_wrench+2*clearance,2*wall+2*clearance+endstop_screw_dia+2,endstop_screw_nut_height+2*clearance]);
		if(teardrop==1)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,(endstop_screw_nut_height+2*clearance+wall+1)/2])
					rotate([0,0,teardrop_angle])
						rotate([0,90,0])
							teardrop(endstop_screw_dia/2+clearance,endstop_screw_nut_height+2*clearance+wall+1);
		if(teardrop==0)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,0])
					cylinder(r=endstop_screw_dia/2+clearance,h=endstop_screw_nut_height+2*clearance+wall+1);
	}

	// hole printability support layer for top surface use of endstop_mount (no teardrop)
	if(teardrop==0) if(top==1)
		for(j=[-1,1])
			translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,endstop_screw_nut_height+2*clearance])
				cylinder(r=endstop_screw_dia/2+clearance+wall_thin,h=layer_height);

}




