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


frame_led_profile_side_long = 15;			// aluminium L-profile
frame_led_profile_side_short = 10;			// aluminium L-profile
frame_led_profile_thickness = 2;				// aluminium L-profile

// internal calculation for led profile clearance
alpha = atan((frame_led_profile_side_short-frame_led_profile_thickness)/(frame_led_profile_side_long-frame_led_profile_thickness));
hypotenuse = ((frame_led_profile_side_short-frame_led_profile_thickness)/sin(alpha)) + (frame_led_profile_thickness/cos(alpha)) + (frame_led_profile_thickness/sin(alpha));
side_1 = frame_led_profile_side_long + (frame_led_profile_thickness/sin(alpha)*cos(alpha));
side_2 = frame_led_profile_side_short + (frame_led_profile_thickness/cos(alpha)*sin(alpha));
height = (side_1*side_2)/hypotenuse;
height_q = (side_1*side_1)/hypotenuse;

frame_led_mount_height = height + clearance + wall;
frame_led_mount_side = hypotenuse + 4*wall;



// RENDER
translate([0,0,frame_led_mount_height]) rotate([180,0,0])
frame_led_mount(option=2);



// option = 0 for two led connections
// option = 1 for left led connection
// option = 2 for right led connection

module frame_led_mount(option=0){
	difference(){

		// main body
		hull(){
			translate([wall,wall,0])
				cylinder(r=wall,h=frame_led_mount_height);
			translate([frame_led_mount_side-wall,wall,0])
				cylinder(r=wall,h=frame_led_mount_height);
			translate([wall,frame_led_mount_side-wall,0])
				cylinder(r=wall,h=frame_led_mount_height);
			translate([frame_led_mount_side-wall,frame_led_mount_side-wall,0])
				cylinder(r=wall,h=frame_led_mount_height);
		}

		// frame enclosure screw hole
		translate([2*wall+clearance+frame_screw_dia/2-clearance,2*wall+clearance+frame_screw_dia/2-clearance,-1])
			cylinder(r=frame_screw_dia/2+clearance,h=frame_led_mount_height+2);

/*
		// led mount aluminium profile clearance
		translate([frame_led_mount_side-2*wall,2*wall,0])
			rotate([0,0,90]) rotate([90,0,0])
				linear_extrude(height=frame_led_mount_side)
					polygon(points=[[0,-1],[0,clearance],[height_q,height+clearance],[hypotenuse,clearance],[hypotenuse,-1]]);
*/

		if (option == 0 || option == 1)
			translate([frame_led_mount_side-2*wall-clearance,2*wall,0])
				rotate([0,0,90]) rotate([90,0,0])
					linear_extrude(height=frame_led_mount_side)
						polygon(points=[[0,-1],[0,clearance],[height_q,height+clearance],[hypotenuse,clearance],[hypotenuse,-1]]);
		if (option == 0 || option == 2)
			rotate([0,0,90])
				mirror([0,1,0])
					translate([frame_led_mount_side-2*wall-clearance,2*wall,0])
						rotate([0,0,90]) rotate([90,0,0])
							linear_extrude(height=frame_led_mount_side)
								polygon(points=[[0,-1],[0,clearance],[height_q,height+clearance],[hypotenuse,clearance],[hypotenuse,-1]]);

		// led strip cable clearance
		intersection(){
			translate([frame_led_mount_side-2*wall,frame_led_mount_side-2*wall,-wall])
				cylinder(r=hypotenuse,h=frame_led_mount_height);
			translate([-2*wall,-2*wall,-wall])
				cube([frame_led_mount_side,frame_led_mount_side,frame_led_mount_height]);
		}

	}

}
