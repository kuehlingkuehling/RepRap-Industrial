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



// RENDER FOR PRINTING
rotate([0,180,0]) air_heater_top();



module air_heater_top(){
	difference(){

		// main body
		union(){
			intersection(){
				union(){
					translate([-air_heater_top_body_width/2,-air_heater_top_body_length,0])
						cube([air_heater_top_body_width,air_heater_top_body_length,air_heater_top_body_height]);
					hull(){
						translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall+wall+clearance+frame_screw_dia+clearance+wall)+wall,-air_heater_top_body_length/2,air_heater_top_body_height-wall])
							rotate([0,0,90])
								teardrop(wall,air_heater_top_body_length);
						translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall+wall+clearance+frame_screw_dia+clearance+wall)+wall,-air_heater_top_body_length/2,air_heater_top_body_height-frame_width+wall])
							rotate([0,0,90])
								teardrop(wall,air_heater_top_body_length);
						translate([(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall+wall+clearance+frame_screw_dia+clearance+wall)-wall,-air_heater_top_body_length/2,air_heater_top_body_height-wall])
							rotate([0,0,90])
								teardrop(wall,air_heater_top_body_length);
						translate([(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall+wall+clearance+frame_screw_dia+clearance+wall)-wall,-air_heater_top_body_length/2,air_heater_top_body_height-frame_width+wall])
							rotate([0,0,90])
								teardrop(wall,air_heater_top_body_length);
					}
				}
				union(){
					translate([0,-air_heater_top_body_length+wall_thin+clearance+wall,wall+clearance+wall])
						teardrop(air_heater_uprofile_height-2*air_heater_uprofile_thickness+wall_thin,air_heater_top_body_width+2);
					for(i=[0,1])
						mirror([i,0,0])
							translate([(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-air_heater_top_body_length-1,-1])
								cube([air_heater_top_body_width/2,air_heater_top_body_length+2,air_heater_top_body_height+2]);
					translate([-wall_thin/2,-air_heater_top_body_length-1,-1])
						cube([wall_thin,air_heater_top_body_length+2,air_heater_top_body_height+2]);
					translate([0,-air_heater_top_body_length+wall_thin+clearance+wall,wall+clearance+wall])
*							teardrop(air_heater_uprofile_height-air_heater_uprofile_thickness+clearance+wall_thin,wall_thin);

					// leave material for assembling threaded rod hole/nut trap
					translate([0,-wall_thin-clearance-wall-clearance-air_heater_assembling_screw_dia/2,0])
						hull(){
							translate([-(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)+wall,-(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)+wall,0])
								cylinder(r=wall,h=air_heater_top_body_height);
							translate([(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)-wall,-(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)+wall,0])
								cylinder(r=wall,h=air_heater_top_body_height);
							translate([-(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)+wall,(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)-wall,0])
								cylinder(r=wall,h=air_heater_top_body_height);
							translate([(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)-wall,(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)-wall,0])
								cylinder(r=wall,h=air_heater_top_body_height);
						}
				}
			}
			translate([-air_heater_top_body_width/2,-air_heater_top_body_length,0])
				cube([air_heater_top_body_width,air_heater_top_body_length,wall+clearance+wall]);
		}

		// air canal
		difference(){
			union(){
				translate([0,-air_heater_top_body_length+wall_thin+clearance+wall,wall+clearance+wall])
					rotate([0,90,0])
						cylinder(r=air_heater_uprofile_height-2*air_heater_uprofile_thickness,h=2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),center=true);
				translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-2*air_heater_top_body_length+wall_thin+clearance+wall,wall+clearance+wall])
					cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),air_heater_top_body_length,air_heater_uprofile_height-2*air_heater_uprofile_thickness]);
			}
			translate([-wall_thin/2,-air_heater_top_body_length-1,-1])
				cube([wall_thin,air_heater_top_body_length+2,air_heater_top_body_height+2]);
			translate([-air_heater_top_body_width/2-2,-2*air_heater_top_body_length+wall_thin+clearance+wall,-air_heater_top_body_height+wall+clearance+wall])
				cube([air_heater_top_body_width+4,air_heater_top_body_length,air_heater_top_body_height]);

			// leave material for assembling threaded rod hole/nut trap
			translate([0,-wall_thin-clearance-wall-clearance-air_heater_assembling_screw_dia/2,0])
				hull(){
					translate([-(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)+wall,-(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)+wall,0])
						cylinder(r=wall,h=air_heater_top_body_height);
					translate([(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)-wall,-(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)+wall,0])
						cylinder(r=wall,h=air_heater_top_body_height);
					translate([-(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)+wall,(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)-wall,0])
						cylinder(r=wall,h=air_heater_top_body_height);
					translate([(air_heater_assembling_screw_sleevenut_dia/2+clearance+wall)-wall,(wall+clearance+air_heater_assembling_screw_sleevenut_dia/2)-wall,0])
						cylinder(r=wall,h=air_heater_top_body_height);
				}
		}

		// air heater assembling threaded rod(sleeve nut hole
		translate([0,-wall_thin-clearance-wall-clearance-air_heater_assembling_screw_dia/2,-1])
			cylinder(r=air_heater_assembling_screw_sleevenut_dia/2+clearance,h=air_heater_top_body_height+2);

		// heater u-profile recess
		difference(){
			translate([-(air_heater_top_body_width-2*wall_thin)/2,-air_heater_top_body_length+wall_thin,-1])
				cube([air_heater_top_body_width-2*wall_thin,air_heater_top_body_length-2*wall_thin,wall+clearance+1]);
			for(i=[0,1])
				mirror([i,0,0])
					translate([(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-(air_heater_top_body_length-2*wall_thin-2*clearance-air_heater_uprofile_thickness-air_heater_front_thickness-2*clearance)-wall_thin-clearance-air_heater_uprofile_thickness-clearance,-1])
						cube([wall,air_heater_top_body_length-2*wall_thin-2*clearance-air_heater_uprofile_thickness-air_heater_front_thickness-2*clearance,air_heater_top_body_height+2]);

		}

		// frame mount screw holes
		for(i=[0,1])
			mirror([i,0,0])
				translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall+wall+clearance+frame_screw_dia/2),-air_heater_top_body_length/2,air_heater_top_body_height-frame_width/2])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(frame_screw_dia/2+clearance,air_heater_top_body_length+2);

	}

}
