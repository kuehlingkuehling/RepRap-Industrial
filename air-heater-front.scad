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




// RENDER FOR LASER CUTTING (.DXF EXPORT)
projection(cut=false) rotate([-90,0,0]) air_heater_front();





module air_heater_front(){
	difference(){

		// main body
		translate([-air_heater_front_body_width/2,0,(air_heater_fan_side/2+air_heater_fan_hole_dist/2-air_heater_fan_screw_dia/2-clearance-wall)])
			cube([air_heater_front_body_width,air_heater_front_body_length,air_heater_front_body_height]);

		// fan mount
		intersection(){
			translate([0,-1,air_heater_fan_side/2])
				rotate([-90,0,0])
					cylinder(r=air_heater_fan_dia/2,h=air_heater_front_body_length+2);
			translate([-air_heater_fan_cutout_side/2,-1,air_heater_fan_side/2-air_heater_fan_cutout_side/2])
				cube([air_heater_fan_cutout_side,air_heater_front_body_length+2,air_heater_fan_cutout_side]);
		}
		for(i=[0,1])
			mirror([i,0,0])
				translate([air_heater_fan_hole_dist/2,-1,air_heater_fan_side/2+air_heater_fan_hole_dist/2])
					rotate([-90,0,0])
						cylinder(r=air_heater_fan_screw_dia/2+clearance,h=air_heater_front_body_length+2);
	}
}
