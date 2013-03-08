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


endcap();


module endcap(){
	difference(){
		// main body
		union(){
			hull(){
				translate([frame_width/2-wall_thin,frame_width/2-wall_thin,0])
					cylinder(r=wall_thin,h=wall_thin);
				translate([-(frame_width/2-wall_thin),(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall_thin);
				translate([(frame_width/2-wall_thin),-(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall_thin);
				translate([-(frame_width/2-wall_thin),-(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall_thin);
			}
			translate([-frame_groove_width/2,-frame_width/2,0])
				cube([frame_groove_width,frame_width,wall_thin+frame_groove_depth]);
			rotate([0,0,90])
				translate([-frame_groove_width/2,-frame_width/2,0])
					cube([frame_groove_width,frame_width,wall_thin+frame_groove_depth]);
		}

		translate([-(frame_width-2*frame_groove_depth)/2,-(frame_width-2*frame_groove_depth)/2,wall_thin])
			cube([frame_width-2*frame_groove_depth,frame_width-2*frame_groove_depth,frame_groove_depth+1]);
	}
}
