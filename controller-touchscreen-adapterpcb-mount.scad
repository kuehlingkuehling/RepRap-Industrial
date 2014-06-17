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
rotate([-90,0,0]) controller_touchscreen_adapterpcb_mount();





module controller_touchscreen_adapterpcb_mount(){
	difference(){

		// main body
		union(){
			hull(){
				translate([-controller_touchscreen_housing_mount_body_side/2+wall,0,-controller_touchscreen_housing_mount_body_side/2-1])
					rotate([90,0,0])
						cylinder(r=wall,h=wall);
				translate([-controller_touchscreen_housing_mount_body_side/2+wall,0,controller_touchscreen_housing_mount_body_side/2-wall])
					rotate([90,0,0])
						cylinder(r=wall,h=wall);
				translate([controller_touchscreen_housing_mount_body_side/2-wall,0,-controller_touchscreen_housing_mount_body_side/2-1])
					rotate([90,0,0])
						cylinder(r=wall,h=wall);
				translate([controller_touchscreen_housing_mount_body_side/2-wall,0,controller_touchscreen_housing_mount_body_side/2-wall])
					rotate([90,0,0])
						cylinder(r=wall,h=wall);
			}

			// pcb mount
			translate([0,0,-controller_touchscreen_housing_mount_body_side/2])
			difference(){
				union(){
					difference(){
						hull(){
							translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2+wall,0,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2+wall,0,-wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall,0,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall,0,-wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
						}
						translate([-(controller_touchscreen_adapterpcb_width+2*clearance-2*wall_thin)/2,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall,-(controller_touchscreen_adapterpcb_height+2*clearance-2*wall_thin)-2*wall_thin])
							cube([controller_touchscreen_adapterpcb_width+2*clearance-2*wall_thin,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance-2*wall_thin]);
						hull(){
							translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2+wall+2*wall,1,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall+2*wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2+wall+2*wall,1,-wall-2*wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall-2*wall,1,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall+2*wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
							translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall-2*wall,1,-wall-2*wall])
								rotate([90,0,0])
									cylinder(r=wall,h=wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin);
						}
						translate([-(controller_touchscreen_adapterpcb_width+2*clearance)/2,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall-controller_touchscreen_adapterpcb_clearance_bottom,-(controller_touchscreen_adapterpcb_height+2*clearance)-wall_thin])
							cube([controller_touchscreen_adapterpcb_width+2*clearance,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance]);
					}
					translate([0,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)+wall_thin/2,-wall_thin])
						rotate([0,90,0])
							cylinder(r=wall_thin/2,h=controller_touchscreen_adapterpcb_width,center=true,$fa=0.1,$fs=0.1);
					translate([0,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)+wall_thin/2,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall_thin])
						rotate([0,90,0])
							cylinder(r=wall_thin/2,h=controller_touchscreen_adapterpcb_width,center=true,$fa=0.1,$fs=0.1);
					translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2+wall_thin,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)+wall_thin/2,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)/2])
						cylinder(r=wall_thin/2,h=controller_touchscreen_adapterpcb_height,center=true,$fa=0.1,$fs=0.1);
				}
	
				translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-1,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall,-wall_thin-clearance-controller_touchscreen_adapterpcb_clearance_corner])
					cube([wall_thin+clearance+controller_touchscreen_adapterpcb_clearance_display+1,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin]);
				translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall_thin-clearance-controller_touchscreen_adapterpcb_clearance_corner,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall,-wall_thin-clearance-controller_touchscreen_adapterpcb_clearance_corner])
					cube([controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin]);
				translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall_thin-clearance-controller_touchscreen_adapterpcb_clearance_corner,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall-controller_touchscreen_adapterpcb_clearance_bottom-clearance-controller_touchscreen_adapterpcb_thickness,-(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)])
					cube([controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin]);
				translate([(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-wall_thin-clearance-controller_touchscreen_adapterpcb_clearance_corner,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall,-2*(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall_thin+clearance+controller_touchscreen_adapterpcb_clearance_corner])
					cube([controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin]);
				translate([-(controller_touchscreen_adapterpcb_width+2*clearance+2*wall_thin)/2-1,-(wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin)-wall,-2*(controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin)+wall_thin+clearance+controller_touchscreen_adapterpcb_clearance_corner])
					cube([wall_thin+clearance+controller_touchscreen_adapterpcb_clearance_hdmi+1,wall+controller_touchscreen_adapterpcb_clearance_bottom+clearance+controller_touchscreen_adapterpcb_thickness+clearance+wall_thin,controller_touchscreen_adapterpcb_height+2*clearance+2*wall_thin]);
			}
		}

		// touchscreen cable clearance
		translate([0,1,0])
			rotate([90,0,0])
				cylinder(r=controller_touchscreen_cable_clearance_dia/2,h=wall+2);

		// frame enclosure mount screw holes and nut traps
		for(v=[0,1])
			mirror([0,0,v]){
				translate([controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2,1,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance,h=wall+2);
				translate([-(controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2),1,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance,h=wall+2);
			}
	}
}


