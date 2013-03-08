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

include <functions.scad>

////////// PARAMETERS ////////////////////////////////////////////////////////////

$fa=1;
$fs=0.5;

filament_dia = 3;
filament_tube_dia = 6;			// inner dia: 4

m3_screw_dia = 3;						// M3
m3_screw_head_dia = 5.5;			// M3 inbus
m3_screw_head_length = 3;			// M3 inbus
m3_nut_wrench = 5.5;				// M3
m3_nut_height = 2.4;				// M3
m3_washer_dia = 7;				// M3

m4_screw_dia = 4;						// M4
m4_screw_head_dia = 7;				// M4 inbus
m4_screw_head_length = 4;				// M4 inbus
m4_screw_head_wrench = 7;				// M4 hex head
m4_screw_head_wrench_length = 2.8;		// M4 hex head
m4_washer_dia = 9;				// M4
m4_washer_thickness = 0.8;		// M4
m4_nut_wrench = 7;				// M4
m4_nut_height = 3.2;				// M4

m8_screw_dia = 8;
m8_screw_head_wrench = 13;
m8_screw_head_wrench_length = 5.3;
m8_washer_dia = 16;
m8_washer_thickness = 1.6;

clearance = 0.2;
layer_height = 0.25;
nozzle_dia = 0.35;

rod_dia = 12;
linear_bearing_dia = 21;					// LM12UU
linear_bearing_length = 30;				// LM12UU
linear_bearing_dist_min = 5;
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
nema17_screw_washer_dia = m3_washer_dia;			// M3
nema17_pulley_base = 8;
nema17_shaft_length = 22;
nema17_shaft_dia = 5;
nema17_gearbox_dia = 36;
nema17_gearbox_length = 30;
nema17_gearbox_center_dia = 22;
nema17_gearbox_center_pitch = 2;
nema17_gearbox_shaft_length = 18;

frame_screw_dia = m4_screw_dia;
frame_screw_head_dia = m4_screw_head_dia;
frame_screw_head_length = m4_screw_head_length;
frame_screw_length = 10;
frame_screw_washer_dia = m4_washer_dia;
frame_screw_washer_thickness = m4_washer_thickness;
frame_screw_nut_wrench = m4_nut_wrench;
frame_screw_nut_height = m4_nut_height;
frame_width = 20;						// TS20-20B
frame_groove_width = 6;				// TS20-20B slot-width
frame_groove_depth = 5.5;				// TS20-20B
frame_groove_nut_length = cornerdiameter(frame_screw_nut_wrench+2*clearance)+2*wall;
frame_center_hole_dia = 5.5;				// TS20-20B
//frame_groove_innerwidthtop = 11.9;
//frame_groove_innerwidthbottom = 6;
//frame_groove_innerdepth = 4.2;
frame_enclosure_thickness = 4;
frame_enclosure_screw_length = 15;
frame_base_dist = 140;					// space between lower horizontal frame bars (electronics enclosure)
frame_foot_screw_dia = m4_screw_dia;
frame_foot_screw_head_wrench = m4_screw_head_wrench;
frame_foot_screw_head_wrench_length = m4_screw_head_wrench_length;
frame_foot_screw_nut_wrench = m4_nut_wrench;
frame_foot_screw_nut_height = m4_nut_height;

belt_width = 6;						// T5 belt, 6mm width
belt_thickness_min = 1;				// 1
belt_thickness_max = 1+1.2;		// min+1.2
belt_tooth_periode = 5;				// T5
belt_tensioning_range = 15;
belt_tensioning_screw_dia = m4_screw_dia;
belt_tensioning_screw_head_dia = m4_screw_head_dia;
belt_tensioning_screw_head_wrench = m4_screw_head_wrench;		// hex head screw
belt_tensioning_screw_head_wrench_length = m4_screw_head_wrench_length;		// hex head screw
belt_tensioning_screw_head_length = m4_screw_head_length;
belt_tensioning_screw_length = 50;
belt_tensioning_washer_dia = m4_washer_dia;
belt_tensioning_washer_thickness = m4_washer_thickness;
belt_tensioning_nut_wrench = m4_nut_wrench;
belt_tensioning_nut_height = m4_nut_height;
belt_width_clearance = 0.5;
belt_pulley_retainer_width = 1;

endstop_hole_dist = 17;
endstop_hole_sensor_dist = 9;
endstop_screw_dia = m3_screw_dia;
endstop_screw_washer_dia = m3_washer_dia;
endstop_screw_nut_wrench = m3_nut_wrench;
endstop_screw_nut_height = m3_nut_height;

bed_bottom_side = 220;			// aluminium composite board (like DiBond)
bed_bottom_thickness = 3;			// aluminium composite board (like DiBond)
bed_insulation_thickness = 10+3;	// rubber foam mat like Armacell Armaflex, plus 3mm heat expansion clearance
bed_heatbed_thickness = 1.65;
bed_heatbed_side = 214;
bed_glass_thickness = 3;
bed_glass_side = 210;
bed_surface_thickness = 1.5;		// FR4 (glass fibre epoxy laminate)
bed_surface_side = 210;
bed_clamp_width = 9;				// foldback clamps 25mm, max. clamp width 9mm
bed_clamp_length = 25;				// foldback clamps 25mm, max. clamp width 9mm
bed_clamp_angle_thickness = 3.5;
bed_corner_screw_dia = m4_screw_dia;
bed_corner_screw_nut_wrench = m4_nut_wrench;
bed_corner_screw_nut_height = m4_nut_height;

air_heating_fan_side = 80;
air_heating_fan_hole_dist = 71.5;		// 80x80mm fan
air_heating_fan_screw_dia = m3_screw_dia;
air_heating_fan_height = 22;				// set to zero when air heating assembly is mounted on the very top of the fan; set to fan height when mounted on level between fan and cooler

air_filter_fan_side = 80;
air_filter_fan_hole_dist = 71.5;		// 80x80mm fan
air_filter_fan_screw_dia = m4_screw_dia;
air_filter_fan_screw_washer_dia = m4_washer_dia;
air_filter_fan_screw_washer_thickness = m4_washer_thickness;
air_filter_fan_screw_head_length = m4_screw_head_length;
air_filter_fan_screw_head_dia = m4_screw_head_dia;
air_filter_fan_screw_nut_height = m4_nut_height;
air_filter_fan_screw_nut_wrench = m4_nut_wrench;

set_collar_screw_dia = m3_screw_dia;
set_collar_screw_nut_wrench = m3_nut_wrench;
set_collar_screw_washer_dia = m3_washer_dia;

spindle_coupling_screw_dia = m3_screw_dia;
spindle_coupling_screw_nut_wrench = m3_nut_wrench;
spindle_coupling_screw_washer_dia = m3_washer_dia;

frame_enclosure_door_hinge_bolt_dia = m4_screw_dia;
frame_enclosure_door_hinge_bolt_washer_thickness = m4_washer_thickness;
frame_enclosure_door_hinge_bolt_nut_wrench = m4_nut_wrench;
frame_enclosure_door_hinge_bolt_nut_height = m4_nut_height;

x_end_rod_setscrew_dia = m4_screw_dia;
x_end_rod_setscrew_nut_wrench = m4_nut_wrench;
x_end_rod_setscrew_nut_height = m4_nut_height;

x_idler_bolt_dia = m8_screw_dia;
x_idler_bolt_wrench = m8_screw_head_wrench;
x_idler_bolt_head = m8_screw_head_wrench_length;
x_idler_bolt_washer_dia = m8_washer_dia;
x_idler_bolt_washer_thickness = m8_washer_thickness;

y_idler_bolt_dia = m8_screw_dia;
y_idler_bolt_wrench = m8_screw_head_wrench;
y_idler_bolt_head = m8_screw_head_wrench_length;
y_idler_bolt_washer_dia = m8_washer_dia;
y_idler_bolt_washer_thickness = m8_washer_thickness;
y_belt_arbor_dia = 8;

z_spindle_dia = 8;
z_spindle_nut_wrench = 17;
z_spindle_nut_height = 15;
z_spindle_coupling_length = 55;		// coupling + collar
z_rod_dist = 100;
z_rod_frame_dist_min = 10;

z_bearing_clamp_screw_dia = m4_screw_dia;
z_bearing_clamp_screw_head_wrench = m4_screw_head_wrench;		// hex head screw
z_bearing_clamp_screw_head_wrench_length = m4_screw_head_wrench_length;		// hex head screw
z_bearing_clamp_nut_wrench = m4_nut_wrench;
z_bearing_clamp_nut_height = m4_nut_height;
z_bearing_clamp_washer_dia = m4_washer_dia;
z_bearing_clamp_washer_thickness = m4_washer_thickness;
z_rod_clamp_screw_dia = m4_screw_dia;
z_rod_clamp_screw_length = 20;
z_rod_clamp_nut_wrench = m4_nut_wrench;
z_rod_clamp_nut_height = m4_nut_height;

z_bed_bolt_screw_dia = m4_screw_dia;

extruder_gearbox_clamp_screw_dia = m4_screw_dia;
extruder_gearbox_clamp_screw_head_length = m4_screw_head_length;
extruder_gearbox_clamp_screw_nut_wrench = m4_nut_wrench;
extruder_gearbox_clamp_screw_nut_height = m4_nut_height;
extruder_gearbox_clamp_screw_washer_dia = m4_washer_dia;
extruder_gearbox_clamp_screw_washer_thickness = m4_washer_thickness;
extruder_drivegear_dia = 11.5+filament_dia;		// 11.5 = inner tooth dia
extruder_gearbox_drivegear_dist = 16.5;				// distance between gearbox mount-surface and center of drive gear groove/hobbing
extruder_hotend_insulator_countersink = 20;		// reprap-fab.org hotend V3
extruder_hotend_insulator_groove_pos = 15;		// reprap-fab.org hotend V3, dist from insulator-top down to groove
extruder_hotend_insulator_dia = 10;
extruder_hotend_mount_screw_dia = m3_screw_dia;
extruder_hotend_mount_screw_nut_wrench = m3_nut_wrench;
extruder_hotend_mount_screw_nut_height = m3_nut_height;
extruder_hotend_adapter_adjustment_range = 3;
extruder_mount_screw_nut_height = m4_nut_height;
extruder_mount_screw_nut_wrench = m4_nut_wrench;
extruder_mount_screw_dia = m4_screw_dia;
extruder_mount_screw_washer_dia = m4_washer_dia;
extruder_idler_screw_dia = m4_screw_dia;
extruder_idler_screw_washer_dia = m4_washer_dia;
extruder_idler_screw_nut_wrench = m4_nut_wrench;
extruder_idler_screw_nut_height = m4_nut_height;
extruder_filamenttube_countersink = 9;
extruder_filamenttube_dia = 6;			// = outer diameter (4mm inner dia)
extruder_filament_hole_clearance = 2*clearance;
extruder_watercoolingtube_dia = 5;		// = outer diameter (3mm inner dia)
extruder_cablechain_mount_screw_washer_dia = m4_washer_dia;
extruder_cablechain_mount_screw_dia = m4_screw_dia;
extruder_cablechain_mount_screw_nut_height = m4_nut_height;
extruder_cablechain_mount_screw_nut_wrench = m4_nut_wrench;

x_carriage_bearing_clamp_screw_dia = m4_screw_dia;
x_carriage_bearing_clamp_screw_length = 26;
x_carriage_bearing_clamp_screw_nut_wrench = m4_nut_wrench;
x_carriage_bearing_clamp_screw_nut_height = m4_nut_height;



////////// CALCULATIONS /////////////////////////////////////////////////////

frame_washer_wall = max(wall,frame_screw_washer_dia/2-(frame_screw_dia/2+clearance)+clearance);
//frame_angle_side = frame_washer_wall+2*clearance+frame_screw_dia+wall+clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+frame_washer_wall+wall;		// for frame-angle_small.scad
//frame_angle_side = wall+clearance+frame_screw_dia/2+frame_screw_washer_dia/2+wall+frame_screw_washer_dia+clearance+(2*wall+(frame_screw_dia+2*clearance)+(((frame_screw_dia/2+clearance)+wall)/sin(45))+((frame_screw_dia/2+clearance)/sin(45)-(frame_screw_dia/2+clearance)));
frame_angle_width = frame_width-frame_enclosure_thickness-clearance;		// two screws for each side - OLD
frame_angle_side = wall+clearance+frame_screw_dia/2+frame_screw_washer_dia/2+clearance+(2*wall+(frame_screw_dia+2*clearance)+(((frame_screw_dia/2+clearance)+wall)/sin(45))+((frame_screw_dia/2+clearance)/sin(45)-(frame_screw_dia/2+clearance)));
frame_angle_width = frame_width-frame_enclosure_thickness-clearance;		// one screw for each side - NEW

x_rod_dist = nema17_width+4*clearance+2*wall+rod_dia;
x_rod_belt_dist = rod_dia/2+1+clearance+2*wall+clearance+2*x_idler_bolt_washer_thickness+bearing_width/2;

x_end_body_length = max((2*linear_bearing_length + 2*clearance + linear_bearing_dist_min),(x_rod_dist+rod_dia+2+2*clearance+2*wall));
x_end_body_height = wall+linear_bearing_dia+2*clearance+wall+rod_dia+2+2*clearance+wall;
x_end_body_width = wall+linear_bearing_dia+2*clearance+wall+clearance+x_idler_bolt_dia/2+cornerdiameter(x_idler_bolt_wrench)/2+wall;

belt_tensioner_width = max(belt_tensioning_screw_head_wrench+2*clearance+2*wall,(wall+clearance+belt_thickness_max+belt_thickness_min)*2);
belt_tensioner_height = max(wall+clearance+belt_width, cornerdiameter(belt_tensioning_screw_head_wrench)+2*clearance+2*wall);
belt_tensioner_length = 4.5*belt_tooth_periode+wall+3*clearance+2*belt_tensioning_screw_head_wrench_length+2*wall;

// temporary x end variable compatibility
nema17_hole_dia = nema17_screw_dia;

y_belt_pulley_dia = bearing_dia+2*clearance+2*wall_thin; // inner diameter for pulley, outer diameter for idler
y_belt_arbor_frame_enclosure_dist = wall + belt_thickness_max + y_belt_pulley_dia/2;
y_end_body_width = rod_dia+2*wall+2*clearance;
y_end_body_height = frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall+rod_dia+2*clearance+wall+bearing_dia+2*clearance+frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall;
//y_end_body_length = (bearing_dia+2*clearance+frame_washer_wall+frame_screw_dia+2*clearance+frame_washer_wall)+frame_width-frame_enclosure_thickness-clearance;
y_end_body_length = y_belt_arbor_frame_enclosure_dist-clearance+bearing_dia/2+clearance+wall;
y_rod_y_belt_x_dist = linear_bearing_dia/2+clearance+wall+clearance+x_idler_bolt_dia/2;
y_rod_y_belt_arbor_dist = rod_dia/2+clearance+wall+clearance+bearing_dia/2;

x_belt_pulley_dia = y_belt_pulley_dia;

y_belt_pulley_width = (belt_width + 2*belt_width_clearance) + 2*belt_pulley_retainer_width;
x_belt_pulley_width = y_belt_pulley_width;

z_rod_frame_enclosure_dist = y_belt_arbor_frame_enclosure_dist + y_belt_arbor_dia/2 + wall + rod_dia/2;

z_bottom_body_length = z_rod_frame_enclosure_dist-clearance+rod_dia/2+clearance+wall;
z_bottom_body_width = z_rod_dist + rod_dia + 2*clearance + 2*wall;
z_bottom_body_height = frame_width-clearance-frame_enclosure_thickness + clearance+wall+clearance+bearing_width;

z_top_body_length = z_rod_frame_enclosure_dist+frame_enclosure_thickness-frame_width-clearance+rod_dia/2+clearance+wall;
z_top_body_width = z_bottom_body_width;
z_top_body_height = frame_width-clearance-frame_enclosure_thickness;

z_spindle_bearing_body_width = z_rod_dist+rod_dia+2*clearance+2*wall;
z_spindle_bearing_body_length = wall+2*clearance+rod_dia+wall+2*clearance+z_rod_clamp_screw_dia+wall;
z_spindle_bearing_body_height = max(2*wall+2*clearance+z_rod_clamp_nut_wrench,wall+clearance+bearing_width);

z_motor_body_width = z_spindle_bearing_body_width;
z_motor_body_length = z_spindle_bearing_body_length;
z_motor_body_height = z_spindle_bearing_body_height;


extruder_idler_width = 2*extruder_gearbox_drivegear_dist;			// TO BE CALCULATED!!
extruder_back_body_width = max((nema17_gearbox_dia+2*clearance+2*wall),(nema17_width));
extruder_back_body_height = (nema17_gearbox_dia/2+clearance+wall+clearance+extruder_gearbox_clamp_screw_dia/2+extruder_gearbox_clamp_screw_washer_dia/2+clearance+wall)+nema17_width/2+clearance+extruder_mount_screw_nut_height+clearance+wall;
extruder_drivegear_elevation = nema17_width/2+clearance+extruder_mount_screw_nut_height+clearance+wall;

//extruder_front_body_z_addition_bottom = clearance+wall+2*clearance+extruder_mount_screw_dia+wall;
extruder_front_body_z_addition_bottom = wall+clearance+extruder_mount_screw_dia+clearance+wall+extruder_hotend_adapter_adjustment_range;
extruder_front_body_width = extruder_back_body_width;
extruder_front_body_height = extruder_back_body_height + extruder_front_body_z_addition_bottom;
extruder_front_body_length = extruder_gearbox_drivegear_dist+ bearing_width/2+clearance+wall_thin+wall+clearance+wall+wall;
//extruder_front_body_length = extruder_gearbox_drivegear_dist+ bearing_width/2+wall_thin+wall+2*clearance+extruder_idler_screw_dia+wall;

extruder_hotend_body_width = extruder_front_body_width;
extruder_hotend_body_height = extruder_hotend_insulator_countersink+clearance;
extruder_hotend_body_length = extruder_front_body_length;


x_carriage_body_length = max(2*extruder_back_body_width,(2*linear_bearing_length+2*clearance+linear_bearing_dist_min));
x_carriage_body_width = x_rod_dist+linear_bearing_dia+2*clearance+2*wall;
x_carriage_body_height = linear_bearing_dia+2*clearance+2*wall;
x_carriage_body_y_addition = extruder_mount_screw_dia+2*clearance+frame_washer_wall;
//x_carriage_body_z_addition_bottom = x_carriage_bearing_clamp_screw_dia+2*clearance+frame_washer_wall;
x_carriage_body_z_addition_bottom = 0;
//x_carriage_body_z_addition_bottom = (x_rod_belt_dist+belt_tensioning_screw_dia/2+clearance+wall)-x_carriage_body_height/2;
//x_carriage_body_z_addition_top = wall;
x_carriage_body_z_addition_top = 0;

y_end_body_width_idler = y_rod_y_belt_x_dist-y_end_body_width/2-2*clearance-y_idler_bolt_washer_thickness-bearing_width/2;

extruder_back_body_length = x_carriage_body_y_addition+wall+2*clearance+linear_bearing_dia+wall+2*clearance+x_carriage_bearing_clamp_screw_dia+frame_washer_wall+wall+clearance+extruder_mount_screw_washer_dia/2+extruder_mount_screw_nut_wrench/2+clearance+wall+clearance;

bed_corner_body_height = bed_insulation_thickness+bed_heatbed_thickness+bed_glass_thickness+bed_surface_thickness + clearance+bed_bottom_thickness;
bed_corner_body_side = wall+clearance+ (bed_bottom_side-bed_surface_side)/2-wall_thin + (wall_thin + bed_clamp_length + wall_thin) + wall;

set_collar_body_dia = z_spindle_dia + 2*wall+ 6*clearance + 2*set_collar_screw_dia;
set_collar_body_height = set_collar_screw_washer_dia + 2*wall + 2*clearance;

spindle_coupling_body_dia = set_collar_body_dia;
spindle_coupling_body_height = set_collar_body_height + wall_thin + 3*wall;

frame_enclosure_door_hinge_body_height = frame_width * 1.5;
frame_enclosure_door_hinge_body_width = 2*wall;
frame_enclosure_door_hinge_bolt_dia = m4_screw_dia;
frame_enclosure_door_hinge_bolt_washer_thickness = m4_washer_thickness;
frame_enclosure_door_hinge_bolt_nut_wrench = m4_nut_wrench;
frame_enclosure_door_hinge_bolt_nut_height = m4_nut_height;

frame_enclosure_door_lock_inside_body_width = (frame_groove_width/2-clearance) + (frame_width/2-frame_enclosure_thickness-clearance);
frame_enclosure_door_lock_inside_body_height = frame_groove_depth-wall_thin + 2*wall+clearance+frame_screw_dia+clearance+wall;
frame_enclosure_door_lock_inside_body_length = 4*wall+clearance+frame_screw_dia+clearance+wall;

frame_enclosure_door_lock_outside_body_width = frame_screw_washer_thickness+frame_screw_nut_height+wall_thin;
frame_enclosure_door_lock_outside_body_height = wall+clearance+frame_screw_dia+clearance+wall;
frame_enclosure_door_lock_outside_body_length = 4*wall+clearance+frame_screw_dia+clearance+wall;

thumbwheel_long_dia = frame_width;

