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




// RENDER FOR LASER CUTTING (.DXF EXPORT)

// CHAMBER DOOR LEFT
* projection(cut=false) rotate([-90,0,0]) mirror([1,0,0]) frame_enclosure_chamber_door();

// CHAMBER DOOR RIGHT
* projection(cut=false) rotate([-90,0,0]) frame_enclosure_chamber_door();

// CHAMBER SIDE 2x
* projection(cut=false) rotate([0,90,0]) frame_enclosure_chamber_side();

// CHAMBER BACK
* projection(cut=false) rotate([-90,0,0]) frame_enclosure_chamber_back();

// CHAMBER TOP
* projection(cut=false) frame_enclosure_chamber_top();

// BASE TOP
* projection(cut=false) frame_enclosure_base_top();

// BASE SIDE 2x
* projection(cut=false) rotate([0,90,0]) frame_enclosure_base_side();

// BASE FRONT
* projection(cut=false) rotate([-90,0,0]) frame_enclosure_base_front();

// BASE BACK
* projection(cut=false) rotate([-90,0,0]) frame_enclosure_base_back();

// BASE BOTTOM
* projection(cut=true) translate([0,0,-1]) frame_enclosure_base_bottom();






module frame_enclosure_chamber_side(){
	difference(){

		// main body
		translate([-frame_enclosure_thickness,-frame_extrusion_length_horizontal/2-frame_width+wall,frame_width+frame_base_dist])
			cube([frame_enclosure_thickness,frame_enclosure_thickness+frame_width+frame_extrusion_length_horizontal+frame_width-wall,frame_enclosure_thickness+frame_extrusion_length_vertical-frame_width-frame_base_dist]);

		translate([0,0,frame_extrusion_length_vertical-(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2])
			for(v=[0,1])
				mirror([0,v,0])
					for(h=[0,1])
						mirror([0,0,h]){

							// frame corner clearance
							translate([-frame_enclosure_thickness-1,(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width+wall,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width+wall])
								cube([frame_enclosure_thickness+2,3*frame_width,3*frame_width]);

							// frame screw holes
							translate([1,(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width-frame_width/2])
								rotate([0,-90,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([1,(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,0])
								rotate([0,-90,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([1,(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width-frame_width/2,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2])
								rotate([0,-90,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([1,0,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2])
								rotate([0,-90,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						}
	}
}



module frame_enclosure_chamber_back(){
	difference(){

		// main body
		translate([-frame_extrusion_length_horizontal/2-frame_width,0,frame_width+frame_base_dist])
			cube([frame_width+frame_extrusion_length_horizontal+frame_width,frame_enclosure_thickness,frame_enclosure_thickness+frame_extrusion_length_vertical-frame_width-frame_base_dist]);

		translate([0,0,frame_extrusion_length_vertical-(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2])
			for(v=[0,1])
				mirror([v,0,0]){
					for(h=[0,1])
						mirror([0,0,h]){

							// frame corner clearance
							translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width+wall,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width+wall])
								cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);

							// frame screw holes
							translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width-frame_width/2])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,-1,0])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width-frame_width/2,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([0,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						}
					translate([0,0,-(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2+frame_width+frame_back_dist+frame_width/2]){
						hull(){
							translate([frame_extrusion_length_horizontal/2-frame_width/2,-1,0])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([2*frame_width+frame_width+clearance_laser+frame_screw_dia/2,-1,0])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						}
						hull(){
							translate([-1,-1,0])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
							translate([frame_width-clearance_laser-frame_screw_dia/2,-1,0])
								rotate([-90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						}

						// filament feed sensor wire harness hole
						translate([0,0,frame_width/2+(filament_feed_sensor_wire_harness_height/2+clearance_laser)])
							hull(){
								translate([0,-1,0])
									rotate([-90,0,0])
										cylinder(r=filament_feed_sensor_wire_harness_height/2+clearance_laser,h=frame_enclosure_thickness+2);
								translate([filament_feed_sensor_wire_harness_width/2-(filament_feed_sensor_wire_harness_height/2+clearance_laser),-1,0])
									rotate([-90,0,0])
										cylinder(r=filament_feed_sensor_wire_harness_height/2+clearance_laser,h=frame_enclosure_thickness+2);
							}
					}
				}

		// filament tube holes
		translate([-frame_extrusion_length_horizontal/2+x_cablechain_height_outside/2,0,frame_extrusion_length_vertical-frame_width-x_cablechain_width_outside/2+x_cablechain_width_inside/2-(x_cablechain_width_inside/(x_cablechain_dividers+1))/2])
			hull(){
				translate([filament_tube_dia/2,-1,0])
					rotate([-90,0,0])
						cylinder(r=filament_tube_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([-filament_tube_dia/2,-1,0])
					rotate([-90,0,0])
						cylinder(r=filament_tube_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			}
	}
}



module frame_enclosure_chamber_door(){
	difference(){

		// main body
		translate([wall_thin/2,0,frame_width+frame_base_dist+wall_thin])
			cube([frame_enclosure_thickness+frame_width+frame_extrusion_length_horizontal/2-wall_thin/2,frame_enclosure_thickness,frame_enclosure_thickness+frame_extrusion_length_vertical-frame_width-frame_base_dist-wall_thin-wall_thin-wall_thin]);

		translate([0,0,frame_extrusion_length_vertical-(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2]){

			// frame corner clearance
			translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width+wall,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2+frame_enclosure_thickness-wall-wall_thin])
				cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);
			translate([(frame_extrusion_length_horizontal/2+frame_width),-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width-wall_thin])
				cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);
			translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width+wall,-1,-((frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-wall)])
				mirror([0,0,1])
					cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);
			translate([(frame_extrusion_length_horizontal/2+frame_width),-1,-((frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width)])
				mirror([0,0,1])
					cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);

			// door handle screw holes
			translate([wall_thin/2+2*wall+clearance+frame_screw_dia/2,-1,frame_width-2*wall-clearance-frame_screw_dia/2-wall_thin/2])
				rotate([-90,0,0])
					cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			translate([wall_thin/2+2*wall+clearance+frame_screw_dia/2,-1,-(frame_width-2*wall-clearance-frame_screw_dia/2)-wall_thin/2])
				rotate([-90,0,0])
					cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);

			// door lock magnet holes
			translate([wall_thin/2+frame_width/2,-1,(frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2-wall_thin])
				rotate([-90,0,0])
					cylinder(r=frame_door_lock_magnet_dia/2,h=frame_enclosure_thickness+2);
			translate([wall_thin/2+frame_width/2,-1,-((frame_extrusion_length_vertical-frame_width-frame_base_dist)/2-frame_width/2)])
				rotate([-90,0,0])
					cylinder(r=frame_door_lock_magnet_dia/2,h=frame_enclosure_thickness+2);
		}
	}
}



module frame_enclosure_chamber_top(){
	difference(){

		// main body
		translate([-frame_width-frame_extrusion_length_horizontal/2,-frame_width-frame_extrusion_length_horizontal/2,0])
			cube([frame_width+frame_extrusion_length_horizontal+frame_width,frame_width+frame_extrusion_length_horizontal+frame_width,frame_enclosure_thickness]);

		for(x=[0,1])
			mirror([x,0,0])
				for(y=[0,1])
					mirror([0,y,0]){

						// frame corner clearance
						translate([frame_extrusion_length_horizontal/2+wall,frame_extrusion_length_horizontal/2-frame_width+wall,-1])
							cube([3*frame_width,3*frame_width,frame_enclosure_thickness+2]);
						translate([frame_extrusion_length_horizontal/2-frame_width+wall,frame_extrusion_length_horizontal/2+wall,-1])
							cube([3*frame_width,3*frame_width,frame_enclosure_thickness+2]);

						// frame screw holes
						translate([frame_extrusion_length_horizontal/2+frame_width/2,frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2+frame_width/2,0,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([0,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
					}
	}
}



module frame_enclosure_base_top(){
	difference(){

		// main body
		translate([-frame_width-frame_extrusion_length_horizontal/2,-frame_width-frame_extrusion_length_horizontal/2,0])
			cube([frame_width+frame_extrusion_length_horizontal+frame_width,frame_width+frame_extrusion_length_horizontal+frame_width,frame_enclosure_thickness]);

		for(x=[0,1])
			mirror([x,0,0])
				for(y=[0,1])
					mirror([0,y,0]){

						// cable clearance, frame clearance, frame angle clearance
						translate([frame_extrusion_length_horizontal/2-frame_width,frame_extrusion_length_horizontal/2-frame_width,-1])
							cube([3*frame_width,3*frame_width,frame_enclosure_thickness+2]);

						// frame screw holes
						translate([frame_extrusion_length_horizontal/2+frame_width/2,frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2+frame_width/2,0,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([0,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
					}
	}
}



module frame_enclosure_base_side(){
	difference(){

		// main body
		translate([-frame_enclosure_thickness,-frame_extrusion_length_horizontal/2-frame_width,-frame_enclosure_thickness])
			cube([frame_enclosure_thickness,frame_enclosure_thickness+frame_width+frame_extrusion_length_horizontal+frame_width,frame_base_dist+frame_width+frame_enclosure_thickness]);

		for(v=[0,1])
			mirror([0,v,0]){

				// frame corner clearance
				translate([-frame_enclosure_thickness-1,frame_extrusion_length_horizontal/2-frame_width+wall,frame_width+frame_base_dist-frame_width])
					cube([frame_enclosure_thickness+2,3*frame_width,3*frame_width]);
				translate([-frame_enclosure_thickness-1,frame_extrusion_length_horizontal/2-frame_width+wall,frame_width-wall])
					mirror([0,0,1])
						cube([frame_enclosure_thickness+2,3*frame_width,3*frame_width]);

				// frame screw holes
				translate([1,(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,frame_width+frame_base_dist-frame_width-frame_width/2])
					rotate([0,-90,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([1,(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,frame_width+frame_width/2])
					rotate([0,-90,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([1,(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width-frame_width/2,frame_width/2])
					rotate([0,-90,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([1,0,frame_width/2])
					rotate([0,-90,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			}
	}
}



module frame_enclosure_base_front(){
	difference(){

		// main body
		translate([-frame_extrusion_length_horizontal/2-frame_width-frame_enclosure_thickness,-frame_enclosure_thickness,-frame_enclosure_thickness])
			cube([frame_enclosure_thickness+frame_width+frame_extrusion_length_horizontal+frame_width+frame_enclosure_thickness,frame_enclosure_thickness,frame_base_dist+frame_width+frame_enclosure_thickness]);

		for(v=[0,1])
			mirror([v,0,0]){

				// frame corner clearance
				translate([frame_extrusion_length_horizontal/2-frame_width+wall,-frame_enclosure_thickness-1,frame_width+frame_base_dist-frame_width])
					cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);
				translate([frame_extrusion_length_horizontal/2-frame_width+wall,-frame_enclosure_thickness-1,frame_width-wall])
					mirror([0,0,1])
						cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);

				// frame screw holes
				translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,1,frame_width+frame_base_dist-frame_width-frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,1,frame_width+frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width-frame_width/2,1,frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([0,1,frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([0,1,frame_width+frame_base_dist-frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			}

		// touchscreen housing mount screw holes
		translate([0,0,-frame_enclosure_thickness+(frame_base_dist+frame_width+frame_enclosure_thickness)/2]){
			for(h=[0,1])
				mirror([h,0,0])
					for(v=[0,1])
						mirror([0,0,v])
							translate([controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2,1,controller_touchscreen_housing_mount_side/2-wall-clearance-frame_screw_dia/2])
								rotate([90,0,0])
									cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			translate([0,1,0])
				rotate([90,0,0])
					cylinder(r=controller_touchscreen_cable_clearance_dia/2,h=frame_enclosure_thickness+2);
		}

		// power button hole
		translate([frame_extrusion_length_horizontal/2-frame_width/2,1,-frame_enclosure_thickness+(frame_base_dist+frame_width+frame_enclosure_thickness)/2])
			rotate([90,0,0])
				cylinder(r=controller_power_button_hole_dia/2+clearance,h=frame_enclosure_thickness+2);
	}
}



module frame_enclosure_base_back(){
	difference(){

		// main body
		translate([-frame_extrusion_length_horizontal/2-frame_width,-frame_enclosure_thickness,-frame_enclosure_thickness])
			cube([frame_width+frame_extrusion_length_horizontal+frame_width,frame_enclosure_thickness,frame_base_dist+frame_width+frame_enclosure_thickness]);

		for(v=[0,1])
			mirror([v,0,0]){

				// frame corner clearance
				translate([frame_extrusion_length_horizontal/2-frame_width+wall,-frame_enclosure_thickness-1,frame_width+frame_base_dist-frame_width])
					cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);
				translate([frame_extrusion_length_horizontal/2-frame_width+wall,-frame_enclosure_thickness-1,frame_width-wall])
					mirror([0,0,1])
						cube([3*frame_width,frame_enclosure_thickness+2,3*frame_width]);

				// frame screw holes
				translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,1,frame_width+frame_base_dist-frame_width-frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([(frame_extrusion_length_horizontal/2+frame_width)-frame_width/2,1,frame_width+frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([(frame_extrusion_length_horizontal/2+frame_width)-2*frame_width-frame_width/2,1,frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([0,1,frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([0,1,frame_width+frame_base_dist-frame_width/2])
					rotate([90,0,0])
						cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			}

		// radiator mount
		translate([-watercooling_radiator_fan_side/2+frame_extrusion_length_horizontal/2-2*frame_width-power_supply_height-frame_width,0,frame_width+(frame_base_dist-frame_width)/2]){
			for(h=[0,1])
				mirror([h,0,0])
					for(v=[0,1])
						mirror([0,0,v])
							translate([watercooling_radiator_fan_hole_dist/2,1,watercooling_radiator_fan_hole_dist/2])
								rotate([90,0,0])
									cylinder(r=watercooling_radiator_fan_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
			intersection(){
				translate([0,1,0])
					rotate([90,0,0])
						cylinder(r=watercooling_radiator_fan_dia/2,h=frame_enclosure_thickness+2);
				translate([-watercooling_radiator_fan_cutout_side/2,-(frame_enclosure_thickness+4)+2,-watercooling_radiator_fan_cutout_side/2])
					cube([watercooling_radiator_fan_cutout_side,frame_enclosure_thickness+4,watercooling_radiator_fan_cutout_side]);
			}
		}

		// waterpump mount
		translate([-watercooling_pump_width/2+frame_extrusion_length_horizontal/2-2*frame_width-power_supply_height-frame_width-watercooling_radiator_fan_side-3*frame_width,0,frame_width+(frame_base_dist-frame_width)/2])
			translate([0,0,-watercooling_pump_height/2+watercooling_pump_mount_pos_z])
				for(h=[0,1])
					mirror([h,0,0])
						for(v=[0,1])
							mirror([0,0,v])
								translate([watercooling_pump_hole_dist_x/2,1,watercooling_pump_hole_dist_z/2])
									rotate([90,0,0])
										cylinder(r=watercooling_pump_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);

		// atx psu mount
		translate([-power_supply_height/2+frame_extrusion_length_horizontal/2-2*frame_width,0,frame_width+power_supply_width/2])
			rotate([0,90,0]){
				translate([power_supply_width/2-power_supply_hole_edge_dist,1,power_supply_height/2-power_supply_hole_edge_dist])
					rotate([90,0,0])
						cylinder(r=power_supply_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([-(power_supply_width/2-power_supply_hole_edge_dist),1,power_supply_height/2-power_supply_hole_edge_dist])
					rotate([90,0,0])
						cylinder(r=power_supply_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([power_supply_width/2-power_supply_hole_edge_dist+power_supply_hole_bottom_right_x_shift,1,-(power_supply_height/2-power_supply_hole_edge_dist)])
					rotate([90,0,0])
						cylinder(r=power_supply_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([-(power_supply_width/2-power_supply_hole_edge_dist),1,-(power_supply_height/2-power_supply_hole_edge_dist)+power_supply_hole_bottom_left_z_shift])
					rotate([90,0,0])
						cylinder(r=power_supply_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				difference(){
					translate([-(power_supply_width-2*power_supply_cutout_edge_dist)/2,-(frame_enclosure_thickness+2)+1,-(power_supply_height-2*power_supply_cutout_edge_dist)/2])
						cube([power_supply_width-2*power_supply_cutout_edge_dist,frame_enclosure_thickness+2,power_supply_height-2*power_supply_cutout_edge_dist]);
					hull(){
						translate([power_supply_width/2-power_supply_hole_edge_dist,2,power_supply_height/2-power_supply_hole_edge_dist])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([power_supply_width/2-power_supply_hole_edge_dist+power_supply_width,2,power_supply_height/2-power_supply_hole_edge_dist])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([power_supply_width/2-power_supply_hole_edge_dist,2,power_supply_height/2-power_supply_hole_edge_dist+power_supply_height])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					}
					hull(){
						translate([-(power_supply_width/2-power_supply_hole_edge_dist),2,power_supply_height/2-power_supply_hole_edge_dist])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([-(power_supply_width/2-power_supply_hole_edge_dist)-power_supply_width,2,power_supply_height/2-power_supply_hole_edge_dist])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([-(power_supply_width/2-power_supply_hole_edge_dist),2,power_supply_height/2-power_supply_hole_edge_dist+power_supply_height])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					}
					hull(){
					translate([power_supply_width/2-power_supply_hole_edge_dist+power_supply_hole_bottom_right_x_shift,2,-(power_supply_height/2-power_supply_hole_edge_dist)])
						rotate([90,0,0])
							cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					translate([power_supply_width/2-power_supply_hole_edge_dist+power_supply_hole_bottom_right_x_shift+power_supply_width,2,-(power_supply_height/2-power_supply_hole_edge_dist)])
						rotate([90,0,0])
							cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					translate([power_supply_width/2-power_supply_hole_edge_dist+power_supply_hole_bottom_right_x_shift,2,-(power_supply_height/2-power_supply_hole_edge_dist)-power_supply_height])
						rotate([90,0,0])
							cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					}
					hull(){
						translate([-(power_supply_width/2-power_supply_hole_edge_dist),2,-(power_supply_height/2-power_supply_hole_edge_dist)+power_supply_hole_bottom_left_z_shift])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([-(power_supply_width/2-power_supply_hole_edge_dist)-power_supply_width,2,-(power_supply_height/2-power_supply_hole_edge_dist)+power_supply_hole_bottom_left_z_shift])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
						translate([-(power_supply_width/2-power_supply_hole_edge_dist),2,-(power_supply_height/2-power_supply_hole_edge_dist)+power_supply_hole_bottom_left_z_shift-power_supply_height])
							rotate([90,0,0])
								cylinder(r=power_supply_screw_dia/2+clearance_laser+3*wall,h=frame_enclosure_thickness+4);
					}
				}
			}

		// ethernet socket mount
		translate([-controller_ethernet_coupling_panel_body_width/2+frame_extrusion_length_horizontal/2,0,frame_width+(frame_base_dist-frame_width)/2])
			translate([0,-frame_enclosure_thickness-1,-controller_ethernet_coupling_panel_body_height/2]){
				for(i=[0,1])
					mirror([i,0,0])
						translate([controller_ethernet_coupling_panel_body_width/2-wall-clearance-frame_screw_dia/2,0,controller_ethernet_coupling_panel_body_height/2])
							rotate([-90,0,0])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
				translate([-controller_ethernet_coupling_width_front/2-clearance_laser,0,controller_ethernet_coupling_panel_body_height-2*wall-clearance-controller_ethernet_coupling_height_front-clearance_laser])
					cube([controller_ethernet_coupling_width_front+2*clearance_laser,frame_enclosure_thickness+2,controller_ethernet_coupling_height_front+2*clearance_laser]);
			}
	}
}



module frame_enclosure_base_bottom(){

		slots = round((frame_extrusion_length_horizontal/2-frame_width)/(4*wall));

	difference(){

		// main body
		translate([-frame_width-frame_extrusion_length_horizontal/2,-frame_width-frame_extrusion_length_horizontal/2,0])
			cube([frame_width+frame_extrusion_length_horizontal+frame_width,frame_width+frame_extrusion_length_horizontal+frame_width,frame_enclosure_thickness]);

		for(x=[0,1])
			mirror([x,0,0])
				for(y=[0,1])
					mirror([0,y,0]){

						// frame corner clearance
						translate([frame_extrusion_length_horizontal/2+wall,frame_extrusion_length_horizontal/2-frame_width+wall,-1])
							cube([3*frame_width,3*frame_width,frame_enclosure_thickness+2]);
						translate([frame_extrusion_length_horizontal/2-frame_width+wall,frame_extrusion_length_horizontal/2+wall,-1])
							cube([3*frame_width,3*frame_width,frame_enclosure_thickness+2]);

						// frame screw holes
						translate([frame_extrusion_length_horizontal/2+frame_width/2,frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2-2*frame_width+frame_width/2,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([frame_extrusion_length_horizontal/2+frame_width/2,0,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
						translate([0,frame_extrusion_length_horizontal/2+frame_width/2,-1])
								cylinder(r=frame_screw_dia/2+clearance_laser,h=frame_enclosure_thickness+2);
					}

		// air ventilation
		if(slots>(frame_extrusion_length_horizontal/2-frame_width)/(4*wall))
			for(x=[0,1])
				mirror([x,0,0])
					for(i=[0:slots-2])
						render() translate([2*wall+i*(4*wall),-frame_extrusion_length_horizontal/2+frame_width+2*wall,0]){
							render() hull(){
								translate([0,wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
								translate([0,2*frame_width-wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
							}
							render() hull(){
								translate([0,2*frame_width+2*wall+wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
								translate([0,2*frame_width+2*wall+2*frame_width-wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
							}
						}
		if(slots<=(frame_extrusion_length_horizontal/2-frame_width)/(4*wall))
			for(x=[0,1])
				mirror([x,0,0])
					for(i=[0:slots-1])
	
						render() translate([2*wall+i*(4*wall),-frame_extrusion_length_horizontal/2+frame_width+2*wall,0]){
							render() hull(){
								translate([0,wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
								translate([0,2*frame_width-wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
							}
							render() hull(){
								translate([0,2*frame_width+2*wall+wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
								translate([0,2*frame_width+2*wall+2*frame_width-wall,-1])
									cylinder(r=wall,h=frame_enclosure_thickness+2);
							}
						}
		}
}





