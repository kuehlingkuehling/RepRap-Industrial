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

include <functions.scad>

///// PARAMETERS ////////////////////////////////////

$fa=1;
$fs=0.5;

support = false;				// set to "true" for FFF 3d printing (generates printability support layers etc.), leave "false" for SLS 3d printing

filament_dia = 2.85;
filament_tolerance = 0.1;		// +/-
filament_tube_dia = 6;			// inner dia: 4

m3_screw_dia = 3;						// M3
m3_screw_head_dia = 5.5;			// M3 inbus
m3_screw_head_length = 3;			// M3 inbus
m3_screw_lens_head_length = 1.65;		// M3 lens head screw
m3_nut_wrench = 5.5;				// M3
m3_nut_height = 2.4;				// M3
m3_squarenut_height = 1.8;		// M3 square nut flat
m3_washer_dia = 7;				// M3
m3_hex_wrench_dia = 3;			// allen key diameter

m4_screw_dia = 4;						// M4
m4_screw_head_dia = 7;				// M4 inbus
m4_screw_head_flange_dia = 9.4;	// M4 round head flange screw
m4_screw_head_length = 4;				// M4 inbus
m4_screw_head_wrench = 7;				// M4 hex head
m4_screw_head_wrench_length = 2.8;		// M4 hex head
m4_washer_dia = 9;				// M4
m4_washer_thickness = 0.8;		// M4
m4_nut_wrench = 7;				// M4
m4_nut_height = 3.2;				// M4
m4_locknut_height = 5;			// M4 locknut
m4_hex_wrench_dia = 3.5;			// allen key diameter
m4_flat_knurled_nut_dia = 16;
m4_flat_knurled_nut_height = 4;

m6_screw_dia = 6;
m6_nut_wrench = 10;
m6_nut_height = 5.2;

m8_screw_dia = 8;
m8_screw_head_wrench = 13;
m8_screw_head_wrench_length = 5.3;
m8_screw_roundheadflange_length = 4.4;			// round head flange screw
m8_nut_wrench = 13;
m8_nut_height = 6.5;
m8_washer_dia = 17.8;		// using larger dimension of round head flange screw head diameter here (m8 washer diameter: 16mm)
m8_washer_thickness = 1.6;

clearance = 0.2;				// for 3d printing; loose fit (screw holes etc.)
clearance_laser = 0.4;		// for laser cutting; gives 0.3mm actual clearance after laser cutting with 0.2mm cutting width
clearance_tight = 0.1;		// for 3d printing; tight/snug fit (bearings, bushings etc.)
layer_height = 0.24;
nozzle_dia = 0.35;

rod_dia = 12;
linear_bearing_dia = 22;					// LME12UU compatible
linear_bearing_length = 32;				// LME12UU compatible
linear_bearing_groove_width = 1.3;		// use fixation bolts of 1.3mm dia
linear_bearing_groove_dia = 20.5;
linear_bearing_groove_pos = 4.7;
linear_bearing_dist_min = 10;
wall = 3;
wall_thin = 1;

bearing_dia = 22;					// 608 bearing
bearing_width = 7;					// 608 bearing
bearing_center_dia = 8;				// 608 bearing
bearing_guide_dia = 28;

nema17_width = 43;
nema17_length = 48;
nema17_center_dia = 22;
nema17_center_pitch = 2;
nema17_hole_dist = 31;
nema17_screw_dia = m3_screw_dia;					// M3
nema17_screw_lens_head_length = m3_screw_lens_head_length;
nema17_screw_washer_dia = m3_washer_dia;			// M3
nema17_screw_hex_wrench_dia = m3_hex_wrench_dia;	// allen key diameter
//nema17_pulley_base = 8;
nema17_shaft_length = 25;
nema17_shaft_dia = 5;
nema17_gearbox_dia = 36;
nema17_gearbox_length = 28;
nema17_gearbox_center_dia = 22;
nema17_gearbox_center_pitch = 1.5;
nema17_gearbox_shaft_length = 20;		// distance mount flange surface - shaft end
nema17_gearbox_hole_pos_dia = 28;

frame_screw_dia = m4_screw_dia;
frame_screw_head_dia = m4_screw_head_dia;
frame_screw_head_length = m4_screw_head_length;
frame_screw_length = 10;
frame_screw_washer_dia = m4_washer_dia;
frame_screw_head_flange_dia = m4_screw_head_flange_dia;
frame_screw_washer_thickness = m4_washer_thickness;
frame_screw_nut_wrench = m4_nut_wrench;
frame_screw_nut_height = m4_nut_height;
frame_screw_hex_wrench_dia = m4_hex_wrench_dia;		// allen key diameter
frame_width = 30;						// t-slot B-type 30mm
frame_width_small = 19;				// t-slot B-type 19x30mm
frame_groove_width = 8;				// t-slot B-type 30mm
frame_groove_depth = 9;				// t-slot B-type 30mm
frame_groove_wall_thickness = 2.3;			// t-slot B-type 30mm
frame_center_screw_dia = m8_screw_dia;				// t-slot B-type 30mm
frame_center_screw_head_length = m8_screw_roundheadflange_length;
frame_center_screw_washer_dia = m8_washer_dia;				// t-slot B-type 30mm
frame_enclosure_thickness = 6;
frame_enclosure_door_hinge_bolt_dia = m4_screw_dia;
frame_enclosure_door_hinge_bolt_length = 36;
frame_base_dist = 170;					// space between lower horizontal frame bars (electronics enclosure)
frame_back_dist = 380;					// space between back horizontal frame bars (z-top to z-bottom)
frame_extrusion_length_horizontal = 540;
frame_extrusion_length_vertical = frame_width+frame_base_dist+frame_width+frame_extrusion_length_horizontal+frame_width;						// assembled frame height (vertical) = 800 (incl. cubic corner connectors)
frame_angle_side = 28;					// aluminum angles for t-slot
frame_door_handle_finger_clearance = 15;
frame_door_lock_magnet_dia = 8;
frame_cable_mount_zip_tie_width = 5.4;		// maximum zip tie width acceptance
frame_cable_mount_zip_tie_thickness = 2;		// maximum zip tie thickness acceptance

belt_width = 6;						// T2.5 belt, 6mm width
belt_thickness_min = 1;			// for T5: 1; for T2.5: 0.6
belt_thickness_max = 1+1.2;		// for T5: 1+1.2; for T2.5: 0.6+0.7
belt_tooth_periode = 5;			// T5: 5; T2.5: 2.5
belt_grip_length = 3;				// number of periodes; T5: 3; T2.5: 5
belt_tensioning_range = 15;
belt_tensioning_screw_dia = m4_screw_dia;
belt_tensioning_screw_head_dia = m4_screw_head_dia;
belt_tensioning_screw_head_wrench = m4_screw_head_wrench;		// hex head screw
belt_tensioning_screw_head_wrench_length = m4_screw_head_wrench_length;		// hex head screw
belt_tensioning_screw_head_length = m4_screw_head_length;
belt_tensioning_screw_length = 50;
belt_tensioning_washer_dia = m4_washer_dia;
belt_tensioning_washer_thickness = m4_washer_thickness;
belt_tensioning_nut_wrench = m4_nut_wrench;		// DEPRECATED in rev. 1.2.0, left for compatibility reasons
belt_tensioning_nut_height = m4_nut_height;		// DEPRECATED in rev. 1.2.0, left for compatibility reasons
belt_tensioning_knurled_nut_dia = m4_flat_knurled_nut_dia;
belt_tensioning_knurled_nut_height = m4_flat_knurled_nut_height;

belt_width_clearance = 0.5;
belt_pulley_retainer_width = 1;

endstop_height = 3;				// PCB thickness plus component clearance
endstop_hole_dist = 11;
endstop_hole_sensor_dist = 9;
endstop_screw_dia = m3_screw_dia;
endstop_screw_washer_dia = m3_washer_dia;
endstop_screw_nut_wrench = m3_nut_wrench;
endstop_screw_nut_height = m3_nut_height;
endstop_magnet_dia = 4;
endstop_magnet_length = 7;

bed_heatbed_thickness = 6.1;		// double faced corrugated aluminum sandwich
bed_heatbed_side = 212;
bed_heatbed_width = 212;            // introduced for temporary dev purpose in "bed_siliconeheater.scad" (bed_heatbed_side still in use elsewhere)
bed_heatbed_length = 212;           // introduced for temporary dev purpose in "bed_siliconeheater.scad" (bed_heatbed_side still in use elsewhere)
bed_siliconeheater_thickness = 3;
bed_siliconeheater_width = 210;
bed_siliconeheater_length = 210;
bed_surface_thickness = 1.5;		// PEI carbon fabric composite
bed_surface_side = 210;
bed_clamp_width = 12;				// foldback clamps 25mm, max. clamp width 9mm
bed_clamp_length = 25;				// foldback clamps 25mm, max. clamp width 9mm
bed_clamp_maxclampwidth = 12;
bed_clamp_angle_thickness = 3.5;
bed_clamp_angle_length = 14;
bed_leveling_mount_dia = 10;		// cylindrical glueing surfaces diameter for bonding to the aluminum sandwich
bed_leveling_rod_end_bearing_dia = 15;
bed_leveling_rod_end_bearing_width = 5;
bed_leveling_rod_end_bearing_screw_dia = m4_screw_dia;
bed_leveling_rod_end_bearing_screw_nut_wrench = m4_nut_wrench;
bed_leveling_rod_end_bearing_screw_nut_height = m4_nut_height;
bed_leveling_rod_end_bearing_shaft_wrench = 8;

air_heater_fan_side = 119;
air_heater_fan_dia = 125;
air_heater_fan_cutout_side = 116;
air_heater_fan_hole_dist = 104.8;
air_heater_fan_screw_dia = 5;			// hole for thermoplast screws grabbing into 4.5mm fan mount holes
air_heater_fan_screw_washer_dia = m4_washer_dia;
air_heater_uprofile_width = 120;
air_heater_uprofile_height = 40;
air_heater_uprofile_thickness = 3;
air_heater_cable_dia = 2;				// 2x2 AWG16
air_heater_overtemp_cable_dia = 1.25; // 2x1 AWG24
air_heater_mosfetboard_height = 15.45;
air_heater_mosfetboard_thickness = 1.7;
air_heater_heating_insert_height = 30;
air_heater_heating_insert_top_clearance = 30;

air_filter_fan_side = 80;
air_filter_fan_dia = 90;
air_filter_fan_cutout_side = 78;
air_filter_fan_hole_dist = 71.5;		// 80x80mm fan
air_filter_fan_screw_dia = 5;			// hole for thermoplast screws grabbing into 4.5mm fan mount holes
air_filter_fan_screw_washer_dia = m4_washer_dia;
air_filter_activatedcarbon_size = 30;
air_filter_activatedcarbon_container_grid_space = 2.5;

set_collar_screw_dia = m3_screw_dia;
set_collar_screw_nut_wrench = m3_nut_wrench;
set_collar_screw_washer_dia = m3_washer_dia;
set_collar_screw_hex_wrench_dia = m3_hex_wrench_dia;

x_idler_bolt_dia = m4_screw_dia;
x_idler_bolt_wrench = m4_screw_head_wrench;
x_idler_bolt_head = m4_screw_head_wrench_length;
x_idler_bolt_washer_dia = m4_washer_dia;
x_idler_bolt_washer_thickness = m4_washer_thickness;
x_idler_bolt_nut_height = m4_nut_height;
x_idler_bolt_head_flange_dia = m4_screw_head_flange_dia;

y_idler_bolt_dia = m8_screw_dia;
y_idler_bolt_head_wrench = m8_screw_head_wrench;
y_idler_bolt_head_wrench_length = m8_screw_head_wrench_length;
y_idler_bolt_washer_dia = m8_washer_dia;
y_idler_bolt_washer_thickness = m8_washer_thickness;
y_belt_arbor_dia = 8;
y_end_frame_dist_top = 65;

z_rod_dist = 120;
z_spindle_dia = 8;						// 8x15mm
z_spindle_nut_height = 12;				// 8x15mm
z_spindle_nut_dia = 18;
z_spindle_nut_screw_dia = m3_screw_dia;	// M3 grub screw
z_spindle_nut_screw_nut_wrench = m3_nut_wrench;
z_spindle_nut_screw_nut_height = m3_nut_height;

z_rod_clamp_screw_dia = m4_screw_dia;
z_rod_clamp_screw_length = 20;
z_rod_clamp_nut_wrench = m4_nut_wrench;
z_rod_clamp_nut_height = m4_nut_height;

z_bed_bolt_screw_dia = m4_screw_dia;
z_bed_bolt_screw_washer_dia = m4_washer_dia;
z_bed_bolt_clamp_screw_dia = m4_screw_dia;
z_bed_bolt_clamp_screw_nut_wrench = m4_nut_wrench;
z_bed_bolt_clamp_screw_nut_height = m4_nut_height;

extruder_drivegear_dia = 13;
extruder_drivegear_filament_insection = 0.2;		// how deep the teeth grab into the filament
extruder_hotend_insulator_countersink = 20;
extruder_hotend_insulator_groove_pos = 15;		// dist from insulator-top down to groove
extruder_hotend_insulator_dia = 10;
extruder_hotend_heatsink_width = 15;
extruder_hotend_heatsink_watercooler_thickness = 5;
extruder_hotend_heatsink_watercooler_steelball_dia = 3;
extruder_hotend_mount_screw_dia = m3_screw_dia;
extruder_hotend_mount_screw_nut_wrench = m3_nut_wrench;
extruder_hotend_mount_screw_nut_height = m3_nut_height;
extruder_mount_screw_dia = m4_screw_dia;
extruder_mount_screw_washer_dia = m4_washer_dia;
extruder_mount_screw_nut_height = m4_nut_height;
extruder_mount_screw_nut_wrench = m4_nut_wrench;
extruder_idler_bearing_screw_dia = m4_screw_dia;
extruder_idler_bearing_screw_nut_wrench = m4_nut_wrench;
extruder_idler_bearing_screw_nut_height = m4_nut_height;
extruder_idler_hinge_screw_dia = m4_screw_dia;
extruder_idler_hinge_screw_length = 50;
extruder_idler_hinge_screw_nut_height = m4_locknut_height;	// locknut!
extruder_idler_hinge_screw_washer_dia = m4_washer_dia;
extruder_idler_hinge_screw_head_wrench = m4_screw_head_wrench;
extruder_idler_hinge_screw_head_wrench_length = m4_screw_head_wrench_length;
extruder_idler_spring_dia = 8;
extruder_idler_spring_tensioner_screw_dia = m4_screw_dia;
extruder_idler_spring_tensioner_screw_nut_wrench = m4_nut_wrench;
extruder_idler_spring_tensioner_screw_nut_height = m4_nut_height;
extruder_idler_spring_tensioning_range = 15;		// tensioning range plus 8mm diameter bolt length (8-10mm..) for pushing the spring
extruder_cablechain_mount_screw_washer_dia = m4_washer_dia;
extruder_cablechain_mount_screw_dia = m4_screw_dia;
extruder_cablechain_mount_screw_head_flange_dia = m4_screw_head_flange_dia;
extruder_cablechain_mount_screw_nut_height = m4_nut_height;
extruder_cablechain_mount_screw_nut_wrench = m4_nut_wrench;

// IGUS chain 200.03.075.0
x_cablechain_mount_screw_dia = m6_screw_dia;
x_cablechain_mount_nut_wrench = m6_nut_wrench;
x_cablechain_mount_nut_height = m6_nut_height;
x_cablechain_mount_hole_dist = 25;
x_cablechain_width_outside = 55;				// max.
x_cablechain_width_inside = 38;
x_cablechain_height_outside = 35;
x_cablechain_height_inside = 25;
x_cablechain_dividers = 2;

// DEPRECATED in v1.1.0, replaced by IGUS cablechain, new dimensions and parameters above
// x_cablechain_wall = 3;
// x_cablechain_width = 45;				// inner dimensions!
// x_cablechain_height = 20;				// inner dimensions!
// x_cablechain_additional_length = 5;
// x_cablechain_dividers = 2;
// x_cablechain_mount = 1;					// mount = 0 for one screw; mount = 1 for two screws

// DEPRECATED in v1.1.0, drop-in replacement by IGUS chains, dimensions left for mounting point compatibility
y_cablechain_wall = 2;
y_cablechain_width = 25;				// inner dimensions!
y_cablechain_height = 15;				// inner dimensions!
y_cablechain_additional_length = 5;
y_cablechain_dividers = 1;
y_cablechain_mount = 0;					// mount = 0 for one screw; mount = 1 for two screws
y_cablechain_rail_profile_side = 10;			// aluminium square profile
y_cablechain_rail_profile_length = frame_extrusion_length_horizontal+10;	// 550

// DEPRECATED in v1.1.0, drop-in replacement by IGUS chains, dimensions left for mounting point compatibility
z_cablechain_wall = 2;
z_cablechain_width = 20;				// inner dimensions!
z_cablechain_height = 15;				// inner dimensions!
z_cablechain_additional_length = 0;
z_cablechain_dividers = 0;
z_cablechain_mount = 0;					// mount = 0 for one screw; mount = 1 for two screws

x_belt_pulley_teeth = 18;		// T5: 18; T2.5: 33
x_motor_pulley_teeth = 18;		// T5: 18; T2.5: 33
y_belt_pulley_teeth = 18;		// T5: 18; T2.5: 33
y_motor_pulley_teeth = 12;		// T5: 12; T2.5: 22
z_belt_pulley_teeth = 18;		// T5: 18; T2.5: 33
z_motor_pulley_teeth = 12;		// T5: 12; T2.5: 22

y_belt_pulley_dia = 27.8007;		// pulley outer diameter, get from ECHO in parametric_pulleys.scad; T5: 27.8007; T2.5: 25.7363
x_belt_pulley_dia = 27.8007;		// pulley outer diameter, get from ECHO in parametric_pulleys.scad; T5: 27.8007; T2.5: 25.7363
z_belt_pulley_dia = 27.8007;		// pulley outer diameter, get from ECHO in parametric_pulleys.scad; T5: 27.8007; T2.5: 25.7363

controller_touchscreen_width = 269.37;
controller_touchscreen_height = 171.97;
controller_touchscreen_cornerradius = 11.3;
controller_touchscreen_glassthickness = 1;
controller_touchscreen_thickness = 13.5;
controller_touchscreen_glasssideclearance_bottom = 10;
controller_touchscreen_glasssideclearance_top = 10;
controller_touchscreen_glasssideclearance_side = 10;
controller_touchscreen_connector_clearance_width = 40;
controller_touchscreen_connector_clearance_height = 25;
controller_touchscreen_connector_clearance_pos_x = 78;
controller_touchscreen_connector_clearance_pos_y = 35;
controller_touchscreen_housing_back_thickness = 3;		// dibond
controller_touchscreen_housing_back_screw_dia = m3_screw_dia;
controller_touchscreen_housing_back_screw_nut_wrench = m3_nut_wrench;
controller_touchscreen_housing_back_screw_nut_height = m3_nut_height;
controller_touchscreen_housing_mount_side = 40;
controller_touchscreen_cable_clearance_dia = 20;
controller_touchscreen_cable_dia = 8;
controller_power_button_hole_dia = 15.75;
controller_ethernet_coupling_width_front = 14.5;
controller_ethernet_coupling_width_back = 18.6;
controller_ethernet_coupling_height_front = 16.5;
controller_ethernet_coupling_height_back = 19;
controller_ethernet_coupling_panel_thickness = 1.5;
controller_ethernet_coupling_panel_front_dist = 8.2;
controller_touchscreen_adapterpcb_width = 52;
controller_touchscreen_adapterpcb_height = 30;
controller_touchscreen_adapterpcb_thickness = 1.6;
controller_touchscreen_adapterpcb_clearance_bottom = 10;
controller_touchscreen_adapterpcb_clearance_corner = 5;
controller_touchscreen_adapterpcb_clearance_hdmi = 15;
controller_touchscreen_adapterpcb_clearance_display = 38;
controller_beagleboneblack_width = 86.36;
controller_beagleboneblack_height = 54.61;
controller_beagleboneblack_hole_left_bottom_pos_z = 3.175;
controller_beagleboneblack_hole_left_top_pos_z = 51.435;
controller_beagleboneblack_hole_right_bottom_pos_z = 6.35;
controller_beagleboneblack_hole_right_top_pos_z = 48.26;
controller_beagleboneblack_screw_dia = m3_screw_dia;
controller_beagleboneblack_screw_nut_height = m3_nut_height;
controller_beagleboneblack_screw_nut_wrench = m3_nut_wrench;

mainboard_width = 135;			// RUMBA
mainboard_height = 75;			// RUMBA
mainboard_hole_left_bottom_pos_z = 36;
mainboard_hole_left_top_pos_z = 71.5;
mainboard_hole_right_bottom_pos_z = 3.5;
mainboard_hole_right_top_pos_z = 71.5;
mainboard_screw_dia = m3_screw_dia;
mainboard_screw_nut_height = m3_nut_height;
mainboard_screw_nut_wrench = m3_nut_wrench;

watercooling_radiator_fan_side = 119;
watercooling_radiator_fan_dia = 125;
watercooling_radiator_fan_cutout_side = 116;
watercooling_radiator_fan_hole_dist = 104.8;
watercooling_radiator_fan_screw_dia = m3_screw_dia;
watercooling_pump_screw_dia = m4_screw_dia;
watercooling_pump_hole_dist_x = 25;
watercooling_pump_hole_dist_z = 25;
watercooling_pump_height = 130;
watercooling_pump_width = 50;
watercooling_pump_mount_pos_z = 42.5;
watercooling_cooler_side = 15;

power_supply_screw_dia = 3.505;		// #6 - 32 UNC
power_supply_width = 150;				// atx 2.2
power_supply_height = 86;				// atx 2.2
power_supply_cutout_edge_dist = 3;
power_supply_hole_cutout_edge_dist = 5;
power_supply_hole_edge_dist = 6;		// hole center distance from psu edge
power_supply_hole_bottom_left_z_shift = 10;
power_supply_hole_bottom_right_x_shift = -24;

filament_feed_dust_cleaner_foam_side = 15;		// 20x20x15mm foam insert
filament_feed_quick_connector_dia = 10;
filament_feed_quick_connector_countersink = 8.2;
filament_feed_sensor_height = 50;
filament_feed_sensor_thickness = 7.5;
filament_feed_sensor_hole_pos = 3.3;			// distance from top
filament_feed_sensor_hole_pos_v = 3;			// distance from side
filament_feed_sensor_hole_dist = 19;
filament_feed_sensor_bottomsolderjoint_pos = 28;	// distance from top
filament_feed_sensor_bottomsolderjoint_thickness = 1.5;
filament_feed_sensor_screw_dia = m3_screw_dia;
filament_feed_sensor_screw_washer_dia = m3_washer_dia;
filament_feed_sensor_screw_nut_wrench = m3_nut_wrench;
filament_feed_sensor_screw_nut_height = m3_nut_height;
filament_feed_sensor_flag_width = 4;
filament_feed_sensor_flag_center_pos = 4.5;		// distance pcb bottom - flag center
filament_feed_sensor_dist_min = 1;	
filament_feed_sensor_wire_harness_width = 10;	// for feedthrough hole in enclosure
filament_feed_sensor_wire_harness_height = 3;

led_hole_dist = 45.9;
led_screw_dia = m3_screw_dia;
led_screw_nut_wrench = m3_nut_wrench;
led_screw_nut_height = m3_nut_height;

wiper_brush_shaft_length = 38;
wiper_brush_shaft_dia = 3.15;

set_collar_body_dia = 22.4;			// diameter incl. clearance for screw head when rotating
set_collar_body_height = 9;
set_collar_screw_pos_radius = 6.5;

wiper_bin_dia = 60;     // beaker glass high type, DIN 12331, ISO 3819
wiper_bin_dia_clampreduction = 0.5;
wiper_bin_edge_dia = 67;
wiper_bin_edge_height = 10;
wiper_bin_clearance_angle = 150;
wiper_bin_wallthickness = 2;
wiper_width = 25;       // silicone wiping element
wiper_thickness = 5;    // silicone wiping element
wiper_height = 30;      // silicone wiping element
wiper_excess_height = 15;
wiper_compression = 0.5;
wiper_bin_holder_height = 6;
wiper_bin_holder_width = 6;
wiper_bin_ypos = -10;

IDfonttype = "DIN 1451 Mittelschrift";
IDfontsize = 4;


///// CALCULATIONS //////////////////////////////////

belt_tensioner_width = max(belt_tensioning_screw_head_wrench+2*clearance+2*wall,(wall+clearance+belt_thickness_max+belt_thickness_min)*2);
belt_tensioner_height = max(wall+clearance+belt_width, cornerdiameter(belt_tensioning_screw_head_wrench)+2*clearance+2*wall);
belt_tensioner_length = (belt_grip_length+0.5)*belt_tooth_periode+wall+3*clearance+2*belt_tensioning_screw_head_wrench_length+2*wall;

x_rod_dist = x_belt_pulley_dia+2*belt_tensioner_width/2+2*wall_thin+2*wall+2*clearance+linear_bearing_dia;

x_end_body_length = max((2*linear_bearing_length + 2*clearance + linear_bearing_dist_min),(x_rod_dist+rod_dia+2*clearance+2*wall));
x_end_body_height = wall+clearance+linear_bearing_dia+clearance+wall+clearance+rod_dia+clearance+2*wall;
x_end_body_width = wall+clearance+belt_tensioning_screw_dia/2+belt_tensioner_height/2+wall_thin+wall+clearance+linear_bearing_dia+clearance+wall;
x_end_body_width_motor_addition = wall_thin+clearance+nema17_screw_hex_wrench_dia/2+nema17_screw_dia/2+clearance;

y_end_body_width = rod_dia+2*wall+2*clearance;
y_end_body_height = wall+clearance+frame_screw_dia+clearance+wall_thin+clearance+rod_dia+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall;
y_end_body_length = frame_width;

y_rod_y_belt_x_dist = belt_tensioner_height/2+wall_thin+wall+clearance+linear_bearing_dia/2;
y_rod_y_belt_arbor_dist = rod_dia/2+clearance+wall+clearance+bearing_dia/2;

y_belt_pulley_width = (belt_width + 2*belt_width_clearance) + 2*belt_pulley_retainer_width;
x_belt_pulley_width = y_belt_pulley_width;

extruder_back_body_width = nema17_width;
extruder_back_body_height = nema17_width;
extruder_back_body_length = wall+nema17_gearbox_length;

extruder_front_body_width = extruder_back_body_width;
extruder_front_body_height = extruder_back_body_height/2+extruder_hotend_insulator_countersink-(nema17_width/2-bearing_dia/2-wall_thin);
extruder_front_body_length = wall+wall_thin+bearing_width+wall_thin+wall+clearance+wall;

extruder_idler_body_length = extruder_front_body_length;

x_carriage_body_length = 2*extruder_back_body_width;
x_carriage_body_width = x_rod_dist+linear_bearing_dia+2*clearance+2*wall;
x_carriage_body_height = linear_bearing_dia+2*clearance+2*wall;

y_end_body_width_idler_addition = y_rod_y_belt_x_dist-y_end_body_width/2-2*y_idler_bolt_washer_thickness-bearing_width/2;
y_end_body_length_arbor_addition = max(0,(wall+wall_thin+y_belt_pulley_dia/2+bearing_dia/2+clearance+wall)-frame_width);

bed_corner_body_height = wall+(bed_clamp_angle_thickness+wall_thin)+wall_thin+bed_heatbed_thickness+bed_surface_thickness;
bed_corner_body_width = wall+wall_thin+bed_clamp_length+wall_thin+wall;
bed_corner_body_length = bed_clamp_angle_length+wall_thin;

bed_leveling_mount_body_height = wall+clearance+bed_leveling_rod_end_bearing_screw_dia/2+bed_leveling_rod_end_bearing_dia/2+wall_thin+bed_siliconeheater_thickness;

// Deprecated in V1.1.0; replaced by steel clamp collar, dimensions set under PARAMETERS above now
// set_collar_body_dia = z_spindle_dia + 2*wall+ 6*clearance + 2*set_collar_screw_dia;
// set_collar_body_height = set_collar_screw_washer_dia + 2*wall + 2*clearance;

z_end_body_width = z_rod_dist+rod_dia+2*clearance+2*wall;
z_end_body_height = frame_width;
z_end_body_length = wall+(set_collar_body_dia/2+wall_thin)+rod_dia/2+clearance+wall;

air_heater_top_body_width = air_heater_uprofile_width+2*clearance+2*wall_thin;
air_heater_top_body_length = air_heater_uprofile_height+2*clearance+2*wall_thin;
air_heater_top_body_height = 2*wall+clearance+2*wall;

air_heater_bottom_body_width = air_heater_uprofile_width+2*clearance+2*wall_thin;
air_heater_bottom_body_length = air_heater_uprofile_height+clearance+wall_thin;
air_heater_bottom_body_height = air_heater_uprofile_height-2*air_heater_uprofile_thickness+wall_thin+wall+clearance+wall;

frame_corner_body_height = frame_width+frame_enclosure_thickness+clearance+3*wall;
frame_corner_body_side = 2*frame_width+frame_enclosure_thickness+clearance+wall;

frame_enclosure_door_handle_body_height = 2*frame_width;
frame_enclosure_door_handle_body_width = frame_width;
frame_enclosure_door_handle_body_length = frame_door_handle_finger_clearance+2*wall;

z_elevator_body_height = 2*linear_bearing_length+2*clearance+linear_bearing_dist_min;
z_elevator_body_width = 2*(z_rod_dist/2+linear_bearing_dia/2+clearance+wall);
z_elevator_body_length = 2*frame_width;

cablechain_mount_y_frame_body_width = (y_cablechain_width+4*y_cablechain_wall+2*clearance+y_cablechain_dividers*wall_thin);
cablechain_mount_y_frame_body_height = wall+clearance+y_cablechain_rail_profile_side+clearance+wall;
cablechain_mount_y_frame_body_length = frame_width;

cablechain_mount_z_elevator_body_width = (z_rod_dist/2-linear_bearing_dia/2-clearance-wall_thin+wall)+(z_cablechain_width+4*z_cablechain_wall+2*clearance+z_cablechain_dividers*wall_thin)/2;
cablechain_mount_z_elevator_body_length = wall+clearance+frame_screw_dia+clearance+wall;

cablechain_mount_extruder_body_width = frame_width;
cablechain_mount_extruder_body_length = x_carriage_body_width-wall-clearance;
cablechain_mount_extruder_body_height = -clearance-extruder_back_body_height-clearance-wall-clearance-linear_bearing_dia/2+(linear_bearing_dia/2+clearance+wall+clearance+rod_dia/2)+(rod_dia/2+clearance+wall+clearance+bearing_dia+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top+wall;

controller_touchscreen_housing_body_length = controller_touchscreen_thickness-controller_touchscreen_glassthickness+wall_thin+controller_touchscreen_housing_back_thickness;
controller_touchscreen_housing_body_width = controller_touchscreen_width;
controller_touchscreen_housing_body_height = controller_touchscreen_height;

controller_touchscreen_housing_mount_body_side = controller_touchscreen_housing_mount_side;
controller_touchscreen_housing_mount_body_length = wall+sin(45)*controller_touchscreen_housing_body_height/2+controller_touchscreen_housing_mount_body_side/2;

controller_ethernet_coupling_panel_body_width = controller_ethernet_coupling_width_front+2*clearance+2*(wall+clearance+frame_screw_dia+clearance+wall);
controller_ethernet_coupling_panel_body_height = controller_ethernet_coupling_height_back+2*clearance+4*wall;
controller_ethernet_coupling_panel_body_length = max((controller_ethernet_coupling_panel_front_dist-frame_enclosure_thickness+controller_ethernet_coupling_panel_thickness),(wall+clearance+frame_screw_nut_height));

pcb_mount_body_length = 2*frame_width;
pcb_mount_body_width = wall+clearance+frame_screw_dia+clearance+wall;

frame_enclosure_angle_body_width = wall+clearance+frame_screw_dia+clearance+wall;
frame_enclosure_angle_body_height = frame_width/2-frame_enclosure_thickness+frame_screw_dia/2+clearance+wall;
frame_enclosure_angle_body_length = frame_width/2+frame_screw_dia/2+clearance+wall;

spool_mount_endcap_body_width = frame_width_small+2*clearance+2*wall;
spool_mount_endcap_body_height = 2*wall+clearance+frame_width+clearance+wall;
spool_mount_endcap_body_length = 3*wall;

frame_small_mount_body_width = 2*(wall_thin+clearance+frame_screw_washer_dia+clearance+wall_thin+clearance+frame_width_small/2);
frame_small_mount_body_height = frame_width;
frame_small_mount_body_length = frame_screw_head_length+clearance+wall+clearance+frame_center_screw_head_length;

air_filter_fan_duct_body_width = 2*(air_filter_fan_hole_dist/2+air_filter_fan_screw_washer_dia/2+clearance+wall_thin+clearance+frame_screw_dia/2+frame_screw_washer_dia/2+clearance+wall_thin);
air_filter_fan_duct_body_length = frame_width;
air_filter_fan_duct_body_height = air_filter_fan_side+2*wall;		// fan duct

air_filter_activatedcarbon_container_body_height = wall+air_filter_activatedcarbon_size+wall;
air_filter_activatedcarbon_container_body_width = air_filter_fan_duct_body_width;
air_filter_activatedcarbon_container_body_length = air_filter_fan_duct_body_length;
air_filter_activatedcarbon_container_grid_bar = wall_thin;

z_bed_bolt_dist = 2*(z_rod_dist/2-linear_bearing_dia/2-clearance+cornerdiameter(bed_leveling_rod_end_bearing_shaft_wrench)/2);					// equilateral triangle side length
z_bed_bolt_radius = (((sqrt(3))/3)*z_bed_bolt_dist);			// equilateral triangle circumcircle radius

z_bed_mount_body_height = frame_width+2*clearance+2*wall;
z_bed_mount_body_width = 2*(z_bed_bolt_dist/2+z_bed_bolt_screw_dia/2+wall_thin+wall_thin+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall);
z_bed_mount_body_length = wall+clearance+z_bed_bolt_clamp_screw_nut_height+clearance+wall_thin+wall_thin+z_bed_bolt_screw_dia/2+(3/2*z_bed_bolt_radius)+cornerdiameter(bed_leveling_rod_end_bearing_shaft_wrench)/2+wall_thin+wall_thin;

z_motor_mount_body_width = nema17_width;
z_motor_mount_body_length = nema17_width;
z_motor_mount_body_height = nema17_shaft_length+wall_thin;

frame_enclosure_cable_feedthrough_body_side = frame_width+wall;
frame_enclosure_cable_feedthrough_body_height = wall_thin+clearance+frame_enclosure_thickness+clearance+wall_thin;

air_heater_mosfetboard_mount_body_width = wall+clearance+frame_screw_dia+clearance+wall;
air_heater_mosfetboard_mount_body_length = 2*frame_width;

y_motor_mount_body_width = nema17_length*0.75;
y_motor_mount_body_length = 2*wall+nema17_width+wall;
y_motor_mount_body_height = nema17_width+2*wall+wall+frame_width;

filament_feed_body_length = wall+wall_thin+filament_feed_dust_cleaner_foam_side+wall_thin+wall;
filament_feed_body_width = 2*(frame_center_screw_dia/2+clearance+wall_thin+filament_feed_dust_cleaner_foam_side+wall);
filament_feed_body_height = filament_feed_quick_connector_countersink+clearance+2*wall+clearance+filament_feed_sensor_height+clearance+wall+filament_feed_dust_cleaner_foam_side;

y_endstop_magnet_mount_body_width = rod_dia+2*wall+2*clearance_tight;
y_endstop_magnet_mount_body_height = wall+clearance+frame_screw_dia+clearance+wall_thin+clearance_tight+rod_dia/2+linear_bearing_dia/2+clearance+wall+clearance+endstop_screw_nut_height+clearance+wall+endstop_magnet_dia/2+clearance+wall;
y_endstop_magnet_mount_body_length = wall+clearance+frame_screw_nut_wrench+clearance+wall;

led_mount_body_height = wall+clearance+led_screw_dia/2+led_hole_dist+led_screw_nut_wrench/2+clearance+wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin;

y_arbor_frame_back_dist = (frame_extrusion_length_horizontal-frame_back_dist-frame_width)-((bearing_dia/2+clearance+wall+clearance+frame_screw_dia+clearance+wall)+y_end_frame_dist_top);
y_arbor_support_body_height = y_arbor_frame_back_dist+bearing_dia/2+clearance+wall;
y_arbor_support_body_width = wall_thin+clearance+frame_screw_head_flange_dia+clearance+wall_thin;
