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


frame_cable_clip_length = frame_width/2;


// RENDER
* rotate([90,0,0]) frame_cable_clip(width=frame_width_small,height=4);
* rotate([90,0,0]) frame_cable_clip(width=frame_width,height=6);
* rotate([90,0,0]) frame_cable_clip(width=frame_width,height=8);
* rotate([90,0,0]) frame_cable_clip(width=frame_width,height=10);
* rotate([90,0,0]) frame_cable_clip(width=frame_width,height=15);




// height >= 4mm


module frame_cable_clip(width,height){

	height_eff = max(4,height);

	difference(){

		// main body
		hull(){
			translate([-width/2+wall,-frame_cable_clip_length/2,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=frame_cable_clip_length);
			translate([width/2-wall,-frame_cable_clip_length/2,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=frame_cable_clip_length);
			translate([-width/2+wall,-frame_cable_clip_length/2,wall+height_eff+wall_thin-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=frame_cable_clip_length);
			translate([width/2-wall,-frame_cable_clip_length/2,wall+height_eff+wall_thin-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=frame_cable_clip_length);
		}

		// cable clearance
		hull(){
			translate([-width/2+wall,-frame_cable_clip_length/2-1,wall+wall-wall_thin])
				rotate([-90,0,0])
					cylinder(r=wall-wall_thin,h=frame_cable_clip_length+2);
			translate([width/2-wall,-frame_cable_clip_length/2-1,wall+wall-wall_thin])
				rotate([-90,0,0])
					cylinder(r=wall-wall_thin,h=frame_cable_clip_length+2);
			translate([-width/2+wall,-frame_cable_clip_length/2-1,wall+height_eff+wall_thin-wall])
				rotate([-90,0,0])
					cylinder(r=wall-wall_thin,h=frame_cable_clip_length+2);
			translate([width/2-wall,-frame_cable_clip_length/2-1,wall+height_eff+wall_thin-wall])
				rotate([-90,0,0])
					cylinder(r=wall-wall_thin,h=frame_cable_clip_length+2);
		}
		translate([-wall/2,-frame_cable_clip_length/2-1,wall])
			cube([wall,frame_cable_clip_length+2,height_eff+wall_thin+1]);

		// frame screw hole
		translate([0,0,wall/2])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(frame_screw_dia/2+clearance,wall+2);
		translate([0,0,wall+height_eff+wall_thin/2])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(frame_screw_head_flange_dia/2+clearance,wall_thin+2,fulldrop=1);
	}
}


