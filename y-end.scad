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

// Y END FRONT LEFT
* rotate([-90,0,0])
    mirror([0,1,0])
        difference(){
            y_end_body(front=1,back=0);
            translate([y_end_body_width/4,0,0])
                mirror([0,1,0]) label("45",orientation="bottom");
        }

// Y END FRONT RIGHT
* mirror([1,0,0])    
    rotate([-90,0,0])
        mirror([0,1,0])
            difference(){
                y_end_body(front=1,back=0);
                translate([y_end_body_width/4,0,0])
                    mirror([1,0,0]) mirror([0,1,0]) label("57",orientation="bottom");
            }

// Y END BACK LEFT
* rotate([90,0,0])
    difference(){
        y_end_body(front=0,back=1);
        translate([y_end_body_width/4,0,0])
            label("31",orientation="bottom");
    }

// Y END BACK RIGHT
* mirror([1,0,0])
    rotate([90,0,0])
        difference(){
            y_end_body(front=0,back=1);
            translate([y_end_body_width/4,0,0])
                mirror([1,0,0]) label("71",orientation="bottom");
        }






module y_end_body(front=0,back=1){
	difference(){

		// main body
		hull(){
			translate([front*y_end_body_width_idler_addition/2,frame_width/2-wall,y_end_body_height-wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler_addition);
			translate([front*y_end_body_width_idler_addition/2,frame_width/2-wall,wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler_addition);
			translate([front*y_end_body_width_idler_addition/2,-frame_width/2-back*y_end_body_length_arbor_addition+wall,y_end_body_height-wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler_addition);
			translate([front*y_end_body_width_idler_addition/2,-frame_width/2-back*y_end_body_length_arbor_addition+wall,wall])
				rotate([90,0,0])
					teardrop(wall,y_end_body_width+front*y_end_body_width_idler_addition);
		}

		// y rod clamp
		translate([0,0,wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia/2])
			rotate([-90,0,0])
				cylinder(r=rod_dia/2+clearance_tight,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
		cube([wall_thin,y_end_body_length+2*y_end_body_length_arbor_addition+2,2*(wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia/2)],center=true);


		// idler bolt support body cut off
		hull(){
			translate([y_end_body_width/2+wall,0,y_end_body_height-wall-clearance-frame_screw_dia-clearance-wall-clearance-bearing_dia/2+y_idler_bolt_washer_dia/2+wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall,0,y_end_body_height+1])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall+y_end_body_width_idler_addition+1,0,y_end_body_height-wall-clearance-frame_screw_dia-clearance-wall-clearance-bearing_dia/2+y_idler_bolt_washer_dia/2+wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall+y_end_body_width_idler_addition+1,0,y_end_body_height+1])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
		}
		hull(){
			translate([y_end_body_width/2+wall,0,y_end_body_height-wall-clearance-frame_screw_dia-clearance-wall-clearance-bearing_dia/2-y_idler_bolt_washer_dia/2-wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall,0,-1])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall+y_end_body_width_idler_addition+1,0,y_end_body_height-wall-clearance-frame_screw_dia-clearance-wall-clearance-bearing_dia/2-y_idler_bolt_washer_dia/2-wall])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
			translate([y_end_body_width/2+wall+y_end_body_width_idler_addition+1,0,-1])
				rotate([90,0,0])
					cylinder(r=wall,h=y_end_body_length+2*y_end_body_length_arbor_addition+2,center=true);
		}

		// frame screw holes
		translate([0,0,wall+clearance+frame_screw_dia/2])
			rotate([-90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_end_body_width+2);
		translate([0,0,y_end_body_height-(wall+clearance+frame_screw_dia/2)])
			rotate([-90,0,0])
				teardrop(frame_screw_dia/2+clearance,y_end_body_width+2);

		// y belt arbor bearing trap (y end back)
		if(front==0){
			translate([y_end_body_width-bearing_width-clearance,y_end_body_length/2-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2)])
				rotate([-90,0,0])
					teardrop(bearing_dia/2+clearance_tight,y_end_body_width);
			difference(){
				translate([0,y_end_body_length/2-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2)])
					rotate([-90,0,0])
						teardrop(bearing_dia/2+clearance-wall,y_end_body_width+2);
			}
			hull(){
				translate([y_end_body_width/2-bearing_width/2-wall/2,-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2-bearing_dia/4)])
					rotate([-90,0,0])
						cylinder(r=wall/2,h=y_end_body_length,center=true);
				translate([y_end_body_width/2-bearing_width-wall/2,-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2-bearing_dia/4)])
					rotate([-90,0,0])
						cylinder(r=wall/2,h=y_end_body_length,center=true);
			}
		}

		// y belt idler bolt trap (y end front)
		if(front==1){
			translate([(y_idler_bolt_head_wrench_length+clearance+1)/2-y_end_body_width/2-1,y_end_body_length/2-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2)])
				rotate([0,90,0])
					nut_trap(y_idler_bolt_head_wrench,y_idler_bolt_head_wrench_length+clearance+1);
			translate([y_end_body_width_idler_addition/2,y_end_body_length/2-(wall+wall_thin+y_belt_pulley_dia/2),y_end_body_height-(wall+clearance+frame_screw_dia+clearance+wall+clearance+bearing_dia/2)])
				rotate([-90,0,0])
					teardrop(y_idler_bolt_dia/2+clearance,2*(y_end_body_width+y_end_body_width_idler_addition));
		}
	}
}



