
module one(){
difference(){
    union(){
    translate([0, 0, 1])rotate([0, 0, 45])cube([9.8, 4.8, 2],center=true);
    translate([0, 0, 1])rotate([0, 0,-45])cube([9.8, 4.8, 2],center=true);
    }
    cylinder(100, r=2.6,center=true,$fn=50);
}
}

module bottom(){
difference(){
    translate([0, 0, -1])cube([9.8, 49.8, 2], center=true);

    //
    translate([0, 0, -1/2])cube([10, 20, 1.01], center=true);

    //side
    //translate([4, 0, -1])cube([2, 50, 2.01], center=true);

    //hole 5mm
    translate([0, 0, 0])cylinder(100, r=2,center=true,$fn=50);

    //hole 3mm
    translate([0,-20, 0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([0, 20, 0])cylinder(100, r=1.6,center=true,$fn=50);
}
}

module batthelp(){
    translate([0, 20, 0])one();
    translate([0, -20, 0])one();
    bottom();
}

module board(){
difference(){
    translate([0, 0, -1])cube([120, 120, 2],center=true);

    //xxx
    translate([-40, 0, 0])cube([10.2, 50.2, 10], center=true);
    translate([ 40, 0, 0])cube([10.2, 50.2, 10], center=true);

    translate([0, 20, 0])cylinder(100, r=2.6,center=true,$fn=50);
    translate([0,-20, 0])cylinder(100, r=2.6,center=true,$fn=50);

    //
    translate([ 0, 40, -1/2])cube([120, 12, 1.01], center=true);
    translate([ 0,  0, -1/2])cube([120, 12, 1.01], center=true);
    translate([ 0,-40, -1/2])cube([120, 12, 1.01], center=true);

    //
    translate([-20, 0, -1/2])cube([12, 120, 1.01], center=true);
    translate([ 20, 0, -1/2])cube([12, 120, 1.01], center=true);
}
}

translate([ 40, 0, 0])batthelp();
translate([-40, 0, 0])rotate([0,0,180])batthelp();
board();