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
rotate([0,90,0]) 
    difference(){
        controller_touchscreen_housing_mount();
        translate([0,-controller_touchscreen_housing_mount_body_length/2,-controller_touchscreen_housing_mount_body_side/2])
            label("30",orientation="bottom");
    }





module controller_touchscreen_housing_mount(){
	difference(){

		// main body
		hull(){
			translate([-controller_touchscreen_housing_mount_body_side/2+wall,-controller_touchscreen_housing_mount_body_length/2,-controller_touchscreen_housing_mount_body_side/2+wall])
				rotate([0,0,90])
					rotate([90,0,0])
						teardrop(wall,controller_touchscreen_housing_mount_body_length);
			translate([-controller_touchscreen_housing_mount_body_side/2+wall,-controller_touchscreen_housing_mount_body_length/2,controller_touchscreen_housing_mount_body_side/2-wall])
				rotate([0,0,90])
					rotate([90,0,0])
						teardrop(wall,controller_touchscreen_housing_mount_body_length);
			translate([controller_touchscreen_housing_mount_body_side/2-wall,-controller_touchscreen_housing_mount_body_length/2,-controller_touchscreen_housing_mount_body_side/2+wall])
				rotate([0,0,90])
					rotate([90,0,0])
						teardrop(wall,controller_touchscreen_housing_mount_body_length);
			translate([controller_touchscreen_housing_mount_body_side/2-wall,-controller_touchscreen_housing_mount_body_length/2,controller_touchscreen_housing_mount_body_side/2-wall])
				rotate([0,0,90])
					rotate([90,0,0])
						teardrop(wall,controller_touchscreen_housing_mount_body_length);
		}

		// diagonal touchscreen housing mount
		translate([0,-controller_touchscreen_housing_mount_body_length+controller_touchscreen_housing_mount_body_side/2,0])
			rotate([-45,0,0])
				translate([-controller_touchscreen_housing_mount_body_side,-2*controller_touchscreen_housing_mount_body_side,-controller_touchscreen_housing_mount_body_side])
					cube([2*controller_touchscreen_housing_mount_body_side,2*controller_touchscreen_housing_mount_body_side,2*controller_touchscreen_housing_mount_body_side]);

		// housing mount screw holes and nut traps
		translate([0,-controller_touchscreen_housing_mount_body_length+controller_touchscreen_housing_mount_body_side/2,0])
			rotate([-45,0,0])
				for(v=[0,1])
					mirror([0,0,v]){
						translate([controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2,(wall+clearance+controller_touchscreen_housing_back_screw_nut_height+clearance+wall+1)/2-1,controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2])
							rotate([0,0,90])
								rotate([-90,0,0])
									teardrop(controller_touchscreen_housing_back_screw_dia/2+clearance,wall+clearance+controller_touchscreen_housing_back_screw_nut_height+clearance+wall+1);
						translate([-(controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2),(wall+clearance+controller_touchscreen_housing_back_screw_nut_height+clearance+wall+1)/2-1,controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2])
							rotate([0,0,90])
								rotate([-90,0,0])
									teardrop(controller_touchscreen_housing_back_screw_dia/2+clearance,wall+clearance+controller_touchscreen_housing_back_screw_nut_height+clearance+wall+1);
					}
		translate([0,-controller_touchscreen_housing_mount_body_length+controller_touchscreen_housing_mount_body_side/2,0])
			rotate([-45,0,0])
				for(v=[0,1])
					mirror([0,0,v]){
						translate([controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2,controller_touchscreen_housing_back_screw_nut_height/2+clearance+wall,controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2])
							rotate([90,0,0])
								nut_slot_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_back_screw_nut_height,controller_touchscreen_housing_mount_side);
						translate([-(controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2),controller_touchscreen_housing_back_screw_nut_height/2+clearance+wall,controller_touchscreen_housing_mount_side/2-wall-clearance-controller_touchscreen_housing_back_screw_dia/2])
							rotate([0,180,0])
								rotate([90,0,0])
									nut_slot_square(controller_touchscreen_housing_back_screw_nut_wrench,controller_touchscreen_housing_back_screw_nut_height,controller_touchscreen_housing_mount_side);
					}

		// touchscreen cable clearance
		translate([0,-controller_touchscreen_housing_mount_body_length/2,0])
			rotate([0,0,-90])
				rotate([90,0,0])
					teardrop(controller_touchscreen_cable_clearance_dia/2,controller_touchscreen_housing_mount_body_length+2);
*		translate([0,-controller_touchscreen_housing_mount_body_length/2-controller_touchscreen_housing_mount_body_length+controller_touchscreen_housing_mount_body_side,0])
			rotate([0,0,-90])
				rotate([90,0,0])
					teardrop(controller_touchscreen_cable_clearance_dia/2,controller_touchscreen_housing_mount_body_length,fulldrop=1);
*		hull(){
			translate([0,-controller_touchscreen_housing_mount_body_length+controller_touchscreen_housing_mount_body_side/2+controller_touchscreen_cable_dia,0])
				rotate([0,-90,0])
					cylinder(r=controller_touchscreen_cable_dia/2,h=controller_touchscreen_housing_mount_body_side);
			translate([0,-controller_touchscreen_housing_mount_body_length,0])
				rotate([0,-90,0])
					cylinder(r=controller_touchscreen_cable_dia/2,h=controller_touchscreen_housing_mount_body_side);
		}

		// frame enclosure mount screw holes and nut traps
		for(v=[0,1])
			mirror([0,0,v]){
				translate([controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2,-(wall+clearance+frame_screw_nut_height+clearance+wall+1)/2+1,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([0,0,90])
						rotate([-90,0,0])
							teardrop(frame_screw_dia/2+clearance,wall+clearance+frame_screw_nut_height+clearance+wall+1);
				translate([-(controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2),-(wall+clearance+frame_screw_nut_height+clearance+wall+1)/2+1,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([0,0,90])
						rotate([-90,0,0])
							teardrop(frame_screw_dia/2+clearance,wall+clearance+frame_screw_nut_height+clearance+wall+1);
			}
		for(v=[0,1])
			mirror([0,0,v]){
				translate([controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2,-frame_screw_nut_height/2-clearance-wall,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([0,-90,0])
						rotate([90,0,0])
							nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,controller_touchscreen_housing_mount_side);
				translate([-(controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2),-frame_screw_nut_height/2-clearance-wall,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([0,-90,0])
						rotate([90,0,0])
							nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,controller_touchscreen_housing_mount_side);
			}
	}
}