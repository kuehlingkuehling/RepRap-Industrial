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

// DEV
// bed_siliconeheater_width = 300;
// bed_heatbed_width = 302;
// bed_heatbed_length = 212;


// RENDER (DXF)
projection(cut=false) bed_siliconeheater();



module bed_siliconeheater(){
	difference(){

		// main body
		cube([bed_siliconeheater_width,bed_siliconeheater_length,bed_siliconeheater_thickness],center=true);

		// bed leveling mount glueing clearance
		for(i=[0:2])
			rotate([0,0,i*120])
				translate([0,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius,0])
					cylinder(r=bed_leveling_mount_dia/2+wall_thin,h=bed_siliconeheater_thickness+2, center=true);

		// bed corner clearance
		for(i=[0:1])
			for(j=[0:1])
				mirror([i,0,0])
					mirror([0,j,0])
						translate([bed_heatbed_width/2-((bed_corner_body_width-wall)+wall_thin),bed_heatbed_length/2-((bed_corner_body_length-wall)+wall_thin),-(bed_siliconeheater_thickness+2)/2])
							cube([(bed_corner_body_width-wall)+wall_thin+1,(bed_corner_body_length-wall)+wall_thin+1,bed_siliconeheater_thickness+2]);
	}
}




