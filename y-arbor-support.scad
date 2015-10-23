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

// Y ARBOR SUPPORT TOP
* rotate([90,0,0])
    difference(){
        y_arbor_support(top=1);
        translate([0,0,y_arbor_support_body_height])
            label("307",orientation="top");
    }

// Y ARBOR SUPPORT BOTTOM
* rotate([90,0,0])
    difference(){
        y_arbor_support(top=0);
        translate([0,frame_width/4,0])
            label("308",orientation="bottom");
    }



module y_arbor_support(top=0){
	if(top==1)
		difference(){
			y_arbor_support_body(top=1);
			translate([-clearance/2,-frame_width/2-y_end_body_length_arbor_addition-1,-1])
				cube([y_arbor_support_body_width,frame_width+y_end_body_length_arbor_addition+2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2+wall+frame_screw_dia/2+clearance+wall+1]);
			translate([-y_arbor_support_body_width/2-1,-frame_width/2-y_end_body_length_arbor_addition-1,-1])
				cube([y_arbor_support_body_width+2,frame_width+y_end_body_length_arbor_addition+2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2-wall-frame_screw_dia/2-clearance-wall+1]);
		}
	if(top==0)
		intersection(){
			y_arbor_support_body(top=0);
			union(){
				translate([clearance/2,-frame_width/2-y_end_body_length_arbor_addition-1,-1])
					cube([y_arbor_support_body_width,frame_width+y_end_body_length_arbor_addition+2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2+frame_screw_dia/2+clearance+wall+1]);
				translate([-y_arbor_support_body_width/2-1,-frame_width/2-y_end_body_length_arbor_addition-1,-1])
					cube([y_arbor_support_body_width+2,frame_width+y_end_body_length_arbor_addition+2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2-wall-frame_screw_dia/2-clearance-2*wall+1]);
			}
		}
}


module y_arbor_support_body(top=0){
	difference(){

		// main body
		union(){
			hull(){
				translate([0,frame_width/2-wall,y_arbor_support_body_height-wall])
					rotate([90,0,0])
						teardrop(wall,y_arbor_support_body_width);
				translate([0,frame_width/2-wall,wall])
					rotate([90,0,0])
						teardrop(wall,y_arbor_support_body_width);
				translate([0,-frame_width/2-y_end_body_length_arbor_addition+wall,y_arbor_support_body_height-wall])
					rotate([90,0,0])
						teardrop(wall,y_arbor_support_body_width);
				translate([0,-frame_width/2-y_end_body_length_arbor_addition+wall,wall])
					rotate([90,0,0])
						teardrop(wall,y_arbor_support_body_width);
			}
		}

		// height adjustment screw holes
		if(top==1){
			hull(){
				translate([0,-frame_width/2-y_end_body_length_arbor_addition+wall+clearance+frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2+wall])
					rotate([-90,0,0])
						teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
				translate([0,-frame_width/2-y_end_body_length_arbor_addition+wall+clearance+frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2-wall])
					rotate([-90,0,0])
						teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
			}
			hull(){
				translate([0,frame_width/2-wall-clearance-frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2+wall])
					rotate([-90,0,0])
						teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
				translate([0,frame_width/2-wall-clearance-frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2-wall])
					rotate([-90,0,0])
						teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
			}
		}
		if(top==0){
			translate([0,-frame_width/2-y_end_body_length_arbor_addition+wall+clearance+frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2])
				rotate([-90,0,0])
					teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
			translate([0,frame_width/2-wall-clearance-frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2])
				rotate([-90,0,0])
					teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_width+2);
			translate([-(frame_screw_nut_height+clearance+1)/2+y_arbor_support_body_width/2+1,-frame_width/2-y_end_body_length_arbor_addition+wall+clearance+frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2])
				rotate([0,90,0])
					nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
			translate([-(frame_screw_nut_height+clearance+1)/2+y_arbor_support_body_width/2+1,frame_width/2-wall-clearance-frame_screw_dia/2,(y_arbor_frame_back_dist-bearing_dia/2-clearance)/2])
				rotate([0,90,0])
					nut_trap_square(frame_screw_nut_wrench,frame_screw_nut_height+clearance+1);
		}

		// y belt arbor bearing trap
		translate([y_arbor_support_body_width-bearing_width-clearance,-y_end_body_length/2+wall+clearance+bearing_dia/2-y_end_body_length_arbor_addition,y_arbor_frame_back_dist])
			rotate([-90,0,0])
				teardrop(bearing_dia/2+clearance_tight,y_arbor_support_body_width);
		translate([0,-y_end_body_length/2+wall+clearance+bearing_dia/2-y_end_body_length_arbor_addition,y_arbor_frame_back_dist])
			rotate([-90,0,0])
				teardrop(bearing_dia/2+clearance-wall_thin,y_arbor_support_body_width+2);

		// frame mount screw hole
		if(top==0){
			translate([0,0,y_arbor_support_body_height/2+wall])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(frame_screw_head_flange_dia/2+clearance,y_arbor_support_body_height,fulldrop=1);
			translate([0,0,y_arbor_support_body_height/2-1])
				rotate([0,0,90])
					rotate([0,90,0])
						teardrop(frame_screw_dia/2+clearance,y_arbor_support_body_height);
		}
	}
}



