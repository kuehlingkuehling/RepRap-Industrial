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
rotate([0,180,0])
    difference(){
        filament_feed();
        translate([0,0,0])
            label("264",orientation="bottom");
    }




module filament_feed(){
	difference(){

		// main body
		hull(){
			for(i=[0,1])
				mirror([i,0,0]){
					translate([-filament_feed_body_width/2+wall,0,wall])
						rotate([0,0,90])
							teardrop(wall,filament_feed_body_length);
					translate([-filament_feed_body_width/2+wall,0,filament_feed_body_height-wall])
						rotate([0,0,90])
							teardrop(wall,filament_feed_body_length);
				}
		}

		// frame extrusion and mount screw clearance
		translate([-frame_width_small/2-clearance,filament_feed_body_length/2-wall,wall])
			cube([frame_width_small+2*clearance,wall+1,frame_width+2*clearance]);
		translate([0,0,wall+clearance+frame_width/2])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_center_screw_dia/2+clearance,filament_feed_body_length+2);
		translate([0,-(wall+1)/2+wall-filament_feed_body_length/2,wall+clearance+frame_width/2])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_center_screw_washer_dia/2+clearance,wall+1);

		for(i=[0,1])
			rotate([0,0,i*180]){

				// filament clearance
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2,0,-1])
					rotate([0,0,45])	
						cylinder(r=filament_dia/2+filament_tolerance/2+clearance,h=filament_feed_body_height+2);

				// press-in quick connector countersink
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2,0,filament_feed_body_height-filament_feed_quick_connector_countersink-clearance])
					cylinder(r=filament_feed_quick_connector_dia/2+clearance,h=filament_feed_quick_connector_countersink+clearance+1);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2,0,filament_feed_body_height-filament_feed_quick_connector_countersink-clearance-((filament_feed_quick_connector_dia/2+clearance)-(filament_dia/2+clearance))])
					cylinder(r1=filament_dia/2+clearance,r2=filament_feed_quick_connector_dia/2+clearance+clearance/2,h=(filament_feed_quick_connector_dia/2+clearance)-(filament_dia/2+clearance)+clearance/2);

				// filament dust cleaner foam clearance
				translate([-filament_feed_dust_cleaner_foam_side/2+frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2,-filament_feed_dust_cleaner_foam_side/2,-1])
					cube([filament_feed_dust_cleaner_foam_side,filament_feed_dust_cleaner_foam_side,filament_feed_dust_cleaner_foam_side+1]);

				// filament feed-in teflon liner clearance
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2,0,filament_feed_dust_cleaner_foam_side-clearance])
					cylinder(r=filament_tube_dia/2,h=3*wall);

				// filament feed sensor clearance
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2-(filament_dia/2+filament_tolerance/2+clearance),-(filament_dia/2+filament_tolerance/2+clearance),filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-clearance-filament_feed_sensor_hole_pos-filament_feed_sensor_hole_dist])
					cube([filament_feed_body_width/2,filament_feed_sensor_flag_width+wall_thin,filament_feed_sensor_hole_dist]);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2-(filament_dia/2+filament_tolerance/2+clearance),0,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-clearance-filament_feed_sensor_hole_pos-filament_feed_sensor_hole_dist])
					rotate([0,90,0])
						rotate([0,0,90])
							linear_extrude(height=2*(filament_dia/2+filament_tolerance/2+clearance))
								polygon(points=[[-(filament_dia/2+filament_tolerance/2+clearance),1],[-(filament_dia/2+filament_tolerance/2+clearance)+filament_feed_sensor_flag_width+wall_thin,1],[-(filament_dia/2+filament_tolerance/2+clearance)+filament_feed_sensor_flag_width+wall_thin,0],[0,-(filament_feed_sensor_flag_width+wall_thin-(filament_dia/2+filament_tolerance/2+clearance))],[-(filament_dia/2+filament_tolerance/2+clearance),-(filament_feed_sensor_flag_width+wall_thin-(filament_dia/2+filament_tolerance/2+clearance))+(filament_dia/2+filament_tolerance/2+clearance)]]);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2-(filament_dia/2+filament_tolerance/2+clearance),0,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-clearance-filament_feed_sensor_hole_pos])
					mirror([0,0,1])
						rotate([0,90,0])
							rotate([0,0,90])
								linear_extrude(height=2*(filament_dia/2+filament_tolerance/2+clearance))
									polygon(points=[[-(filament_dia/2+filament_tolerance/2+clearance),1],[-(filament_dia/2+filament_tolerance/2+clearance)+filament_feed_sensor_flag_width+wall_thin,1],[-(filament_dia/2+filament_tolerance/2+clearance)+filament_feed_sensor_flag_width+wall_thin,0],[0,-(filament_feed_sensor_flag_width+wall_thin-(filament_dia/2+filament_tolerance/2+clearance))],[-(filament_dia/2+filament_tolerance/2+clearance),-(filament_feed_sensor_flag_width+wall_thin-(filament_dia/2+filament_tolerance/2+clearance))+(filament_dia/2+filament_tolerance/2+clearance)]]);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min-clearance,-(filament_dia/2+filament_tolerance/2+clearance)+wall_thin/2+filament_feed_sensor_flag_width/2+filament_feed_sensor_flag_center_pos-filament_feed_sensor_thickness-clearance,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_height+clearance)])
					cube([filament_feed_body_width/2,clearance+filament_feed_sensor_thickness+clearance,clearance+filament_feed_sensor_height+clearance]);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,0,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(filament_feed_sensor_screw_dia/2+clearance,filament_feed_body_length+2);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,-filament_feed_body_length/2-(filament_dia/2+filament_tolerance/2+clearance)+wall_thin/2+filament_feed_sensor_flag_width/2+filament_feed_sensor_flag_center_pos+clearance,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(filament_feed_sensor_screw_washer_dia/2+clearance,filament_feed_body_length);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,0,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)-filament_feed_sensor_hole_dist])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(filament_feed_sensor_screw_dia/2+clearance,filament_feed_body_length+2);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,-filament_feed_body_length/2-(filament_dia/2+filament_tolerance/2+clearance)+wall_thin/2+filament_feed_sensor_flag_width/2+filament_feed_sensor_flag_center_pos+clearance,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)-filament_feed_sensor_hole_dist])
					rotate([0,0,90])
						rotate([180,0,0])
							teardrop(filament_feed_sensor_screw_washer_dia/2+clearance,filament_feed_body_length);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,-(filament_feed_sensor_screw_nut_height+clearance+1)/2+filament_feed_body_length/2+1,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)])
					rotate([90,0,0])
						nut_trap_square(filament_feed_sensor_screw_nut_wrench,filament_feed_sensor_screw_nut_height+clearance+1);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min+filament_feed_sensor_hole_pos_v,-(filament_feed_sensor_screw_nut_height+clearance+1)/2+filament_feed_body_length/2+1,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_hole_pos)-filament_feed_sensor_hole_dist])
					rotate([90,0,0])
						nut_trap_square(filament_feed_sensor_screw_nut_wrench,filament_feed_sensor_screw_nut_height+clearance+1);
				translate([frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side/2+(filament_dia/2+filament_tolerance/2)+filament_feed_sensor_dist_min-clearance+filament_feed_body_width/4,-(filament_dia/2+filament_tolerance/2+clearance)+wall_thin/2+filament_feed_sensor_flag_width/2+filament_feed_sensor_flag_center_pos-filament_feed_sensor_thickness-clearance+clearance+filament_feed_sensor_thickness+clearance,filament_feed_body_height-(filament_feed_quick_connector_countersink+clearance+2*wall)-(clearance+filament_feed_sensor_bottomsolderjoint_pos)])
					for(i=[0,1])
						rotate([i*180,0,0])
							teardrop(filament_feed_sensor_bottomsolderjoint_thickness/2+clearance,filament_feed_body_width/2,fulldrop=1);
			}
	}
}
