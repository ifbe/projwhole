
module motor_x(){
    translate([ 60-30, 60+30,0])rotate([0,90,-45])cylinder(40, r=20,center=true,$fn=50);
    translate([-60+30, 60+30,0])rotate([0,90, 45])cylinder(40, r=20,center=true,$fn=50);
    translate([ 60-30,-60-30,0])rotate([0,90, 45])cylinder(40, r=20,center=true,$fn=50);
    translate([-60+30,-60-30,0])rotate([0,90,-45])cylinder(40, r=20,center=true,$fn=50);
}

module board()
{
    difference(){
        union(){
        translate([0,0,1])cube([120,120,2],center=true);
        translate([ 60, 60,1])cylinder(2, r=16,center=true,$fn=50);
        translate([-60, 60,1])cylinder(2, r=16,center=true,$fn=50);
        translate([ 60,-60,1])cylinder(2, r=16,center=true,$fn=50);
        translate([-60,-60,1])cylinder(2, r=16,center=true,$fn=50);
        }

        cube([80,80,5],center=true);

        translate([ 60, 60,1])cylinder(7, r=2.5,center=true,$fn=50);
        for(x=[0:45:360]){
        translate([ 60, 60,1])rotate([0,0,x])translate([ 10,0,0])cylinder(7, r=2.5,center=true,$fn=50);
        }

        translate([-60, 60,1])cylinder(7, r=2.5,center=true,$fn=50);
        for(x=[0:45:360]){
        translate([-60, 60,1])rotate([0,0,x])translate([-10,0,0])cylinder(7, r=2.5,center=true,$fn=50);
        }

        translate([ 60,-60,1])cylinder(7, r=2.5,center=true,$fn=50);
        for(x=[0:45:360]){
        translate([ 60,-60,1])rotate([0,0,x])translate([0, 10,0])cylinder(7, r=2.5,center=true,$fn=50);
        }

        translate([-60,-60,1])cylinder(7, r=2.5,center=true,$fn=50);
        for(x=[0:45:360]){
        translate([-60,-60,1])rotate([0,0,x])translate([0,-10,0])cylinder(7, r=2.5,center=true,$fn=50);
        }
    }
}

module bot_motorseat(){
difference(){
    translate([0, 40,2.5])cube([24,80,5],center=true);
    cube([26,110,20],center=true);

    //shaft hole
    translate([0, 80,0])cylinder(20, r=5,center=true,$fn=50);
    translate([0,-80,0])cylinder(20, r=5,center=true,$fn=50);

    //shaft hole
    translate([0, 80-11.5,0])cylinder(20, r=2.2,center=true,$fn=50);
    translate([0,-80+11.5,0])cylinder(20, r=2.2,center=true,$fn=50);

    //screw hole
    translate([-8.6, 80-21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([ 8.6, 80-21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([-8.6,-80+21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([ 8.6,-80+21,0])cylinder(20, r=1.6,center=true,$fn=50);

    translate([-8.6, 80-21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 8.6, 80-21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-8.6,-80+21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 8.6,-80+21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
}
}
module bot_motorseat_helper()
{
    difference(){
        cube([20,40,6.5],center=true);

        translate([0,-10, 6.5/2-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0,-10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0,-10,-6.5/2+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);

        translate([0, 10, 6.5/2-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0, 10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0, 10,-6.5/2+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
    }
}
module motorseat_extra(){
    difference(){
        union(){
        translate([10, 36/2-6.5/2, -5/2])cube([20,6.5,5],center=true);
        translate([0, 0,-5/2])cylinder(5, r=18,center=true,$fn=100);
        translate([10,-36/2+6.5/2, -5/2])cube([20,6.5,5],center=true);
        }
        translate([20, 0, 0])cube([20,23,20],center=true);
        translate([ 0, 0, -5+1.5])cylinder(h=3.01,r=14,center=true,$fn=100);
        translate([  0, 10, 0])cylinder(h=100,r=2.5,center=true,$fn=50);
        translate([  0,  0, 0])cylinder(h=100,r=2.5,center=true,$fn=50);
        translate([-10,  0, 0])cylinder(h=100,r=2.5,center=true,$fn=50);
        translate([  0,-10, 0])cylinder(h=100,r=2.5,center=true,$fn=50);
    }
}
module motorseat(){
    translate([30, 36/2-6.5/2, -20])rotate([90,0,0])bot_motorseat_helper();

    translate([40,0, 40])rotate([-90, 0, 90])bot_motorseat();

    motorseat_extra();

    translate([30,-36/2+6.5/2, -20])rotate([90,0,0])bot_motorseat_helper();
}
module motorseat_four()
{
    translate([ 60, 60,40])rotate([0,0, 135])motorseat();
    translate([-60, 60,40])rotate([0,0,  45])motorseat();
    translate([ 60,-60,40])rotate([0,0,-135])motorseat();
    translate([-60,-60,40])rotate([0,0, -45])motorseat();
}

wheeldiameter = 60;
module wheel_h(){
translate([ 60, 60,0])rotate([0,90, 0])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([-60, 60,0])rotate([0,90, 0])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([ 60,-60,0])rotate([0,90, 0])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([-60,-60,0])rotate([0,90, 0])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
}

module wheel_x(){
translate([ 60, 60,0])rotate([0,90,-45])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([-60, 60,0])rotate([0,90, 45])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([ 60,-60,0])rotate([0,90, 45])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
translate([-60,-60,0])rotate([0,90,-45])cylinder(25, r=wheeldiameter/2,center=true,$fn=50);
}

module football(){
translate([0,0,-110])sphere(d=220, $fn=100);
}

module basketball(){
translate([0,0,-120])sphere(d=240, $fn=100);
}

/*
//for preview
translate([0,0,40])board();
motorseat_four();
//motor_x();
wheel_x();
basketball();
*/

/*
*/
//for print
//board();
translate([-10,0,0])rotate([180,0,0])motorseat();