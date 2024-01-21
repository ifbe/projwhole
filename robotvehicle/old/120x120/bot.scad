


module bottom(){
difference(){
    union(){
        translate([0,0,2/2])cube([120,120,2],center=true);

        //motor
        translate([-50,-40,2+0.2/2])cube([20, 40, 0.2],center=true);
        translate([-50, 40,2+0.2/2])cube([20, 40, 0.2],center=true);
        translate([ 50,-40,2+0.2/2])cube([20, 40, 0.2],center=true);
        translate([ 50, 40,2+0.2/2])cube([20, 40, 0.2],center=true);

        //ads1115
        translate([-15,0+5/2,2+2/2])cube([30,5,2],center=true);
        translate([-15,5+5/2,2+2/2])cube([30,5,2],center=true);
    }

    //hole
    translate([-40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([-40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);

    translate([-20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([  0, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);

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

    //ads1115
    translate([-15-11.1,0+5/2,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-15+11.1,0+5/2,0])cylinder(10, r=1.6,center=true,$fn=50);

    //l298n
    translate([0, -65/2, 2/2])cube([65,65,2.01],center=true);
}
}
module l298n(){
difference(){
    union(){
        //board
        translate([0, -60/2, 1/2])cube([65,60,1],center=true);

        //ear
        translate([-27.5,-60,1/2])cylinder(1, r=5,center=true,$fn=50);
        translate([ 27.5,-60,1/2])cylinder(1, r=5,center=true,$fn=50);

        //board
        translate([-27.5,-60,1+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([ 27.5,-60,1+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([-14.5, -6,1+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([ 14.5, -6,1+2/2])cylinder(2, r=3,center=true,$fn=50);
    }
    //marker line
    translate([0,-40,0.1])cube([120,0.2,0.21],center=true);
    translate([0,-20,0.1])cube([120,0.2,0.21],center=true);
    translate([0,  0,0.1])cube([120,0.2,0.21],center=true);
    translate([0, 20,0.1])cube([120,0.2,0.21],center=true);
    translate([0, 40,0.1])cube([120,0.2,0.21],center=true);
    translate([-20,0,0.1])cube([0.2,120,0.21],center=true);
    translate([  0,0,0.1])cube([0.2,120,0.21],center=true);
    translate([ 20,0,0.1])cube([0.2,120,0.21],center=true);

    translate([  0, -40, 1.1])cube([80,0.2,0.2],center=true);
    translate([  0, -20, 1.1])cube([80,0.2,0.2],center=true);
    translate([-20, -30, 1.1])cube([0.2,60,0.2],center=true);
    translate([  0, -30, 1.1])cube([0.2,60,0.2],center=true);
    translate([ 20, -30, 1.1])cube([0.2,60,0.2],center=true);
    //hole
    translate([-27.5,-60,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 27.5,-60,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-14.5,-6,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 14.5,-6,0])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module motorseat(){
difference(){
    cube([24,120,5],center=true);
    cube([26,60,10],center=true);

    translate([0, 60,0])cylinder(10, r=4,center=true,$fn=50);
    translate([0,-60,0])cylinder(10, r=4,center=true,$fn=50);

    translate([-8.6, 60-21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 8.6, 60-21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-8.6,-60+21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 8.6,-60+21,0])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module switch(){
    difference(){
        translate([0,10-7,10/2])cube([20,14,10],center=true);
        translate([0,10-1,10/2])cube([12,2.01,10.01],center=true);
        translate([0,10-3,10/2])cube([16,2.01,10.01],center=true);
        translate([0,10-9,1+9/2])cube([15,10.01,9.01],center=true);
    }
    translate([-2-3/2,10-14-6/2,10/2])cube([3,6,10],center=true);
    translate([ 2+3/2,10-14-6/2,10/2])cube([3,6,10],center=true);
}

module xt60(){
    difference(){
        translate([0,0,+10/2])cube([20,20,10],center=true);
        translate([0,1-0.5/2,+10/2])cube([16.5,16.5,10.01],center=true);
        translate([0,8,+10/2])cube([14,16,7],center=true);
        translate([-4,-8,+10/2])cube([5,16,10.01],center=true);
        translate([ 4,-8,+10/2])cube([5,16,10.01],center=true);
    }
}

bottom();
l298n();

translate([-10,50,2])switch();
translate([10,50,2])xt60();
difference(){
translate([-40,0,24/2+2])rotate([0,90,0])motorseat();
translate([-40,-40,2+24-2/2])cylinder(2.01, r=1.6,center=true,$fn=50);
translate([-40, 40,2+24-2/2])cylinder(2.01, r=1.6,center=true,$fn=50);
}
difference(){
translate([ 40,0,24/2+2])rotate([0,90,0])motorseat();
translate([ 40,-40,2+24-2/2])cylinder(2.01, r=1.6,center=true,$fn=50);
translate([ 40, 40,2+24-2/2])cylinder(2.01, r=1.6,center=true,$fn=50);
}