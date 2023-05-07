
module rpi(){
difference(){
    union(){
    translate([-24.5,20-62, 1])cylinder(2, r=3,center=true,$fn=50);
    translate([ 24.5,20-62, 1])cylinder(2, r=3,center=true,$fn=50);
    translate([-24.5, 20-4, 1])cylinder(2, r=3,center=true,$fn=50);
    translate([ 24.5, 20-4, 1])cylinder(2, r=3,center=true,$fn=50);
    }
    translate([-24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([-24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);
}
}
module part5_rpi(){
translate([0,-20,60])cube([55,88,20],center=true);
}

module cam(){
difference(){
    cube([30,40,1.6],center=true);
    cube([14,22,100],center=true);
    translate([-21/2,-12.5/2,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,-12.5/2,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 12.5/2,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 12.5/2,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}
module part4_cam(){
translate([0,55.8,64])rotate([98,0,0])cam();
difference(){
translate([0,50,5+40])cube([40,18,2],center=true);
translate([ 0,49,5.9+40])cube([0.21,18,0.21],center=true);
translate([ 10,50,5+40])cylinder(10, r=1.6,center=true,$fn=50);
translate([-10,50,5+40])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module middle(){
difference(){
    translate([0,0,2/2])cube([120,120,2],center=true);

    //center
    translate([0,0,2/2])cube([40,40,3],center=true);

    //leftright
    translate([-35,-10,2/2])cube([10,60,3],center=true);
    translate([ 35,-10,2/2])cube([10,60,3],center=true);

    //cammount
    translate([ 10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([-10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);

    //rpi
    translate([-24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([-24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);

    //hole
    translate([-50,-10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([-50, 10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 50, 10,0])cylinder(100, r=2.7,center=true,$fn=50);

    //translate([-20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([  0, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);

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
}
}

module part3_top(){
//translate([0,0,2+40+2])rpi();

translate([0,0,2+40])middle();
}

module bezier(h){
linear_extrude(height=h)polygon([
    for(t=[0:0.1:1.0])    [20*t*t, 40*(1-t)*(1-t)],
    [0, 0]
    ]);
}

module batterydock(){
    difference(){
    cube([80,40,40],center=true);
    cube([76,40.02,40.02],center=true);
    }
}

module l298n(){
difference(){
    union(){
        translate([-27.5,20-60,2+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([ 27.5,20-60,2+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([-14.5, 20-6,2+2/2])cylinder(2, r=3,center=true,$fn=50);
        translate([ 14.5, 20-6,2+2/2])cylinder(2, r=3,center=true,$fn=50);
    }
        translate([-27.5,20-60,2+2/2])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 27.5,20-60,2+2/2])cylinder(10, r=1.6,center=true,$fn=50);
        translate([-14.5, 20-6,2+2/2])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 14.5, 20-6,2+2/2])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module bottom(){
difference(){
    translate([0,0,2/2])cube([120,120,2],center=true);

    //screw hole
    translate([-50,-10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([-50, 10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=2.7,center=true,$fn=50);
    translate([ 50, 10,0])cylinder(100, r=2.7,center=true,$fn=50);

    //cable hole
    translate([-40+5/2, 0,0])cube([5,10,30],center=true,$fn=50);
    translate([ 40-5/2, 0,0])cube([5,10,30],center=true,$fn=50);

    //corner
    translate([-50.01,-40.01,2/2])cube([20,40,4],center=true);
    translate([ 50.01,-40.01,2/2])cube([20,40,4],center=true);
    translate([-50.01, 40.01,2/2])cube([20,40,4],center=true);
    translate([ 50.01, 40.01,2/2])cube([20,40,4],center=true);

    //hole
    //translate([-40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);
    //translate([-40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);
    //translate([ 40,-20,0])cylinder(100, r=2.7,center=true,$fn=50);
    //translate([ 40, 20,0])cylinder(100, r=2.7,center=true,$fn=50);

    //translate([-20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([  0, 20,0])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 20, 20,0])cylinder(100, r=1.6,center=true,$fn=50);

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

    //l298
    translate([-27.5,20-60,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([ 27.5,20-60,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([-14.5,20-6,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([ 14.5,20-6,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);

    translate([-27.5,20-60,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 27.5,20-60,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-14.5,20-6,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 14.5,20-6,0])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module motorseat(){
difference(){
    cube([24,120,4],center=true);
    cube([26,70,10],center=true);

    //shaft hole
    translate([0, 60,0])cylinder(10, r=4,center=true,$fn=50);
    translate([0,-60,0])cylinder(10, r=4,center=true,$fn=50);

    //shaft hole
    translate([0, 60-11.5,0])cylinder(10, r=2,center=true,$fn=50);
    translate([0,-60+11.5,0])cylinder(10, r=2,center=true,$fn=50);

    //screw hole
    translate([-8.6, 60-21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 8.6, 60-21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-8.6,-60+21,0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 8.6,-60+21,0])cylinder(10, r=1.6,center=true,$fn=50);
}
}

module part2_battery(){
    translate([ 0,40,2+20])cube([78,40,40],center=true);
}
module zhuomian(){
    difference(){
        union(){
        translate([ 0,10,0])cube([80,60,20],center=true);
        translate([ 30,42.5,-9])cube([20,5,2],center=true);
        translate([-30,42.5,-9])cube([20,5,2],center=true);
        }
        translate([ 0,10,5])cube([76,56,10.01],center=true);

        //screw
        translate([-40,20,0])rotate([0,90,0])cylinder(h=20,r=1.6,center=true,$fn=50);
        translate([ 40,20,0])rotate([0,90,0])cylinder(h=20,r=1.6,center=true,$fn=50);
        //screw
        translate([-40,0,0])rotate([0,90,0])cylinder(h=20,r=1.6,center=true,$fn=50);
        translate([ 40,0,0])rotate([0,90,0])cylinder(h=20,r=1.6,center=true,$fn=50);
        //screw
        translate([-40+2+1.5,0,0])rotate([0,90,0])cylinder(h=3,r=3.5,center=true,$fn=50);
        translate([ 40-2-1.5,0,0])rotate([0,90,0])cylinder(h=3,r=3.5,center=true,$fn=50);

        //near
        translate([  0,-20+0.1,0])cube([0.21,0.21,80.1],center=true);
        translate([-20,-20+0.1,0])cube([0.21,0.21,80.1],center=true);
        translate([ 20,-20+0.1,0])cube([0.21,0.21,80.1],center=true);
        //translate([  0,-20+0.1,0])cube([80,0.21,0.21],center=true);
        //far
        translate([  0,40-0.1,0])cube([0.21,0.21,80.1],center=true);
        translate([-20,40-0.1,0])cube([0.21,0.21,80.1],center=true);
        translate([ 20,40-0.1,0])cube([0.21,0.21,80.1],center=true);
        //translate([  0,40-0.1,0])cube([80,0.21,0.21],center=true);
        //left
        translate([-40+0.1, 0,0])cube([0.2,0.4,80],center=true);
        translate([-40+0.1,20,0])cube([0.2,0.4,80],center=true);
        translate([-40+0.1, 0,0])cube([0.2,20,0.4],center=true);
        //right
        translate([ 40-0.1, 0,0])cube([0.2,0.4,80],center=true);
        translate([ 40-0.1,20,0])cube([0.2,0.4,80],center=true);
        translate([ 40-0.1,0,0])cube([0.2,20,0.4],center=true);
        //top
        translate([ 0, 0,10-0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,20,10-0.1])cube([80,0.21,0.21],center=true);
        translate([ 0, 0,10-0.1])cube([0.21,80,0.21],center=true);
        translate([-20,0,10-0.1])cube([0.21,80,0.21],center=true);
        translate([ 20,0,10-0.1])cube([0.21,80,0.21],center=true);
        //bot
        translate([ 0, 0,-10+0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,20,-10+0.1])cube([80,0.21,0.21],center=true);
        translate([ 0, 0,-10+0.1])cube([0.21,80,0.21],center=true);
        translate([-20,0,-10+0.1])cube([0.21,80,0.21],center=true);
        translate([ 20,0,-10+0.1])cube([0.21,80,0.21],center=true);

        //0,0: xt60
        translate([-30,-2.5, 0.5-5])cube([13,5.01,9.01],center=true);
        translate([-30,-10, 0.5-5])cube([16.4,16.4,9.01],center=true);
        translate([-30,-20+2.5, 0.5-5])cube([14,5.01,9.01],center=true);
        //1,0: xh254
        translate([-10,-3/2, 2-5])cube([7,3.01,6.01],center=true);
        translate([-10,-10, 1-5])cube([9,15,8.01],center=true);
        translate([-10,-10-15/2+7/2, 1-5])cube([11,7.01,8.01],center=true);
        translate([-10,-10-15/2-0.5, 1-5])cube([9,1,8.01],center=true);
        translate([-10,-19.01, 0.4-5])cube([13,2,9.21],center=true);
        //2,0: xt60
        translate([10,-2.5, 0.5-5])cube([13,5.01,9.01],center=true);
        translate([10,-10, 0.5-5])cube([16.4,16.4,9.01],center=true);
        translate([10,-20+2.5, 0.5-5])cube([14,5.01,9.01],center=true);
        //3,0 xh254
        translate([30,-3/2, 2-5])cube([7,3.01,6.01],center=true);
        translate([30,-10, 1-5])cube([9,15,8.01],center=true);
        translate([30,-10-15/2+7/2, 1-5])cube([11,7.01,8.01],center=true);
        translate([30,-10-15/2-0.5, 1-5])cube([9,1,8.01],center=true);
        translate([30,-19.01, 0.4-5])cube([14,2,9.21],center=true);

        //0,1
        translate([-30, 10, 1-5])cube([16,20,8.01],center=true);
        translate([-20-1, 10, 1-5])cube([2.01,20,8.01],center=true);
        translate([-30, 10,-8.5+0.01])cube([10,10,1],center=true);
        translate([-30-5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([-30, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([-30+5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        //1,1
        translate([-10, 10, 1-5])cube([20,20,8.01],center=true);
        translate([-10, 10, 1-5])cube([20,20,8.01],center=true);
        translate([-10, 10,-8.5+0.01])cube([10,10,1],center=true);
        translate([-10-5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([-10, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([-10+5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        //2,1
        translate([ 10, 10, 1-5])cube([20,20,8.01],center=true);
        translate([ 10, 10,-8.5+0.01])cube([10,10,1],center=true);
        translate([ 10-5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([ 10, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([ 10+5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        //3,1
        translate([ 30, 10, 1-5])cube([16,20,8.01],center=true);
        translate([ 20+1, 10, 1-5])cube([2.01,20,8.01],center=true);
        translate([ 30, 10,-8.5+0.01])cube([10,10,1],center=true);
        translate([ 30-5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([ 30, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);
        translate([ 30+5, 10,-10])cylinder(h=10,r=1.6,center=true,$fn=50);

        //0,2: bulk
        translate([-30, 30, 1-5])cube([16,28,8.01],center=true);
        translate([-40, 30, -4])cube([20.01,10.01,8.01],center=true);
        translate([-30, 40, 5-5/2])cube([16,5,5],center=true);
        translate([-21, 30, -4])cube([2.01,10.01,8.01],center=true);
        //1,2
        translate([-10+2.5, 30, 1-5])cube([15,20.01,8.01],center=true);
        translate([-10, 30, -4])cube([20.01,10.01,8.01],center=true);
        //2,2
        translate([ 10-2.5, 30, 1-5])cube([15,20.01,8.01],center=true);
        translate([10, 30, -4])cube([20.01,10.01,8.01],center=true);
        //3,2: ads1115
        translate([ 30, 30, -4])cube([18,28,8.01],center=true);
        translate([ 40, 30, -4])cube([20.01,10.01,8.01],center=true);
        translate([ 21, 30, -4])cube([2.01,10.01,8.01],center=true);
        translate([35,30+22.5/2,0-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([35,30-22.5/2,0-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30-9+1.5, 30, -10])cube([3,26,5],center=true);
        translate([ 30, 40-1, 5-5/2])cube([18,2.01,5],center=true);

        //8v, 5v, 4v, 3v, 0v
        translate([-10,20,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ -5,20,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  0,20,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  5,20,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,20,-10])cylinder(h=5,r=1.6,center=true,$fn=50);

        //4v, 2.5v, 2v, 1.5v, 0v
        translate([-10,30,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([- 5,30,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  0,30,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  5,30,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,30,-10])cylinder(h=5,r=1.6,center=true,$fn=50);

        //0v
        translate([-10,40,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([- 5,40,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  0,40,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([  5,40,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,40,-10])cylinder(h=5,r=1.6,center=true,$fn=50);
    }
}
/*
module zhuotui(){
    difference(){
        //
        //cube([40,40,1.6],center=true);
        hull(){
        translate([0,0,-0.79])cube([40,40,0.01],center=true);
        translate([0,0, 0.79])cube([40-3.2,40-3.2,0.01],center=true);
        }

        //hole
        cylinder(100, r=1.6,center=true,$fn=50);

        //connector
        translate([-15,-15,0])cube([10.01, 10.01, 10],center=true);
        translate([ 15,-15,0])cube([10.01, 10.01, 10],center=true);
        translate([-15, 15,0])cube([10.01, 10.01, 10],center=true);
        translate([ 15, 15,0])cube([10.01, 10.01, 10],center=true);

        //top
        translate([ 0,  0,0.8-0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,-10,0.8-0.1])cube([80,0.21,0.21],center=true);
        translate([ 0, 10,0.8-0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,  0,0.8-0.1])cube([0.21,80,0.21],center=true);
        translate([-10, 0,0.8-0.1])cube([0.21,80,0.21],center=true);
        translate([ 10, 0,0.8-0.1])cube([0.21,80,0.21],center=true);

        //bot
        translate([ 0,  0,-0.8+0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,-10,-0.8+0.1])cube([80,0.21,0.21],center=true);
        translate([ 0, 10,-0.8+0.1])cube([80,0.21,0.21],center=true);
        translate([ 0,  0,-0.8+0.1])cube([0.21,80,0.21],center=true);
        translate([-10, 0,-0.8+0.1])cube([0.21,80,0.21],center=true);
        translate([ 10, 0,-0.8+0.1])cube([0.21,80,0.21],center=true);
    }
}*/
module part2_power(){
    //zhuomian();
    //zhuotui();

    translate([ 0,-40,2+30])zhuomian();
    //translate([-40+0.8,-40,2+20])rotate([0, 90,0])zhuotui();
    //translate([ 40-0.8,-40,2+20])rotate([0,-90,0])zhuotui();
}
module part2_l298n(){
    translate([ 0,-20,2+10])cube([60,80,14],center=true);
}
module part2_kuang_base1(){
    //shang
    difference(){
        union(){
        translate([-10, 40,1.2])cube([4,4,2.4],center=true);
        translate([  0, 40,1.2])cube([4,4,2.4],center=true);
        translate([ 10, 40,1.2])cube([4,4,2.4],center=true);
        translate([20,20,0])rotate([0,-90,0])bezier(40);
        translate([0,40,0.2])cube([40,40,0.4],center=true);
        }
        translate([-10,40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([  0,40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 10,40,0])cylinder(10, r=1.6,center=true,$fn=50);
    }
    //zhong
    difference(){
        translate([0,0,10])cube([40,40,20],center=true);
        translate([0,0,10])cube([20,39.9,20.02],center=true);
        translate([0,10,10])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
        translate([0,-10,10])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
    //xia
    difference(){
        union(){
        translate([-10,-40,1.2])cube([4,4,2.4],center=true);
        translate([  0,-40,1.2])cube([4,4,2.4],center=true);
        translate([ 10,-40,1.2])cube([4,4,2.4],center=true);
        mirror([0,1,0])translate([20,20,0])rotate([0,-90,0])bezier(40);
        translate([0,-40,0.2])cube([40,40,0.4],center=true);
        }
        translate([-10,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([  0,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 10,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
    }
}
module part2_kuang_right(){
    translate([40,0,2+20])rotate([0,90,0])part2_kuang_base1();
}
module part2_kuang_left(){
    translate([-40,0,2+20])rotate([0,-90,0])part2_kuang_base1();
}

module part1_dipan(){
bottom();
//l298n();

translate([ 40, 20,0])bezier(2);
translate([ 40,-20,0])mirror([0,1,0])bezier(2);
translate([-40, 20,0])mirror([1,0,0])bezier(2);
translate([-40,-20,0])rotate([0,0,180])bezier(2);

translate([-40+18,0,-24/2])rotate([0,90,0])motorseat();
translate([ 40-18,0,-24/2])rotate([0,90,0])motorseat();
}


module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module part1_wheel(){
translate([-60,-60,-24/2])wheel();
translate([ 60,-60,-24/2])wheel();
translate([-60, 60,-24/2])wheel();
translate([ 60, 60,-24/2])wheel();
}

module screwhelper()
{
difference(){
    cylinder(2, r=3,center=true,$fn=50);
    cylinder(4, r=1.6,center=true,$fn=50);
}
}



//for preview
/*
part5_rpi();
part4_cam();
part3_top();

part2_kuang_right();
part2_kuang_left();
part2_battery();
part2_power();
part2_l298n();

part1_dipan();
part1_wheel();
*/



//for print
part3_top();
//rotate([-98,0,0])part4_cam();
//part2_kuang_base1();
//zhuomian();
//rotate([0,180,0])part1_dipan();
//screwhelper();