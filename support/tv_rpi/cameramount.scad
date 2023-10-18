holerad=2;
module pi(){
difference(){
translate([0,0,-5])cube([90,13+4,10],center=true);
translate([0,0,-5])cube([90.01,13.01,10],center=true);
}
difference(){
    translate([0,0,0.5])cube([90,55,1],center=true);
    translate([20-60,-24.5, 1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-60, 24.5, 1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-2,-24.5,  1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-2, 24.5,  1])cylinder(4, r=holerad,center=true,$fn=50);
}
}
//pi();



module landing(){
    difference(){
    translate([0,0,-5])cube([100,13+4,10],center=true);
    translate([0,0,-5])cube([100.01,13.01,10],center=true);
    }
    difference(){
        translate([0,0,5])cube([100,70,10],center=true);
        translate([0,0,6])cube([96,66,8],center=true);
    }
}

landing();