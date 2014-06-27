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

// TOP FRONT LEFT
* rotate([180,0,0]) frame_corner(hinge=1);

// TOP FRONT RIGHT
* rotate([180,0,0]) mirror([1,0,0]) frame_corner(hinge=1);

// TOP BACK 2x
// BOTTOM 4x
* rotate([180,0,0]) frame_corner(hinge=0);

// MIDDLE FRONT LEFT
* frame_corner_middle(hinge=1);

// MIDDLE FRONT RIGHT
* mirror([1,0,0]) frame_corner_middle(hinge=1);

// MIDDLE BACK 2x
* frame_corner_middle(hinge=0);

// DOOR HINGE TOP LEFT
* rotate([180,0,0]) frame_corner_door_top();

// DOOR HINGE TOP RIGHT
 rotate([180,0,0]) mirror([1,0,0]) frame_corner_door_top();

// DOOR HINGE BOTTOM LEFT
* frame_corner_door_bottom();

// DOOR HINGE BOTTOM RIGHT
* mirror([1,0,0]) frame_corner_door_bottom();






module frame_corner(hinge=0){
	difference(){

		// main body
		translate([-frame_enclosure_thickness-clearance-wall,-frame_enclosure_thickness-clearance-wall,-frame_width])
			hull(){
				translate([wall,wall,0])
					cylinder(r=wall,h=frame_corner_body_height);
				translate([frame_corner_body_side-wall,wall,0])
					cylinder(r=wall,h=frame_corner_body_height);
				translate([wall,frame_corner_body_side-wall,0])
					cylinder(r=wall,h=frame_corner_body_height);
				translate([frame_corner_body_side-wall,frame_corner_body_side-wall,0])
					cylinder(r=wall,h=frame_corner_body_height);
			}

		// body clearance
		difference(){
			translate([wall,wall,-frame_width-wall])
				cube([frame_corner_body_side-frame_enclosure_thickness-clearance-wall-wall-wall,frame_corner_body_side-frame_enclosure_thickness-clearance-wall-wall-wall,frame_corner_body_height]);
			for(i=[0,1])
				mirror([i,-i,0])
					translate([-(wall+clearance+frame_screw_dia/2)+frame_width+frame_width/2,-frame_corner_body_side+frame_width-wall-clearance,-frame_width])
						cube([wall+clearance+frame_screw_dia+clearance+wall,frame_corner_body_side,frame_corner_body_height]);
		}
		difference(){
			union(){
				translate([-clearance-frame_enclosure_thickness-clearance,-clearance-frame_enclosure_thickness-clearance,-(frame_width-wall-clearance-wall-wall)-wall])
					cube([frame_corner_body_side-wall-clearance-wall-wall,frame_corner_body_side-wall-clearance-wall-wall,frame_width-wall-clearance-wall-wall]);
				translate([-clearance-frame_enclosure_thickness-clearance,wall+wall,-(frame_width-wall-clearance-wall-wall)-wall])
					cube([frame_corner_body_side-wall-clearance-wall-wall,2*frame_width-wall-clearance-wall-wall-wall,frame_corner_body_height-wall-wall-clearance-wall]);
				if(hinge==0)
					translate([-clearance-frame_enclosure_thickness-clearance,-clearance-frame_enclosure_thickness-clearance,-(frame_width-wall-clearance-wall-wall)-wall])
						cube([frame_corner_body_side-wall-clearance-wall-wall,frame_corner_body_side-wall-clearance-wall-wall,frame_corner_body_height-wall-wall-clearance-wall]);
			}
			for(i=[0,1])
				mirror([i,-i,0])
					translate([-(wall+clearance+frame_screw_dia/2)+frame_width+frame_width/2,-frame_corner_body_side+frame_width-wall-clearance,-frame_width])
						cube([wall+clearance+frame_screw_dia+clearance+wall,frame_corner_body_side,frame_corner_body_height]);
			translate([-frame_corner_body_side+wall,-frame_corner_body_side+wall,-frame_width])
				cube([frame_corner_body_side,frame_corner_body_side,2*frame_width]);
			if(hinge==1)
				translate([-frame_corner_body_side+wall,-frame_corner_body_side+wall+wall,-frame_width])
					cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);
		}

		// frame clearance
		translate([-clearance,-clearance,-frame_corner_body_height+clearance])
			cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);

		// frame enclosure clearance top
		difference(){
			translate([-clearance,-clearance,-frame_corner_body_height+frame_enclosure_thickness+clearance])
				cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);
			translate([-frame_enclosure_thickness-clearance-wall-wall-clearance,-frame_enclosure_thickness-clearance-wall-wall-clearance,-frame_width-1])
				cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height+2]);
		}

		// frame enclosure clearance side
		for(i=[0,1])
			mirror([i,-i,0]){
				translate([-frame_enclosure_thickness-clearance,-frame_enclosure_thickness-clearance,-frame_corner_body_height-frame_width+wall+clearance])
					cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);
				translate([-frame_enclosure_thickness-clearance,2*frame_width-wall-clearance,-frame_corner_body_height+frame_enclosure_thickness+clearance])
					cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);
			}

		// frame mount screw holes
		for(i=[0,1])
			mirror([i,-i,0])
				translate([(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,frame_width+frame_width/2,-frame_width/2])
					rotate([180,0,0])
						teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);
		if(hinge==1)
			translate([frame_width+frame_width/2,frame_width/2,-frame_width-1])
				cylinder(r=frame_screw_dia/2+clearance,h=frame_corner_body_height+2);

		// door hinge clearance and bolt hole
		if(hinge==1){
			translate([-frame_enclosure_thickness-clearance-wall-1,-frame_corner_body_side,-frame_width-1])
				cube([frame_corner_body_side+2,frame_corner_body_side,frame_width+frame_enclosure_thickness+clearance+1]);
			translate([-frame_corner_body_side,-frame_corner_body_side+wall,-frame_width-1])
				cube([frame_corner_body_side,frame_corner_body_side,frame_width+frame_enclosure_thickness+clearance+1]);
			translate([(-frame_enclosure_thickness-clearance-wall)/2,(-frame_enclosure_thickness-clearance-wall)/2,-(frame_enclosure_door_hinge_bolt_length+2*clearance)+frame_enclosure_thickness+clearance+2*wall])
				cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance,h=frame_enclosure_door_hinge_bolt_length+2*clearance);
		}
	}
}



module frame_corner_door_top(){
	difference(){

		// main body
		intersection(){
			translate([-frame_enclosure_thickness-clearance-wall,-frame_enclosure_thickness-clearance-wall,-frame_width])
				hull(){
					translate([wall,wall,0])
						cylinder(r=wall,h=frame_corner_body_height);
					translate([frame_corner_body_side-wall,wall,0])
						cylinder(r=wall,h=frame_corner_body_height);
					translate([wall,frame_corner_body_side-wall,0])
						cylinder(r=wall,h=frame_corner_body_height);
					translate([frame_corner_body_side-wall,frame_corner_body_side-wall,0])
						cylinder(r=wall,h=frame_corner_body_height);
				}
			translate([-frame_enclosure_thickness-clearance-wall-1,-frame_corner_body_side-clearance,-frame_width-1-wall_thin])
				cube([frame_corner_body_side+2,frame_corner_body_side,frame_width+frame_enclosure_thickness-clearance+1]);
		}

		// frame enclosure clearance (door)
		translate([-clearance,-frame_enclosure_thickness-clearance,-frame_corner_body_height+frame_enclosure_thickness-wall+clearance])
			cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height]);
		translate([2*frame_width-wall-clearance,-frame_enclosure_thickness-clearance,-frame_width-1])
			cube([frame_corner_body_side,frame_corner_body_side,frame_corner_body_height+2]);

		// frame mount screw holes
		translate([frame_width/2,(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,-frame_width/2])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);
		translate([frame_width+frame_width/2,(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,-frame_width/2])
			rotate([0,0,90])
				rotate([180,0,0])
					teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);

		// door hinge bolt hole
		translate([(-frame_enclosure_thickness-clearance-wall)/2,(-frame_enclosure_thickness-clearance-wall)/2,-(frame_enclosure_door_hinge_bolt_length+2*clearance)+frame_enclosure_thickness+clearance+2*wall-wall_thin-wall])
			cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance,h=frame_enclosure_door_hinge_bolt_length+2*clearance);
	}
}



module frame_corner_middle(hinge=0){
	difference(){

		// main body
		translate([-frame_enclosure_thickness-clearance-wall,-frame_enclosure_thickness-clearance-wall,-frame_width])
			hull(){
				translate([wall,wall,0])
					cylinder(r=wall,h=2*frame_width);
				translate([frame_corner_body_side-wall,wall,0])
					cylinder(r=wall,h=2*frame_width);
				translate([wall,frame_corner_body_side-wall,0])
					cylinder(r=wall,h=2*frame_width);
				translate([frame_corner_body_side-wall,frame_corner_body_side-wall,0])
					cylinder(r=wall,h=2*frame_width);
			}

		// body clearance
		difference(){
			translate([-frame_enclosure_thickness-clearance,-frame_enclosure_thickness-clearance,-frame_width+wall])
				cube([frame_corner_body_side-wall-wall-clearance-wall,frame_corner_body_side-wall-wall-clearance-wall,2*frame_width-wall-clearance-wall-wall]);
			for(i=[0,1])
				mirror([i,-i,0]){
					translate([-(wall+clearance+frame_screw_dia/2)+frame_width+frame_width/2,-frame_enclosure_thickness-clearance-wall-1,-frame_width])
						cube([wall+clearance+frame_screw_dia+clearance+wall,frame_corner_body_side,2*frame_width]);
					translate([-(wall+clearance+frame_screw_dia/2)+frame_width/2,-frame_enclosure_thickness-clearance-wall-1,-frame_width])
						cube([wall+clearance+frame_screw_dia+clearance+wall,frame_corner_body_side,2*frame_width]);
				}
			translate([-frame_corner_body_side+wall,-frame_corner_body_side+wall,-frame_width])
				cube([frame_corner_body_side,frame_corner_body_side,2*frame_width]);
			if(hinge==1){
				translate([-frame_enclosure_thickness-clearance-wall-1,-frame_corner_body_side+wall,-clearance-wall])
					cube([frame_corner_body_side+2,frame_corner_body_side,frame_width+1]);
				translate([-frame_corner_body_side+wall,-frame_corner_body_side+wall+wall,-frame_width])
					cube([frame_corner_body_side,frame_corner_body_side,2*frame_width]);
			}
		}

		// frame clearance
		translate([-clearance,-clearance,-frame_width-1])
			cube([frame_corner_body_side,frame_corner_body_side,2*frame_width+2]);

		// frame enclosure clearance side
		for(i=[0,1])
			mirror([i,-i,0]){
				translate([-frame_enclosure_thickness-clearance,-frame_enclosure_thickness-clearance,frame_width-wall-clearance])
					cube([frame_corner_body_side,frame_corner_body_side,frame_width]);
				translate([-frame_enclosure_thickness-clearance,2*frame_width-wall-clearance,-frame_width-1])
					cube([frame_corner_body_side,frame_corner_body_side,2*frame_width+2]);
			}

		// frame mount screw holes
		for(i=[0,1])
			mirror([i,-i,0])
				translate([(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,frame_width+frame_width/2,frame_width/2])
					teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);
		if(hinge==1)
			mirror([1,-1,0])
				translate([(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,frame_width/2,-frame_width/2])
					teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);

		// door hinge clearance and bolt hole
		if(hinge==1){
			translate([-frame_enclosure_thickness-clearance-wall-1,-frame_corner_body_side+wall,-clearance])
				cube([frame_corner_body_side+2,frame_corner_body_side,frame_width+clearance+1]);
			translate([(-frame_enclosure_thickness-clearance-wall)/2,(-frame_enclosure_thickness-clearance-wall)/2,-(frame_enclosure_door_hinge_bolt_length+2*clearance)/2-wall])
				cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance,h=frame_enclosure_door_hinge_bolt_length+2*clearance);
		}
	}
}



module frame_corner_door_bottom(){
	difference(){

		// main body
		intersection(){
			translate([-frame_enclosure_thickness-clearance-wall,-frame_enclosure_thickness-clearance-wall,-frame_width])
				hull(){
					translate([wall,wall,0])
						cylinder(r=wall,h=2*frame_width);
					translate([frame_corner_body_side-wall,wall,0])
						cylinder(r=wall,h=2*frame_width);
					translate([wall,frame_corner_body_side-wall,0])
						cylinder(r=wall,h=2*frame_width);
					translate([frame_corner_body_side-wall,frame_corner_body_side-wall,0])
						cylinder(r=wall,h=2*frame_width);
				}
			translate([-frame_enclosure_thickness-clearance-wall-1,-frame_corner_body_side-clearance,clearance])
				cube([frame_corner_body_side+2,frame_corner_body_side,frame_width-clearance+1]);
		}

		// frame enclosure clearance (door)
		translate([-clearance,-frame_enclosure_thickness-clearance,wall-clearance])
			cube([frame_corner_body_side,frame_corner_body_side,frame_width]);
		translate([2*frame_width-wall-clearance,-frame_enclosure_thickness-clearance,-frame_width-1])
			cube([frame_corner_body_side,frame_corner_body_side,2*frame_width+2]);

		// frame mount screw holes
		translate([frame_width+frame_width/2,(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,frame_width/2])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);
		translate([frame_width/2,(frame_corner_body_side+2)/2-frame_enclosure_thickness-clearance-wall-1,frame_width/2])
			rotate([0,0,90])
				teardrop(frame_screw_dia/2+clearance,frame_corner_body_side+2);

		// door hinge bolt hole
		translate([(-frame_enclosure_thickness-clearance-wall)/2,(-frame_enclosure_thickness-clearance-wall)/2,-(frame_enclosure_door_hinge_bolt_length+2*clearance)/2])
			cylinder(r=frame_enclosure_door_hinge_bolt_dia/2+clearance,h=frame_enclosure_door_hinge_bolt_length+2*clearance);
	}
}


