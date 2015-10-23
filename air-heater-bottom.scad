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
difference(){
    air_heater_bottom();
    translate([0,-air_heater_bottom_body_length/4*3,0])
        label("53",orientation="bottom");
}



module air_heater_bottom(){
	difference(){

		// main body
		union(){
			intersection(){
				union(){
					translate([-air_heater_bottom_body_width/2,-air_heater_bottom_body_length,0])
						cube([air_heater_bottom_body_width,air_heater_bottom_body_length,air_heater_bottom_body_height+wall]);
					hull(){
						for(i=[0,1])
							mirror([i,0,0]){
								translate([air_heater_fan_side/2+clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall-wall,-air_heater_bottom_body_length/2,frame_width-wall])
									rotate([0,0,90])
										rotate([180,0,0])
											teardrop(wall,air_heater_bottom_body_length);
								translate([air_heater_fan_side/2+clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall-wall,-air_heater_bottom_body_length/2,wall])
									rotate([0,0,90])
										rotate([180,0,0])
											teardrop(wall,air_heater_bottom_body_length);
							}
					}
				}
				union(){
					translate([0,-air_heater_bottom_body_length+wall,air_heater_bottom_body_height-(wall+clearance+wall)])
						rotate([180,0,0])
							teardrop(air_heater_uprofile_height-2*air_heater_uprofile_thickness+wall_thin,air_heater_bottom_body_width+2);
					for(i=[0,1])
						mirror([i,0,0])
							translate([(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-air_heater_bottom_body_length-1,-1])
								cube([air_heater_bottom_body_width/2,air_heater_bottom_body_length+2,air_heater_bottom_body_height+wall+2]);
					translate([0,-air_heater_bottom_body_length+wall,air_heater_bottom_body_height-(wall+clearance+wall)])
						rotate([180,0,0])
							teardrop(air_heater_bottom_body_length-wall,wall_thin);
				}
			}
			translate([-air_heater_bottom_body_width/2,-air_heater_bottom_body_length,air_heater_bottom_body_height-(wall+clearance+2*air_heater_cable_dia+clearance+wall_thin)])
				cube([air_heater_bottom_body_width,air_heater_bottom_body_length,wall+clearance+2*air_heater_cable_dia+clearance+wall_thin+wall]);
			for(i=[0,1])
				mirror([i,0,0])
					hull(){
							translate([air_heater_fan_hole_dist/2,-air_heater_bottom_body_length/2,air_heater_fan_side/2-air_heater_fan_hole_dist/2])
								rotate([0,0,90])
									rotate([180,0,0])
										teardrop(air_heater_fan_screw_washer_dia/2+clearance+wall_thin,air_heater_bottom_body_length);
							translate([air_heater_fan_hole_dist/2,-air_heater_bottom_body_length/2,wall/2])
								cube([2*(air_heater_fan_screw_washer_dia/2+clearance+wall_thin),air_heater_bottom_body_length,wall],center=true);
					}
		}

		// air canal
		difference(){
			union(){
				translate([0,-air_heater_bottom_body_length+wall,air_heater_bottom_body_height-(wall+clearance+wall)])
					rotate([0,90,0])
						cylinder(r=air_heater_uprofile_height-2*air_heater_uprofile_thickness,h=2*(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),center=true);
				translate([-(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-2*air_heater_bottom_body_length+wall,-(air_heater_uprofile_height-2*air_heater_uprofile_thickness)+air_heater_bottom_body_height-(wall+clearance+wall)])
					cube([2*(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),air_heater_bottom_body_length,air_heater_uprofile_height-2*air_heater_uprofile_thickness]);
				translate([-(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-air_heater_bottom_body_length-wall_thin-clearance-wall,air_heater_bottom_body_height-(wall+clearance+wall)])
					cube([2*(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),air_heater_bottom_body_length,air_heater_uprofile_height-2*air_heater_uprofile_thickness]);
			}

			// fan mount
			difference(){
				translate([-air_heater_bottom_body_width/2,-air_heater_bottom_body_length,0])
					cube([air_heater_bottom_body_width,wall,air_heater_bottom_body_height]);
				intersection(){
					translate([0,1,air_heater_fan_side/2])
						rotate([90,0,0])
							cylinder(r=air_heater_fan_dia/2,h=air_heater_bottom_body_length+2);
					translate([-air_heater_fan_cutout_side/2,-air_heater_bottom_body_length-1,air_heater_fan_side/2-air_heater_fan_cutout_side/2])
						cube([air_heater_fan_cutout_side,air_heater_bottom_body_length+2,air_heater_fan_cutout_side]);
				}
			}
			for(i=[0,1])
				mirror([i,0,0])
					translate([air_heater_fan_hole_dist/2,-air_heater_bottom_body_length/2,air_heater_fan_side/2-air_heater_fan_hole_dist/2])
						rotate([0,0,90])
							rotate([180,0,0])
								teardrop(air_heater_fan_screw_washer_dia/2+clearance+wall_thin,air_heater_bottom_body_length+2);
		}

		// heater u-profile recess
		difference(){
			translate([-(air_heater_bottom_body_width-2*wall_thin)/2,-(air_heater_bottom_body_length-wall_thin+1)-wall_thin,air_heater_bottom_body_height-wall-clearance])
				cube([air_heater_bottom_body_width-2*wall_thin,air_heater_bottom_body_length-wall_thin+1,2*wall+clearance+1]);
			for(i=[0,1])
				mirror([i,0,0])
					translate([(air_heater_bottom_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-(air_heater_bottom_body_length-wall_thin-clearance-air_heater_uprofile_thickness-clearance+2)-wall_thin-clearance-air_heater_uprofile_thickness-clearance,-1])
						cube([wall,air_heater_bottom_body_length-wall_thin-clearance-air_heater_uprofile_thickness-clearance+2,air_heater_bottom_body_height+wall+2]);

		}

		// frame mount screw holes
		for(i=[0,1])
			mirror([i,0,0])
				translate([air_heater_fan_side/2+clearance+frame_screw_washer_dia/2,-air_heater_bottom_body_length/2,frame_width/2])
					rotate([0,0,90])
						teardrop(frame_screw_dia/2+clearance,air_heater_bottom_body_length+2);

		// fan mount screw holes
		for(i=[0,1])
			mirror([i,0,0]){
				translate([air_heater_fan_hole_dist/2,-air_heater_bottom_body_length/2,air_heater_fan_side/2-air_heater_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_heater_fan_screw_dia/2+clearance,air_heater_bottom_body_length+2);
				translate([air_heater_fan_hole_dist/2,-air_heater_bottom_body_length/2+wall,air_heater_fan_side/2-air_heater_fan_hole_dist/2])
					rotate([0,0,90])
						teardrop(air_heater_fan_screw_washer_dia/2+clearance,air_heater_bottom_body_length);
			}

		// heater cable clearance
		for(i=[0,1])
			mirror([i,0,0])
				translate([air_heater_overtemp_cable_dia/2+clearance+2*wall+clearance+air_heater_cable_dia,0,0])
					hull(){
						translate([air_heater_cable_dia/2,1,air_heater_bottom_body_height+wall+1])
							rotate([90,0,0])
								cylinder(r=air_heater_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
						translate([-air_heater_cable_dia/2,1,air_heater_bottom_body_height+wall+1])
							rotate([90,0,0])
								cylinder(r=air_heater_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
						translate([air_heater_cable_dia/2,1,air_heater_bottom_body_height-wall-clearance-air_heater_cable_dia-air_heater_cable_dia/2])
							rotate([90,0,0])
								cylinder(r=air_heater_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
						translate([-air_heater_cable_dia/2,1,air_heater_bottom_body_height-wall-clearance-air_heater_cable_dia-air_heater_cable_dia/2])
							rotate([90,0,0])
								cylinder(r=air_heater_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
					}
		hull(){
			translate([0,1,air_heater_bottom_body_height+wall+1])
				rotate([90,0,0])
					cylinder(r=air_heater_overtemp_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
			translate([0,1,air_heater_bottom_body_height-wall-clearance-air_heater_overtemp_cable_dia-air_heater_overtemp_cable_dia/2])
				rotate([90,0,0])
					cylinder(r=air_heater_overtemp_cable_dia/2+clearance,h=air_heater_bottom_body_length+2);
		}
	}
}
