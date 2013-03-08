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


frame_cable_clip_width = 3*wall;
frame_cable_clip_flexfactor = 2 / (6-wall + frame_width/2-frame_groove_width/2+2*clearance);


// RENDER
frame_cable_clip(frame_cable_clip_size = 8);
//frame_cable_clip(frame_cable_clip_size = 17);
//frame_cable_clip(frame_cable_clip_size = 30);



module frame_cable_clip(frame_cable_clip_size = 6){

	frame_cable_clip_size = max(2*wall, frame_cable_clip_size);
	top_flex_thickness = (2/3) * min(2*wall,(2+ ((frame_cable_clip_size-6) * frame_cable_clip_flexfactor)));

	difference(){

		// main body
		hull(){
			translate([frame_width/2+frame_cable_clip_size+wall-wall,frame_width/2+clearance+top_flex_thickness-wall,0])
				cylinder(r=wall,h=frame_cable_clip_width);
			translate([frame_width/2+frame_cable_clip_size+wall-wall,-frame_width/2+frame_enclosure_thickness+clearance+wall,0])
				cylinder(r=wall,h=frame_cable_clip_width);
			translate([-frame_width/2+frame_enclosure_thickness+clearance,-frame_width/2+frame_enclosure_thickness+clearance,0])
				cube([wall,top_flex_thickness+clearance+frame_width-frame_enclosure_thickness-clearance,frame_cable_clip_width]);
		}

		// cable clearance
		hull(){
			translate([frame_width/2+frame_cable_clip_size+wall-wall-wall,frame_width/2+clearance+wall-wall-wall,-1])
				cylinder(r=wall,h=frame_cable_clip_width+2);
			translate([frame_width/2+frame_cable_clip_size+wall-wall-wall,+frame_groove_width/2-clearance+wall,-1])
				cylinder(r=wall,h=frame_cable_clip_width+2);
			translate([frame_groove_width/2-clearance,frame_groove_width/2-clearance,-1])
				cube([wall,clearance+frame_width/2-frame_groove_width/2+clearance,frame_cable_clip_width+2]);
		}

		// frame clearance
		translate([-(frame_width-2*wall+2*clearance)/2,-(frame_width-4*wall_thin)/2,-1])
			cube([frame_width-2*wall+2*clearance,frame_width-4*wall_thin,frame_cable_clip_width+2]);
		translate([0,-(frame_width/2-frame_groove_width/2+clearance)-frame_groove_width/2+clearance,-1])
			cube([frame_width/2+clearance,frame_width/2-frame_groove_width/2+clearance,frame_cable_clip_width+2]);
		translate([-frame_width/2-frame_groove_width/2+clearance,0,-1])
			cube([frame_width/2,frame_width/2+clearance,frame_cable_clip_width+2]);

		// screw driver clip release hole
		translate([-wall_thin/2,0,-wall/2+frame_cable_clip_width/2])
			cube([wall_thin,frame_width,wall]);
			
	}
}


