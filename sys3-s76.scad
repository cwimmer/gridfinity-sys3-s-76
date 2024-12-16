use <gridfinity-rebuilt-openscad-main/gridfinity-rebuilt-baseplate.scad>;
include <gridfinity-rebuilt-openscad-main/src/core/standard.scad>
use <gridfinity-rebuilt-openscad-main/src/core/gridfinity-rebuilt-utility.scad>
use <gridfinity-rebuilt-openscad-main/src/core/gridfinity-rebuilt-holes.scad>
use <gridfinity-rebuilt-openscad-main/src/helpers/generic-helpers.scad>


// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25;

/* [General Settings] */
// number of bases along x-axis
gridx = 6;
// number of bases along y-axis
gridy = 0;

/* [Screw Together Settings - Defaults work for M3 and 4-40] */
// screw diameter
d_screw = 3.35;
// screw head diameter
d_screw_head = 5;
// screw spacing distance
screw_spacing = .5;
// number of screws per grid block
n_screws = 1; // [1:3]


/* [Fit to Drawer] */
// minimum length of baseplate along x (leave zero to ignore, will automatically fill area if gridx is zero)
distancex = 254;
// minimum length of baseplate along y (leave zero to ignore, will automatically fill area if gridy is zero)
distancey = 163;

//Size of notches in the front and rear of the baseplate
notch = 120;
notch_offset = (distancex - notch)/2;

// where to align extra space along x
fitx = 0; // [-1:0.1:1]
// where to align extra space along y
fity = 0; // [-1:0.1:1]


/* [Styles] */

// baseplate styles
style_plate = 0; // [0: thin, 1:weighted, 2:skeletonized, 3: screw together, 4: screw together minimal]


// hole styles
style_hole = 0; // [0:none, 1:countersink, 2:counterbore]

/* [Magnet Hole] */
// Baseplate will have holes for 6mm Diameter x 2mm high magnets.
enable_magnet = true;
// Magnet holes will have crush ribs to hold the magnet.
crush_ribs = true;
// Magnet holes will have a chamfer to ease insertion.
chamfer_holes = true;

hole_options = bundle_hole_options(refined_hole=false, magnet_hole=enable_magnet, screw_hole=false, crush_ribs=crush_ribs, chamfer=chamfer_holes, supportless=false);

// ===== IMPLEMENTATION ===== //

color("tomato")
difference() {
    translate([distancex/2, distancey/2, 0])
        gridfinityBaseplate([gridx, gridy], l_grid, [distancex, distancey], style_plate, hole_options, style_hole, [fitx, fity]);
    // Bottom Left corner
    translate([0,0,-1])
        cylinder(d=28, h=10, $fn=100);
    // Bottom Right corner
    translate([distancex, 0, -1])
        cylinder(d=28, h=10, $fn=100);
    // Top Right corner
    translate([distancex, distancey, -1])
        cube([21, 36.5, 20], center=true);
        cylinder(d=28, h=10, $fn=100);
    // Top Left corner
    translate([0, distancey, -1])
        cube([21, 36.5, 20], center=true);
    // Left notch
    translate([-1, distancey/2-1.75, -1])
        cube([7.5, 7.5, 10]);
    // Right notch
    translate([distancex-6.5, distancey/2-1.75, -1])
        cube([7.5, 7.5, 10]);
    // Front notche
    translate([notch_offset, -1, -1])
        cube([notch, 13, 10]);
    // Rear notche
    translate([notch_offset, distancey-8, -1])
        cube([notch, 9, 10]);
}