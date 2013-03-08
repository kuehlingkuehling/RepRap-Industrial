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


x_cablechain_wall = 2;
x_cablechain_width = 43 + (6*x_cablechain_wall+2*clearance);
x_cablechain_height = 15 + (2*x_cablechain_wall);
x_cablechain_additional_length = 10;

y_cablechain_wall = 1.5;
y_cablechain_width = 15 + (6*y_cablechain_wall+2*clearance);
y_cablechain_height = 7.5 + (2*y_cablechain_wall);
y_cablechain_additional_length = 10;

z_cablechain_wall = 1.5;
z_cablechain_width = 15 + (6*z_cablechain_wall+2*clearance);
z_cablechain_height = 7.5 + (2*z_cablechain_wall);
z_cablechain_additional_length = 10;




// RENDER FOR PRINTING

// X AXIS LINK
//translate([0,0,x_cablechain_height]) rotate([0,180,0])
//cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,end=0,dividers=2);

// Y AXIS LINK
//translate([0,0,y_cablechain_height]) rotate([0,180,0])
//cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,end=0,dividers=0);

// Z AXIS LINK
//translate([0,0,z_cablechain_height]) rotate([0,180,0])
//cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,end=0,dividers=0);



// X AXIS CHAIN-END FRAME
//translate([0,0,x_cablechain_height]) rotate([0,180,0])
//cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,end=1,dividers=2);

// Y AXIS CHAIN-END FRAME
//translate([0,0,y_cablechain_height]) rotate([0,180,0])
//cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,end=4,dividers=0);

// Z AXIS CHAIN-END FRAME
//translate([0,0,z_cablechain_height]) rotate([0,180,0])
//cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,end=1,dividers=0);



// X AXIS CHAIN-END EXTRUDER
//translate([0,0,x_cablechain_height]) rotate([0,180,0])
//cablechain(x_cablechain_width,x_cablechain_height,x_cablechain_wall,x_cablechain_additional_length,end=2,dividers=2);

// Y AXIS CHAIN-END BRIDGE
//translate([0,0,y_cablechain_height]) rotate([0,180,0])
//cablechain(y_cablechain_width,y_cablechain_height,y_cablechain_wall,y_cablechain_additional_length,end=3,dividers=0);

// Z AXIS CHAIN-END BED
translate([0,0,z_cablechain_height]) rotate([0,180,0])
cablechain(z_cablechain_width,z_cablechain_height,z_cablechain_wall,z_cablechain_additional_length,end=2,dividers=0);


// end = 0 for usual cable chain link
// end = 1 for cable chain frame mount flat
// end = 2 for cable chain extruder & z-stage mount (x&z)
// end = 3 for cable chain y bridge mount
// end = 4 for cable chain frame mount front


module cablechain(cablechain_width,cablechain_height,cablechain_wall,cablechain_additional_length, end=0, dividers=0){

	cablechain_length = 2*cablechain_height+cablechain_wall+2*clearance + cablechain_additional_length;

	difference(){

		// main body
		union(){

			// chain link body
			hull(){
				translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
				translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
					rotate([180,0,0]) rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
				translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
					rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
				translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
					rotate([0,0,90])
						teardrop(cablechain_height/2,cablechain_width);
			}

			// end = 1; frame mount flat
			if (end == 1)
				translate()
					hull(){
						translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)-wall,cablechain_width/2+(clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall)-wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)-wall,-cablechain_width/2-(clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall)+wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)-(frame_width-frame_enclosure_thickness-clearance)+wall,cablechain_width/2+(clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall)-wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)-(frame_width-frame_enclosure_thickness-clearance)+wall,-cablechain_width/2-(clearance+frame_screw_washer_dia/2+frame_screw_dia/2+clearance+wall)+wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
					}

			// end = 2; extruder/z-stage mount
			if (end == 2){
				translate([-cablechain_length/2,-cablechain_width/2,0])
					cube([cablechain_length/2,cablechain_width,cablechain_height]);
				translate([-cablechain_length/2,-cablechain_width/2,cablechain_wall-(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall)])
					cube([wall+2*clearance+extruder_cablechain_mount_screw_dia+wall,cablechain_width,wall+2*clearance+extruder_cablechain_mount_screw_dia+wall]);
				translate([-cablechain_length/2+(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall),-cablechain_width/2,-wall])
					cube([wall,cablechain_width,wall]);
/*
				translate([-cablechain_length/2-(clearance+extruder_cablechain_mount_screw_washer_dia/2+extruder_cablechain_mount_screw_dia/2+clearance+wall),-cablechain_width/2-wall,0])
					cube([cablechain_length/2+clearance+extruder_cablechain_mount_screw_washer_dia/2+extruder_cablechain_mount_screw_dia/2+clearance+wall,wall+2*cablechain_wall+clearance,cablechain_height]);
*/
			}

			// end = 3; y-bridge mount
			if (end == 3)
				mirror([1,0,0])
					hull(){
						translate([cablechain_length/2+clearance+x_idler_bolt_washer_dia-wall,-cablechain_width/2+(wall+clearance+rod_dia/2+y_rod_y_belt_x_dist)+x_idler_bolt_washer_dia/2-wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([cablechain_length/2+clearance+x_idler_bolt_washer_dia-wall,-cablechain_width/2+wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([wall,-cablechain_width/2+(wall+clearance+rod_dia/2+y_rod_y_belt_x_dist)+x_idler_bolt_washer_dia/2-wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
						translate([wall,-cablechain_width/2+wall,cablechain_height-2*wall])
							cylinder(r=wall,h=2*wall);
					}

			// end = 4; frame mount front
			if (end == 4){
				mirror([1,0,0]){
					translate([-cablechain_length/2,-cablechain_width/2,0])
						cube([cablechain_length/2,cablechain_width,cablechain_height]);
					translate([-cablechain_length/2,-(cablechain_width/2+frame_width-frame_enclosure_thickness-clearance),0])
						cube([2*wall,cablechain_width/2+frame_width-frame_enclosure_thickness-clearance,cablechain_height]);
					translate([-cablechain_length/2,-cablechain_width/2-wall,0])
						cube([2*wall+wall,wall+2*cablechain_wall+clearance,cablechain_height]);
				}
			}
		}

		// cable channel
		difference(){
			translate([-(cablechain_length+2)/2,-(cablechain_width-4*cablechain_wall-2*clearance)/2,cablechain_wall])
				cube([cablechain_length+2,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height-2*cablechain_wall]);

			// channel dividers
			if(dividers>0)
				for(d=[1:dividers])
					translate([-(cablechain_length*4)/2,-cablechain_wall/2-cablechain_width/2+(6*x_cablechain_wall+2*clearance)/2-cablechain_wall/2+d*((cablechain_width-(6*x_cablechain_wall+2*clearance)+cablechain_wall)/(dividers+1)),-1])
					cube([cablechain_length*4,cablechain_wall,cablechain_height+2]);

		}

		// chain link 1
		if (end != 1 && end != 4)
			difference(){
				union(){
					translate([cablechain_length-cablechain_height-clearance,0,0])
						hull(){
							translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
								rotate([0,0,90])
									teardrop(cablechain_height/2,cablechain_width-2*cablechain_wall,fulldrop=1);
							translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
								rotate([0,0,90])
									teardrop(cablechain_height/2,cablechain_width-2*cablechain_wall,fulldrop=1);
						}
					translate([cablechain_length/2-cablechain_height-clearance,-(cablechain_width-2*cablechain_wall)/2,-cablechain_height/2])
						cube([cablechain_length,cablechain_width-2*cablechain_wall,cablechain_height]);
					translate([cablechain_length/2-cablechain_height-clearance,-(cablechain_width-4*cablechain_wall-2*clearance)/2,-1])
						cube([cablechain_length,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height+2]);
				}
				translate([cablechain_length/2-cablechain_height/2,-cablechain_width/2+cablechain_wall,cablechain_height/2])
					rotate([-90,0,0])
						cylinder(r1=cablechain_height/4-clearance,r2=cablechain_height/4-clearance-cablechain_wall+clearance,h=cablechain_wall-clearance);
				translate([cablechain_length/2-cablechain_height/2,cablechain_width/2-cablechain_wall,cablechain_height/2])
					rotate([90,0,0])
						cylinder(r1=cablechain_height/4-clearance,r2=cablechain_height/4-clearance-cablechain_wall+clearance,h=cablechain_wall-clearance);
			}

		if (end != 2 && end != 3){

			// chain link 2
			difference(){
				union(){
					translate([-cablechain_length+cablechain_height+clearance,0,0])
						hull(){
							translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
								rotate([0,0,90])
									teardrop(cablechain_height/2,cablechain_width+2,fulldrop=1);
							translate([cablechain_length/2-cablechain_height/2,0,cablechain_height/2])
								rotate([0,0,90])
									teardrop(cablechain_height/2,cablechain_width+2,fulldrop=1);
						}
					translate([-cablechain_length-cablechain_length/2+cablechain_height+clearance,-(cablechain_width+2)/2,-cablechain_height/2])
						cube([cablechain_length,cablechain_width+2,cablechain_height]);
				}
				difference(){
					translate([-(cablechain_length*4)/2,-(cablechain_width-2*cablechain_wall-2*clearance)/2,-1])
						cube([cablechain_length*4,cablechain_width-2*cablechain_wall-2*clearance,cablechain_height+2]);
	
					translate([-cablechain_length/2+cablechain_height/2,-cablechain_width/2+cablechain_wall,cablechain_height/2])
						rotate([-90,0,0])
							cylinder(r1=cablechain_height/4,r2=cablechain_height/4-cablechain_wall,h=cablechain_wall);
					translate([-cablechain_length/2+cablechain_height/2,cablechain_width/2-cablechain_wall,cablechain_height/2])
						rotate([90,0,0])
							cylinder(r1=cablechain_height/4,r2=cablechain_height/4-cablechain_wall,h=cablechain_wall);
				}
			}
			translate([-cablechain_length-cablechain_length/2+cablechain_height/2,-(cablechain_width-4*cablechain_wall-2*clearance)/2,cablechain_height/4*3])
				cube([cablechain_length,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height]);
	
			// cable clearance when tilted
			translate([-cablechain_length/2+cablechain_height/2,0,cablechain_height/2])
				for(i=[0:2])
					rotate([0,-i*45,0])
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

		// end = 1; frame mount flat (cuts and screw holes)
		if (end == 1){
			translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)-(frame_width-frame_enclosure_thickness-clearance),-(cablechain_width-4*cablechain_wall-2*clearance)/2,-cablechain_wall])
				cube([cablechain_length,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height]);
			translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)+clearance+frame_enclosure_thickness-frame_width/2,cablechain_width/2+(clearance+frame_screw_washer_dia/2),-1])
				cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
			translate([max(cablechain_length/2,frame_width-frame_enclosure_thickness-clearance)+clearance+frame_enclosure_thickness-frame_width/2,-cablechain_width/2-(clearance+frame_screw_washer_dia/2),-1])
				cylinder(r=frame_screw_dia/2+clearance,h=cablechain_height+2);
		}

		// end = 2; extruder/z-stage mount
		if (end == 2){
			translate([-cablechain_length/2,-cablechain_width/2,cablechain_wall-(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall)])
				rotate([0,-90,0]) rotate([-90,0,0])
					roundcorner(wall,cablechain_width);
			translate([-cablechain_length/2+(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall),-cablechain_width/2,cablechain_wall-(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall)])
				rotate([0,180,0]) rotate([-90,0,0])
					roundcorner(wall,cablechain_width);
			translate([-cablechain_length/2+(wall+2*clearance+extruder_cablechain_mount_screw_dia+wall)+wall,-cablechain_width/2-1,-wall])
				rotate([-90,0,0])
					cylinder(r=wall,h=cablechain_width+2);
			translate([-cablechain_length/2+(wall+clearance+extruder_cablechain_mount_screw_dia/2),0,cablechain_wall-(wall+clearance+extruder_cablechain_mount_screw_dia/2)])
				rotate([0,0,90])
					rotate([180,0,0])
						teardrop(extruder_cablechain_mount_screw_dia/2+clearance,cablechain_width+2);
		}

		// end = 3; y-bridge mount
		if (end == 3)
			mirror([1,0,0]){
				translate([wall,-(cablechain_width-4*cablechain_wall-2*clearance)/2,-cablechain_wall])
					cube([cablechain_length/2-wall,cablechain_width-4*cablechain_wall-2*clearance,cablechain_height]);
				translate([cablechain_length/2+clearance+x_idler_bolt_washer_dia/2,-cablechain_width/2+(wall+clearance+rod_dia/2+y_rod_y_belt_x_dist),-1])
					cylinder(r=x_idler_bolt_dia/2+clearance,h=cablechain_height+2);
			}

		// end = 4; frame mount front
		if (end == 4){
			mirror([1,0,0]){
				translate([-cablechain_length/2+2*wall,-cablechain_width/2-frame_width+frame_enclosure_thickness+clearance,cablechain_height])
					rotate([0,180,0])
						roundcorner_tear(wall,wall+2*cablechain_wall+clearance);
				translate([-cablechain_length/2+2*wall,-cablechain_width/2-frame_width+frame_enclosure_thickness+clearance,0])
					rotate([0,0,90]) rotate([0,-90,0]) rotate([-90,0,0])
						roundcorner(wall,wall+2*cablechain_wall+clearance);
				translate([-cablechain_length/2+wall,-cablechain_width/2-frame_width/2,cablechain_height/2])
					rotate([180,0,0])
						teardrop(endstop_screw_dia/2+clearance,wall+2*cablechain_wall+clearance+2);
				translate([-cablechain_length/2+2*wall+wall,-cablechain_width/2-wall,-1])
					cylinder(r=wall,h=cablechain_height+2);
			}
		}

	}

	// chain link 2 hinge wall thickness
	if (end != 2 && end != 3){
		translate([-cablechain_length/2+cablechain_height/2,-cablechain_width/2+2*cablechain_wall,cablechain_height/2])
			rotate([-90,0,0])
				cylinder(r1=cablechain_height/4,r2=cablechain_height/4-cablechain_wall,h=cablechain_wall);
		translate([-cablechain_length/2+cablechain_height/2,cablechain_width/2-2*cablechain_wall,cablechain_height/2])
			rotate([90,0,0])
				cylinder(r1=cablechain_height/4,r2=cablechain_height/4-cablechain_wall,h=cablechain_wall);
	}
}
