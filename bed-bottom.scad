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
projection(cut=false) bed_bottom();


// ECHO
echo("bed corner screw hole dia: ", 2*(bed_corner_screw_dia/2+clearance_laser));
echo("bed corner screw hole corner dist: ", (bed_corner_body_side-wall-clearance)/2);
echo("bed leveling bolt hole dia: ", 2*(z_bed_bolt_screw_dia/2+wall_thin/2));
echo("bed leveling bolt center dist: ", (((sqrt(3))/3)*z_bed_bolt_dist));


module bed_bottom(){
	difference(){

		// main body
		translate([-bed_bottom_side/2,-bed_bottom_side/2,0])
			cube([bed_bottom_side,bed_bottom_side,bed_bottom_thickness]);

		// bed corner screw holes
		for(i=[0:3])
			rotate([0,0,i*90])
				translate([bed_bottom_side/2-(bed_corner_body_side-wall-clearance)/2,bed_bottom_side/2-(bed_corner_body_side-wall-clearance)/2,-1])
					cylinder(r=bed_corner_screw_dia/2+clearance_laser,h=bed_bottom_thickness+2);

		// bed center screw hole
		translate([0,0,-1])
			cylinder(r=bed_corner_screw_dia/2+clearance_laser,h=bed_bottom_thickness+2);

		// bed leveling bolt holes
		for(i=[0:2])
			rotate([0,0,i*120])
				translate([0,-(((sqrt(3))/3)*z_bed_bolt_dist),-1])
					cylinder(r=z_bed_bolt_screw_dia/2+wall_thin/2,h=bed_bottom_thickness+2);


	}
}


