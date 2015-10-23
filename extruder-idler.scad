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

// RIGHT BACK PART
* rotate([-90,0,0])
    difference(){
        extruder_idler(back=1);
        translate([0,extruder_idler_body_length-2*extruder_idler_body_length+wall+wall_thin+bearing_width/2+clearance/2,extruder_back_body_height/8*7])
            label("55",orientation="front");
    }

// RIGHT FRONT PART
* rotate([90,0,0])
    difference(){
        extruder_idler(back=0);
        translate([0,extruder_idler_body_length-2*extruder_idler_body_length+wall+wall_thin+bearing_width/2-clearance/2,extruder_back_body_height/8*7])
            label("3",orientation="back");
    }


// LEFT BACK PART
* rotate([-90,0,0])
    difference(){
        mirror([1,0,0])
            extruder_idler(back=1);
        translate([0,extruder_idler_body_length-2*extruder_idler_body_length+wall+wall_thin+bearing_width/2+clearance/2,extruder_back_body_height/8*7])
            label("62",orientation="front");
    }

// LEFT FRONT PART
* rotate([90,0,0])
    difference(){
        mirror([1,0,0])
            extruder_idler(back=0);
        translate([0,extruder_idler_body_length-2*extruder_idler_body_length+wall+wall_thin+bearing_width/2-clearance/2,extruder_back_body_height/8*7])
            label("10",orientation="back");
    }






module extruder_idler(back=0){
	difference(){

		// main body
		union(){
			hull(){
				translate([-extruder_front_body_width/2+wall/2,-extruder_idler_body_length,extruder_back_body_height+2*wall-wall])
					cube([wall,extruder_idler_body_length-(nema17_screw_lens_head_length+clearance),wall]);
				translate([0,-extruder_idler_body_length,extruder_back_body_height+2*wall-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_idler_body_length-(nema17_screw_lens_head_length+clearance));
				translate([0,-extruder_idler_body_length,extruder_back_body_height/2+wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_idler_body_length-(nema17_screw_lens_head_length+clearance));
				translate([-extruder_front_body_width/2+wall/2,-extruder_idler_body_length,extruder_back_body_height/2])
					cube([wall,extruder_idler_body_length-(nema17_screw_lens_head_length+clearance),wall]);
			}
			hull(){
				translate([-extruder_front_body_width/2+wall/2,-extruder_idler_body_length,extruder_back_body_height-wall])
					cube([wall,extruder_idler_body_length-(nema17_screw_lens_head_length+clearance),wall]);
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia-wall_thin-wall,-extruder_idler_body_length,extruder_back_body_height-wall])
					rotate([-90,0,0])
						cylinder(r=wall,h=extruder_idler_body_length-(nema17_screw_lens_head_length+clearance));
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia-wall_thin-wall,-extruder_idler_body_length,extruder_back_body_height/2])
					cube([wall,extruder_idler_body_length-(nema17_screw_lens_head_length+clearance),wall]);
				translate([-extruder_front_body_width/2+wall/2,-extruder_idler_body_length,extruder_back_body_height/2])
					cube([wall,extruder_idler_body_length-(nema17_screw_lens_head_length+clearance),wall]);
			}
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=bearing_dia/2-wall_thin,h=extruder_idler_body_length-(nema17_screw_lens_head_length+clearance));
		}

		// filament drive gear clearance, top cut off
		hull(){
			translate([-extruder_front_body_width/2,-extruder_idler_body_length-1,extruder_back_body_height/2+extruder_drivegear_dia/2+wall-wall])
				cube([wall,extruder_idler_body_length+2,wall]);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+wall_thin-wall,-extruder_idler_body_length-1,extruder_back_body_height/2+extruder_drivegear_dia/2+wall-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_idler_body_length+2);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+wall_thin-wall,-extruder_idler_body_length-1,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_idler_body_length+2);
			translate([-extruder_front_body_width/2,-extruder_idler_body_length-1,0])
				cube([wall,extruder_idler_body_length+2,wall]);
		}
		hull(){
			translate([extruder_front_body_width/2,-extruder_idler_body_length-1,extruder_back_body_height])
				cube([wall,extruder_idler_body_length+2,wall]);
			translate([extruder_front_body_width/2,-extruder_idler_body_length-1,extruder_back_body_height+2*wall])
				cube([wall,extruder_idler_body_length+2,wall]);
			translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_idler_body_length-1,extruder_back_body_height+wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_idler_body_length+2);
			translate([-extruder_drivegear_dia/2-wall_thin+wall,-extruder_idler_body_length-1,extruder_back_body_height+2*wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=extruder_idler_body_length+2);
		}

		// idler back-/front-part choice
		if(back==0)
			translate([-extruder_back_body_width,-extruder_idler_body_length+wall+wall_thin+bearing_width/2-clearance/2,-extruder_back_body_height/4])
				cube([2*extruder_back_body_width,extruder_idler_body_length,2*extruder_back_body_height]);
		if(back==1)
			translate([-extruder_back_body_width,-2*extruder_idler_body_length+wall+wall_thin+bearing_width/2+clearance/2,-extruder_back_body_height/4])
				cube([2*extruder_back_body_width,extruder_idler_body_length,2*extruder_back_body_height]);

		// idler bearing clearance, leaving bearing core bolt
		difference(){
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length+wall,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=bearing_dia/2+wall_thin,h=wall_thin+bearing_width+wall_thin);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=bearing_center_dia/2-clearance_tight,h=extruder_idler_body_length);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=bearing_center_dia/2-clearance+wall_thin,h=wall+wall_thin);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length+wall+wall_thin+bearing_width,extruder_back_body_height/2])
				rotate([-90,0,0])
					cylinder(r=bearing_center_dia/2-clearance+wall_thin,h=extruder_idler_body_length);
		}

		difference(){
			union(){

				// idler bearing screw hole and nut trap
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-extruder_idler_body_length-1,extruder_back_body_height/2])
					rotate([-90,0,0])
						cylinder(r=extruder_idler_bearing_screw_dia/2+clearance,h=extruder_idler_body_length+2);
				translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia+bearing_dia/2,-(nema17_screw_lens_head_length+clearance)-(extruder_idler_bearing_screw_nut_height+clearance+1)/2+1,extruder_back_body_height/2])
					rotate([90,0,0])
						nut_trap_square(extruder_idler_bearing_screw_nut_wrench,extruder_idler_bearing_screw_nut_height+clearance+1);

				// idler back- and front-part screw hole and nut trap
				translate([-extruder_back_body_width/2+wall/2+(extruder_back_body_width/2-extruder_drivegear_dia/2-wall_thin-wall/2)/2,-extruder_idler_body_length-1,extruder_back_body_height/2+extruder_drivegear_dia/2+wall+2*wall+wall_thin+clearance+extruder_idler_bearing_screw_dia/2])
					rotate([-90,0,0])
						cylinder(r=extruder_idler_bearing_screw_dia/2+clearance,h=extruder_idler_body_length+2);
				translate([-extruder_back_body_width/2+wall/2+(extruder_back_body_width/2-extruder_drivegear_dia/2-wall_thin-wall/2)/2,-(nema17_screw_lens_head_length+clearance)-(extruder_idler_bearing_screw_nut_height+clearance+1)/2+1,extruder_back_body_height/2+extruder_drivegear_dia/2+wall+2*wall+wall_thin+clearance+extruder_idler_bearing_screw_dia/2])
					rotate([90,0,0])
						nut_trap_square(extruder_idler_bearing_screw_nut_wrench,extruder_idler_bearing_screw_nut_height+clearance+1);
			}
			if(support) translate([-extruder_back_body_width,-layer_height-(nema17_screw_lens_head_length+clearance)-(extruder_idler_bearing_screw_nut_height+clearance),-extruder_back_body_height/4])
				cube([2*extruder_back_body_width,layer_height,2*extruder_back_body_height]);
		}

		// idler hinge bolt hole
		translate([extruder_back_body_width/2-extruder_mount_screw_washer_dia/2,-extruder_idler_body_length-1,extruder_back_body_height-extruder_mount_screw_washer_dia/2])
			rotate([-90,0,0])
				cylinder(r=extruder_idler_hinge_screw_dia/2+clearance,h=extruder_idler_body_length+2);

		// idler spring recess
		translate([-extruder_drivegear_dia/2-wall_thin-wall_thin-clearance-extruder_idler_spring_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,extruder_drivegear_dia/2+wall+2*wall])
			cylinder(r=extruder_idler_spring_dia/2+clearance,h=extruder_back_body_height/2);

		// top thumb grip
		for(i=[-5:5])
			translate([-extruder_back_body_width/2+wall/2+(extruder_back_body_width/2-extruder_drivegear_dia/2-wall_thin-wall/2)/2+i*4*wall_thin,-extruder_idler_body_length-1,extruder_back_body_height+2*wall])
				rotate([-90,0,0])
					cylinder(r=wall_thin,h=extruder_idler_body_length+2);

		// filament hole, filament tube recess
		hull(){
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2-(filament_tube_dia/2+clearance)+(filament_dia/2+wall_thin/2),-extruder_front_body_length+wall+wall_thin+bearing_width/2,-1])
				cylinder(r=filament_dia/2+wall_thin/2,h=extruder_back_body_height+2);
			translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2+(filament_tube_dia/2+clearance)-(filament_dia/2+wall_thin/2),-extruder_front_body_length+wall+wall_thin+bearing_width/2,-1])
				cylinder(r=filament_dia/2+wall_thin/2,h=extruder_back_body_height+2);
		}
		translate([extruder_drivegear_dia/2-extruder_drivegear_filament_insection+filament_dia/2,-extruder_front_body_length+wall+wall_thin+bearing_width/2,extruder_back_body_height-3*wall])
			cylinder(r=filament_tube_dia/2+clearance,h=extruder_back_body_height);
	}
}





