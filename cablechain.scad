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



// end = 0 for usual cable chain link
// end = 1 for cable chain first end (frame)
// end = 2 for cable chain second end (carriage)



// RENDER FOR PRINTING

// X AXIS LINK
* cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,x_cablechain_dividers,x_cablechain_mount,end=0);

// Y AXIS LINK
* cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,y_cablechain_dividers,y_cablechain_mount,end=0);

// Z AXIS LINK
* cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,z_cablechain_dividers,z_cablechain_mount,end=0);



// X AXIS CHAIN-END FRAME
* cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,x_cablechain_dividers,x_cablechain_mount,end=1);

// Y AXIS CHAIN-END FRAME
* cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,y_cablechain_dividers,y_cablechain_mount,end=1);

// Z AXIS CHAIN-END FRAME
* cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,z_cablechain_dividers,z_cablechain_mount,end=1);



// X AXIS CHAIN-END EXTRUDER
* cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,x_cablechain_dividers,x_cablechain_mount,end=2);

// Y AXIS CHAIN-END BRIDGE
* cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,y_cablechain_dividers,y_cablechain_mount,end=2);

// Z AXIS CHAIN-END BED
* cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,z_cablechain_dividers,z_cablechain_mount,end=2);




module cablechain(width,height,cablechain_wall,cablechain_additional_length,dividers=0,mount=0,end=0){

	cablechain_width = width+4*cablechain_wall+2*clearance+dividers*wall_thin;
	cablechain_height = height+2*cablechain_wall;
	cablechain_length = 2*cablechain_height+cablechain_wall+2*clearance+cablechain_additional_length;

	difference(){

		// main body
		hull(){

			// first end
			if(end==0 || end==2){
				translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
				translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
					rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
			}
			if(end==1){
				translate([0,0,cablechain_height-wall])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(wall,cablechain_width);
				translate([frame_width-wall,0,wall])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(wall,cablechain_width);
				translate([frame_width-wall,-cablechain_width/2,0])
					cube([wall,cablechain_width,wall]);
			}

			// second end
			if(end==0 || end==1){
				translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
				translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
					rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
			}
			if(end==2){
				translate([0,0,cablechain_height-wall])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(wall,cablechain_width);
				translate([-frame_width+wall,0,wall])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(wall,cablechain_width);
				translate([-frame_width,-cablechain_width/2,0])
					cube([wall,cablechain_width,wall]);
			}
		}

		// cable channel
		difference(){
			hull(){
				translate([0,(cablechain_width-4*cablechain_wall-2*clearance)/2-wall,cablechain_height-cablechain_wall-wall])
					teardrop(wall,cablechain_length+2+2*frame_width);
				translate([0,-(cablechain_width-4*cablechain_wall-2*clearance)/2+wall,cablechain_height-cablechain_wall-wall])
					teardrop(wall,cablechain_length+2+2*frame_width);
				translate([0,(cablechain_width-4*cablechain_wall-2*clearance)/2-wall,cablechain_wall+wall])
					teardrop(wall,cablechain_length+2+2*frame_width);
				translate([0,-(cablechain_width-4*cablechain_wall-2*clearance)/2+wall,cablechain_wall+wall])
					teardrop(wall,cablechain_length+2+2*frame_width);
			}

			// channel dividers
			if(dividers>0)
				for(d=[1:dividers])
					translate([0,-cablechain_width/2+2*cablechain_wall+clearance+d*((cablechain_width-(4*cablechain_wall+2*clearance))/(dividers+1)),0])
						difference(){
							translate([-(cablechain_length+4+2*frame_width)/2,-wall-wall_thin/2,-1])
								cube([cablechain_length+4+2*frame_width,wall+wall_thin+wall,cablechain_height+2]);
							hull(){
								translate([0,-wall-wall_thin/2,cablechain_height-cablechain_wall-wall])
									teardrop(wall,cablechain_length+6+2*frame_width);
								translate([0,-wall-wall_thin/2,cablechain_wall+wall])
									teardrop(wall,cablechain_length+6+2*frame_width);
							}
							hull(){
								translate([0,wall+wall_thin/2,cablechain_height-cablechain_wall-wall])
									teardrop(wall,cablechain_length+6+2*frame_width);
								translate([0,wall+wall_thin/2,cablechain_wall+wall])
									teardrop(wall,cablechain_length+6+2*frame_width);
							}
						}

		}

		// chain link 1, outer link
		if(end==0 || end==2){
			translate([cablechain_length-cablechain_height-clearance,0,0])
				hull(){
					translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
						rotate([180,0,0])
							rotate([0,0,90])
								teardrop(cablechain_height/2,cablechain_width-2*cablechain_wall,fulldrop=1);
					translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
						rotate([180,0,0])
							rotate([0,0,90])
								teardrop(cablechain_height/2,cablechain_width-2*cablechain_wall,fulldrop=1);
				}
			translate([cablechain_length/2-cablechain_height-clearance,-(cablechain_width-2*cablechain_wall)/2,cablechain_height/2])
				cube([cablechain_length,cablechain_width-2*cablechain_wall,cablechain_height]);
			translate([cablechain_length/2-cablechain_height-clearance,-(cablechain_width-4*cablechain_wall-2*clearance)/2,-1])
				cube([cablechain_length,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height+2]);
			translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
				rotate([0,0,90])
					teardrop(cablechain_height/6+clearance,cablechain_width+2);
			difference(){
				translate([cablechain_length/2-cablechain_height/2,-(cablechain_width-2*wall_thin)/2,cablechain_height/2])
					rotate([0,45,0])
						translate([-cablechain_height/6-clearance,0,0])
							cube([cablechain_height/3+2*clearance,cablechain_width-2*wall_thin,cablechain_height]);
				for(i=[0,1])
					mirror([0,i,0])
						translate([cablechain_length/2-cablechain_height/2,cablechain_width/2,cablechain_height/2])
							rotate([90,0,0])
								cylinder(r1=cablechain_height/6+clearance+wall_thin+cablechain_wall,r2=cablechain_height/6+clearance+wall_thin-1,h=cablechain_wall+1);
			}
		}

		// chain link 2, inner link
		if(end==0 || end==1){
			difference(){
				union(){
					translate([-cablechain_length+cablechain_height+clearance,0,0])
						hull(){
							translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
								rotate([180,0,0])
									rotate([0,0,90])
										teardrop(cablechain_height/2,cablechain_width+2,fulldrop=1);
							translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
								rotate([180,0,0])
									rotate([0,0,90])
										teardrop(cablechain_height/2,cablechain_width+2,fulldrop=1);
						}
					translate([-cablechain_length-cablechain_length/2+cablechain_height+clearance,-(cablechain_width+2)/2,cablechain_height/2])
						cube([cablechain_length,cablechain_width+2,cablechain_height]);
				}
				translate([-(cablechain_length*4)/2,-(cablechain_width-2*cablechain_wall-2*clearance)/2,-1])
					cube([cablechain_length*4,cablechain_width-2*cablechain_wall-2*clearance,cablechain_height+2]);
				difference(){
					translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
						rotate([90,0,0])
							cylinder(r=cablechain_height/6,h=cablechain_width,center=true);
					for(i=[0,1])
						mirror([0,i,0])
							translate([-cablechain_height/6-1-cablechain_length/2+cablechain_height/2,cablechain_width/2-cablechain_wall-clearance,cablechain_height/3])
								rotate([-45,0,0])
									translate([0,0,-cablechain_height/2])
										cube([cablechain_height/3+2,cablechain_width/2,cablechain_height]);
				}
			}
			translate([-cablechain_length-cablechain_length/2+cablechain_height/2,-(cablechain_width-4*cablechain_wall-2*clearance)/2,-cablechain_height/2])
				cube([cablechain_length,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height]);
	
			// cable clearance when tilted
			translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
				for(i=[0:2])
					rotate([0,i*45,0])
						translate([-cablechain_length/2+cablechain_height/2,0,-cablechain_height/2])
							hull(){
								translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
									rotate([180,0,0]) rotate([0,0,90])
										teardrop(cablechain_height/2-cablechain_wall,cablechain_width-4*cablechain_wall-2*clearance);
								translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
									rotate([180,0,0]) rotate([0,0,90])
										teardrop(cablechain_height/2-cablechain_wall,cablechain_width-4*cablechain_wall-2*clearance);
								translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
									rotate([0,0,90])
										teardrop(cablechain_height/2-cablechain_wall,cablechain_width-4*cablechain_wall-2*clearance);
								translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
									rotate([0,0,90])
										teardrop(cablechain_height/2-cablechain_wall,cablechain_width-4*cablechain_wall-2*clearance);
							}
		}

		// chain end 1, mount screw holes, frame side
		if(end==1){
			if(mount==0){
				translate([frame_width/2,0,-1])
					cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
				translate([frame_width/2,0,cablechain_wall])
					cylinder(r=frame_screw_head_flange_dia/2+clearance,h=cablechain_height+2);
			}
			if(mount==1)
				for(j=[0,1])
					mirror([0,j,0]){
						translate([frame_width/2,cablechain_width/2-2*cablechain_wall-clearance-clearance-frame_screw_head_flange_dia/2,-1])
							cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
						translate([frame_width/2,cablechain_width/2-2*cablechain_wall-clearance-clearance-frame_screw_head_flange_dia/2,cablechain_wall])
							cylinder(r=frame_screw_head_flange_dia/2+clearance,h=cablechain_height+2);
					}
		}

		// chain end 2, mount screw holes, carriage side
		if(end==2){
			if(mount==0){
				translate([-frame_width/2,0,-1])
					cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
				translate([-frame_width/2,0,cablechain_wall])
					cylinder(r=frame_screw_head_flange_dia/2+clearance,h=cablechain_height+2);
			}
			if(mount==1)
				for(j=[0,1])
					mirror([0,j,0]){
						translate([-frame_width/2,cablechain_width/2-2*cablechain_wall-clearance-clearance-frame_screw_head_flange_dia/2,-1])
							cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
						translate([-frame_width/2,cablechain_width/2-2*cablechain_wall-clearance-clearance-frame_screw_head_flange_dia/2,cablechain_wall])
							cylinder(r=frame_screw_head_flange_dia/2+clearance,h=cablechain_height+2);
					}
		}
	}
}
