/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

Licensed under:
	Creative Commons Attribution-ShareAlike
	CC BY-SA 3.0
	http://creativecommons.org/licenses/by-sa/3.0/

*******************************************************************/

include <configuration.scad>



z_bedclamp_front_body_height = frame_width;
z_bedclamp_front_body_width = z_rod_dist+linear_bearing_dia-2*frame_width-2*clearance;
z_bedclamp_front_body_length = (z_bedclamp_front_body_width/2+wall/2)+2*wall+2*clearance+2*frame_screw_washer_dia/2+2*clearance+2*frame_screw_dia/2+2*frame_washer_wall;




z_bedclamp_front();


module z_bedclamp_front(){
	difference(){

		// main body
//		translate([-z_bedclamp_front_body_width/2,0,0])
//			cube([z_bedclamp_front_body_width,z_bedclamp_front_body_length,z_bedclamp_front_body_height]);
		hull(){
			translate([0,wall,wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_front_body_width);
			translate([0,z_bedclamp_front_body_length-wall,wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_front_body_width);
			translate([0,wall,z_bedclamp_front_body_height-wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_front_body_width);
			translate([0,z_bedclamp_front_body_length-wall,z_bedclamp_front_body_height-wall])
				rotate([180,0,0])
					teardrop(wall,z_bedclamp_front_body_width);
		}

		// frame mount screw lips, body cutoff
		difference(){
			hull(){
				translate([-z_bedclamp_front_body_width/2+wall,-wall,-1])
					cube([z_bedclamp_front_body_width-2*wall,wall,z_bedclamp_front_body_height+2]);
				translate([-z_bedclamp_front_body_width/2+2*wall,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall,-1])
					cylinder(r=wall,h=z_bedclamp_front_body_height+2);
				translate([z_bedclamp_front_body_width/2-2*wall,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall,-1])
					cylinder(r=wall,h=z_bedclamp_front_body_height+2);
			}

			// leave material for bed bolt clamp..
			translate([0,-wall_thin/2,0])
			hull(){
				translate([-wall-clearance-z_bed_bolt_screw_dia/2,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall),-4])
					cube([wall+2*clearance+z_bed_bolt_screw_dia+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall,wall,z_bedclamp_front_body_height+4]);
				translate([z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall-wall,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-z_bed_bolt_screw_dia/2-clearance-wall,-4])
					cube([wall,wall,z_bedclamp_front_body_height+4]);
				translate([-clearance-z_bed_bolt_screw_dia/2,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-z_bed_bolt_screw_dia/2-clearance,-4])
					cylinder(r=wall,h=z_bedclamp_front_body_height+4);
			}
		}
		hull(){
			translate([-z_bedclamp_front_body_width/2+wall,z_bedclamp_front_body_length,-1])
				cube([z_bedclamp_front_body_width-2*wall,wall,z_bedclamp_front_body_height+2]);
			translate([-z_bedclamp_front_body_width/2+2*wall,z_bedclamp_front_body_length-((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall),-1])
				cylinder(r=wall,h=z_bedclamp_front_body_height+2);
			translate([z_bedclamp_front_body_width/2-2*wall,z_bedclamp_front_body_length-((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall),-1])
				cylinder(r=wall,h=z_bedclamp_front_body_height+2);
		}


		// body cutoff
		for(i=[0,1])
			mirror([i,0,0]){
				hull(){
					translate([z_bedclamp_front_body_width/2-2*wall,((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+2*wall),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
					translate([z_bedclamp_front_body_width/2-2*wall,z_bedclamp_front_body_length-((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+wall)-(((wall/2)/sin(45))+wall+(wall/sin(45))),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
					translate([0.5*wall+(((wall/2)/sin(45))+wall+(wall/sin(45))),((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+2*wall),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
				}
				hull(){
					translate([1.5*wall,z_bedclamp_front_body_length-((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+2*wall),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
					translate([z_bedclamp_front_body_width/2-wall-(((wall/2)/sin(45))+wall+(wall/sin(45))),z_bedclamp_front_body_length-((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+2*wall),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
					translate([1.5*wall,((wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+wall)+(((wall/2)/sin(45))+wall+(wall/sin(45))),-1])
						cylinder(r=wall,h=z_bedclamp_front_body_height+2);
				}
			}


/*
		// bed bolt clamp
		translate([z_bedclamp_back_body_width/2,z_bedclamp_back_body_length-(z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall),-1])
			cylinder(r=z_bed_bolt_screw_dia/2+clearance,h=frame_width+2);
		translate([z_bedclamp_back_body_width/2-wall_thin/2,z_bedclamp_back_body_length-(z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall),-1])
			cube([wall_thin,z_bedclamp_back_body_length,z_bedclamp_back_body_height+2]);

*/

		// frame screw holes
		difference(){
			union(){
				translate([0,frame_washer_wall+clearance+frame_screw_dia/2,z_bedclamp_front_body_height/2])
					teardrop(frame_screw_dia/2+clearance,z_bedclamp_front_body_width+2);
				translate([0,z_bedclamp_front_body_length-(frame_washer_wall+clearance+frame_screw_dia/2),z_bedclamp_front_body_height/2])
					teardrop(frame_screw_dia/2+clearance,z_bedclamp_front_body_width+2);
			}
			translate([-(z_bedclamp_front_body_width-2*wall-2)/2,-1,-1])
				cube([z_bedclamp_front_body_width-2*wall-2,z_bedclamp_front_body_length+2,z_bedclamp_front_body_height+2]);
		}

		// bed bolt clamp
		translate([0,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall_thin/2,-1])
			cylinder(r=z_bed_bolt_screw_dia/2+clearance,h=z_bedclamp_front_body_height+2);
		translate([0,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall_thin,-1])
			cube([z_bed_bolt_screw_dia/2+clearance+wall_thin+2*clearance+frame_screw_dia+frame_washer_wall+1,wall_thin,z_bedclamp_front_body_height+2]);
		translate([z_bed_bolt_screw_dia/2+clearance+wall_thin+clearance+frame_screw_dia/2,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)-wall_thin/2,z_bedclamp_front_body_height/2])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,z_bedclamp_front_body_length/2);
		translate([z_bed_bolt_screw_dia/2+clearance+wall_thin+clearance+frame_screw_dia/2,(wall+clearance+frame_screw_washer_dia/2+clearance+frame_screw_dia/2+frame_washer_wall)+2*wall,z_bedclamp_front_body_height/2])
			rotate([0,0,90]) rotate([90,0,0])
				nut_slot(frame_screw_nut_wrench,frame_screw_nut_height,z_bedclamp_front_body_height/2,vertical=1);

	}
}



