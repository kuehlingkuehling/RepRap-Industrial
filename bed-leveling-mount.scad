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





// RENDER
difference(){
    bed_leveling_mount();
    translate([0,0,wall_thin])
        label("351",orientation="top");
}



module bed_leveling_mount(){
	difference(){

		// main body
		union(){
			for(i=[0:2])
				rotate([0,0,i*120])
					translate([0,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius,0])
						cylinder(r=bed_leveling_mount_dia/2,h=bed_leveling_mount_body_height);
			for(i=[0:2])
				rotate([0,0,i*120])
					translate([0,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius,0])
						hull(){
							hull(){
								translate([bed_leveling_mount_dia/2-wall,bed_leveling_mount_dia/2-wall,0])
									cylinder(r=wall,h=wall+clearance+bed_leveling_rod_end_bearing_screw_dia+clearance+wall);
								translate([-bed_leveling_mount_dia/2+wall,bed_leveling_mount_dia/2-wall,0])
									cylinder(r=wall,h=wall+clearance+bed_leveling_rod_end_bearing_screw_dia+clearance+wall);
								translate([-bed_leveling_mount_dia/2+wall,-bed_leveling_mount_dia/2+wall,0])
									cylinder(r=wall,h=wall+clearance+bed_leveling_rod_end_bearing_screw_dia+clearance+wall);
								translate([bed_leveling_mount_dia/2-wall,-bed_leveling_mount_dia/2+wall,0])
									cylinder(r=wall,h=wall+clearance+bed_leveling_rod_end_bearing_screw_dia+clearance+wall);
							}
							cylinder(r=bed_leveling_mount_dia/2,h=bed_leveling_mount_body_height-bed_siliconeheater_thickness);
						}
			for(i=[0:2])
				rotate([0,0,i*120])
					translate([-bed_leveling_mount_dia/2,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius,0])
						cube([bed_leveling_mount_dia,-bed_leveling_mount_dia/2-bed_leveling_rod_end_bearing_width/2+z_bed_bolt_radius,wall_thin]);
		}

		// bed leveling bolt rod end bearing screw holes and nut trap
		for(i=[0:2])
			rotate([0,0,i*120])
				translate([0,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius+bed_leveling_mount_dia/2+1,wall+clearance+bed_leveling_rod_end_bearing_screw_dia/2])
					rotate([90,0,0])
						cylinder(r=bed_leveling_rod_end_bearing_screw_dia/2+clearance,h=bed_leveling_mount_dia+2);
		for(i=[0:2])
			rotate([0,0,i*120])
				translate([0,bed_leveling_mount_dia/2+bed_leveling_rod_end_bearing_width/2-z_bed_bolt_radius+bed_leveling_mount_dia/2-(bed_leveling_rod_end_bearing_screw_nut_height+1)/2+1,wall+clearance+bed_leveling_rod_end_bearing_screw_dia/2])
					rotate([90,0,0])
						nut_trap(bed_leveling_rod_end_bearing_screw_nut_wrench,bed_leveling_rod_end_bearing_screw_nut_height+1);
	}
}


