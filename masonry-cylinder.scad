// Masonry texture test

//$fn=32;

masonry_cylinder(25,20,1.5,10,2);
translate([0,0,20]) masonry_cylinder(18,35,1.5,10,4);
translate([0,0,55]) masonry_cylinder(25,20,1.5,10,2);


module masonry_cylinder(radius, height, depth, verticalgrooves, horizontalgrooves) {
    difference() {
        cylinder(r=radius, h=height);
        for(i=[0:1:horizontalgrooves]) {
            translate([0,0,i*height/horizontalgrooves]) mortar_horizontal   (radius,height,depth);
            for(j=[0:360/verticalgrooves:359]) {
                rotate(j + (i % 2) * 180/verticalgrooves) translate([0,0,i*height/horizontalgrooves]) mortar_vertical(radius,height/horizontalgrooves,depth);
            }
        }
    }
}
module mortar_horizontal(radius, height, depth) {
    rotate_extrude() {
        translate([radius-depth,0,0]) mortar_shape(radius, height, depth);
    }
}

module mortar_vertical(radius, height, depth) {
    translate([radius-depth,0,0])
        linear_extrude(height=height)
        mortar_shape(radius, height, depth);
}

module mortar_shape(radius, height, depth) {
        intersection() {
            difference() {
                translate([0,-depth,0]) square([2*depth,2*depth]);
                translate([0,depth,0]) circle(depth);
                translate([0,-depth,0]) circle(depth);
            }
            // 1.2 seems right, but why not extend a tad?
            translate([-radius+depth*1.3,0,0]) circle(radius);
        }
}