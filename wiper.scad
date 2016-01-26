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



// RENDER
difference(){
    wiper();
    translate([0,0,frame_width/4])
        label("408",orientation="right");
}




module wiper(){
    wiper_pos = wiper_bin_edge_dia/2+wall_thin+2*wall;
    wiper_bin_translation = [-wiper_bin_edge_dia/2-wall_thin-2*wall,wiper_bin_ypos,0];
    wiper_bin_rotation = [0,0,0];
    wiper_clamp_elevation = frame_width-(wiper_height-wiper_excess_height);
    
    difference(){
        
        // main body wiper holder
        wiper_holder(wiper_pos,wiper_clamp_elevation);
        
        // wiper bin clearance
        translate(wiper_bin_translation+[0,0,wiper_bin_holder_height])
            difference(){
                cylinder(r=wiper_bin_edge_dia/2+wall_thin,h=wiper_bin_edge_height+wall_thin);
                translate([0,0,-1])
                    cylinder(r=wiper_bin_dia/2-wiper_bin_wallthickness-wall_thin,h=wiper_bin_edge_height+wall_thin+2);
            }
        translate(wiper_bin_translation+[0,0,-1])
            cylinder(r=wiper_bin_dia/2-wiper_bin_dia_clampreduction/2,h=wiper_bin_holder_height+wiper_bin_edge_height/2+1);
        
        // frame mount
        translate([1,0,frame_width/2])
            rotate([0,-90,0])
                cylinder(r=frame_center_screw_dia/2+clearance,h=wall+2);
        translate([-wall,0,frame_width/2])
            rotate([0,-90,0])
                cylinder(r=frame_center_screw_washer_dia/2+clearance,h=wiper_pos-wiper_width/2-wall_thin/2-wall+wall_thin/2);
        intersection(){
            hull(){
                translate([-wall-(frame_center_screw_head_length+wall_thin),0,frame_width/2])
                    rotate([0,-90,0])
                        cylinder(r=frame_center_screw_washer_dia/2+clearance,h=wiper_pos-wiper_width/2-wall_thin/2-wall-(frame_center_screw_head_length+wall_thin)+wall_thin/2);
                translate([-wall-(frame_center_screw_head_length+wall_thin),0,-frame_width/2])
                    rotate([0,-90,0])
                        cylinder(r=frame_center_screw_washer_dia/2+clearance,h=wiper_pos-wiper_width/2-wall_thin/2-wall-(frame_center_screw_head_length+wall_thin)+wall_thin/2);
            }
            translate(wiper_bin_translation+[0,0,wiper_bin_holder_height])
                cylinder(r=wiper_bin_dia/2-wiper_bin_dia_clampreduction/2,h=frame_width);
        }
        
        // print head x-move clearance
        translate([-2*wiper_bin_dia,-frame_width/2+wall+wall,wiper_clamp_elevation+wiper_height])
            rotate([45,0,0])
                translate([0,0,-frame_width/2])
                    cube([4*wiper_bin_dia,wiper_bin_dia,wiper_bin_dia]);
    }
    
    // bin holder
    translate(wiper_bin_translation)
        rotate(wiper_bin_rotation)
            bin_holder();
}

module wiper_holder(wiper_pos,wiper_clamp_elevation){
    difference(){
        
        // body
        union(){
            hull(){
                translate([-1,-frame_width/2,0])
                    cube([1,frame_width,frame_width]);
                translate([-wiper_pos-wiper_width/2-wall_thin/2+wall,-(frame_width/2-2*wall),0])
                    cylinder(r=2*wall,h=frame_width);
                translate([-wiper_pos-wiper_width/2-wall_thin/2,frame_width/2-wall,0])
                    cylinder(r=wall,h=frame_width);
            }
            
            // hood
            translate([0,0,wiper_clamp_elevation])
                hull(){
                    translate([-(wiper_width+wall_thin)/2-wiper_pos-wall,-1,0])
                        cube([wiper_width+wall_thin+2*wall,1,wiper_height]);
                    translate([-wiper_pos,0,0])
                        for(i=[0,1])
                            mirror([i,0,0])
                                translate([-wiper_width/2-wall_thin/2+wall,-frame_width/2+2*wall,0])
                                    cylinder(r=2*wall,h=wiper_height);
                }
        }
        
        // wiper clearance
        translate([0,0,wiper_bin_holder_height])
            hull(){
                translate([-(wiper_width+wall_thin)/2-wiper_pos,frame_width/2-(bed_clamp_maxclampwidth-wiper_thickness+wiper_compression)-1,-1])
                    cube([wiper_width+wall_thin,1,frame_width*2+2]);
                translate([-wiper_pos,0,0])
                    for(i=[0,1])
                        mirror([i,0,0])
                            translate([-wiper_width/2-wall_thin/2+wall,-frame_width/2+2*wall,-1])
                                cylinder(r=wall,h=frame_width*2+2);
            }
            
        // foldback clamp clearance
        translate([-(wiper_width+wall_thin)/2-wiper_pos,frame_width/2-(bed_clamp_maxclampwidth-wiper_thickness+wiper_compression)-1,-bed_clamp_angle_length])
            cube([wiper_width+wall_thin,bed_clamp_maxclampwidth-wiper_thickness+wiper_compression+2,frame_width]);
    }
}

module bin_holder(){
    difference(){
        cylinder(r=wiper_bin_dia/2-wiper_bin_dia_clampreduction+wiper_bin_holder_width,h=wiper_bin_holder_height);
        translate([0,0,-1])
            cylinder(r=wiper_bin_dia/2-wiper_bin_dia_clampreduction,h=wiper_bin_holder_height+2);
        translate([0,0,wiper_bin_holder_height/2])
            rotate([0,0,180-wiper_bin_clearance_angle/2])
                pie_slice(radius=wiper_bin_dia/2+wiper_bin_holder_width+1,angle=wiper_bin_clearance_angle,height=wiper_bin_holder_height+2);
    }
    for(i=[-1,1])
        rotate([0,0,i*(180-wiper_bin_clearance_angle/2)])
            translate([wiper_bin_dia/2-wiper_bin_dia_clampreduction+wiper_bin_holder_width/2,0,0])
                cylinder(r=wiper_bin_holder_width/2,h=wiper_bin_holder_height);


}

