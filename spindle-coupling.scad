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

Inspired by:
	Spider Coupling with rubber insert
	http://www.thingiverse.com/thing:7678
	by MiseryBot

*******************************************************************/

include <configuration.scad>


// RENDER FOR PRINTING

// COUPLER SPINDLE SIDE
//translate([15,0,0]) rotate([0,0,45]) spindle_coupling(motor=0);

// COUPLER MOTOR SIDE
//translate([-15,0,0]) rotate([0,0,45]) spindle_coupling(motor=1);

// COUPLING INSERT MOLD (e.g. for Sugru)
//translate([0,25,0])
spindle_coupling_insert_mold();


module spindle_coupling(motor=0){
	difference(){
	
		// main body
		cylinder(r=spindle_coupling_body_dia/2, h=spindle_coupling_body_height);
	
		// spindle/motor shaft hole
		translate([0,0,-1])
			if ( motor == 0){
				cylinder(r=z_spindle_dia/2+clearance, h=spindle_coupling_body_height-wall_thin-3*wall+1);
			} else {
				cylinder(r=nema17_shaft_dia/2+clearance, h=spindle_coupling_body_height-wall_thin-3*wall+1);
			}
	
		// slot
		translate([-spindle_coupling_body_dia/2,-wall_thin/2,-1])
			cube([spindle_coupling_body_dia+2,wall_thin,spindle_coupling_body_height-wall_thin-3*wall+1]);
		translate([0,0,spindle_coupling_body_height-wall_thin-3*wall])
			rotate([0,90,0])
				cylinder(r=wall_thin/2,h=spindle_coupling_body_dia+2,center=true,$fn=24);
	
		// screw hole and nut trap
		for(k=[0,1])
			rotate([0,0,k*180]){
				translate([spindle_coupling_body_dia/2-(spindle_coupling_body_dia/2-z_spindle_dia/2-clearance)/2,0,(spindle_coupling_body_height-wall_thin-3*wall)/2]){
					rotate([0,0,90])
						teardrop(spindle_coupling_screw_dia/2+clearance,spindle_coupling_body_dia+2);
					translate([0,(spindle_coupling_body_dia/2+1)/2+wall_thin/2+wall,0])
						rotate([0,0,90])
							teardrop(spindle_coupling_screw_washer_dia/2+clearance,spindle_coupling_body_dia/2+1);
					translate([0,-(spindle_coupling_body_dia/2+1)/2-wall_thin/2-wall,0])
						rotate([90,0,0])
							rotate([0,0,30])
								nut_trap(spindle_coupling_screw_nut_wrench,spindle_coupling_body_dia/2+1);
				}
			}

		// cross claw
		difference(){
			rotate([0,0,45]){
				for(i=[0,1])
					mirror([i,i,0])
						translate([-wall,-wall,spindle_coupling_body_height-2*wall])
							cube([spindle_coupling_body_dia+2,spindle_coupling_body_dia+2,2*wall+1]);
				for(j=[0,1])
					rotate([0,0,j*180])
						translate([-wall,wall,spindle_coupling_body_height-2*wall+1])
							rotate([0,0,90])
								roundcorner(wall,2*wall);
			}

			// coupling insert centering nose
			translate([0,0,spindle_coupling_body_height-2*wall-wall+wall_thin/2+clearance])
				sphere(r=wall);
		}
	}
}


module spindle_coupling_insert_mold(){
	difference(){

		// main body
		union(){
			cylinder(r=spindle_coupling_body_dia/2+wall,h=2*wall);
			cube([spindle_coupling_body_dia/2+wall,spindle_coupling_body_dia/2+wall,2*wall]);
			translate([-spindle_coupling_body_dia-3*wall,0,0]){
				cylinder(r=spindle_coupling_body_dia/2+wall,h=wall);
				cube([spindle_coupling_body_dia/2+wall,spindle_coupling_body_dia/2+wall,wall]);
			}
			translate([spindle_coupling_body_dia+3*wall,0,0]){
				cylinder(r=spindle_coupling_body_dia/2+wall,h=wall);
				cube([spindle_coupling_body_dia/2+wall,spindle_coupling_body_dia/2+wall,wall]);
			}
			translate([2*(spindle_coupling_body_dia+3*wall)+wall,0,0])
				difference(){
					union(){
						cylinder(r=spindle_coupling_body_dia/2+2*wall,h=2*wall+2*wall);
						cube([spindle_coupling_body_dia/2+2*wall,spindle_coupling_body_dia/2+2*wall,2*wall+2*wall]);
					}
					translate([0,0,-1]){
						cylinder(r=spindle_coupling_body_dia/2+wall+clearance,h=2*wall+2*wall+2);
						cube([spindle_coupling_body_dia/2+wall+clearance,spindle_coupling_body_dia/2+wall+clearance,2*wall+2*wall+2]);
					}
				}
		}

		// mold
		intersection(){
			translate([0,0,-1])
			cylinder(r=spindle_coupling_body_dia/2,h=2*wall+wall_thin+2);

			// cross
			rotate([0,0,0]){
				for(i=[0,1])
					mirror([i,i,0])
						translate([-(spindle_coupling_body_dia+2)/2,-wall-clearance,-1])
							cube([spindle_coupling_body_dia+2,2*wall+2*clearance,2*wall+2]);
				for(j=[0:3])
					rotate([0,0,j*90])
						translate([-wall-clearance,wall+clearance,0])
							rotate([0,0,90])
								roundcorner(wall,2*wall);
			}
		}

	}


}
