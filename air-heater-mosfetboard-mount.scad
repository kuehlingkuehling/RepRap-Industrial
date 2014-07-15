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
rotate([0,-90,0]) air_heater_mosfetboard_mount(boards=5);





module air_heater_mosfetboard_mount(boards=5){

	air_heater_mosfetboard_mount_body_height = 2*wall+wall+boards*(wall_thin+air_heater_mosfetboard_height+wall_thin+wall);

	difference(){

		// main body
		union(){
			intersection(){
				union(){
					hull(){
						translate([-air_heater_mosfetboard_mount_body_width/2+wall,-frame_width/2+wall,wall])
							rotate([0,-90,0])
								teardrop(wall,2*wall);
						translate([air_heater_mosfetboard_mount_body_width/2-wall,-frame_width/2+wall,wall])
							rotate([0,-90,0])
								teardrop(wall,2*wall);
						translate([-air_heater_mosfetboard_mount_body_width/2,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,0])
							cube([air_heater_mosfetboard_mount_body_width,wall,2*wall]);
					}
					hull(){
						translate([-air_heater_mosfetboard_mount_body_width/2+wall,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,air_heater_mosfetboard_mount_body_height-wall])
							rotate([90,0,0])
								rotate([0,-90,0])
									teardrop(wall,2*wall);
						translate([air_heater_mosfetboard_mount_body_width/2-wall,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,air_heater_mosfetboard_mount_body_height-wall])
							rotate([90,0,0])
								rotate([0,-90,0])
									teardrop(wall,2*wall);
						translate([-air_heater_mosfetboard_mount_body_width/2,-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall,0])
							cube([air_heater_mosfetboard_mount_body_width,2*wall,wall]);
					}
					translate([-air_heater_mosfetboard_mount_body_width/2,-frame_width/2+wall,0])
						cube([air_heater_mosfetboard_mount_body_width,air_heater_mosfetboard_mount_body_length-wall,air_heater_mosfetboard_mount_body_height-wall]);
				}
				difference(){
					hull(){
						translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,wall])
							rotate([0,90,0])
								cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
						translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,air_heater_mosfetboard_mount_body_height+wall])
							rotate([0,90,0])
								cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
						translate([0,-frame_width/2-wall,wall])
							rotate([0,90,0])
								cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
						translate([0,-frame_width/2-wall,air_heater_mosfetboard_mount_body_height+wall])
							rotate([0,90,0])
								cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
					}
					translate([0,-2*wall,2*wall])
						hull(){
							translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,wall])
								rotate([0,90,0])
									cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
							translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-wall,air_heater_mosfetboard_mount_body_height+wall])
								rotate([0,90,0])
									cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
							translate([0,-frame_width/2-wall,wall])
								rotate([0,90,0])
									cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
							translate([0,-frame_width/2-wall,air_heater_mosfetboard_mount_body_height+wall])
								rotate([0,90,0])
									cylinder(r=wall,h=air_heater_mosfetboard_mount_body_width+2,center=true);
						}
				}
			}
		}

		// frame mount screw hole
		translate([0,0,wall])
			rotate([0,90,0])
				teardrop(frame_screw_dia/2+clearance,2*wall+2);
	}

	// mosfet board mount
	for(i=[0:boards-1])
		translate([0,0,i*(wall_thin+air_heater_mosfetboard_height+wall_thin+wall)])
			difference(){
				translate([-air_heater_mosfetboard_mount_body_width/2,-(1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin)-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall+1,2*wall+wall])
					cube([air_heater_mosfetboard_mount_body_width,1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin,wall_thin+clearance+air_heater_mosfetboard_height+wall_thin]);
				translate([-air_heater_mosfetboard_mount_body_width/2-1,-(1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin)-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall,2*wall+wall+2*wall_thin])
					cube([air_heater_mosfetboard_mount_body_width+2,1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin,air_heater_mosfetboard_height-2*wall_thin]);
				difference(){
					translate([-air_heater_mosfetboard_mount_body_width/2-1,-(1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin)-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall-wall,2*wall+wall+wall_thin])
						cube([air_heater_mosfetboard_mount_body_width+2,1+wall+clearance+air_heater_mosfetboard_thickness+clearance+wall_thin,air_heater_mosfetboard_height]);
					translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall-wall-clearance-air_heater_mosfetboard_thickness-clearance-wall_thin/2,2*wall+wall+wall_thin])
						rotate([0,90,0])
							cylinder(r=wall_thin/2,h=air_heater_mosfetboard_mount_body_width+2,center=true,$fa=0.1,$fs=0.1);
					translate([0,-frame_width/2+air_heater_mosfetboard_mount_body_length-2*wall-wall-clearance-air_heater_mosfetboard_thickness-clearance-wall_thin/2,2*wall+wall+wall_thin+air_heater_mosfetboard_height])
						rotate([0,90,0])
							cylinder(r=wall_thin/2,h=air_heater_mosfetboard_mount_body_width+2,center=true,$fa=0.1,$fs=0.1);
				}
			}
}


