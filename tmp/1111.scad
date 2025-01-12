module aa(){
difference(){
    union(){
    translate([0,8,0])cylinder(2.5,r=8,center=true,$fn=50);
    translate([3,2,0])cube([6,4,2.5],center=true);
    }
    translate([0,8,0])cylinder(3,r=3,center=true,$fn=50);
    translate([-4,4,0])cube([8,8,3],center=true);
}
translate([0,-3,0])cube([13,6,2.5],center=true);
translate([0,-3-26/2,0])cube([7,26,2.5],center=true);
}

module bb(){
difference(){
    translate([0,12.5,0])cylinder(2.5,r=13,center=true,$fn=50);
}
translate([0,-26/2,0])cube([7,26,2.5],center=true);
}

module cc(){
translate([0, 4/2,0])cube([10,4,2.5],center=true);
translate([0,-33/2,0])cube([4.6,33,2.5],center=true);
}

/*
aa();
translate([12,13,0])bb();
*/
cc();