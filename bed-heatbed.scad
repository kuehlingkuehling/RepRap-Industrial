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

// DEV
// bed_heatbed_width = 312;    // PEI printbed size: 210*310 - Model HT500 S300200
bed_heatbed_width = 212;    // PEI printbed size: 210*210 - Model HT500 default
bed_heatbed_length = 212;
bed_heatbed_thickness = 6;
bed_heatbed_thickness_topbottom = 1;
bed_heatbed_thickness_middle = 4;
bed_heatbed_honeycomb_size = 60;
bed_heatbed_honeycomb_landwidth = 4;
bed_heatbed_honeycomb_frame = 4;
bed_heatbed_top_holes = 2;

// RENDER (DXF)
* projection(cut=true) bed_heatbed(layer="top");
* projection(cut=true) bed_heatbed(layer="middle");
* projection(cut=true) bed_heatbed(layer="bottom");



module bed_heatbed(layer="top"){
	difference(){

		// main body
        if((layer=="top")||(layer=="bottom"))
            cube([bed_heatbed_width,bed_heatbed_length,bed_heatbed_thickness_topbottom],center=true);
        if(layer=="middle")
            cube([bed_heatbed_width,bed_heatbed_length,bed_heatbed_thickness_middle],center=true);

        // honeycomb
        intersection(){
            cube([bed_heatbed_width-2*bed_heatbed_honeycomb_frame,bed_heatbed_length-2*bed_heatbed_honeycomb_frame,bed_heatbed_thickness_middle+2],center=true);
            for(x=[-ceil((2*bed_heatbed_width/(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth))/2):ceil((2*bed_heatbed_width/(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth))/2)])
                translate([x*(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth),0,0])
                    rotate([0,0,-60])
                        for(y=[-ceil(((2*bed_heatbed_length)/(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth))/2):ceil(((2*bed_heatbed_length)/(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth))/2)])
                            translate([y*(bed_heatbed_honeycomb_size+bed_heatbed_honeycomb_landwidth),0,0])
                                rotate([0,0,30]){
                                    if(layer=="top")
                                        for(i=[0:5])
                                            rotate([0,0,i*60])
                                                translate([bed_heatbed_honeycomb_size/2,0,0])
                                                    cylinder(r=bed_heatbed_top_holes/2,h=bed_heatbed_thickness_topbottom+2,center=true);
                                    if(layer=="middle")
                                        nut_trap(bed_heatbed_honeycomb_size,bed_heatbed_thickness_middle+2,clearance=0);
                                    if(layer=="bottom")
                                        cylinder(r=0,h=bed_heatbed_thickness_topbottom+2,center=true);
                                }
        }
	}
}




