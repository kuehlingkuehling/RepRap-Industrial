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



/****** X-END IDLER *************/
//rotate([90,0,0]) x_end(motor=0);

/****** X-END MOTOR *************/
mirror([1,0,0]) rotate([90,0,0]) x_end(motor=1);



// TEST RENDER ENDSTOP MOUNT
//endstop_mount();


// DEBUG //////
echo("x_end frame_enclosure clearance", frame_width-clearance-frame_enclosure_thickness+clearance+wall+clearance+rod_dia/2-linear_bearing_dia/2-clearance-wall);
echo("y_rod y_endstop dist", linear_bearing_dia/2+clearance+wall+endstop_screw_nut_height+2*clearance+wall);


module x_end(motor=1){
	difference(){
		// main body
		union(){
			translate([-wall-clearance-linear_bearing_dia/2,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				hull(){
					translate([wall,0,wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([wall,0,x_end_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([x_end_body_width-wall,0,x_end_body_height-wall])
						rotate([-90,0,0])
							cylinder(r=wall, h=x_end_body_length);
					translate([x_end_body_width-wall,0,0])
						cube([wall,x_end_body_length,wall]);
				}

			// x rod clamp idler bolt support
			difference(){
				translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-(wall+cornerdiameter(x_idler_bolt_wrench)/2+x_idler_bolt_washer_dia/2+clearance+wall),0,-x_end_body_height-wall+linear_bearing_dia/2+clearance+wall])
					cube([wall+cornerdiameter(x_idler_bolt_wrench)/2+x_idler_bolt_washer_dia/2+clearance+wall,x_end_body_length,wall]);
				translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-(wall+cornerdiameter(x_idler_bolt_wrench)/2+x_idler_bolt_washer_dia/2+clearance+wall),-1,-x_end_body_height-wall+linear_bearing_dia/2+clearance+wall])
					rotate([-90,0,0])
						cylinder(r=wall, h=x_end_body_length+2);
			}


			if(motor==1){

				// x motor mount body
				difference(){
					union(){
						translate([-wall-clearance-linear_bearing_dia/2,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
							translate([x_end_body_width,0,0])
								cube([wall_thin+wall+nema17_width+2*clearance+wall,x_end_body_length,wall+2*clearance+2+rod_dia+wall]);
						translate([-wall-clearance-linear_bearing_dia/2,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall+(wall+2*clearance+2+rod_dia+wall)])
							translate([x_end_body_width,0,0])
								cube([wall,x_end_body_length,wall]);
					}
					translate([-wall-clearance-linear_bearing_dia/2+wall,-1,-x_end_body_height+linear_bearing_dia/2+clearance+wall+(wall+2*clearance+2+rod_dia+wall)+wall])
						translate([x_end_body_width,0,0])
							rotate([-90,0,0])
								cylinder(r=wall, h=x_end_body_length+2);
					translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-1,-1,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall+clearance+1+rod_dia/2-x_end_body_height+((2*sin(180/8)*(cornerdiameter_8(rod_dia+2+2*clearance)/2))/2)])
						cube([wall_thin+1,x_end_body_length+2,x_end_body_height]);
				}
		
				// y endstop mount
				translate([0,0,linear_bearing_dia/2+clearance+wall])
					endstop_mount(teardrop=1,teardrop_angle=90);

				// x endstop mount
				translate([x_end_body_width-linear_bearing_dia/2-clearance-wall+wall_thin+wall+nema17_width+2*clearance+wall-2*wall-2*clearance-endstop_screw_dia-endstop_hole_sensor_dist,x_end_body_length,-linear_bearing_dia/2-clearance-wall-1-clearance-rod_dia/2])
					rotate([-90,0,0])
						rotate([0,0,-90])
							endstop_mount(teardrop=0,top=1);
			}
		}

		// linear bearing clamp
		difference(){
			translate([0,-1,0])
				rotate([-90,0,0])
					cylinder(r=linear_bearing_dia/2+clearance, h=x_end_body_length+2);

			// linear bearing push in stop
			translate([-linear_bearing_dia/2-clearance-wall_thin,x_end_body_length/2-(x_end_body_length-2*linear_bearing_length-2*clearance)/2,rod_dia/2+wall_thin])
				cube([linear_bearing_dia+2*clearance+2*wall_thin,x_end_body_length-2*linear_bearing_length-2*clearance,(linear_bearing_dia/2-rod_dia/2-wall_thin)+wall_thin]);
		}
		translate([0,-1,-wall_thin/2])
			cube([x_end_body_width-linear_bearing_dia/2-clearance-wall+1,x_end_body_length+2,wall_thin]);

		// x rod clamp holes
/***** OPEN ENDS
		for(i=[-1,1])
			translate([-linear_bearing_dia/2-clearance-wall-1,x_end_body_length/2+i*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2])
				rotate([0,90,0])
					rotate([0,0,45/2])
						cylinder(r=cornerdiameter_8(rod_dia+2*clearance)/2, h=x_end_body_width+2+(wall_thin+wall+nema17_width+2*clearance+wall),$fn=8);
		difference(){
			for(i=[-1,1])
				translate([-linear_bearing_dia/2-clearance-wall-1,x_end_body_length/2+i*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2])
					rotate([0,90,0])
						rotate([0,0,45/2])
							cylinder(r=cornerdiameter_8(rod_dia+2+2*clearance)/2, h=x_end_body_width+2+(wall_thin+wall+nema17_width+2*clearance+wall),$fn=8);
			translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-wall,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall+clearance+1+rod_dia/2])
				cube([wall,x_end_body_length,x_end_body_height]);
			translate([linear_bearing_dia/2+clearance+wall+clearance+x_idler_bolt_dia/2-wall/2,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall+clearance+1+rod_dia/2-x_end_body_height])
				cube([wall,x_end_body_length,x_end_body_height]);
			translate([-linear_bearing_dia/2-clearance-wall-1,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				cube([2*wall+1,x_end_body_length,x_end_body_height]);
			translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-wall+(wall_thin+wall+nema17_width+2*clearance+wall),0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				cube([wall+1,x_end_body_length,x_end_body_height]);
		}
*/
/***** CLOSED ENDS ****/
		for(i=[-1,1])
			translate([0,x_end_body_length/2+i*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2])
				rotate([0,90,0])
					rotate([0,0,45/2])
						cylinder(r=cornerdiameter_8(rod_dia+2*clearance)/2, h=x_end_body_width+2+(wall_thin+wall+nema17_width+2*clearance+wall),$fn=8);
		difference(){
			for(i=[-1,1])
				translate([0,x_end_body_length/2+i*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2])
					rotate([0,90,0])
						rotate([0,0,45/2])
							cylinder(r=cornerdiameter_8(rod_dia+2+2*clearance)/2, h=x_end_body_width+2+(wall_thin+wall+nema17_width+2*clearance+wall),$fn=8);
			translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-wall,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall+clearance+1+rod_dia/2])
				cube([wall,x_end_body_length,x_end_body_height]);
			translate([linear_bearing_dia/2+clearance+wall+clearance+x_idler_bolt_dia/2-wall/2,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall+clearance+1+rod_dia/2-x_end_body_height])
				cube([wall,x_end_body_length,x_end_body_height]);
			translate([0,0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				cube([1.5*wall,x_end_body_length,x_end_body_height]);
			translate([x_end_body_width-linear_bearing_dia/2-clearance-wall-wall+(wall_thin+wall+nema17_width+2*clearance+wall),0,-x_end_body_height+linear_bearing_dia/2+clearance+wall])
				cube([wall+1,x_end_body_length,x_end_body_height]);
		}

		// x rod clamp cut
		translate([0,-1,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2-(2*sin(180/8)*(cornerdiameter_8(rod_dia+2+2*clearance)/2))/2])
			cube([x_end_body_width-wall-clearance-linear_bearing_dia/2+wall_thin,x_end_body_length+2,2*sin(180/8)*(cornerdiameter_8(rod_dia+2+2*clearance)/2)]);
		translate([0,-1,-linear_bearing_dia/2-clearance-wall-clearance-1-rod_dia/2])
			rotate([-90,0,0])
				cylinder(r=sin(180/8)*(cornerdiameter_8(rod_dia+2+2*clearance)/2), h=x_end_body_length+2);

		// x rod set screw holes/nut traps
		if(motor==1){
			for(j=[-1,1]){
				translate([-(linear_bearing_dia/2+clearance+wall)/2,x_end_body_length/2+j*x_rod_dist/2,-linear_bearing_dia/2-clearance-wall-1-clearance-rod_dia/2]){
					rotate([-90,0,0])
						teardrop(x_end_rod_setscrew_dia/2+clearance,linear_bearing_dia/2+clearance+wall+2);
					rotate([0,90,0])
						nut_slot(x_end_rod_setscrew_nut_wrench,x_end_rod_setscrew_nut_height,rod_dia/2+clearance+1+wall);
				}
			}
		}

		// x idler bolt hole
		translate([linear_bearing_dia/2+clearance+wall+x_idler_bolt_dia/2+clearance,x_end_body_length/2,-x_end_body_height-wall-1+linear_bearing_dia/2+clearance+wall+(x_end_body_height+wall+2)/2])
			rotate([0,90,0])
				rotate([-90,0,0])
					teardrop(x_idler_bolt_dia/2+clearance,x_end_body_height+wall+2);
		translate([linear_bearing_dia/2+clearance+wall+x_idler_bolt_dia/2+clearance,x_end_body_length/2,linear_bearing_dia/2+clearance+wall-(x_idler_bolt_head+1)/2+1])
			nut_trap(x_idler_bolt_wrench,x_idler_bolt_head+1);

		// x motor mount cuts
		translate([-linear_bearing_dia/2-clearance-wall+x_end_body_width+wall,x_end_body_length/2-(nema17_width+2*clearance)/2,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall])
			cube([nema17_width+2*clearance,nema17_width+2*clearance,rod_dia+2*clearance+2+wall+1]);
		translate([-linear_bearing_dia/2-clearance-wall+x_end_body_width+wall+clearance+nema17_width/2,x_end_body_length/2-(nema17_width+2*clearance)/2+clearance+nema17_width/2,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall-wall/2])
			rotate([-90,0,0])
				rotate([0,0,90])
					teardrop(nema17_center_dia/2+clearance,wall+2);
		for(j=[-1,1])
			for(k=[-1,1])
				translate([-linear_bearing_dia/2-clearance-wall+x_end_body_width+wall+clearance+nema17_width/2+j*nema17_hole_dist/2,x_end_body_length/2-(nema17_width+2*clearance)/2+clearance+nema17_width/2+k*nema17_hole_dist/2,-x_end_body_height+linear_bearing_dia/2+clearance+wall+wall-wall/2])
					rotate([-90,0,0])
						rotate([0,0,90])
							teardrop(nema17_hole_dia/2+clearance,wall+2);

		// belt grip
		translate([y_rod_y_belt_x_dist-belt_width/2-clearance,0,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2]){
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
		}

		// belt tensioner
		translate([y_rod_y_belt_x_dist,x_end_body_length,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2-belt_thickness_max/2]){
			translate([0,-(belt_tensioning_range+2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
				rotate([-90,0,0])
					cylinder(r=belt_tensioning_screw_dia/2+clearance,belt_tensioning_range+2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance+1);
			translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
				rotate([-90,0,0])
					cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall+2*clearance,h=belt_tensioning_nut_height+2*clearance+wall_thin+clearance);
			translate([-((cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance)/2),-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),0])
					cube([cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance,belt_tensioning_nut_height+2*clearance+wall_thin+clearance,(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+2*clearance)]);
		}
		difference(){
			translate([y_rod_y_belt_x_dist,x_end_body_length,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2-belt_thickness_max/2])
				translate([0,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance),-wall_thin])
					rotate([-90,0,0])
						cylinder(r=cornerdiameter(belt_tensioning_nut_wrench+2*clearance)/2+wall+2*clearance,belt_tensioning_nut_height+2*clearance+wall_thin+clearance);
			translate([y_rod_y_belt_x_dist,x_end_body_length,0])
				translate([-((cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance)/2)-1,-(2*wall+belt_tensioning_nut_height+2*clearance+wall_thin+clearance)-1,0])
						cube([cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+4*clearance+2,belt_tensioning_nut_height+2*clearance+wall_thin+clearance+2,(cornerdiameter(belt_tensioning_nut_wrench+2*clearance)+2*wall+2*clearance)]);
		}
	}

/*
	// x rod clamp cut round socket printability support
	translate([-(rod_dia+2*clearance+2)/2,wall+2*clearance+rod_dia+2,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia-2])
		cube([(rod_dia+2*clearance+2)/2,layer_height,rod_dia+2]);
	translate([-(rod_dia+2*clearance+2)/2,wall+2*clearance+rod_dia+2+x_rod_dist,-linear_bearing_dia/2-clearance-wall-clearance-rod_dia-2])
		cube([(rod_dia+2*clearance+2)/2,layer_height,rod_dia+2]);
*/

	// belt tensioner screw hole printability support
	translate([y_rod_y_belt_x_dist,x_end_body_length,y_rod_y_belt_arbor_dist-y_belt_pulley_dia/2])
		translate([0,-2*wall,0])
			rotate([-90,0,0])
				cylinder(r=belt_tensioning_screw_dia/2+clearance+1,layer_height);

/*
	// linear bearing push in stop
	translate([-linear_bearing_dia/2-clearance-wall_thin,x_end_body_length/2-(x_end_body_length-2*linear_bearing_length-2*clearance)/2,-linear_bearing_dia/2-clearance-wall_thin])
		cube([linear_bearing_dia+2*clearance+2*wall_thin,x_end_body_length-2*linear_bearing_length-2*clearance,2*wall_thin]);
*/

}


module endstop_mount(teardrop=1,teardrop_angle=-90,top=1){
	difference(){

		// main body
		union(){
			translate([-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0,-wall])
				cube([endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall,2*wall+2*clearance+endstop_screw_dia,endstop_screw_nut_height+2*clearance+2*wall]);

			translate([0,0,-wall])
				rotate([-90,0,0])
					linear_extrude(height=2*wall+2*clearance+endstop_screw_dia)
						polygon(points=[[-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0],[-(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2+2*wall,2*wall],[(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2-2*wall,2*wall],[(endstop_hole_dist+endstop_screw_nut_wrench+2*clearance+2*wall)/2,0]]);
		}
		for(k=[-1,1])
			translate([-(endstop_screw_nut_wrench+2*clearance)/2+k*endstop_hole_dist/2,-1,0])
				cube([endstop_screw_nut_wrench+2*clearance,2*wall+2*clearance+endstop_screw_dia+2,endstop_screw_nut_height+2*clearance]);
		if(teardrop==1)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,(endstop_screw_nut_height+2*clearance+wall+1)/2])
					rotate([0,0,teardrop_angle])
						rotate([0,90,0])
							teardrop(endstop_screw_dia/2+clearance,endstop_screw_nut_height+2*clearance+wall+1);
		if(teardrop==0)
			for(j=[-1,1])
				translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,0])
					cylinder(r=endstop_screw_dia/2+clearance,h=endstop_screw_nut_height+2*clearance+wall+1);
	}

	// hole printability support layer for top surface use of endstop_mount (no teardrop)
	if(teardrop==0) if(top==1)
		for(j=[-1,1])
			translate([j*endstop_hole_dist/2,(2*wall+2*clearance+endstop_screw_dia)/2,endstop_screw_nut_height+2*clearance])
				cylinder(r=endstop_screw_dia/2+clearance+wall_thin,h=layer_height);

}


