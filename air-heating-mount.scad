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

air_heating_mount_body_width = 2*wall;
air_heating_mount_body_height = air_heating_fan_hole_dist+air_heating_fan_screw_dia+2*clearance+2*wall;
air_heating_mount_body_length = frame_width-clearance-frame_enclosure_thickness + air_heating_fan_height + air_heating_mount_body_width;

// RENDER FOR PRINTING
air_heating_mount();


module air_heating_mount(){

	difference(){

		// main body
		union(){
			hull(){
				translate([wall,air_heating_mount_body_width/2,wall])
					rotate([180,0,90])
						teardrop(wall,air_heating_mount_body_width);
				translate([wall,air_heating_mount_body_width/2,air_heating_mount_body_height-wall])
					rotate([180,0,90])
						teardrop(wall,air_heating_mount_body_width);
				translate([frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width-wall,0,0])
					cube([wall,air_heating_mount_body_width,air_heating_mount_body_height]);
			}
			translate([0,air_heating_fan_height,0])
				hull(){
					translate([(frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width)+2*wall+((air_heating_fan_side-air_heating_fan_hole_dist)/2+air_heating_fan_screw_dia/2+clearance+wall)-wall,air_heating_mount_body_width/2,wall])
						rotate([180,0,90])
							teardrop(wall,air_heating_mount_body_width);
					translate([(frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width)+2*wall+((air_heating_fan_side-air_heating_fan_hole_dist)/2+air_heating_fan_screw_dia/2+clearance+wall)-wall,air_heating_mount_body_width/2,air_heating_mount_body_height-wall])
						rotate([180,0,90])
							teardrop(wall,air_heating_mount_body_width);
					translate([frame_width-clearance-frame_enclosure_thickness,0,0])
						cube([wall,air_heating_mount_body_width,air_heating_mount_body_height]);
				}
			translate([frame_width-clearance-frame_enclosure_thickness,0,0])
				cube([air_heating_mount_body_width,air_heating_fan_height,air_heating_mount_body_height]);
		}


		// fan radial clearance
		translate([frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width+2*wall+air_heating_fan_side/2,air_heating_fan_height-1,air_heating_mount_body_height/2])
			rotate([-90,0,0])
				cylinder(r=air_heating_fan_side/2+wall,h=air_heating_mount_body_width+2);

		// frame screw holes
		translate([-clearance-frame_enclosure_thickness+frame_width/2,air_heating_mount_body_width/2,wall+clearance+frame_screw_dia/2])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,air_heating_mount_body_width+2);
		translate([-clearance-frame_enclosure_thickness+frame_width/2,air_heating_mount_body_width/2,air_heating_mount_body_height-(wall+clearance+frame_screw_dia/2)])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,air_heating_mount_body_width+2);

		// fan screw holes
		translate([0,air_heating_fan_height,0]){
			translate([(frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width)+2*wall+(air_heating_fan_side-air_heating_fan_hole_dist)/2,air_heating_mount_body_width/2,air_heating_mount_body_height/2-air_heating_fan_hole_dist/2])
				rotate([0,0,90])
					teardrop(air_heating_fan_screw_dia/2+clearance,air_heating_mount_body_width+2);
			translate([(frame_width-clearance-frame_enclosure_thickness+air_heating_mount_body_width)+2*wall+(air_heating_fan_side-air_heating_fan_hole_dist)/2,air_heating_mount_body_width/2,air_heating_mount_body_height/2+air_heating_fan_hole_dist/2])
				rotate([0,0,90])
					teardrop(air_heating_fan_screw_dia/2+clearance,air_heating_mount_body_width+2);
		}
			
	}

}
