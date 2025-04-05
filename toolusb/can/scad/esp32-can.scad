

module aa0330(){
    translate([ 26.5/2-10, 18/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([-26.5/2-10, 18/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([ 26.5/2-10,-18/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([-26.5/2-10,-18/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    //
    difference(){
        translate([0, 0, -4/2])cube([60+2, 31+2, 4],center=true);
        translate([0, 0, -1-4/2])cube([60, 31, 4.01],center=true);
    }
}


module bb(){
    difference(){
        union(){
        translate([0, -26/2-1/2, 6/2])cube([20, 1, 6],center=true);
        translate([0,  26/2+1/2, 6/2])cube([20, 1, 6],center=true);
        }
        //
        translate([-10+2/2, 0, 4/2])cube([2, 99, 4],center=true);
        translate([ 10-2/2, 0, 4/2])cube([2, 99, 4],center=true);
    }
    translate([ 23/2-0.2, 19/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([-23/2+0.2, 19/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([ 23/2-0.2,-19/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    translate([-23/2+0.2,-19/2, 4/2])cylinder(r=1.6, h=4, center=true, $fn=50);
    //
    difference(){
        translate([0, 0, -4/2])cube([60+2, 31+2, 4],center=true);
        translate([0, 0, -1-4/2])cube([60, 31, 4.01],center=true);
    }
}


//bb();
aa0330();