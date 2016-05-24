mounting_holes = [[-25, 0], [25, 0]];

module roundedcube(x,y,h,r) {
    hull() {
        translate([-x/2+r,-y/2+r,0]) cylinder(r=r, h=h, center=true);
        translate([x/2-r,-y/2+r,0]) cylinder(r=r, h=h, center=true);
        translate([-x/2+r,y/2-r,0]) cylinder(r=r, h=h, center=true);
        translate([x/2-r,y/2-r,0]) cylinder(r=r, h=h, center=true);
    }
}

module micromot() {
    difference() {
        $fn=50;
        height=10;

        // base shape, extruded
        union() { 
            translate([0,-10,0]) roundedcube(65,30,height,5);
            translate([0,5,0]) roundedcube(27.99,40,height,5);
        }
        //cube([65,40,height], center=true);

        // big round hole
        cylinder(r=10, h=2*height, center=true);
        // middle crack
        translate([0,5,0]) cube([2, 40, 2*height], center=true);
        // small round hole
        translate([0,-15,0]) cylinder(r=2.5, h=2*height, center=true);
        // right edge cut off
        translate([24,15,0]) cube([20,11,height*2],center=true);
        // left edge cut off
        translate([-24,15,0]) cube([20,11,height*2],center=true);

        // left crack
        translate([-15,5,0]) cube([2,30,height*2],center=true);
        translate([-15,-10,0]) cylinder(r=2.5, h=2*height, center=true);
        // right crack
        translate([15,5,0]) cube([2,30,height*2],center=true);
        translate([15,-10,0]) cylinder(r=2.5, h=2*height, center=true);
        // middle nut trap
        translate([-15,15,0]) rotate([0,90,0]) nut_trap(M4_clearance_radius, M4_nut_radius, M4_nut_trap_depth);
        // left nut trap
        for(xy = mounting_holes)
            translate([xy[0], xy[1], -15])
                nut_trap(M4_clearance_radius, M4_nut_radius, M4_nut_trap_depth);
    }
}
