


module bottom(){
difference(){
    union(){
        translate([0,0, 2/2])cube([120,120,2],center=true);
        translate([ 0, (-4-62)/2, 4/2])cube([57+3,65+1,4],center=true);
    }

    //bottom layer
    translate([ 0, (-4-62)/2, 0.99])cube([57,65.5,2],center=true);

    //marker line
    translate([0,-40,0.1])cube([120,0.2,0.21],center=true);
    translate([0,-20,0.1])cube([120,0.2,0.21],center=true);
    translate([0,  0,0.1])cube([120,0.2,0.21],center=true);
    translate([0, 20,0.1])cube([120,0.2,0.21],center=true);
    translate([0, 40,0.1])cube([120,0.2,0.21],center=true);
    translate([-40,0,0.1])cube([0.2,120,0.21],center=true);
    translate([-20,0,0.1])cube([0.2,120,0.21],center=true);
    translate([  0,0,0.1])cube([0.2,120,0.21],center=true);
    translate([ 20,0,0.1])cube([0.2,120,0.21],center=true);
    translate([ 40,0,0.1])cube([0.2,120,0.21],center=true);

    translate([0,-40,1.9])cube([120,0.2,0.21],center=true);
    translate([0,-20,1.9])cube([120,0.2,0.21],center=true);
    translate([0,  0,1.9])cube([120,0.2,0.21],center=true);
    translate([0, 20,1.9])cube([120,0.2,0.21],center=true);
    translate([0, 40,1.9])cube([120,0.2,0.21],center=true);
    translate([-40,0,1.9])cube([0.2,120,0.21],center=true);
    translate([-20,0,1.9])cube([0.2,120,0.21],center=true);
    translate([  0,0,1.9])cube([0.2,120,0.21],center=true);
    translate([ 20,0,1.9])cube([0.2,120,0.21],center=true);
    translate([ 40,0,1.9])cube([0.2,120,0.21],center=true);

    //sdcard
    //cylinder(10, r=10,center=true,$fn=50);

    //rpi
    translate([-24.5,-62,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 24.5,-62,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-24.5, -4,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 24.5, -4,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 24.5, (-4-62)/2,0])cube([5.2,52,10],center=true);
    translate([ 0, (-4-62)/2,0])cube([43,63,10],center=true);
    translate([ 0, (-4-62)/2,0])cube([55,52,10],center=true);

    //hole
    translate([-60, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([-40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([-20, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([  0, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 20, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 60, 20,0])cylinder(100, r=2.7,center=true,$fn=50);

    translate([-40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);

    translate([-40,-60,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 40,-60,0])cylinder(100, r=2.7,center=true,$fn=50);

    //batt
    translate([0, 40, 0])cube([1000,40.1,10],center=true);
}
}


bottom();