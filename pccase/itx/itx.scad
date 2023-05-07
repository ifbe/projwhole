
module itx(){
difference(){
    cube([170, 170, 2]);
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