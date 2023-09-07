
module conn(){
    difference(){
        cube([36,36,20],center=true);
        cube([20,20,22],center=true);
        translate([0,0,2])cube([32,32,18.01],center=true);
        translate([0,0,5])cube([20,40,10],center=true);
        translate([0, 10,0])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
        translate([0,-10,0])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
}
module top_top(){
    difference(){
    translate([0, 0, 80-1])cube([120,120,2],center=true);
    translate([0, 0, 80-1])cube([80,80,3],center=true);

    translate([-40,53, 80-1])cube([36,4,3],center=true);
    translate([ 40,53, 80-1])cube([36,4,3],center=true);

    translate([-50,-10,80])cylinder(100, r=2.5,center=true,$fn=50);
    translate([-50, 10,80])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50,-10,80])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50, 10,80])cylinder(100, r=2.5,center=true,$fn=50);
    }
}
module top_support(){
    translate([-50, 0, 60])rotate([0,90,0])conn();
    translate([ 50, 0, 60])rotate([0,-90,0])conn();
}

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
module notprint_rpi(){
translate([0,-20,60])cube([55,88,36-4],center=true);
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
module cam_mount(){
translate([0,55.8,62])rotate([98,0,0])cam();
difference(){
translate([0,50,42+1])cube([40,18,2],center=true);
translate([0,49,3.9+40])cube([0.21,18,0.21],center=true);
translate([10,50,40])cylinder(10, r=1.6,center=true,$fn=50);
translate([-10,50,40])cylinder(10, r=1.6,center=true,$fn=50);
}
}
module top_cam(){
translate([-40,0.0])cam_mount();
translate([ 40,0.0])cam_mount();
}

module upper_real(){
difference(){
    translate([0,0,2/2])cube([120,120,2],center=true);

    //center
    //translate([0,0,2/2])cube([40,40,3],center=true);

    //leftright
    translate([-35,0,2/2])cube([10,40,3],center=true);
    translate([ 35,0,2/2])cube([10,40,3],center=true);

    //cammount
    translate([40+10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([40-10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([40+10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([40-10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([-40+10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40-10,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([-40-10,50,0.5])cylinder(1.01, r=2.5,center=true,$fn=50);

    //rpi
    translate([-24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5,20-62, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([-24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([ 24.5, 20-4, 1])cylinder(4, r=1.6,center=true,$fn=50);
    translate([-24.5,20-62, 0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([ 24.5,20-62, 0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([-24.5, 20-4, 0.5])cylinder(1.01, r=2.5,center=true,$fn=50);
    translate([ 24.5, 20-4, 0.5])cylinder(1.01, r=2.5,center=true,$fn=50);

    //hole
    translate([-50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([-50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);

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

module top_upper(){
//translate([0,0,2+40+2])rpi();

translate([0,0,40])upper_real();
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
    translate([0,0,0.6])cube([40, 80, 1.21],center=true);
    translate([0,-40+8,0])cube([40, 16, 10],center=true);
    translate([0, 40-8,0])cube([40, 16, 10],center=true);

    //screw hole
    translate([-50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([-50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
    translate([ 50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);

    //cable hole
    translate([-40+5/2, 0,0])cube([5,10,30],center=true,$fn=50);
    translate([ 40-5/2, 0,0])cube([5,10,30],center=true,$fn=50);

    //corner
    translate([-50.01,-40.01,2/2])cube([20,40,4],center=true);
    translate([ 50.01,-40.01,2/2])cube([20,40,4],center=true);
    translate([-50.01, 40.01,2/2])cube([20,40,4],center=true);
    translate([ 50.01, 40.01,2/2])cube([20,40,4],center=true);

    //hole
    //translate([-40,-20,0])cylinder(100, r=2.5,center=true,$fn=50);
    //translate([-40, 20,0])cylinder(100, r=2.5,center=true,$fn=50);
    //translate([ 40,-20,0])cylinder(100, r=2.5,center=true,$fn=50);
    //translate([ 40, 20,0])cylinder(100, r=2.5,center=true,$fn=50);

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

module notprint_battery(){
    translate([ 0,40,20])cube([78,40,40],center=true);
}
module notprint_battery2(){
    translate([ 0,-40,20])cube([78,40,40],center=true);
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
module mid_power(){
    //zhuomian();
    //zhuotui();

    translate([ 0,-40,30])zhuomian();
    //translate([-40+0.8,-40,2+20])rotate([0, 90,0])zhuotui();
    //translate([ 40-0.8,-40,2+20])rotate([0,-90,0])zhuotui();
}
module notprint_l298n(){
    translate([ 0,-20,10])cube([60,80,14],center=true);
}
module part2_kuang_base1(){
    //shang
    difference(){
        union(){
        translate([-10, 40,1.2])cube([4,4,2.4],center=true);
        translate([  0, 40,1.2])cube([4,4,2.4],center=true);
        translate([ 10, 40,1.2])cube([4,4,2.4],center=true);
        translate([20,20,0])rotate([0,-90,0])bezier(40);
        translate([0,40,0.5])cube([40,40,1.0],center=true);
        }
        translate([-10,40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([  0,40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 10,40,0])cylinder(10, r=1.6,center=true,$fn=50);
    }
    //zhong
    difference(){
        translate([0,0,10])cube([40,40,20],center=true);
        translate([0,0,10])cube([30,39.9,20.02],center=true);
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
        translate([0,-40,0.5])cube([40,40,1.0],center=true);
        }
        translate([-10,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([  0,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 10,-40,0])cylinder(10, r=1.6,center=true,$fn=50);
    }
}
module mid_kuang_right(){
    translate([40,0,20])rotate([0,90,0])part2_kuang_base1();
}
module mid_kuang_lght(){
    translate([-40,0,20])rotate([0,-90,0])part2_kuang_base1();
}

module bot_dipan(){
translate([ 0, 0,-2])bottom();
//l298n();

translate([ 40, 20,-2])bezier(2);
translate([ 40,-20,-2])mirror([0,1,0])bezier(2);
translate([-40, 20,-2])mirror([1,0,0])bezier(2);
translate([-40,-20,-2])rotate([0,0,180])bezier(2);
}
module bot_support(){
    translate([-50, 0,-20])rotate([0,90,0])conn();
    translate([ 50, 0,-20])rotate([0,-90,0])conn();
}



module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([-60,-60,-20])wheel();
    translate([ 60,-60,-20])wheel();
    translate([-60, 60,-20])wheel();
    translate([ 60, 60,-20])wheel();
}

module screwhelper()
{
difference(){
    cylinder(2, r=3,center=true,$fn=50);
    cylinder(4, r=1.8,center=true,$fn=50);
}
}
module bot_seat_helper()
{
    difference(){
        cube([20,40,6],center=true);

        translate([0,-10, 3-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0,-10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0,-10,-3+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);

        translate([0, 10, 3-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0, 10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0, 10,-3+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
    }
}
module bot_seat_left(){
    translate([-30, -40, -2-3])bot_seat_helper();
    translate([-30,  40, -2-3])bot_seat_helper();

    translate([-40+18,0,-20])rotate([0,90,0])motorseat();

    translate([-30, -40, -40+2+3])bot_seat_helper();
    translate([-30,  40, -40+2+3])bot_seat_helper();
}
module bot_seat_right(){
    translate([ 30,  40, -2-3])bot_seat_helper();
    translate([ 30, -40, -2-3])bot_seat_helper();

    translate([ 40-18,0,-20])rotate([0,90,0])motorseat();

    translate([ 30,  40, -40+2+3])bot_seat_helper();
    translate([ 30, -40, -40+2+3])bot_seat_helper();
}
module bot_seat(){
    bot_seat_left();
    bot_seat_right();
}
module bot_power(){
    difference(){
        union(){
        translate([0, 20-1,20])cube([79.6,2,40],center=true);
        //long
        translate([0, 20-1,20])cube([120,2,29.6],center=true);
        //bottom
        translate([0, 20-1,-4])cube([70,2,2+6],center=true);
        //
        translate([-50,10,20])rotate([90,0,0])cylinder(20, r=5,center=true,$fn=50);
        translate([ 50,10,20])rotate([90,0,0])cylinder(20, r=5,center=true,$fn=50);

        //8vto5v +++
        translate([-20, 20-2-10/2,20])cube([20,10,30],center=true);
        //xxxxx
        translate([  0, 20-2-10/2,20])cube([20,10,30],center=true);
        //ads1115 +++
        translate([ 20, 20-2-10/2,20])cube([20,10,30],center=true);
        }
        translate([-50,10,20])rotate([90,0,0])cylinder(25, r=2.5,center=true,$fn=50);
        translate([ 50,10,20])rotate([90,0,0])cylinder(25, r=2.5,center=true,$fn=50);

        //hole.left,right
        translate([-40+2.5, 20-1,20])cube([5,2.01,10],center=true);
        translate([ 40-2.5, 20-1,20])cube([5,2.01,10],center=true);
        //8vto5v ---
        translate([-20, 20-2-10/2,20+30/2-10/2])cube([16,10.01,10],center=true);
        translate([-20, 20-2-8/2,20])cube([16,8,28],center=true);
        translate([-20, 20-2-4/2,5])cube([16,4,10],center=true);
        //xxxxx
        translate([  0, 20-2-10/2+1,20+2])cube([18,8,28],center=true);
        translate([  0, 20-2-10/2-0.01,20])cube([18,10,26],center=true);
        //ads1115 ---
        translate([ 20, 20-2-4/2,35-0.5])cube([18,4,1.01],center=true);
        translate([ 20, 20-2-4/2,20])cube([18,4,28],center=true);
        translate([ 11+1.5, 20-2-5,20+0.5])cube([3,10.01,29],center=true);
    }
}
module bot_l298n(){
    difference(){
        union(){
        translate([0,-20+1,20])cube([79.6,2,40],center=true);
        //long
        translate([0,-20+1,20])cube([120,2,29.6],center=true);
        //bottom
        translate([0,-20+1,-4])cube([70,2,2+6],center=true);
        //
        translate([-50,-10,20])rotate([90,0,0])cylinder(20, r=5,center=true,$fn=50);
        translate([ 50,-10,20])rotate([90,0,0])cylinder(20, r=5,center=true,$fn=50);
        }
        translate([0,0,0])cube([66,36,80.02],center=true);
        translate([0,0,0])cube([80,10,20.02],center=true);

        translate([-50,-10-0.2,20])rotate([90,0,0])cylinder(22, r=2.5,center=true,$fn=50);
        translate([ 50,-10-0.2,20])rotate([90,0,0])cylinder(22, r=2.5,center=true,$fn=50);

        //hole.mid
        translate([0,-20,20])cube([40,20,20],center=true);

        //hole.left,right
        translate([-40+2.5,-20+1,20])cube([5,2.01,10],center=true);
        translate([ 40-2.5,-20+1,20])cube([5,2.01,10],center=true);

        //hole.screw
        translate([-27.5,0,0])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 27.5,0,0])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-14.5,0,40-6])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 14.5,0,40-6])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-27.5,-20+0.5,0])cube([5,1.01,5],center=true);
        translate([ 27.5,-20+0.5,0])cube([5,1.01,5],center=true);
        translate([-14.5,-20+0.5,40-6])cube([5,1.01,5],center=true);
        translate([ 14.5,-20+0.5,40-6])cube([5,1.01,5],center=true);
    }
}

module bot_top(){
    //mid
    difference(){
        union(){
        translate([0, 0, -1])cube([80,120,2],center=true);
        //hole,ln
        translate([-30,-30,-3])cylinder(h=2,r=4,center=true,$fn=50);
        translate([-30,-50,-3])cylinder(h=2,r=4,center=true,$fn=50);
        //hole,rn
        translate([ 30,-30,-3])cylinder(h=2,r=4,center=true,$fn=50);
        translate([ 30,-50,-3])cylinder(h=2,r=4,center=true,$fn=50);
        //hole,lf
        translate([-30, 30,-3])cylinder(h=2,r=4,center=true,$fn=50);
        translate([-30, 50,-3])cylinder(h=2,r=4,center=true,$fn=50);
        //hole,rf
        translate([ 30, 30,-3])cylinder(h=2,r=4,center=true,$fn=50);
        translate([ 30, 50,-3])cylinder(h=2,r=4,center=true,$fn=50);
        }
        //hole,ln
        translate([-30,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,rn
        translate([ 30,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,lf
        translate([-30, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,rf
        translate([ 30, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole.batt
        translate([0,-40, 0])cube([40,20,10],center=true,$fn=50);
        translate([0, 40, 0])cube([40,20,10],center=true,$fn=50);
        //hole,middle
        translate([0, 0, -1])cube([70,30,10],center=true);
        translate([-40+5/2, 0,0])cube([5.2,10.2,30],center=true,$fn=50);
        translate([ 40-5/2, 0,0])cube([5.2,10.2,30],center=true,$fn=50);
        translate([0, 20-2.5,0])cube([10.2,5.2,30],center=true,$fn=50);
        translate([0,-20+2.5,0])cube([10.2,5.2,30],center=true,$fn=50);
    }

    //left
    difference(){
        translate([-50, 0, -1])cube([20,40,2],center=true);
        translate([-50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
        translate([-50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
    //right
    difference(){
        translate([ 50, 0, -1])cube([20,40,2],center=true);
        translate([ 50,-10,0])cylinder(100, r=2.5,center=true,$fn=50);
        translate([ 50, 10,0])cylinder(100, r=2.5,center=true,$fn=50);
    }

    //corner
    translate([ 40, 20,-2])bezier(2);
    translate([ 40,-20,-2])mirror([0,1,0])bezier(2);
    translate([-40, 20,-2])mirror([1,0,0])bezier(2);
    translate([-40,-20,-2])rotate([0,0,180])bezier(2);
}
module bot_bot(){
    //mid
    difference(){
        translate([0, 0, -40+1])cube([80,120,2],center=true);
        //heng
        translate([0, 40, -40+1.9])cube([80,0.21,0.21],center=true);
        translate([0, 20, -40+1.9])cube([80,0.21,0.21],center=true);
        translate([0,  0, -40+1.9])cube([80,0.21,0.21],center=true);
        translate([0,-20, -40+1.9])cube([80,0.21,0.21],center=true);
        translate([0,-40, -40+1.9])cube([80,0.21,0.21],center=true);
        //shu
        translate([ 40,0, -40+1.9])cube([0.21,120,0.21],center=true);
        translate([ 20,0, -40+1.9])cube([0.21,120,0.21],center=true);
        translate([  0,0, -40+1.9])cube([0.21,120,0.21],center=true);
        translate([-20,0, -40+1.9])cube([0.21,120,0.21],center=true);
        translate([-40,0, -40+1.9])cube([0.21,120,0.21],center=true);
        //hole,far
        translate([-30,-30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30,-50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10,-30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10,-50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,-30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,-50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,mid
        translate([-30,-10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30, 10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10,-10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10, 10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,-10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10, 10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 10,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,near
        translate([-30, 30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30, 50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10, 30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10, 50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10, 30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10, 50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 30,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 50,-40+1])cylinder(h=5,r=1.6,center=true,$fn=50);
    }

    //left
    difference(){
        translate([-50, 0, -40+1])cube([20,40,2],center=true);
        translate([-50,-10,-40])cylinder(100, r=2.5,center=true,$fn=50);
        translate([-50, 10,-40])cylinder(100, r=2.5,center=true,$fn=50);
    }
    //right
    difference(){
        translate([ 50, 0, -40+1])cube([20,40,2],center=true);
        translate([ 50,-10,-40])cylinder(100, r=2.5,center=true,$fn=50);
        translate([ 50, 10,-40])cylinder(100, r=2.5,center=true,$fn=50);
    }

    //corner
    translate([ 40, 20,-40])bezier(2);
    translate([ 40,-20,-40])mirror([0,1,0])bezier(2);
    translate([-40, 20,-40])mirror([1,0,0])bezier(2);
    translate([-40,-20,-40])rotate([0,0,180])bezier(2);
}

module special_board()
{
    difference(){
    union(){
    cube([80, 40, 2],center=true);
    translate([0,-20-12,0])cube([60, 24, 2],center=true);
    }
    cube([40, 20, 3],center=true);
    translate([0,-20-6,0])cube([40, 12, 5],center=true);

    translate([-40+5, 20-2.5, 0])cube([10, 5.2, 3],center=true);
    translate([-40+5,  5-2.5, 0])cube([10, 5.2, 3],center=true);
    translate([-40+5, -5+2.5, 0])cube([10, 5.2, 3],center=true);
    translate([-40+5,-20+2.5, 0])cube([10, 5.2, 3],center=true);
    translate([ 40-5, 20-2.5, 0])cube([10, 5.2, 3],center=true);
    translate([ 40-5,  5-2.5, 0])cube([10, 5.2, 3],center=true);
    translate([ 40-5, -5+2.5, 0])cube([10, 5.2, 3],center=true);
    translate([ 40-5,-20+2.5, 0])cube([10, 5.2, 3],center=true);
    translate([-14.5, 20-6, 0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5, 20-6, 0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-27.5,-40,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5,-40,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}
module special_back(){
    difference(){
        translate([ 0,0,6])cube([60,40,12],center=true);
        translate([-14.5, 20-6, 0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 14.5, 20-6, 0])cylinder(100, r=3,center=true,$fn=50);

        //0
        translate([-20, 0, 5])cube([16,36,10.01],center=true);
        translate([-30, 18-2.5, 2.5])cube([5,5,5.01],center=true);
        translate([-30+4, -20, 2.5])cube([4,10,5.01],center=true);
        translate([-10-4, -20, 2.5])cube([4,10,5.01],center=true);

        //1
        translate([0, 0, 5])cube([18,36,10.01],center=true);

        //2
        translate([ 20, 0, 5])cube([18,36,10.01],center=true);
        translate([15,-5+22.5/2,0])cylinder(h=100,r=1.6,center=true,$fn=50);
        translate([15,-5-22.5/2,0])cylinder(h=100,r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-14.5, 20-6, 5])cylinder(10.01, r=5,center=true,$fn=50);
    translate([-14.5, 20-6, 7])cylinder(10, r=3,center=true,$fn=50);
    translate([-14.5, 20-6, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([ 14.5, 20-6, 5])cylinder(10.01, r=5,center=true,$fn=50);
    translate([ 14.5, 20-6, 7])cylinder(10, r=3,center=true,$fn=50);
    translate([ 14.5, 20-6, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }

}
module special_support()
{
    difference(){
    union(){
    translate([0, -10, 7.5])cube([5, 20, 5],center=true);
    translate([0, 0, 2.5])cube([5, 40, 5],center=true);

    translate([5, -20+6-0.1/2, 7.5])cube([5, 12-0.1, 5],center=true);
    translate([5, -20+7, 2.5])cube([5, 14, 5],center=true);
    }
    translate([0, -7, 7.5-0.2/2])cube([20, 2.2, 5+0.2],center=true);
    }
}
module special_zhicheng()
{
    translate([-40+2.5, 0, 0])special_support();
    translate([ 40-2.5, 0, 0])mirror([1,0,0])special_support();
    translate([ 0, 20-2.5, 2.5])cube([80, 5, 5],center=true);
}
module special()
{
    color("#00ff00")translate([0, -7, 20])rotate([90,0,0])special_board();
    special_zhicheng();
}

module special_bottom()
{

    difference(){
    union(){
    //translate([0, 60-1, 18])cube([40, 2, 36],center=true);
    translate([0, 0, 1])cube([40, 120, 2],center=true);
    translate([0,-50, 5])cube([40, 20, 10],center=true);
    //translate([0,-60+1, 18])cube([40, 2, 36],center=true);
    }
    translate([ 10, 50,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-10, 50,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 10, 30,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-10, 30,0])cylinder(100, r=1.6,center=true,$fn=50);

    translate([0, 0, 0])cube([20, 60, 36],center=true);

    translate([ 10,-30,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-10,-30,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 10,-50,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-10,-50,0])cylinder(100, r=1.6,center=true,$fn=50);

    //0,0: xt60
    translate([-10,-40-2.5, 5+0.5])cube([13,5.01,9.01],center=true);
    translate([-10,-40-10, 5+0.5])cube([16.4,16.4,9.01],center=true);
    translate([-10,-40-20+2.5, 5+0.5])cube([14,5.01,9.01],center=true);
    //1,0: xh254
    translate([ 10,-40-3/2, 5+2])cube([7,3.01,6.01],center=true);
    translate([ 10,-40-10, 5+1])cube([9,15,8.01],center=true);
    translate([ 10,-40-10-15/2+7/2, 5+1])cube([11,7.01,8.01],center=true);
    translate([ 10,-40-10-15/2-0.5, 5+1])cube([9,1,8.01],center=true);
    translate([ 10,-40-19.01, 5+0.4])cube([13,2,9.21],center=true);
    }

}
module special_delete()
{
    difference(){
        union(){
        translate([0, 0, 20])cube([79.6, 39.6, 40],center=true);
        translate([-40+2.5, 0, -2.5])cube([5, 9.8, 5],center=true);
        translate([ 40-2.5, 0, -2.5])cube([5, 9.8, 5],center=true);
        translate([0,-20+2.5, -2.5])cube([9.8, 5, 5],center=true);
        translate([0, 20-2.5, -2.5])cube([9.8, 5, 5],center=true);
        }

        //[-20,-8]:back
        translate([0, -14+2.5, 2.5])cube([70, 7, 5.01],center=true);
        translate([0, -14, 20+2.5])cube([80, 12.01, 35.01],center=true);

        //[-8,-6]:board
        //translate([0, -7, 20])cube([50, 2.6, 20],center=true);
        translate([-40+2.5, -7, 20])cube([5, 2.6, 20],center=true);
        translate([ 40-2.5, -7, 20])cube([5, 2.6, 20],center=true);

        //[-6,0]
        translate([0, -3, 0])cube([70, 6.01, 100],center=true);
        translate([0, -3, 20+2.5])cube([80, 6.01, 35],center=true);

        //[0,20]:heatsink
        //translate([0, 10, 20])cube([70, 20, 60],center=true);
        translate([0, 10, 20+2.51])cube([80, 20, 35.01],center=true);
        translate([0, 7.5, 2.5])cube([70, 15, 5.02],center=true);

        //hole.l298n
        translate([-14.5,0,40-6])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 14.5,0,40-6])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        //translate([-27.5,0,-20])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        //translate([ 27.5,0,-20])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}

//--------for preview--------
/*
//top
top_cam();
top_top();
top_support();
top_upper();
notprint_rpi();
//mid
mid_power();
mid_kuang_right();
mid_kuang_lght();
notprint_battery();
notprint_l298n();
//bot
bot_dipan();
bot_support();
bot_seat();
bot_bot();
notprint_wheel();
*/


/*
color("#ffff00")translate([0,0,80])cube([2,200,0.00000001],center=true);
color("#ffff00")translate([0,0,80])cube([200,2,0.00000001],center=true);

color("#ff00ff")translate([0,0,40])cube([2,200,0.00000001],center=true);
color("#ff00ff")translate([0,0,40])cube([200,2,0.00000001],center=true);

color("#ff00ff")cube([2,200,0.00000001],center=true);
color("#ff00ff")cube([200,2,0.00000001],center=true);

color("#ffff00")translate([0,0,-40])cube([2,200,0.00000001],center=true);
color("#ffff00")translate([0,0,-40])cube([200,2,0.00000001],center=true);
*/
/*
//top
color("#ff0000")top_cam();
color("#ff0000")top_top();
color("#ff0000")top_support();
color("#ff0000")top_upper();

//mid
color("#00ff00")mid_kuang_right();
color("#00ff00")mid_kuang_lght();
//notprint_battery();
//notprint_battery2();
//notprint_l298n();

//mid-bot
//color("#00ffff")bot_power();
//color("#00ffff")bot_l298n();
color("#00ffff")special();

//bot
color("#0000ff")bot_top();
color("#0000ff")bot_support();
color("#0000ff")bot_seat();
color("#0000ff")bot_bot();
//notprint_wheel();
*/


//--------for print--------
//top_top();
//top_upper();
//rotate([-98,0,0])top_cam();
//part2_kuang_base1();
//zhuomian();
//rotate([0,180,0])bot_dipan();
//screwhelper();
//special_support();
//special_back();
//special_board();
//special_zhicheng();
special_bottom();
//rotate([180,0,0])bot_top();
//bot_seat();
//conn();
//rotate([0,90,0])bot_seat_left();
//rotate([0,180,0])upper_real();
//screwhelper();
//bot_bot();
//rotate([90,0,0])bot_l298n();
//rotate([-90,0,0])bot_power();