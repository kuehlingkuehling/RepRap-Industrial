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

// 2x
rotate([0,90,0])
    difference(){
        frame_enclosure_door_handle();
        translate([-frame_enclosure_door_handle_body_width/2,-frame_enclosure_door_handle_body_length+2*wall,0])
            label("13",orientation="back");
    }




module frame_enclosure_door_handle(){
	difference(){

		// main body
		union(){
			hull(){
				for(k=[1,-1])
					translate([-frame_enclosure_door_handle_body_width+wall,-frame_enclosure_door_handle_body_length+2*wall,k*(frame_enclosure_door_handle_body_height/2-wall)])
						rotate([90,0,0])
							cylinder(r=wall,h=2*wall);
				translate([-wall,-frame_enclosure_door_handle_body_length,-frame_enclosure_door_handle_body_height/2])
					cube([wall,2*wall,frame_enclosure_door_handle_body_height]);
			}
			for(i=[1,-1])
				translate([0,0,i*(frame_enclosure_door_handle_body_height/2-2*wall-clearance-frame_screw_dia/2)])
					hull(){
						for(j=[1,-1])
							translate([-2*(frame_screw_dia/2+clearance+2*wall)+wall,0,j*(frame_screw_dia/2+clearance+2*wall-wall)])
								rotate([90,0,0])
									cylinder(r=wall,h=frame_enclosure_door_handle_body_length);
						translate([-wall,-frame_enclosure_door_handle_body_length,-(frame_screw_dia/2+clearance+2*wall)])
							cube([wall,frame_enclosure_door_handle_body_length,2*(frame_screw_dia/2+clearance+2*wall)]);
					}

		}

		// frame enclosure door mount screw holes and nut traps
		for(i=[1,-1])
			translate([-2*wall-clearance-frame_screw_dia/2,0,i*(frame_enclosure_door_handle_body_height/2-2*wall-clearance-frame_screw_dia/2)])
				rotate([0,0,-90])
					rotate([90,0,0])
						teardrop(frame_screw_dia/2+clearance,2*(frame_enclosure_door_handle_body_length-wall));
		for(i=[1,-1])
			translate([-2*wall-clearance-frame_screw_dia/2,-frame_screw_nut_height/2-clearance-2*wall,i*(frame_enclosure_door_handle_body_height/2-2*wall-clearance-frame_screw_dia/2)])
				rotate([0,0,180])
					rotate([90,0,0])
						nut_slot_square(frame_screw_nut_wrench,frame_screw_nut_height,frame_enclosure_door_handle_body_width);

	}
}

