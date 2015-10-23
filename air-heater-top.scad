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
rotate([0,180,0]) 
difference(){
    air_heater_top();
    translate([0,-air_heater_top_body_length+wall_thin+wall,-(air_heater_top_body_height+air_heater_heating_insert_top_clearance)])
        label("66.",orientation="back");
}


module air_heater_top(){
	difference(){

		// main body
		union(){
			translate([-air_heater_top_body_width/2,-air_heater_top_body_length,0])
				cube([air_heater_top_body_width,air_heater_top_body_length,air_heater_top_body_height]);
			translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance),-air_heater_top_body_length+wall_thin+clearance,-(air_heater_heating_insert_height+air_heater_heating_insert_top_clearance-2*wall-clearance+(air_heater_fan_side/2-air_heater_fan_hole_dist/2+air_heater_fan_screw_dia/2+clearance+wall))])
				cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance),air_heater_uprofile_thickness,air_heater_top_body_height+air_heater_heating_insert_height+air_heater_heating_insert_top_clearance-2*wall-clearance+(air_heater_fan_side/2-air_heater_fan_hole_dist/2+air_heater_fan_screw_dia/2+clearance+wall)]);
		}

		// air canal
		difference(){
			union(){
				translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-(air_heater_uprofile_height-2*air_heater_uprofile_thickness)/2-air_heater_top_body_length/2,-1])
					cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),air_heater_uprofile_height-2*air_heater_uprofile_thickness,air_heater_top_body_height+2]);
				translate([-(air_heater_top_body_width/2-wall_thin),-(air_heater_top_body_length-2*wall_thin)/2-air_heater_top_body_length/2,air_heater_top_body_height-wall])
					cube([2*(air_heater_top_body_width/2-wall_thin),air_heater_top_body_length-2*wall_thin,wall+1]);
			}
			for(i=[0,1])
				mirror([i,0,0]){
					translate([-wall_thin/2+(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall)/3,-air_heater_top_body_length-1,2*wall+clearance])
						cube([wall_thin,air_heater_top_body_length+2,air_heater_top_body_height+2]);
					translate([-wall_thin/2+(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall)+wall_thin/2,-air_heater_top_body_length-1,2*wall+clearance])
						cube([wall_thin,air_heater_top_body_length+2,air_heater_top_body_height+2]);
				}
			translate([0,-air_heater_top_body_length/2,0])
				for(i=[0,1])
					mirror([0,i,0])
						for(j=[0:((air_heater_top_body_length/2)/(2*wall+wall_thin))])
							translate([-(air_heater_top_body_width+2)/2,wall+j*(2*wall+wall_thin),-3])
								cube([air_heater_top_body_width+2,wall_thin,air_heater_top_body_height+6]);
			translate([-air_heater_top_body_width/2-2,-2*air_heater_top_body_length+wall_thin+clearance+wall,-air_heater_top_body_height+wall+clearance+wall])
				cube([air_heater_top_body_width+4,air_heater_top_body_length,air_heater_top_body_height]);
			difference(){
				translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall)-wall_thin,-(air_heater_uprofile_height-2*air_heater_uprofile_thickness)/2-air_heater_top_body_length/2-wall_thin,-1])
					cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall)+2*wall_thin,air_heater_uprofile_height-2*air_heater_uprofile_thickness+2*wall_thin,air_heater_top_body_height+2]);
				translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-(air_heater_uprofile_height-2*air_heater_uprofile_thickness)/2-air_heater_top_body_length/2,-2])
					cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),air_heater_uprofile_height-2*air_heater_uprofile_thickness,air_heater_top_body_height+4]);
			}
		}

		// heater u-profile recess
		difference(){
			translate([-(air_heater_top_body_width-2*wall_thin)/2,-air_heater_top_body_length+wall_thin,-1])
				cube([air_heater_top_body_width-2*wall_thin,air_heater_top_body_length-2*wall_thin,2*wall+clearance+1]);
			for(i=[0,1])
				mirror([i,0,0])
					translate([(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance-wall),-(air_heater_top_body_length-2*wall_thin-2*clearance-air_heater_uprofile_thickness-air_heater_uprofile_thickness-2*clearance)-wall_thin-clearance-air_heater_uprofile_thickness-clearance-clearance-1,-1])
						cube([wall,air_heater_top_body_length-2*wall_thin-2*clearance-air_heater_uprofile_thickness-air_heater_uprofile_thickness-clearance+1,air_heater_top_body_height+2]);
			translate([-(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance),-(air_heater_uprofile_height-2*air_heater_uprofile_thickness)-air_heater_top_body_length+wall_thin+clearance+air_heater_uprofile_thickness,-2])
				cube([2*(air_heater_top_body_width/2-wall_thin-clearance-air_heater_uprofile_thickness-clearance),air_heater_uprofile_height-2*air_heater_uprofile_thickness,air_heater_top_body_height+4]);
		}

		// fan mount
		translate([0,-air_heater_top_body_length,-(air_heater_heating_insert_height+air_heater_heating_insert_top_clearance-2*wall-clearance)]){
			intersection(){
				translate([0,-1,-air_heater_fan_side/2])
					rotate([-90,0,0])
						cylinder(r=air_heater_fan_dia/2,h=air_heater_top_body_length+2);
				translate([-air_heater_fan_cutout_side/2,-1,-air_heater_fan_side/2-air_heater_fan_cutout_side/2])
					cube([air_heater_fan_cutout_side,air_heater_top_body_length+2,air_heater_fan_cutout_side]);
			}
			for(i=[0,1])
				mirror([i,0,0])
					translate([air_heater_fan_hole_dist/2,-1,-air_heater_fan_side/2+air_heater_fan_hole_dist/2])
						rotate([-90,0,0])
							cylinder(r=air_heater_fan_screw_dia/2+clearance,h=air_heater_top_body_length+2);
		}
	}
}
