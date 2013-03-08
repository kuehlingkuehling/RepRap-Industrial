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

/*
// extruder test assembly
use <extruder_back.scad>
translate([0,-x_carriage_body_width/2-x_carriage_body_y_addition,x_carriage_body_height/2])
	rotate([0,0,0]){
		translate([extruder_back_body_width/2,0,0])
		extruder_back();
		translate([-extruder_back_body_width/2,0,0])
		mirror([1,0,0]) extruder_back();
	}

use <extruder_front.scad>
translate([0,-x_carriage_body_width/2-x_carriage_body_y_addition-extruder_front_body_length,x_carriage_body_height/2])
	rotate([0,0,0]){
		translate([extruder_front_body_width/2,0,0]){
			extruder_front();
			extruder_idler();
			extruder_filamenttubeconnector();
		}
		translate([-extruder_front_body_width/2,0,0]){
			mirror([1,0,0]) extruder_front();
			mirror([1,0,0]) extruder_idler();
			mirror([1,0,0]) extruder_filamenttubeconnector();
		}
	}

use <extruder_hotend.scad>
translate([0,-x_carriage_body_width/2-x_carriage_body_y_addition-extruder_hotend_body_length,x_carriage_body_height/2])
	rotate([0,0,0]){
		translate([extruder_hotend_body_width/2,0,0])
		extruder_hotend();
		translate([-extruder_hotend_body_width/2,0,0])
		mirror([1,0,0]) extruder_hotend();
	}
*/


// RENDER X CARRIAGE
//translate([0,0,x_carriage_body_length/2]) rotate([0,-90,0])	// for printing
x_carriage();


module x_carriage(){
	difference(){

		// main body
		union(){
			translate([0,0,0])	
				hull(){
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2+x_carriage_body_z_addition_top-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2,-x_carriage_body_width/2-x_carriage_body_y_addition,x_carriage_body_height/2+x_carriage_body_z_addition_top-wall])
						cube([x_carriage_body_length,wall,wall]);
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,-x_carriage_body_height/2-x_carriage_body_z_addition_bottom+wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
/*
					translate([-x_carriage_body_length/2,-x_carriage_body_width/2-x_carriage_body_y_addition+wall,-x_carriage_body_height/2-x_carriage_body_z_addition_bottom+wall])
						rotate([0,90,0])
%							cylinder(r=wall,h=x_carriage_body_length);
*/
					translate([-x_carriage_body_length/2,-x_carriage_body_width/2-x_carriage_body_y_addition,-x_carriage_body_height/2-x_carriage_body_z_addition_bottom])
						cube([x_carriage_body_length,wall,wall]);
				}

			translate([0,0,0])	
				hull(){
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,x_carriage_body_height/2+x_carriage_body_z_addition_top-wall])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-wall,x_carriage_body_height/2+x_carriage_body_z_addition_top-wall])
						cube([x_carriage_body_length,wall,wall]);
					translate([-x_carriage_body_length/2,x_carriage_body_width/2-wall,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
				}
		}

		// linear bearing clamps
		for(i=[0,1])
			mirror([0,i,0]){
				translate([-x_carriage_body_length/2-1,x_rod_dist/2,0])
					rotate([0,90,0])
						cylinder(r=linear_bearing_dia/2+clearance,h=x_carriage_body_length+2);
			}
		mirror([0,1,0])
			translate([-x_carriage_body_length/2-1,-x_rod_dist/2-wall_thin/2,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance+wall+1)])
				cube([x_carriage_body_length+2,wall_thin,x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance+wall+1]);
		translate([-x_carriage_body_length/2-1,-x_rod_dist/2,-wall_thin/2])
			cube([x_carriage_body_length+2,x_rod_dist/2,wall_thin]);

		// linear bearing clamp screw holes/nut traps front
		translate([x_carriage_body_length/2-linear_bearing_length/2,-x_rod_dist/2+linear_bearing_dia/2+clearance+wall+x_carriage_bearing_clamp_screw_dia/2,0])
			rotate([0,90,0])
				teardrop(x_carriage_bearing_clamp_screw_dia/2+clearance,x_carriage_body_height+2);
		translate([-(x_carriage_body_length/2-linear_bearing_length/2),-x_rod_dist/2+linear_bearing_dia/2+clearance+wall+x_carriage_bearing_clamp_screw_dia/2,0])
			rotate([0,90,0])
				teardrop(x_carriage_bearing_clamp_screw_dia/2+clearance,x_carriage_body_height+2);
		translate([x_carriage_body_length/2-linear_bearing_length/2,-x_rod_dist/2+linear_bearing_dia/2+clearance+wall+x_carriage_bearing_clamp_screw_dia/2,x_carriage_body_height/4+wall_thin/2+1.5*wall])
			rotate([0,0,30])
				nut_trap(x_carriage_bearing_clamp_screw_nut_wrench,x_carriage_body_height/2);
		translate([-(x_carriage_body_length/2-linear_bearing_length/2),-x_rod_dist/2+linear_bearing_dia/2+clearance+wall+x_carriage_bearing_clamp_screw_dia/2,x_carriage_body_height/4+wall_thin/2+1.5*wall])
			rotate([0,0,30])
				nut_trap(x_carriage_bearing_clamp_screw_nut_wrench,x_carriage_body_height/2);

		// linear bearing clamp screw holes/nut traps back
		translate([x_carriage_body_length/2-linear_bearing_length/2,-(x_carriage_bearing_clamp_screw_length+2)/2+x_carriage_body_width/2+1,-linear_bearing_dia/2-clearance-wall-clearance-x_carriage_bearing_clamp_screw_dia/2])
			rotate([90,0,0]) rotate([0,90,0])
				teardrop(x_carriage_bearing_clamp_screw_dia/2+clearance,x_carriage_bearing_clamp_screw_length+2);
		translate([-(x_carriage_body_length/2-linear_bearing_length/2),-(x_carriage_bearing_clamp_screw_length+1)/2+x_carriage_body_width/2+1,-linear_bearing_dia/2-clearance-wall-clearance-x_carriage_bearing_clamp_screw_dia/2])
			rotate([90,0,0]) rotate([0,90,0])
				teardrop(x_carriage_bearing_clamp_screw_dia/2+clearance,x_carriage_bearing_clamp_screw_length+1);
		translate([x_carriage_body_length/2-linear_bearing_length/2,x_rod_dist/2-(x_carriage_bearing_clamp_screw_nut_height+2*clearance)/2-wall_thin/2-1.5*wall,-linear_bearing_dia/2-clearance-wall-clearance-x_carriage_bearing_clamp_screw_dia/2])
			rotate([90,0,0]) rotate([0,0,-90])
				nut_slot(x_carriage_bearing_clamp_screw_nut_wrench,x_carriage_bearing_clamp_screw_nut_height,x_carriage_body_height/2);
		translate([-(x_carriage_body_length/2-linear_bearing_length/2),x_rod_dist/2-(x_carriage_bearing_clamp_screw_nut_height+2*clearance)/2-wall_thin/2-1.5*wall,-linear_bearing_dia/2-clearance-wall-clearance-x_carriage_bearing_clamp_screw_dia/2])
			rotate([90,0,0]) rotate([0,0,-90])
				nut_slot(x_carriage_bearing_clamp_screw_nut_wrench,x_carriage_bearing_clamp_screw_nut_height,x_carriage_body_height/2);


		// x carriage body cutoff
		hull(){
			translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-wall-wall,x_carriage_body_height/2-2*wall-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=x_carriage_body_length+2);
			translate([-x_carriage_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-x_carriage_bearing_clamp_screw_dia-2*clearance-frame_washer_wall-wall),x_carriage_body_height/2-2*wall-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=x_carriage_body_length+2);
			translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-wall-wall,-x_rod_belt_dist-belt_tensioning_screw_dia/2-clearance-wall-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=x_carriage_body_length+2);
			translate([-x_carriage_body_length/2-1,-(x_rod_dist/2-linear_bearing_dia/2-clearance-wall-x_carriage_bearing_clamp_screw_dia-2*clearance-frame_washer_wall-wall),-x_rod_belt_dist-belt_tensioning_screw_dia/2-clearance-wall-wall])
				rotate([0,90,0])
					cylinder(r=wall,h=x_carriage_body_length+2);
		}

		// x belt tensioning cutoff
		translate([0,x_belt_pulley_dia/2,-x_rod_belt_dist])
			rotate([90,0,0])
			hull(){
				translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,belt_tensioner_height/2-wall+wall_thin,belt_tensioner_width/2-wall+wall_thin])
					rotate([0,90,0])
						cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
				translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,-belt_tensioner_height/2-(-wall+wall_thin),belt_tensioner_width/2-wall+wall_thin])
					rotate([0,90,0])
						cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
				translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,belt_tensioner_height/2-wall+wall_thin,-belt_tensioner_width/2-(-wall+wall_thin)])
					rotate([0,90,0])
						rotate([0,-90,0]) rotate([-90,0,0]) translate([(belt_tensioner_length+belt_tensioning_range+1)/2,0,0]) teardrop(wall,belt_tensioner_length+belt_tensioning_range+1);
//%						cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
				translate([x_carriage_body_length/2-belt_tensioner_length-belt_tensioning_range/2,-belt_tensioner_height/2-(-wall+wall_thin),-belt_tensioner_width/2-(-wall+wall_thin)])
					rotate([0,90,0])
						cylinder(r=wall,h=belt_tensioner_length+belt_tensioning_range+1);
			}

		// belt grip
		translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-(belt_thickness_max-belt_thickness_min),-x_rod_belt_dist+belt_width/2+clearance])
			rotate([90,0,0]) rotate([0,0,-90])
				difference(){
					union(){
						translate([0,-1,-belt_thickness_min-belt_thickness_max-clearance])
							cube([y_rod_y_belt_x_dist,4*belt_tooth_periode+1,2*belt_thickness_min+2*clearance]);
						for(i=[0:3])
							translate([0,belt_tooth_periode/2+i*belt_tooth_periode,-2*belt_thickness_max-clearance])
								cube([y_rod_y_belt_x_dist,belt_tooth_periode/2,2*belt_thickness_max+2*clearance]);
						translate([0,belt_tooth_periode+3*belt_tooth_periode,-belt_thickness_max])
							rotate([0,90,0])
								cylinder(r=belt_thickness_max+clearance,h=y_rod_y_belt_x_dist);
					}
					for(l=[0:2])
						translate([-1,belt_tooth_periode+l*belt_tooth_periode,-2*belt_thickness_max-clearance-1])
							cube([y_rod_y_belt_x_dist+1,layer_height,2*belt_thickness_max+2*clearance+2]);
				}

		// belt tensioner screw hole
		translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2)-(wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+belt_tensioning_range/2),x_belt_pulley_dia/2,-x_rod_belt_dist])
			rotate([0,90,0])
				cylinder(r=belt_tensioning_screw_dia/2+clearance,h=(belt_tensioner_length+belt_tensioning_range)+(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+belt_tensioning_range)+1);

		// belt tensioner thumb wheel trap
		difference(){
			translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2),x_belt_pulley_dia/2,-x_rod_belt_dist])
					rotate([180,0,0]) rotate([0,0,-90]){
						translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
							rotate([-90,0,0])
								cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall+2*clearance,h=belt_tensioning_nut_height+2*clearance+wall_thin+clearance);
						translate([-((cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance)/2),-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
							cube([cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance,belt_tensioning_nut_height+2*clearance+wall_thin+clearance,(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+2*clearance)]);
					}
			intersection(){
				translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance-2*wall,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance)-2*wall])
					cube([x_carriage_body_length+2,2*wall,2*wall]);
				difference(){
					translate([-x_carriage_body_length/2,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall,h=x_carriage_body_length);
					translate([-x_carriage_body_length/2-1,x_belt_pulley_dia/2-belt_tensioning_screw_dia/2-clearance,-(x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance)])
						rotate([0,90,0])
							cylinder(r=wall-1.5*wall_thin,h=x_carriage_body_length+2);
				}
			}
		}

		// extruder mount screw holes and nut traps
		for(e=[1,-1])	
				translate([e*extruder_back_body_width/2,-x_carriage_body_width/2-x_carriage_body_y_addition,x_carriage_body_height/2]){
					// back
					translate([0,extruder_back_body_length-(extruder_mount_screw_nut_wrench/2+clearance+wall),-(2*wall+2)/2+1])
						rotate([0,0,0]) rotate([0,90,0])
							teardrop(extruder_mount_screw_dia/2+clearance,2*wall+2);
					// front
					translate([e*(extruder_back_body_width/2-wall-2*clearance-extruder_mount_screw_dia-wall-clearance-extruder_mount_screw_dia/2),wall+clearance+extruder_mount_screw_dia/2,-(x_carriage_body_height+2)/2+1])
						rotate([0,0,0]) rotate([0,90,0])
							teardrop(extruder_mount_screw_dia/2+clearance,x_carriage_body_height+2);
				}

		// extruder hotend adapter mount screw holes and nut traps
		for(e=[1,-1])	
			translate([e*extruder_back_body_width/2,-x_carriage_body_width/2-x_carriage_body_y_addition,x_carriage_body_height/2]){
				translate([e*(extruder_back_body_width/2-wall-clearance-extruder_mount_screw_dia/2),(wall+2*clearance+extruder_mount_screw_nut_height+wall+1)/2-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
					rotate([90,0,0]) rotate([0,90,0])
						teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_mount_screw_nut_height+wall+1);
				translate([e*(extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2-clearance-wall-clearance-extruder_mount_screw_dia/2),(wall+2*clearance+extruder_mount_screw_nut_height+wall+1)/2-1,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
					rotate([90,0,0]) rotate([0,90,0])
						teardrop(extruder_mount_screw_dia/2+clearance,wall+2*clearance+extruder_mount_screw_nut_height+wall+1);
			}
		for(f=[0,1])	
			mirror([f,0,0])
				translate([extruder_back_body_width/2,-x_carriage_body_width/2-x_carriage_body_y_addition,x_carriage_body_height/2]){
					translate([(extruder_back_body_width/2-wall-clearance-extruder_mount_screw_dia/2),extruder_mount_screw_nut_height/2+clearance+wall,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
						rotate([90,0,0])
							nut_slot(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,wall+clearance+extruder_mount_screw_dia/2);
					translate([(extruder_drivegear_dia/2-extruder_hotend_insulator_dia/2-clearance-wall-clearance-extruder_mount_screw_dia/2),extruder_mount_screw_nut_height/2+clearance+wall,-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range])
						rotate([0,-90,0]) rotate([90,0,0])
							nut_slot(extruder_mount_screw_nut_wrench,extruder_mount_screw_nut_height,-(-wall-clearance-extruder_mount_screw_dia/2-extruder_hotend_adapter_adjustment_range));
				}
			

	}

	// belt tensioner screw hole printability support layer
	translate([x_carriage_body_length/2-(belt_tensioner_length+belt_tensioning_range/2)+(belt_tensioning_nut_height+2*clearance+wall_thin+clearance),x_belt_pulley_dia/2,-x_rod_belt_dist])
			rotate([180,0,0]) rotate([0,0,-90])
				translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
					rotate([-90,0,0])
						cylinder(r=belt_tensioning_screw_dia/2+clearance+wall_thin,h=layer_height);

	// linear bearing push in stop
	difference(){
		translate([-(x_carriage_body_length-2*linear_bearing_length-2*clearance)/2,-(x_carriage_body_width-2*wall)/2,linear_bearing_dia/2+clearance-wall_thin])
			cube([x_carriage_body_length-2*linear_bearing_length-2*clearance,x_carriage_body_width-2*wall,2*wall_thin]);
		translate([-(x_carriage_body_length+2)/2,-(x_rod_dist-linear_bearing_dia-2*clearance-2*wall_thin)/2,-(x_carriage_body_height+2)/2])
			cube([x_carriage_body_length+2,x_rod_dist-linear_bearing_dia-2*clearance-2*wall_thin,x_carriage_body_height+2]);

	}

}


module belt_tensioner_thumbwheel(){
	difference(){
		cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall,belt_tensioning_nut_height+wall_thin+clearance);
		translate([0,0,wall_thin+(belt_tensioning_nut_height+1)/2])
			nut_trap(belt_tensioning_nut_wrench, belt_tensioning_nut_height+1);
		translate([0,0,-1])
			cylinder(r=belt_tensioning_screw_dia/2+clearance,belt_tensioning_nut_height+wall_thin+clearance+2);
		for(i=[0:11])
			rotate([0,0,i*(360/12)])
				translate([cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall,0,-1])
					cylinder(r=wall_thin,belt_tensioning_nut_height+wall_thin+clearance+2);
	}
}
