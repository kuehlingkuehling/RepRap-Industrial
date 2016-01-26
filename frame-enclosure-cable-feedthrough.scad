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
// 10 MM
* rotate([180,0,0])
    difference(){
        frame_enclosure_cable_feedthrough(cable_clearance=10);
        translate([frame_enclosure_cable_feedthrough_body_side/2,frame_enclosure_cable_feedthrough_body_side-wall-wall,-wall-(frame_enclosure_cable_feedthrough_body_height-wall)/2])
            label("275",orientation="front");
    }

// 20 MM
* rotate([180,0,0])
    difference(){
        frame_enclosure_cable_feedthrough(cable_clearance=20);
        translate([frame_enclosure_cable_feedthrough_body_side/2,frame_enclosure_cable_feedthrough_body_side-wall-wall,-wall-(frame_enclosure_cable_feedthrough_body_height-wall)/2])
            label("277",orientation="front");
    }




module frame_enclosure_cable_feedthrough(cable_clearance=6){
	difference(){

		// main body
		union(){
			hull(){
				translate([clearance,clearance,0])
					cube([wall,wall,wall_thin]);
				translate([frame_enclosure_cable_feedthrough_body_side-wall,clearance,0])
					cube([wall,wall,wall_thin]);
				translate([frame_enclosure_cable_feedthrough_body_side-wall,frame_enclosure_cable_feedthrough_body_side-wall,0])
					cylinder(r=wall,h=wall_thin);
				translate([clearance,frame_enclosure_cable_feedthrough_body_side-wall,0])
					cube([wall,wall,wall_thin]);
			}
			translate([clearance,clearance,wall_thin-wall])
				cube([frame_width-2*clearance,frame_width-2*clearance,wall]);
			for(i=[0,1])
				mirror([i,-i,0]){
					translate([clearance,-wall+frame_enclosure_cable_feedthrough_body_side-wall-clearance,-frame_enclosure_cable_feedthrough_body_height+wall_thin-wall])
						cube([frame_enclosure_cable_feedthrough_body_side-wall-clearance-2*wall,wall,frame_enclosure_cable_feedthrough_body_height+wall]);
					hull(){
						translate([clearance,-wall_thin+frame_enclosure_cable_feedthrough_body_side-wall-clearance+wall_thin,-frame_enclosure_cable_feedthrough_body_height+wall_thin+wall_thin/2])
							rotate([0,90,0])
								cylinder(r=wall_thin/2,h=frame_enclosure_cable_feedthrough_body_side-wall-clearance-2*wall,$fa=0.1,$fs=0.1);
						translate([clearance,-wall_thin+frame_enclosure_cable_feedthrough_body_side-wall-clearance+wall_thin,-frame_enclosure_cable_feedthrough_body_height+wall_thin+wall_thin/2-wall])
							rotate([0,90,0])
								cylinder(r=wall_thin/2,h=frame_enclosure_cable_feedthrough_body_side-wall-clearance-2*wall,$fa=0.1,$fs=0.1);
					}
				}
		}

		// cable clearance
		hull(){
			translate([-wall,-wall,-frame_enclosure_cable_feedthrough_body_height+wall_thin+1])
				cube([wall,wall,frame_enclosure_cable_feedthrough_body_height+2]);
			translate([cable_clearance+clearance-wall,-wall,-frame_enclosure_cable_feedthrough_body_height+wall_thin+1])
				cube([wall,wall,frame_enclosure_cable_feedthrough_body_height+2]);
			translate([cable_clearance+clearance-wall,cable_clearance+clearance-wall,-frame_enclosure_cable_feedthrough_body_height+wall_thin+1])
				cylinder(r=wall,h=frame_enclosure_cable_feedthrough_body_height+2);
			translate([-wall,cable_clearance+clearance-wall,-frame_enclosure_cable_feedthrough_body_height+wall_thin+1])
				cube([wall,wall,frame_enclosure_cable_feedthrough_body_height+2]);
		}
	}
}
