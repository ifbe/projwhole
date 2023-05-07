
module bottom(){
difference(){
    union(){
        translate([0,0, 4/2])cube([70,20,4],center=true);
        translate([ 14,10-2/2, 60/2])cube([2,2,60],center=true);
        translate([-14,10-2/2, 60/2])cube([2,2,60],center=true);
        translate([ 14,8-2/2, 45.5/2])cube([2,2,45.5],center=true);
        translate([-14,8-2/2, 45.5/2])cube([2,2,45.5],center=true);
        translate([ 14,6-2/2, 30.4/2])cube([2,2,30.4],center=true);
        translate([-14,6-2/2, 30.4/2])cube([2,2,30.4],center=true);
        translate([ 14,4-2/2, 15/2])cube([2,2,15],center=true);
        translate([-14,4-2/2, 15/2])cube([2,2,15],center=true);
    }

    //rpi
    translate([ 0, (-4-62)/2, 2/2])cube([60,65+1,2.01],center=true);
    translate([ 0, (-4-62)/2,0])cube([43,66,100],center=true);
    translate([ 0, (-4-62)/2,0])cube([60,52,100],center=true);

    //screw
    translate([-24.5, -4,0])cylinder(110, r=1.6,center=true,$fn=50);
    translate([ 24.5, -4,0])cylinder(110, r=1.6,center=true,$fn=50);
}
}

module upper(){
difference(){
    union(){
        translate([0,1, 1+60/2])cube([30,2,60],center=true);
    }

    //camera
    translate([0,0, 4+30/2])cube([26,10,30],center=true);
    translate([0,0, 55-12.5/2])cube([14,10,20],center=true);
    translate([-21/2,0,55-12.5])rotate([90,0,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,0,55-12.5])rotate([90,0,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2,0,55])rotate([90,0,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,0,55])rotate([90,0,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}


bottom();
rotate([-7.5,0,0])upper();