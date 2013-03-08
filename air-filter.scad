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


air_filter_body_side = air_filter_fan_side;
air_filter_body_length = 30;
air_filter_body_wall = wall;
air_filter_grid_space = 3;
air_filter_grid_bar = wall_thin;
//air_filter_grid_bar = 1.5;





// RENDER
// CONTAINER
//translate([0,0,air_filter_body_length]) rotate([-90,0,0])		// for printing
air_filter_container();

// LID
//rotate([90,0,0])		// for printing
//air_filter_lid();

// FAN MOUNT
//rotate([-90,0,0])
//air_filter_fanmount();




module air_filter_container(){
	difference(){

		// main body
		hull(){
			translate([wall,0,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=air_filter_body_length);
			translate([air_filter_body_side-wall,0,wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=air_filter_body_length);
			translate([wall,0,air_filter_body_side-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=air_filter_body_length);
			translate([air_filter_body_side-wall,0,air_filter_body_side-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=air_filter_body_length);
		}

		// inner space
		intersection(){
			translate([air_filter_body_side/2,-1,air_filter_body_side/2])
				rotate([-90,0,0])
					cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall,h=air_filter_body_length+2);
			translate([0,-1,0])
				hull(){
					translate([air_filter_body_wall+wall,0,air_filter_body_wall+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_wall+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_wall+wall,0,air_filter_body_side-air_filter_body_wall-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_side-air_filter_body_wall-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
				}
		}

		// back air exhaust grid
		intersection_for(i=[0:2]){
			if(i==0)
				translate([air_filter_body_side/2,-1,air_filter_body_side/2])
					rotate([-90,0,0])
						cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall,h=air_filter_body_length+2);
			if(i==1)
				translate([0,1,0])
					hull(){
						translate([air_filter_body_wall+wall,0,air_filter_body_wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_wall+wall,0,air_filter_body_side-air_filter_body_wall-wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_side-air_filter_body_wall-wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
					}	
			// grid pattern
			if(i==2)

				// line pattern
				for(x=[0:round((air_filter_body_side/(air_filter_grid_space+air_filter_grid_bar))/2)+1]){
					translate([(air_filter_body_side/2-air_filter_grid_space/2)+x*(air_filter_grid_space+air_filter_grid_bar),-(air_filter_body_wall+2)/2+air_filter_body_length-air_filter_body_wall/2,0])
						cube([air_filter_grid_space,air_filter_body_wall+2,air_filter_body_side]);
					translate([(air_filter_body_side/2-air_filter_grid_space/2)-x*(air_filter_grid_space+air_filter_grid_bar),-(air_filter_body_wall+2)/2+air_filter_body_length-air_filter_body_wall/2,0])
						cube([air_filter_grid_space,air_filter_body_wall+2,air_filter_body_side]);
				}
/*
				// honeycomb pattern
				for(x=[0:round(air_filter_body_side/(((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*4))])
					for(z=[0:round(air_filter_body_side/(air_filter_grid_space+air_filter_grid_bar))])
						translate([x*((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*4,0,z*(air_filter_grid_space+air_filter_grid_bar)]){
							translate([0,air_filter_body_length-air_filter_body_wall/2,0])
								rotate([-90,0,0])
									nut_trap(air_filter_grid_space,air_filter_body_wall+2);
							translate([((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*2,air_filter_body_length-air_filter_body_wall/2,air_filter_grid_space/2+air_filter_grid_bar/2])
								rotate([-90,0,0])
									nut_trap(air_filter_grid_space,air_filter_body_wall+2);
						}
*/
		}

		// mount screw holes
		translate([air_filter_body_side/2,-1,air_filter_body_side/2])
		for(q=[0:1])
			rotate([0,q*180+90,0])
				translate([air_filter_fan_hole_dist/2,0,air_filter_fan_hole_dist/2])
					rotate([-90,0,0])
						cylinder(r=air_filter_fan_screw_dia/2+clearance,h=air_filter_body_length+2);

		// fan mount screw head clearance
		difference(){
			union(){
				translate([air_filter_body_side/2+1,-1,air_filter_body_side/2+1])
					cube([air_filter_body_side/2,air_filter_fan_screw_washer_thickness+air_filter_fan_screw_head_length+wall_thin+1,air_filter_body_side/2]);
				translate([-1,-1,-1])
					cube([air_filter_body_side/2,air_filter_fan_screw_washer_thickness+air_filter_fan_screw_head_length+wall_thin+1,air_filter_body_side/2]);
			}
			translate([air_filter_body_side/2,-2,air_filter_body_side/2])
				rotate([-90,0,0])
					cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance,h=air_filter_body_length+4);
		}
			

		// front lid countersink
		intersection(){
			translate([air_filter_body_side/2,-1,air_filter_body_side/2])
				rotate([-90,0,0])
					cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall+wall_thin+clearance,h=air_filter_body_wall+clearance+1);
			translate([0,-1,0])
				hull(){
					translate([air_filter_body_wall+wall-wall_thin-clearance,0,air_filter_body_wall+wall-wall_thin-clearance])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_side-air_filter_body_wall-wall+wall_thin+clearance,0,air_filter_body_wall+wall-wall_thin-clearance])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_wall+wall-wall_thin-clearance,0,air_filter_body_side-air_filter_body_wall-wall+wall_thin+clearance])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
					translate([air_filter_body_side-air_filter_body_wall-wall+wall_thin+clearance,0,air_filter_body_side-air_filter_body_wall-wall+wall_thin+clearance])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall+1);
				}
		}

		// front lid removal screw driver recess
		translate([air_filter_body_side/2-wall,-1,-1])
			cube([2*wall,wall+wall_thin+1,wall+2]);
	}

}


module air_filter_lid(){
	difference(){

		// main body
		intersection(){
			translate([air_filter_body_side/2,0,air_filter_body_side/2])
				rotate([-90,0,0])
					cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall+wall_thin,h=air_filter_body_wall);
			translate([0,0,0])
				hull(){
					translate([air_filter_body_wall-wall_thin+wall,0,air_filter_body_wall-wall_thin+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall);
					translate([air_filter_body_side-air_filter_body_wall+wall_thin-wall,0,air_filter_body_wall-wall_thin+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall);
					translate([air_filter_body_wall-wall_thin+wall,0,air_filter_body_side-air_filter_body_wall+wall_thin-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall);
					translate([air_filter_body_side-air_filter_body_wall+wall_thin-wall,0,air_filter_body_side-air_filter_body_wall+wall_thin-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=air_filter_body_length-air_filter_body_wall);
				}
		}

		// front air entrance grid
		intersection_for(i=[0:2]){
			if(i==0)
				translate([air_filter_body_side/2,-1,air_filter_body_side/2])
					rotate([-90,0,0])
						cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall,h=air_filter_body_length+2);
			if(i==1)
				translate([0,-1,0])
					hull(){
						translate([air_filter_body_wall+wall,0,air_filter_body_wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_wall+wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_wall+wall,0,air_filter_body_side-air_filter_body_wall-wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
						translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_side-air_filter_body_wall-wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=air_filter_body_length);
					}	

			// grid pattern
			if(i==2)

				// line pattern
				for(x=[0:round((air_filter_body_side/(air_filter_grid_space+air_filter_grid_bar))/2)+1]){
					translate([(air_filter_body_side/2-air_filter_grid_space/2)+x*(air_filter_grid_space+air_filter_grid_bar),-1,0])
						cube([air_filter_grid_space,air_filter_body_wall+2,air_filter_body_side]);
					translate([(air_filter_body_side/2-air_filter_grid_space/2)-x*(air_filter_grid_space+air_filter_grid_bar),-1,0])
						cube([air_filter_grid_space,air_filter_body_wall+2,air_filter_body_side]);
				}
/*
				// honeycomb pattern
				for(xx=[0:round(air_filter_body_side/(((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*4))])
					for(zz=[0:round(air_filter_body_side/(air_filter_grid_space+air_filter_grid_bar))])
						translate([xx*((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*4,0,zz*(air_filter_grid_space+air_filter_grid_bar)]){
							translate([0,air_filter_body_wall/2,0])
								rotate([-90,0,0])
									nut_trap(air_filter_grid_space,air_filter_body_wall+2);
							translate([((air_filter_grid_space/2+air_filter_grid_bar/2)*cos(30))*2,air_filter_body_wall/2,air_filter_grid_space/2+air_filter_grid_bar/2])
								rotate([-90,0,0])
									nut_trap(air_filter_grid_space,air_filter_body_wall+2);
						}
*/
		}		
	}
}


module air_filter_fanmount(){
	difference(){

		// main body
		union(){

			// fan and container mount frame
			translate([0,-(wall+clearance+air_filter_fan_screw_nut_height),0])
				hull(){
					translate([air_filter_body_side-wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=wall+clearance+air_filter_fan_screw_nut_height);
					translate([-wall_thin,0,0])
						cube([wall,wall+clearance+air_filter_fan_screw_nut_height,air_filter_body_side]);
					translate([air_filter_body_side-wall,0,air_filter_body_side-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=wall+clearance+air_filter_fan_screw_nut_height);
				}

			// vertical wall for improved stiffness
			rotate([0,0,-90])
				translate([0,-2*wall-wall_thin,0])
					hull(){
						translate([4*wall+2*clearance+frame_screw_dia-wall,0,wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=2*wall);
						translate([0,0,0])
							cube([wall,2*wall,air_filter_body_side]);
						translate([4*wall+2*clearance+frame_screw_dia-wall,0,air_filter_body_side-wall])
							rotate([-90,0,0])
								cylinder(r=wall,h=2*wall);
					}

			// frame mount
			translate([0,0,wall])
				rotate([0,-90,0])
					rotate([0,0,-90])
						translate([0,0,wall_thin])
							hull(){
								translate([4*wall+2*clearance+frame_screw_dia-wall,0,0])
									cube([wall,2*wall,wall]);	
								translate([0,0,0])
									cube([wall,2*wall,wall]);
								translate([wall,wall,2*wall+clearance+frame_width-frame_enclosure_thickness-clearance-wall])
									rotate([0,-90,0]) rotate([0,0,90])
										teardrop(wall,2*wall);
								translate([4*wall+2*clearance+frame_screw_dia-wall,0,2*wall+clearance+frame_width-frame_enclosure_thickness-clearance-wall])
									rotate([-90,0,0])
										cylinder(r=wall,h=2*wall);
							}
		}

		// inner space
		intersection(){
			translate([air_filter_body_side/2,-(wall+clearance+air_filter_fan_screw_nut_height)-1,air_filter_body_side/2])
				rotate([-90,0,0])
					cylinder(r=air_filter_fan_hole_dist*sin(45)-air_filter_fan_screw_washer_dia/2-clearance-wall,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);
			translate([0,-(wall+clearance+air_filter_fan_screw_nut_height)-1,0])
				hull(){
					translate([air_filter_body_wall+wall,0,air_filter_body_wall+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);
					translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_wall+wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);
					translate([air_filter_body_wall+wall,0,air_filter_body_side-air_filter_body_wall-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);
					translate([air_filter_body_side-air_filter_body_wall-wall,0,air_filter_body_side-air_filter_body_wall-wall])
						rotate([-90,0,0])
							cylinder(r=wall,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);
				}
		}

		// fan screw holes
		translate([air_filter_body_side/2,-(wall+clearance+air_filter_fan_screw_nut_height)-1,air_filter_body_side/2])
			for(q=[0:3])
				rotate([0,q*90,0])
					translate([air_filter_fan_hole_dist/2,0,air_filter_fan_hole_dist/2])
						rotate([-90,0,0])
							cylinder(r=air_filter_fan_screw_dia/2+clearance,h=(wall+clearance+air_filter_fan_screw_nut_height)+2);

		// active carbon container mount nut traps
		translate([air_filter_body_side/2,-(wall+clearance+air_filter_fan_screw_nut_height)-1+(air_filter_fan_screw_nut_height+clearance+1)/2,air_filter_body_side/2])
			for(r=[0:1])
				rotate([0,r*180+90,0])
					translate([air_filter_fan_hole_dist/2,0,air_filter_fan_hole_dist/2])
						rotate([0,45,0])
						rotate([90,0,0])
							nut_trap(air_filter_fan_screw_nut_wrench,air_filter_fan_screw_nut_height+clearance+1);

		// frame mount screw hole
		translate([-wall_thin-clearance-frame_width+frame_enclosure_thickness+clearance,-2*wall-clearance-frame_screw_dia/2,(2*wall+2)/2-1+wall])
			rotate([90,0,0])
				rotate([0,0,90])
					teardrop(frame_screw_dia/2+clearance,2*wall+2);
	}

}
