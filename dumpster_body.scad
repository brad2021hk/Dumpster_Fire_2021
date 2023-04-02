dumpster_width = 75;
dumpster_depth = 50;
$fn=100;

module empty_box(width, depth, height, wall_thickness) {
    difference () {
        cube([width, depth, height]);
        translate([wall_thickness, wall_thickness, wall_thickness]) cube([(width-(2*wall_thickness)), (depth-(2*wall_thickness)), height]);
    }
}

module rail_edge(rail_height=10, rail_thickness=4, rail_length=10) {
    translate([0, 0, rail_height]) rotate([-90, 0, 0]) linear_extrude(height=rail_length) polygon([ [0,0], [rail_thickness, rail_thickness], [rail_thickness, rail_height-rail_thickness], [0, rail_height] ]); 
}

module hinge(hinge_thickness=4.5, hinge_width=6, hinge_height=9, hinge_hole=3.2) {
    translate([hinge_width/2, hinge_height, 0]) rotate([0, 0, 180]) difference() {
        hull() {
            
            cylinder(h=hinge_thickness, d=hinge_width);
            translate([0, hinge_height, 0]) cylinder(h=hinge_thickness, d=hinge_width);
        }
        
        translate([0, 0, -0.1]) cylinder(h=hinge_thickness+0.2, d=hinge_hole);
    }
}


color("green") union() {
    difference() {
        empty_box(dumpster_width, dumpster_depth, 50, 5);
        rotate([-5, 0, 0]) translate([-5, 0.5, 50]) cube([100, 60, 20]);
        
        translate([-0.01, -0.01, 10]) rail_edge(3, 1, 100);
        translate([0, dumpster_depth+.01, 10]) rotate([0, 0, -90]) rail_edge(3, 1, 100);
        translate([dumpster_width+.01, dumpster_depth+.01, 10]) rotate([0, 0, 180]) rail_edge(3, 1, 100);
        
        translate([-0.01, -0.01, 40]) rail_edge(3, 1, 100);
        translate([0, dumpster_depth+.01, 40]) rotate([0, 0, -90]) rail_edge(3, 1, 100);
        translate([dumpster_width+.01, dumpster_depth+.01, 40]) rotate([0, 0, 180]) rail_edge(3, 1, 100);
        translate([dumpster_width-12.5, dumpster_depth-0.8, 15]) resize([dumpster_width-25, 1, 20]) rotate([90, 0, 180]) linear_extrude(height=1) text("2021");
        
    }

    translate([0, 0, 48]) rotate([90, 0, 90]) hinge(hinge_thickness=4.5, hinge_width=6, hinge_height=7, hinge_hole=3.2);
    translate([dumpster_width-4.5, 0, 48]) rotate([90, 0, 90]) hinge(hinge_thickness=4.5, hinge_width=6, hinge_height=7, hinge_hole=3.2);
    translate([(dumpster_width-4.5)/2, 0, 48]) rotate([90, 0, 90]) hinge(hinge_thickness=4.5, hinge_width=6, hinge_height=7, hinge_hole=3.2);
    
    translate([dumpster_width, 0, 20]) difference() {
        rail_edge(rail_height=14, rail_thickness=4, rail_length=dumpster_depth);
        translate([1, -0.1, 3]) rail_edge(rail_height=8, rail_thickness=2, rail_length=dumpster_depth+0.2);
    }

    translate([0, dumpster_depth, 20]) rotate([0, 0, 180]) difference() {
        rail_edge(rail_height=14, rail_thickness=4, rail_length=dumpster_depth);
        translate([1, -0.1, 3]) rail_edge(rail_height=8, rail_thickness=2, rail_length=dumpster_depth+0.2);
    }
    
}

lid_hinge_width = ((dumpster_width/2)-(4.5+2.25+0.4));
lid_width = dumpster_width/2;

module lid() {
    union() {
        translate([4.7, 0, 3.25+50]) rotate([90, 0, 90]) hinge(hinge_thickness=lid_hinge_width, hinge_width=6, hinge_height=1.8, hinge_hole=3.2);
        rotate([-5, 0, 0]) difference() {
            union() {
                translate([4.7, -0, 50.3]) cube([lid_hinge_width, 5, 2]);
                translate([4.7, -2, 50.3]) cube([lid_hinge_width, 5, 1]);
                translate([-0.2, 2, 50.3]) cube([lid_width, dumpster_depth-5, 2]);
            }
            
           translate([5.1, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
            translate([5.1*2, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
            translate([5.1*3, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
            translate([5.1*4, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
            translate([5.1*5, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
            translate([5.1*6, 2, 52.5]) rotate([0, 90, 0]) rail_edge(rail_height=2, rail_thickness=1, rail_length=dumpster_depth);
        }
    }
}

color("grey") lid();
color("grey") translate([2*lid_width, 0, 0]) mirror([90, 0, 0]) lid();


