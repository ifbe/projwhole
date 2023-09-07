
module itx(){
    //top
    translate([120,170,0])cube([50,10,2]);
    translate([60,170,0])cube([50,10,2]);
    translate([0,170,0])cube([50,10,2]);

    //bot
    translate([120,-10,0])cube([50,10,2]);
    translate([60,-10,0])cube([50,10,2]);
    translate([0,-10,0])cube([50,10,2]);

    //left
    translate([-10,120,0])cube([10,50,2]);
    translate([-10,60,0])cube([10,50,2]);
    translate([-10,0,0])cube([10,50,2]);

    //right
    translate([170,120,0])cube([10,50,2]);
    translate([170,60,0])cube([10,50,2]);
    translate([170,0,0])cube([10,50,2]);

    difference(){
    cube([170, 170, 2]);
    translate([170/2,170/2,0])cube([150, 150, 10],center=true);
    //0.25, h-0.4
    translate([6.35, 170-10.16,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25+6.2, h-0.4-0.9
    translate([6.35+157.48, 170-10.16-22.86,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35+157.48, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    }
}

itx();