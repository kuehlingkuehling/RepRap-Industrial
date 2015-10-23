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
rotate([90,0,0])
    difference(){
        controller_ethernet_coupling_panel();
        translate([0,frame_enclosure_thickness+controller_ethernet_coupling_panel_body_length/2,0])
            label("29",orientation="bottom");
    }




module controller_ethernet_coupling_panel(){
	difference(){

		// main body
		hull(){
			translate([-controller_ethernet_coupling_panel_body_width/2+wall,frame_enclosure_thickness,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=controller_ethernet_coupling_panel_body_length);
			translate([controller_ethernet_coupling_panel_body_width/2-wall,frame_enclosure_thickness,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=controller_ethernet_coupling_panel_body_length);
			translate([-controller_ethernet_coupling_panel_body_width/2+wall,frame_enclosure_thickness,controller_ethernet_coupling_panel_body_height-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=controller_ethernet_coupling_panel_body_length);
			translate([controller_ethernet_coupling_panel_body_width/2-wall,frame_enclosure_thickness,controller_ethernet_coupling_panel_body_height-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=controller_ethernet_coupling_panel_body_length);
		}

		// controller ethernet coupling mount
		translate([-controller_ethernet_coupling_width_front/2-clearance,0,wall])
			cube([controller_ethernet_coupling_width_front+2*clearance,controller_ethernet_coupling_panel_front_dist,controller_ethernet_coupling_panel_body_height-2*wall]);
		translate([-controller_ethernet_coupling_width_front/2-clearance,0,2*wall])
			cube([controller_ethernet_coupling_width_front+2*clearance,frame_enclosure_thickness+controller_ethernet_coupling_panel_body_length+1,controller_ethernet_coupling_height_back+2*clearance]);
		translate([-controller_ethernet_coupling_width_back/2-clearance,controller_ethernet_coupling_panel_front_dist+controller_ethernet_coupling_panel_thickness,wall])
			cube([controller_ethernet_coupling_width_back+2*clearance,controller_ethernet_coupling_panel_front_dist,controller_ethernet_coupling_panel_body_height-2*wall]);

		// frame enclosure mount screw holes and nut traps
		for(i=[0,1])
			mirror([i,0,0]){
				translate([controller_ethernet_coupling_panel_body_width/2-wall-clearance-frame_screw_dia/2,0,controller_ethernet_coupling_panel_body_height/2])
					rotate([-90,0,0])
						cylinder(r=frame_screw_dia/2+clearance,h=frame_enclosure_thickness+controller_ethernet_coupling_panel_body_length+1);
				translate([controller_ethernet_coupling_panel_body_width/2-wall-clearance-frame_screw_dia/2,(frame_screw_nut_height+clearance+1)/2+frame_enclosure_thickness+wall,controller_ethernet_coupling_panel_body_height/2])
					rotate([0,180,0])
						rotate([-90,0,0])
							nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,controller_ethernet_coupling_panel_body_width/2);
			}
	}
}