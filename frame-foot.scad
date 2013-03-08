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


foot_nut();

//foot_screw();


module foot_nut(){
	difference(){
		// main body
		union(){
			hull(){
				translate([frame_width/2-wall_thin,frame_width/2-wall_thin,0])
					cylinder(r=wall_thin,h=wall+frame_screw_nut_height+clearance);
				translate([-(frame_width/2-wall_thin),(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall+frame_screw_nut_height+clearance);
				translate([(frame_width/2-wall_thin),-(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall+frame_screw_nut_height+clearance);
				translate([-(frame_width/2-wall_thin),-(frame_width/2-wall_thin),0])
					cylinder(r=wall_thin,h=wall+frame_screw_nut_height+clearance);
			}
			translate([-frame_groove_width/2,-frame_width/2,0])
				cube([frame_groove_width,frame_width,wall+frame_screw_nut_height+clearance+frame_groove_depth]);
			rotate([0,0,90])
				translate([-frame_groove_width/2,-frame_width/2,0])
					cube([frame_groove_width,frame_width,wall+frame_screw_nut_height+clearance+frame_groove_depth]);
		}

		// frame core clearance
		translate([-(frame_width-2*frame_groove_depth)/2,-(frame_width-2*frame_groove_depth)/2,wall+frame_screw_nut_height+clearance])
			cube([frame_width-2*frame_groove_depth,frame_width-2*frame_groove_depth,frame_groove_depth+1]);

		// foot screw nut trap
		translate([0,0,(frame_screw_nut_height+clearance+1)/2+wall])
			nut_trap(frame_foot_screw_nut_wrench,frame_foot_screw_nut_height+clearance+1);

		// foot screw hole
		translate([0,0,-1])
			cylinder(r=frame_foot_screw_dia/2+clearance,h=wall+2);
	}
}


module foot_screw(){
	difference(){
		// main body
		cylinder(r=frame_width/2,h=wall+frame_foot_screw_head_wrench_length+clearance);

		// foot screw hex head trap
		translate([0,0,(frame_foot_screw_head_wrench_length+clearance+1)/2+wall])
			nut_trap(frame_foot_screw_head_wrench,frame_foot_screw_head_wrench_length+clearance+1);

		// foot screw hole
		translate([0,0,-1])
			cylinder(r=frame_foot_screw_dia/2+clearance,h=wall+2);
	}
}



