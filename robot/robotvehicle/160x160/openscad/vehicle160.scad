
module cam(){
difference(){
    cube([28,28,1.6],center=true);
    //middle
    translate([0,-2,0])cube([12,24,10],center=true);
    //edge
    //translate([-15,15,0])cube([10,4,10],center=true);
    //translate([ 15,15,0])cube([10,4,10],center=true);
    //hole
    translate([-21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}
module cam_bottom(){
    difference(){
        translate([0,50,42+2])cube([20,20,4],center=true);
        translate([0,50,42+1.1])cube([50,10,2.2],center=true);
        translate([0,50,0.5])cylinder(100, r=1.6,center=true,$fn=50);
        translate([0,58,42+3])cube([100,2,2],center=true);
    }
}
module cam_mount(){
    translate([0,60-0.8,56])rotate([90,0,0])cam();
    cam_bottom();
}

module bezier(x,y,h){
linear_extrude(height=h)polygon([
    for(t=[0:0.05:1.0])    [x*t*t, y*(1-t)*(1-t)], [0, 0]
]);
}

module cubeminucylinder(cubex,cylinderx,height){
    difference(){
    translate([cubex/2,cubex/2,height/2])cube([cubex,cubex,height],center=true);
    translate([0,0,height/2])cylinder(height+1, r=cylinderx,center=true,$fn=50);
    }
}

VALUE_0 = 40.0;
VALUE_1 = 41.8;
VALUE_2 = 44.2;
VALUE_3 = 47.6;
module cubeintersectcylinderminuscylinder(cubex, outx, inx,height){
    difference(){
    intersection(){
    translate([cubex/2,cubex/2,height/2])cube([cubex,cubex,height],center=true);
    translate([0,0,height/2])cylinder(height,r=outx,center=true,$fn=50);
    }
    translate([0,0,height/2])cylinder(height+1,r=inx,center=true,$fn=50);
    }
}

module cylinderintersectcylinder(height){
    intersection(){
    translate([-20, 20, height/2])cylinder(height,r=40,center=true,$fn=50);
    translate([ 20,-20,height/2])cylinder(height,r=40,center=true,$fn=50);
    }
}

module screwhelper(rout, rin, height)
{
    difference(){
        translate([0,0,height/2])cylinder(height, r=rout,center=true,$fn=50);
        translate([0,0,height/2])cylinder(height+0.01, r=rin,center=true,$fn=50);
    }
}

module addon(size){
    difference(){
        cylinder(size, r=4.9,center=true,$fn=50);
        cylinder(size+0.01, r=2.5,center=true,$fn=50);
        translate([-2.5,-2.5,0])cube([5.1,5.1,size+0.01],center=true);
        translate([ 2.5, 2.5,0])cube([5.1,5.1,size+.01],center=true);
    }
}
module conn_xh254_real(){
    difference(){
    union(){
    //+special
    translate([-10,-11,5])cube([20,2,10], center=true);
    //xh254
    translate([0,0,5])cube([40,20,10],center=true);
    }

    //hole
    translate([ 20,0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([  0,0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-20,0,0])cylinder(100,r=3.1,center=true,$fn=50);

    //-xh254.chargerside
    //.special+++
    translate([-10,9+0.5, 5.5])cube([   6,1.01,9.01],center=true);
    //translate([-10,9+0.5, 9])cube([12.4,1.01,2.01],center=true);
    translate([-10,8+0.5, 5.5])cube([12.4,1.01,9.01],center=true);
    //.special---
    //normal
    translate([-10,  -2+0.5, 5.5])cube([12.4,19,9.01],center=true);
    translate([-10,-12+0.5, 5.5])cube([9,1.01,9.01],center=true);

    //-xh254.batteryside
    translate([ 10,10-3/2, 5+2])cube([6,3.01,6.01],center=true);
    translate([ 10,0, 5+1])cube([8.2,15,8.01],center=true);
    translate([ 10,0-15/2+7/2, 5+1])cube([10.0,7.01,8.01],center=true);
    translate([ 10,0-15/2-0.5, 5+1])cube([8.0,1,8.01],center=true);
    translate([ 10,-9.01, 5.4])cube([13,2,9.21],center=true);
    }
}
module conn_xh254_upper(){
    //up.up.3pin
    translate([10,0,8])rotate([0,0,90])conn_xh254_real();

    //up.up.other
    difference(){
    translate([-10,0,18-5])cube([20,40,10],center=true);
    //hole
    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //
    translate([-9, 10,18-9/2])cube([18,10,19.01],center=true);
    translate([-10, 0, 20-5-10/2])cube([10,10,10.01],center=true);
    translate([-9,-10,18-9/2])cube([18,10,19.01],center=true);
    }

    //up.down
    difference(){
    union(){
    //support
    translate([0,0,4])cube([40,40,8],center=true);
    }
    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([ 10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //
    translate([0,0, 8])cube([33,33,16.01], center=true);
    translate([0,0, 8])cube([60,20,16.01], center=true);
    }
}
module conn_xh254_below()
{
    difference(){
        union(){
        translate([-10, 20-3/2,-5/2])cube([10,3,5], center=true);
        translate([-10, 20,0])cylinder(10,r=3,center=true,$fn=50);
        translate([ 10, 20-3/2,-5/2])cube([10,3,5], center=true);
        translate([ 10, 20,0])cylinder(10,r=3,center=true,$fn=50);
        
        translate([-10,-20+3/2,-5/2])cube([10,3,5], center=true);
        translate([-10,-20,0])cylinder(10,r=3,center=true,$fn=50);
        translate([ 10,-20+3/2,-5/2])cube([10,3,5], center=true);
        translate([ 10,-20,0])cylinder(10,r=3,center=true,$fn=50);
        }

        translate([0, 30,-5])cube([30,20,20], center=true);
        translate([0,-30,-5])cube([30,20,20], center=true);
    }

    //bot.up
    difference(){
    union(){
    //support
    translate([0,0,-5])cube([40,40,10],center=true);
    }
    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([ 10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //
    translate([0,0,-8])cube([33, 33, 16.01], center=true);
    translate([0,0,-8])cube([60,20,16.01], center=true);
    }

    //bot.down.other
    difference(){
    translate([-10,0,-18+4])cube([20,40,8], center=true);
    //hole
    translate([10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //hole
    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //
    translate([-9, 10,-18+8/2])cube([18,10,8.01],center=true);
    translate([-10, 0,-10-5/2])cube([10,10,5.01],center=true);
    translate([-9,-10,-18+8/2])cube([18,10,8.01],center=true);
    }

    //bot.down.2pin
    difference(){
    translate([10,0,-18+4])cube([20,40,8], center=true);
    //hole
    translate([10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);
    //
    translate([15, 10,-18+6/2])cube([8,8,6.1], center=true);
    translate([15, 10,-18+6/2])cube([10.01,6,6.1], center=true);
    translate([5, 10,-18+6/2])cube([10.01,4,6.1], center=true);

    translate([15,-10,-18+6/2])cube([8,8,6.1], center=true);
    translate([15,-10,-18+6/2])cube([10.01,6,6.1], center=true);
    translate([5,-10,-18+6/2])cube([10.01,4,6.1], center=true);
    }
}
module conn_xh254(){
    conn_xh254_upper();
    conn_xh254_below();
}
module conn_bms_upper(){
    difference(){
    union(){
    translate([0,0,9])cube([40,40,18],center=true);
    }

    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([ 10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([0, 0,0])cube([50,10,32],center=true);
    translate([0, 0,0])cube([28,20,32],center=true);
    translate([0, 0,0])cube([20,28,32],center=true);
    translate([0, 0,0])cube([10,50,32],center=true);
    }
}
module conn_bms_below(){
    difference(){
    union(){
    translate([0,0,-9])cube([40,40,18],center=true);
    }

    translate([-10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([-10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([ 10, 20,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,  0,0])cylinder(100,r=3.1,center=true,$fn=50);
    translate([ 10,-20,0])cylinder(100,r=3.1,center=true,$fn=50);

    translate([0, 0,0])cube([50,10,32],center=true);
    translate([0, 0,0])cube([28,20,32],center=true);
    translate([0, 0,0])cube([20,28,32],center=true);
    translate([0, 0,0])cube([10,50,32],center=true);
    }
}
module conn_bms(){
    conn_bms_upper();
    conn_bms_below();
}

module conn_motor(){
    difference(){
        conn(36,45);
        translate([0,0,5.01])cube([20,40.01,10],center=true);
    }
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
    cube([28,28,1.6],center=true);
    //middle
    translate([0,-2,0])cube([12,24,10],center=true);
    //edge
    //translate([-15,15,0])cube([10,4,10],center=true);
    //translate([ 15,15,0])cube([10,4,10],center=true);
    //hole
    translate([-21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}
module cam_bottom(){
    difference(){
        translate([0,50,42+2])cube([20,20,4],center=true);
        translate([0,50,42+1.1])cube([50,10,2.2],center=true);
        translate([0,50,0.5])cylinder(100, r=1.6,center=true,$fn=50);
        translate([0,58,42+3])cube([100,2,2],center=true);
    }
}
module cam_mount(){
    translate([0,60-0.8,56])rotate([90,0,0])cam();
    cam_bottom();
}

module inmp441(){
    translate([0,0,1])cube([20,40,2],center=true);
    translate([0,0,2+5])cube([2.54*3,2.54*4,10],center=true);
}
module top_mic(){
translate([ 40,0,60])rotate([0, 90,0])inmp441();
translate([-40,0,60])rotate([0,-90,0])inmp441();
}

module batterypack(){
    translate([ 0,29,0])cube([40,20,40],center=true);
    translate([-10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([-10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 0,-29,0])cube([40,20,40],center=true);
}
module notprint_battery(){
    difference(){
    union(){
    translate([ 60,0, 20])batterypack();
    translate([-60,0, 20])batterypack();
    }
    translate([-80+1,0,20-20+1])cube([2.01,80,2.01],center=true);
    translate([-80+1,0,20+20-1])cube([2.01,80,2.01],center=true);
    translate([-40-1,0,20-20+1])cube([2.01,80,2.01],center=true);
    translate([-40-1,0,20+20-1])cube([2.01,80,2.01],center=true);
    }
}

module notprint_rpizero(){
    difference(){
        translate([0,0,1])cube([30.5,65,2],center=true);
        translate([-58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}

module notprint_wavesharesensehat(){
    difference(){
        union(){
        translate([0,0,1])cube([30.5,65,2],center=true);
        translate([30.5/2-4,0,-2])cube([6,52,4],center=true);
        }
        translate([-58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}

module sensorsupport(){
    translate([0,0,-20-1])cube([40,10,2],center=true);
    //left
    difference(){
        translate([-30,0,-20-1])cube([20,30,2],center=true);
        translate([-40+5,0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
        translate([-40+5/2,0,-30])cube([5,10,16],center=true);
        translate([-40+5,0,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
    //right
    difference(){
        translate([ 30,0,-20-1])cube([20,30,2],center=true);
        translate([ 40-5,0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 58/2, 23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2,-23/2, 0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
        translate([ 40-5/2,0,-30])cube([5,10,16],center=true);
        translate([ 40-5,0,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
}

module notprint_l298n(){
    difference(){
        union(){
        translate([0,0,1])cube([65,65,2],center=true);
        translate([0,-65/2+3+15/2,13])cube([53,15,20],center=true);
        translate([0,-65/2+(51+28)/2,2+11/2])cube([56,51-28,11],center=true);
        translate([-8, 65/2-(14+24)/2,2+13/2])cylinder(13, r=5,center=true,$fn=50);
        translate([ 8, 65/2-(14+24)/2,2+13/2])cylinder(13, r=5,center=true,$fn=50);
        }

        translate([-27.5, 65/2-5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 27.5, 65/2-5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-14.5,-65/2+5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 14.5,-65/2+5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}



module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([ 80, 80,-40])rotate([0,0, 45])wheel();
    translate([-80, 80,-40])wheel();
    translate([ 80,-80,-40])wheel();
    translate([-80,-80,-40])wheel();
}

/*
module motorseat(){
difference(){
    translate([0, 0,2])cube([24,160,4],center=true);
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
module bot_motorseat_left(){
    translate([-50, -60, -2-6.5/2])bot_motorseat_helper();
    translate([-50,  60, -2-6.5/2])bot_motorseat_helper();

    translate([-40,0,-20])rotate([0,-90,0])motorseat();

    translate([-50, -60, -40+2+6.5/2])bot_motorseat_helper();
    translate([-50,  60, -40+2+6.5/2])bot_motorseat_helper();
}
module bot_motorseat_right(){
    translate([ 50,  60, -2-6.5/2])bot_motorseat_helper();
    translate([ 50, -60, -2-6.5/2])bot_motorseat_helper();

    translate([ 40,0,-20])rotate([0, 90,0])motorseat();

    translate([ 50,  60, -40+2+6.5/2])bot_motorseat_helper();
    translate([ 50, -60, -40+2+6.5/2])bot_motorseat_helper();
}
module bot_motorseat(){
    bot_motorseat_left();
    bot_motorseat_right();
}
*/



module tmp_bot_motorseat(){
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

    translate([-8.6, 80-21,3/2])cylinder(3.01, r=3,center=true,$fn=50);
    translate([ 8.6, 80-21,3/2])cylinder(3.01, r=3,center=true,$fn=50);
    translate([-8.6,-80+21,3/2])cylinder(3.01, r=3,center=true,$fn=50);
    translate([ 8.6,-80+21,3/2])cylinder(3.01, r=3,center=true,$fn=50);
}
}
module tmp_bot_motorseat_helper()
{
    difference(){
        translate([0,10,0])cube([20,60,6.5],center=true);
/*
        translate([0,-10, 6.5/2-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0,-10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0,-10,-6.5/2+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);

        translate([0, 10, 6.5/2-1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
        translate([0, 10,0])cylinder(h=7,r=1.6,center=true,$fn=50);
        translate([0, 10,-6.5/2+1.1])cylinder(h=2.21,r=5,center=true,$fn=50);
*/
    }
}
module tmp_motorseat_extra(){
    difference(){
        union(){
        translate([0, 0,-5/2])cylinder(5, r=20,center=true,$fn=100);
        translate([20,0, -5/2])cube([40,40,5],center=true);
        }
        //
        translate([ 0, 0, 0])cylinder(h=3.01,r=16,center=true,$fn=100);
        translate([ 0, 0,-5])cylinder(h=3.01,r=16,center=true,$fn=100);
        //
        translate([  0,  0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([  0, 10, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([  0,-10, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([ 10,  0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([-10,  0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    }
}
module tmp_motorseat(){
    translate([0,0,20])tmp_motorseat_extra();

    translate([40,0, 40])rotate([-90, 0, 90])tmp_bot_motorseat();
    translate([30, 36/2-6.5/2,-20])rotate([90,0,0])tmp_bot_motorseat_helper();
    translate([30,-36/2+6.5/2,-20])rotate([90,0,0])tmp_bot_motorseat_helper();
}
module tmp_motorseat_intersection()
{
    intersection(){
    tmp_motorseat();
    cylinder(1000, r=40-0.1,center=true,$fn=50);
    }
}
module tmp_motorseat_all(){
    translate([ 80, 80,0])rotate([0,0,45])tmp_motorseat_intersection();
    translate([-80, 80,0])rotate([0,0,0])tmp_motorseat_intersection();
    translate([ 80,-80,0])rotate([0,0,180])tmp_motorseat_intersection();
    translate([-80,-80,0])rotate([0,0,0])tmp_motorseat_intersection();
}


module bot_seperater_above()
{
difference(){
    translate([0,0, 2+8])cube([80,80,16],center=true);
    translate([0,0, 2+8])cube([76,64,20],center=true);
    translate([0,0, 2+8])cube([64,76,20],center=true);
    translate([0,0, 2+16])cube([60,90,32],center=true);
    translate([0,0, 2+16])cube([90,60,32],center=true);
    //corner
    translate([-40+5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    //corner
    translate([-40+5, 40-5,18-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,18-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,18-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,18-1])cylinder(2.01, r=3.1,center=true,$fn=50);
}

difference(){
    union(){
    translate([0,0, 1])cube([80,80,2],center=true);
    //+pizero hole
    translate([-20-23/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([-20+23/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([-20-23/2,-58/2, 2])screwhelper(4, 1.6, 2);
    translate([-20+23/2,-58/2, 2])screwhelper(4, 1.6, 2);
    //+sensehat hole
    translate([ 20-23/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([ 20+23/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([ 20-23/2,-58/2, 2])screwhelper(4, 1.6, 2);
    translate([ 20+23/2,-58/2, 2])screwhelper(4, 1.6, 2);
    }
    //corner
    translate([-40+5, 40-5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    //corner
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    //
    translate([ 0, 40-5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 0,-40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([-40+5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40-5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    //-pizero hole
    translate([-20-23/2, 58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-20+23/2, 58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-20-23/2,-58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-20+23/2,-58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    //-sensehat hole
    translate([ 20-23/2, 58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 20+23/2, 58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 20-23/2,-58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 20+23/2,-58/2,1])cylinder(2.01, r=3,center=true,$fn=50);
    //-rpi 40pin
    translate([-20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
    //-sensehat 40pin
    translate([ 20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
}
}

module bot_seperater_below()
{
    difference(){
    translate([0,0,-2-8])cube([80,80,16],center=true);
    translate([0,0,-2-8])cube([64,76,20],center=true);
    translate([0,0,-2-8])cube([76,64,20],center=true);
    translate([0,0,-2-16])cube([60,90,32],center=true);
    translate([0,0,-2-16])cube([90,60,32],center=true);
    //corner
    translate([-40+5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    //corner
    translate([-40+5, 40-5,-18+1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,-18+1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,-18+1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,-18+1])cylinder(2.01, r=3.1,center=true,$fn=50);
    }

    difference(){
    translate([0,0,-1])cube([80,80,2],center=true);
    //corner
    translate([-40+5, 40-5,-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    //
    translate([ 0, 40-5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 0,-40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([-40+5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40-5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    //-l298n hole
    translate([-27.5, 65/2-5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-14.5, 65/2-5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 14.5, 65/2-5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-27.5,-65/2+5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 27.5,-65/2+5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-14.5,-65/2+5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 14.5,-65/2+5.3,-1])cylinder(2.01, r=3,center=true,$fn=50);
    }

    //-l298n hole
    //translate([-27.5, 65/2-5.3,-4])screwhelper(4, 1.6, 2);
    //translate([ 27.5, 65/2-5.3,-4])screwhelper(4, 1.6, 2);
    translate([-14.5, 65/2-5.3,-4])screwhelper(4, 1.6, 2);
    translate([ 14.5, 65/2-5.3,-4])screwhelper(4, 1.6, 2);
    translate([-27.5,-65/2+5.3,-4])screwhelper(4, 1.6, 2);
    translate([ 27.5,-65/2+5.3,-4])screwhelper(4, 1.6, 2);
    //translate([-14.5,-65/2+5.3,-4])screwhelper(4, 1.6, 2);
    //translate([ 14.5,-65/2+5.3,-4])screwhelper(4, 1.6, 2);
}

module mid_top(){
/*
    //yuan 2
    difference(){
        union(){
        //top 0
        translate([-80, 80,-5])rotate([0,0,270])cubeintersectcylinderminuscylinder(40, 60, VALUE_0, 5);
        translate([ 80, 80,-5])rotate([0,0,180])cubeintersectcylinderminuscylinder(40, 60, VALUE_0, 5);
        translate([ 80,-80,-5])rotate([0,0,90])cubeintersectcylinderminuscylinder(40, 60, VALUE_0, 5);
        translate([-80,-80,-5])rotate([0,0,0])cubeintersectcylinderminuscylinder(40, 60, VALUE_0, 5);
        }
        //corner hole
        translate([-50+5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50+5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
        //
        translate([-50+5, 50-5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        //
        translate([-50+5, 50-5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5,-5])cylinder(3.01, r=4,center=true,$fn=50);
    }
*/
/*
    //popup
    translate([ 24.5,   0+29,-4])screwhelper(3.6, 1.6, 2);
    difference(){
    translate([ 24.5-23,0+29,-4])screwhelper(3.6, 1.6, 2);
    translate([-24.5+23,0+29,-4])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23,0+29,-4])screwhelper(3.6, 1.6, 2);
    translate([ 24.5-23,0+29,-4])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,   0+29,-4])screwhelper(3.6, 1.6, 2);
    //
    translate([ 24.5,   0-29,-4])screwhelper(3.6, 1.6, 2);
    difference(){
    translate([ 24.5-23,0-29,-4])screwhelper(3.6, 1.6, 2);
    translate([-24.5+23,0-29,-4])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23,0-29,-4])screwhelper(3.6, 1.6, 2);
    translate([ 24.5-23,0-29,-4])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,   0-29,-4])screwhelper(3.6, 1.6, 2);
*/
    translate([ 60, 60, -10])screwhelper(4, 1.6, 10);
    translate([-60, 60, -10])screwhelper(4, 1.6, 10);
    translate([ 60,-60, -10])screwhelper(4, 1.6, 10);
    translate([-60,-60, -10])screwhelper(4, 1.6, 10);

    difference(){
    union(){
    translate([ 60, 60, -30])screwhelper(4, 3.1, 20);
    translate([-60, 60, -30])screwhelper(4, 3.1, 20);
    translate([ 60,-60, -30])screwhelper(4, 3.1, 20);
    translate([-60,-60, -30])screwhelper(4, 3.1, 20);
    }
    translate([ 60, 60, -20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60, 60, -20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60, 60, -20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60, 60, -20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60,-60, -20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60,-60, -20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60,-60, -20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60,-60, -20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    }

    difference(){
    union(){
    translate([  0,  0, -1])cube([80, 160, 2],center=true);
    translate([  0,  0, -1])cube([160, 80, 2],center=true);
    //
    translate([ 40, 40,-1])cylinder(2, r=40,center=true,$fn=50);
    translate([-40, 40,-1])cylinder(2, r=40,center=true,$fn=50);
    translate([ 40,-40,-1])cylinder(2, r=40,center=true,$fn=50);
    translate([-40,-40,-1])cylinder(2, r=40,center=true,$fn=50);
    //
    translate([-30, 80-20/2, 0-2-2/2])cube([9.9, 9.9, 2],center=true);
    translate([ 30, 80-20/2, 0-2-2/2])cube([9.9, 9.9, 2],center=true);
    }
    //less print
    //translate([  0,  0, -1.1])cylinder(1.81, r=40,center=true,$fn=50);
    //translate([  0,  0, -1.5])cylinder(1.01, r=60,center=true,$fn=50);
/*
    //-rpi3 hole
    translate([ 24.5,0+29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([-24.5,0+29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([ 24.5,0-29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([-24.5,0-29,0])cylinder(1000, r=2.6,center=true,$fn=50);

    //rpi3 40pin
    translate([ 24.5, 0,-10-2])cube([5.8,52-0.4,40],center=true);
    translate([-24.5, 0,-10-2])cube([5.8,52-0.4,40],center=true);

    //-rpizero hole
    translate([24.5-23,0+29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([24.5-23,0-29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([-24.5+23,0+29,0])cylinder(1000, r=2.6,center=true,$fn=50);
    translate([-24.5+23,0-29,0])cylinder(1000, r=2.6,center=true,$fn=50);

    //rpizero 40pin
    translate([ 24.5-23,0,-10-2])cube([5.8,52-0.4,40],center=true);
    translate([-24.5+23,0,-10-2])cube([5.8,52-0.4,40],center=true);

    //rpiall 1mm area
    translate([0,0,-1.5])cube([80,52,1.01],center=true);
*/
/*
    //corner hole 35
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    //corner hole 45
    translate([-40-5, 40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40+5, 40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([-40-5,-40-5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40+5,-40-5,1])cylinder(10, r=4,center=true,$fn=50);
*/

    //-cam hole
    translate([-30,70,0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([30,70,0])cylinder(1000, r=1.6,center=true,$fn=50);

    //
    translate([0, 60,-2+1.8/2])cube([50,30,1.81],center=true);
    translate([0,-60,-2+1.8/2])cube([70,30,1.81],center=true);
    translate([ 60,0,-2+1.8/2])cube([30,70,1.81],center=true);
    translate([-60,0,-2+1.8/2])cube([30,70,1.81],center=true);
    translate([0,0,-2+1.8/2])cylinder(1.81, r=40,center=true,$fn=50);

    //fl
    translate([-60, 60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60-10, 60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-60+10, 60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //fr
    translate([ 60, 60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60-10, 60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 60+10, 60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //nl
    translate([-60,-60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60-10,-60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-60+10,-60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //nr
    translate([ 60,-60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60-10,-60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 60+10,-60+10,1])cylinder(10, r=1.6,center=true,$fn=50);

    //47,47
    translate([ 47, 47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([-47, 47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([ 47,-47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([-47,-47,0])cylinder(300, r=5,center=true,$fn=50);
/*
    //-near far hole
    for(x=[-30:10:30]){
    for(y=[-70:10:-50]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    for(y=[50:10:70]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }

    //-left right hole
    for(y=[-30:10:30]){
    for(x=[-70:10:-50]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    for(x=[50:10:70]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }
*/
    }
}

module mid_connect(){
    difference(){
    translate([-60, 60, 42])cylinderintersectcylinder(36);
    translate([-50, 70, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([-60, 60, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([-70, 50, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
}

module speakerseat(){
    //l
    translate([-80+1.4, 40, 0])rotate([0,-21.4,0])translate([1,0,12])cube([2, 20, 24],center=true);
    translate([-80+1.4,-40, 0])rotate([0,-21.4,0])translate([1,0,12])cube([2, 20, 24],center=true);
    translate([-80+1, 40, 2+2.2/2])cube([2, 20, 2.2],center=true);
    translate([-80+1,-40, 2+2.2/2])cube([2, 20, 2.2],center=true);
    //r
    translate([-40-1, 40, 2+13.7/2])cube([2, 20, 13.7],center=true);
    translate([-40-1,-40, 2+13.7/2])cube([2, 20, 13.7],center=true);
    //f
    translate([-80-5/2, 50+1, 15])cube([5, 2, 10],center=true);
    translate([-80+5, 50+1, 2+18/2])cube([10, 2, 18],center=true);
    translate([-40-5, 50+1, 2+18/2])cube([10, 2, 18],center=true);
    //n
    translate([-80-5/2,-50-1, 15])cube([5, 2, 10],center=true);
    translate([-80+5,-50-1, 2+18/2])cube([10, 2, 18],center=true);
    translate([-40-5,-50-1, 2+18/2])cube([10, 2, 18],center=true);
}

module mid_bot_add(){
    val = 0;
    //val+29
    translate([ 24.5,   val+29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23,val+29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23,val+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23,val+29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23,val+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,   val+29, 2])screwhelper(4, 1.6, 2);

    //val-29
    translate([ 24.5,   val-29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23,val-29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23,val-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23,val-29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23,val-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,   val-29, 2])screwhelper(4, 1.6, 2);
}
module mid_bot_sub(){
    val = 0;
    //-rpi3 hole
    translate([ 24.5, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-24.5, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([ 24.5, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-24.5, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpizero hole
    translate([ 24.5-23, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([ 24.5-23, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-24.5+23, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-24.5+23, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpi 40pin
    translate([ 49/2, val,0])cube([5.8,52-0.4,99],center=true);
    translate([-49/2, val,0])cube([5.8,52-0.4,99],center=true);

    //-rpizero 40pin
    translate([ 49/2-23, val,0])cube([5.8,52-0.4,99],center=true);
    translate([-49/2+23, val,0])cube([5.8,52-0.4,99],center=true);
}
module mid_bot_add2(){
    val = 0;
    //val+29
    translate([ 23/2,   val+29, 2])screwhelper(4, 1.6, 8);
    translate([-23/2,   val+29, 2])screwhelper(4, 1.6, 8);

    //val-29
    translate([ 23/2,   val-29, 2])screwhelper(4, 1.6, 8);
    translate([-23/2,   val-29, 2])screwhelper(4, 1.6, 8);
}
module mid_bot_sub2(){
    val = 0;
    //-rpi3 hole
    translate([ 23/2, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-23/2, val+29,0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpizero hole
    translate([ 23/2, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([-23/2, val-29,0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpi 40pin
    translate([ 23/2, val,0])cube([5.8,52-0.4,99],center=true);
    translate([-23/2, val,0])cube([5.8,52-0.4,99],center=true);

    //-rpizero 40pin
    translate([ 23/2, val,0])cube([5.8,52-0.4,99],center=true);
    translate([-23/2, val,0])cube([5.8,52-0.4,99],center=true);
}
module mid_bot(){
    difference(){
    translate([0, 40+32/2,0])rotate([0,0,90])mid_bot_add2();
    translate([0, 40+32/2,0])cube([52-0.4,32, 99],center=true);
    }
    difference(){
    translate([0, 40-32/2,0])rotate([0,0,90])mid_bot_add2();
    translate([0, 40-32/2,0])cube([52-0.4,32, 99],center=true);
    }
    difference(){
    translate([0,-40,0])mid_bot_add();
    translate([0,-40,0])cube([64, 52-0.4,99],center=true);
    }

    difference(){
    union(){
    translate([ 60, 60, 10])screwhelper(2.9, 1.6, 20);
    translate([-60, 60, 10])screwhelper(2.9, 1.6, 20);
    translate([ 60,-60, 10])screwhelper(2.9, 1.6, 20);
    translate([-60,-60, 10])screwhelper(2.9, 1.6, 20);
    }
    translate([ 60, 60, 20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60, 60, 20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60,-60, 20])rotate([0,90,-45])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60,-60, 20])rotate([0,90, 45])cylinder(99, r=1.6,center=true,$fn=50);
    }
    translate([ 60, 60, 0])screwhelper(4, 1.6, 10);
    translate([-60, 60, 0])screwhelper(4, 1.6, 10);
    translate([ 60,-60, 0])screwhelper(4, 1.6, 10);
    translate([-60,-60, 0])screwhelper(4, 1.6, 10);

    //board
    difference(){
    union(){
    //
    translate([ 40, 40, 1])cylinder(2, r=40,center=true,$fn=50);
    translate([-40, 40, 1])cylinder(2, r=40,center=true,$fn=50);
    translate([ 40,-40, 1])cylinder(2, r=40,center=true,$fn=50);
    translate([-40,-40, 1])cylinder(2, r=40,center=true,$fn=50);
    //
    translate([0, 0, 1])cube([80, 160, 2],center=true);
    translate([0, 0, 1])cube([160, 80, 2],center=true);
    //speaker 100x45
    //speakerseat();
    //mirror([1,0,0])speakerseat();
    //translate([-60, 0, 20])rotate([0,-21.4,0])cube([45, 100, 21],center=true);
    //speaker 25*35
    translate([ 65, 0, 10/2])cube([30, 40, 10],center=true);
    translate([-65, 0, 10/2])cube([30, 40, 10],center=true);
    }

    //-speaker 25*35 right
    translate([ 65, 0, 2+18/2])cube([10, 60, 18],center=true);
    translate([ 65, 0, 2+18/2])cube([40, 20, 18],center=true);
    translate([ 65, 0, 2+18/2])cube([25, 35, 18.01],center=true);
    translate([ 65, 0, 1+19/2])cube([20, 30, 19.01],center=true);
    translate([ 65, 0, 0+20/2])cube([10, 20, 20.01],center=true);
    //-speaker 25*35 left
    translate([-65, 0, 2+18/2])cube([10, 60, 18],center=true);
    translate([-65, 0, 2+18/2])cube([40, 20, 18],center=true);
    translate([-65, 0, 2+18/2])cube([25, 35, 18.01],center=true);
    translate([-65, 0, 1+19/2])cube([20, 30, 19.01],center=true);
    translate([-65, 0, 0+20/2])cube([10, 20, 20.01],center=true);

    //47,47
    translate([ 47, 47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([-47, 47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([ 47,-47,0])cylinder(300, r=5,center=true,$fn=50);
    translate([-47,-47,0])cylinder(300, r=5,center=true,$fn=50);

    //-center
    //translate([0, 0, 1.1])cube([40, 20, 1.81],center=true);
    translate([ 20, 0, 0])cylinder(99, r=5,center=true,$fn=50);
    translate([  0, 0, 0])cylinder(99, r=5,center=true,$fn=50);
    translate([-20, 0, 0])cylinder(99, r=5,center=true,$fn=50);
    //
    translate([ 36, 70, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36, 70, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36, 50, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36, 50, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36, 30, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36, 30, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36, 10, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36, 10, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36,-10, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36,-10, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36,-30, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36,-30, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36,-50, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36,-50, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([ 36,-70, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    translate([-36,-70, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
    /*
    //corner hole 35
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);

    //corner hole 45
    translate([-40-5, 40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40+5, 40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([-40-5,-40-5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40+5,-40-5,1])cylinder(10, r=4,center=true,$fn=50);
    //@ 50
    translate([-50, 50,1])cylinder(99, r=4,center=true,$fn=50);
    translate([ 50, 50,1])cylinder(99, r=4,center=true,$fn=50);
    translate([-50,-50,1])cylinder(99, r=4,center=true,$fn=50);
    translate([ 50,-50,1])cylinder(99, r=4,center=true,$fn=50);
    */
    //fl
    translate([-60, 60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60-10, 60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-60+10, 60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //fr
    translate([ 60, 60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60-10, 60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 60+10, 60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //nl
    translate([-60,-60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-60-10,-60+10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-60+10,-60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    //nr
    translate([ 60,-60,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 60-10,-60-10,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 60+10,-60+10,1])cylinder(10, r=1.6,center=true,$fn=50);

    translate([0, 40+32/2,0])rotate([0,0,90])mid_bot_sub2();
    translate([0, 40-32/2,0])rotate([0,0,90])mid_bot_sub2();
    translate([0,-40,0])mid_bot_sub();
/*
    //-near far hole
    for(x=[-30:10:30]){
    for(y=[-70:10:-50]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    for(y=[50:10:70]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }

    //-left right hole
    for(y=[-30:10:30]){
    for(x=[-70:10:-50]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    for(x=[50:10:70]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }
*/
    }//difference
}

module bot_top(){
    //yuan 0
    difference(){
        union(){
        translate([ 80, 80, -5])cylinder(10, r=20,center=true,$fn=50);
        translate([-80, 80, -5])cylinder(10, r=20,center=true,$fn=50);
        translate([ 80,-80, -5])cylinder(10, r=20,center=true,$fn=50);
        translate([-80,-80, -5])cylinder(10, r=20,center=true,$fn=50);
        }
        //top,right
        translate([ 80, 80, 0-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([ 80, 80,-10+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([ 80, 80, -10])cylinder(30, r=5,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([ 
            80, 80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //
        translate([-80, 80, 0-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([-80, 80,-10+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([-80, 80, -10])cylinder(30, r=5,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([-80, 80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //
        translate([ 80,-80, 0-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([ 80,-80,-10+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([ 80,-80, -10])cylinder(30, r=5,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([ 80,-80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //
        translate([-80,-80, 0-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([-80,-80,-10+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([-80,-80, -10])cylinder(30, r=5,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([-80,-80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
    }

    //yuan 1
    difference(){
        union(){
    translate([-80, 80,-10])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,60, 20, 10);
    translate([ 80, 80,-10])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,60, 20, 10);
    translate([ 80,-80,-10])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,60, 20, 10);
    translate([-80,-80,-10])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,60, 20, 10);
        }
        //print less
        translate([ 60, 60,-2-4])cube([36, 36, 8.01],center=true);
        translate([-60, 60,-2-4])cube([36, 36, 8.01],center=true);
        translate([ 60,-60,-2-4])cube([36, 36, 8.01],center=true);
        translate([-60,-60,-2-4])cube([36, 36, 8.01],center=true);
        //hole@47,47
        translate([ 47, 47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([-47, 47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([ 47,-47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([-47,-47,0])cylinder(300, r=5,center=true,$fn=50);
        
        //top,right
        translate([ 50, 70,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 60, 60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 70, 50,0])cylinder(300, r=1.6,center=true,$fn=50);
        //top,left
        translate([-70, 50,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-60, 60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50, 70,0])cylinder(300, r=1.6,center=true,$fn=50);
        //bot,right
        translate([ 50,-70,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 60,-60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 70,-50,0])cylinder(300, r=1.6,center=true,$fn=50);
        //bot,left
        translate([-70,-50,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-60,-60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50,-70,0])cylinder(300, r=1.6,center=true,$fn=50);
    }
/*
    //yuan 2
    difference(){
        union(){
        //top 0
        translate([-80, 80,-5])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,VALUE_1, VALUE_0, 5);
        translate([ 80, 80,-5])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,VALUE_1, VALUE_0, 5);
        translate([ 80,-80,-5])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,VALUE_1, VALUE_0, 5);
        translate([-80,-80,-5])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,VALUE_1, VALUE_0, 5);
        //top 1
        translate([-80, 80,-5])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 4);
        translate([ 80, 80,-5])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 4);
        translate([ 80,-80,-5])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 4);
        translate([-80,-80,-5])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 4);
        }
    }

    //yuan 3
    difference(){
        union(){
        translate([-80, 80,-5])rotate([0,0,270])cubeintersectcylinderminuscylinder(40, 60, VALUE_2, 5);
        translate([ 80, 80,-5])rotate([0,0,180])cubeintersectcylinderminuscylinder(40, 60, VALUE_2, 5);
        translate([ 80,-80,-5])rotate([0,0, 90])cubeintersectcylinderminuscylinder(40, 60, VALUE_2, 5);
        translate([-80,-80,-5])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40, 60, VALUE_2, 5);
        }
        //
        translate([-50+5, 50-5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5, 0])cylinder(3.01, r=4,center=true,$fn=50);
        //
        translate([-50+5, 50-5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5,-5])cylinder(3.01, r=4,center=true,$fn=50);
        //corner hole
        translate([-50+5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50+5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
    }
*/
/*
    //popup for corner
    translate([-40+5, 40-5, -4])screwhelper(3, 1.6, 2);
    translate([ 40-5, 40-5, -4])screwhelper(3, 1.6, 2);
    translate([-40+5,-40+5, -4])screwhelper(3, 1.6, 2);
    translate([ 40-5,-40+5, -4])screwhelper(3, 1.6, 2);
*/
    //-side hole
    translate([ 20, 70, -4])screwhelper(3, 1.6, 2);
    translate([  0, 70, -4])screwhelper(3, 1.6, 2);
    translate([-20, 70, -4])screwhelper(3, 1.6, 2);
    translate([ 20, 50, -4])screwhelper(3, 1.6, 2);
    translate([  0, 50, -4])screwhelper(3, 1.6, 2);
    translate([-20, 50, -4])screwhelper(3, 1.6, 2);
    translate([ 20,-50, -4])screwhelper(3, 1.6, 2);
    translate([  0,-50, -4])screwhelper(3, 1.6, 2);
    translate([-20,-50, -4])screwhelper(3, 1.6, 2);
    translate([ 20,-70, -4])screwhelper(3, 1.6, 2);
    translate([  0,-70, -4])screwhelper(3, 1.6, 2);
    translate([-20,-70, -4])screwhelper(3, 1.6, 2);

    //mid
    difference(){
        union(){
        translate([  0,  0, -1])cube([160, 80, 2],center=true);
        translate([  0,  0, -1])cube([80, 160, 2],center=true);
        }

        //-battpack right
        translate([60-10,    30-1, -1])cube([16, 20, 10],center=true);
        translate([60+10,    30-1, -1])cube([16, 20, 10],center=true);
        translate([60-10,     0, -1.5])cube([10, 40, 1.01],center=true);
        translate([60+10,     0, -1.5])cube([10, 40, 1.01],center=true);
        translate([60-10,   -30+1, -1])cube([16, 20, 10],center=true);
        translate([60+10,   -30+1, -1])cube([16, 20, 10],center=true);
        //-battpack left
        translate([-60-10,  30-1,  -1])cube([16, 20, 10],center=true);
        translate([-60+10,  30-1,  -1])cube([16, 20, 10],center=true);
        translate([-60-10,     0,-1.5])cube([10, 40, 1.01],center=true);
        translate([-60+10,     0,-1.5])cube([10, 40, 1.01],center=true);
        translate([-60-10, -30+1,  -1])cube([16, 20, 10],center=true);
        translate([-60+10, -30+1,  -1])cube([16, 20, 10],center=true);

        //-center
        //translate([ 0, 0, -2+1.8/2])cube([80, 80, 1.81],center=true);
        translate([ 0, 0, -2.01+1.8/2])cylinder(1.8, r=40,center=true,$fn=50);
        /*
        translate([ 30, 25, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
        translate([-30, 25, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
        translate([ 30, 10, -2+1.8/2])cylinder(18, r=8,center=true,$fn=50);
        translate([-30, 10, -2+1.8/2])cylinder(18, r=8,center=true,$fn=50);
        translate([ 30,-10, -2+1.8/2])cylinder(18, r=8,center=true,$fn=50);
        translate([-30,-10, -2+1.8/2])cylinder(18, r=8,center=true,$fn=50);
        translate([ 30,-25, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
        translate([-30,-25, -2+1.8/2])cylinder(18, r=4,center=true,$fn=50);
        */

        //-far side hole
        translate([ 20, 70,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([  0, 70,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-20, 70,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30, 60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 10, 60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-10, 60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30, 60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 20, 50,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([  0, 50,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-20, 50,0])cylinder(100, r=1.6,center=true,$fn=50);
        //-near side hole
        translate([ 20,-50,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([  0,-50,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-20,-50,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30,-60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 10,-60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-10,-60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30,-60,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 20,-70,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([  0,-70,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-20,-70,0])cylinder(100, r=1.6,center=true,$fn=50);
/*
        //corner hole
        translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
*/
/*
        //xy hole
        translate([ 0, 40-5,1])cylinder(10, r=3,center=true,$fn=50);
        translate([ 0,-40+5,1])cylinder(10, r=3,center=true,$fn=50);
        translate([-40+5, 0,1])cylinder(10, r=3,center=true,$fn=50);
        translate([ 40-5, 0,1])cylinder(10, r=3,center=true,$fn=50);
*/
        //side hole
        translate([ 35, 70, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35, 70, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([ 35, 50, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35, 50, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        //
        translate([ 35, 30, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35, 30, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([ 35, 10, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35, 10, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        //
        translate([ 35,-10, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35,-10, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([ 35,-30, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35,-30, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        //
        translate([ 35,-50, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35,-50, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([ 35,-70, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        translate([-35,-70, -2+1.8/2])cylinder(18, r=3,center=true,$fn=50);
        /*
        //-rpi3 hole
        translate([ 24.5,0+29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([-24.5,0+29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([ 24.5,0-29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([-24.5,0-29,0])cylinder(1000, r=1.6,center=true,$fn=50);

        //-rpizero 40pin

        translate([24.5-23,0+29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([24.5-23,0-29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([-24.5+23,0+29,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([-24.5+23,0-29,0])cylinder(1000, r=1.6,center=true,$fn=50);

        */
        //-sensehat 40pin
        /*
        translate([ 20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        translate([ 20-23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        translate([ 20,65/2-11/2,-10-2])cube([11,11,40],center=true);
        */
    }
}

module bot_connector_triangle(){
    difference(){
        union(){
        translate([-80,-80,0])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40,60, VALUE_2, 30);
        //
        translate([-50+5,-50+5,15])cylinder(33, r=4-0.1,center=true,$fn=50);
        }
        translate([-50+5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
    }
}

module bot_connector_circle(){
    //yuan 0
    difference(){
        union(){
        translate([-80,-80, 30+5/2])cylinder(5, r=20,center=true,$fn=50);
        translate([-80,-80, 30+5/2])cylinder(5+3-0.2, r=16-0.1,center=true,$fn=50);
        }

        //
        translate([-80,-80, -10])cylinder(300, r=1.6,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([-80,-80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
    }
}

module bot_bot(){
    //yuan 0
    difference(){
        union(){
        translate([ 80, 80, 20+5])cylinder(10, r=20,center=true,$fn=50);
        translate([-80, 80, 20+5])cylinder(10, r=20,center=true,$fn=50);
        translate([ 80,-80, 20+5])cylinder(10, r=20,center=true,$fn=50);
        translate([-80,-80, 20+5])cylinder(10, r=20,center=true,$fn=50);
        }

        //top,right
        translate([ 80, 80, 30-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([ 80, 80, 20+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([ 80, 80, -10])cylinder(300, r=1.6,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([ 80, 80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //top,left
        translate([-80, 80, 30-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([-80, 80, 20+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([-80, 80, -10])cylinder(300, r=1.6,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([-80, 80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //bot,right
        translate([ 80,-80, 30-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([ 80,-80, 20+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([ 80,-80, -10])cylinder(300, r=1.6,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([ 80,-80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
        //bot,left
        translate([-80,-80, 30-4/2])cylinder(4.01, r=16,center=true,$fn=50);
        translate([-80,-80, 20+4/2])cylinder(4.01, r=16,center=true,$fn=50);
        //
        translate([-80,-80, -10])cylinder(300, r=1.6,center=true,$fn=50);
        for(angle=[0:45:360]){
        translate([-80,-80, -10])rotate([0,0,angle])translate([10,0,0])cylinder(300, r=1.6,center=true,$fn=50);
        }
    }

    //yuan 1
    difference(){
        union(){
    translate([-80, 80,20])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,VALUE_0, 20, 10);
    translate([ 80, 80,20])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,VALUE_0, 20, 10);
    translate([ 80,-80,20])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,VALUE_0, 20, 10);
    translate([-80,-80,20])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,VALUE_0, 20, 10);
        }
        
        translate([ 60, 60, 20+4])cube([36, 36, 8.01],center=true);
        translate([-60, 60, 20+4])cube([36, 36, 8.01],center=true);
        translate([ 60,-60, 20+4])cube([36, 36, 8.01],center=true);
        translate([-60,-60, 20+4])cube([36, 36, 8.01],center=true);
        
        //top,right
        translate([ 50, 70,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 60, 60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 70, 50,0])cylinder(300, r=1.6,center=true,$fn=50);
        //top,left
        translate([-70, 50,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-60, 60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50, 70,0])cylinder(300, r=1.6,center=true,$fn=50);
        //bot,right
        translate([ 50,-70,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 60,-60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 70,-50,0])cylinder(300, r=1.6,center=true,$fn=50);
        //bot,left
        translate([-70,-50,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-60,-60,0])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50,-70,0])cylinder(300, r=1.6,center=true,$fn=50);
    }

    //yuan 2
    difference(){
        /*
        union(){
        //top 0, 1
        translate([-80, 80,25])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([ 80, 80,25])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([ 80,-80,25])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([-80,-80,25])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([-80, 80,25])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 5);
        translate([ 80, 80,25])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 5);
        translate([ 80,-80,25])rotate([0,0,90])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 5);
        translate([-80,-80,25])rotate([0,0,0])cubeintersectcylinderminuscylinder(40,VALUE_2, VALUE_1, 5);
        //mid
        translate([-80, 80, 5])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,VALUE_2-0.02, VALUE_0+0.02, 20);
        translate([ 80, 80, 5])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,VALUE_2-0.02, VALUE_0+0.02, 20);
        translate([ 80,-80, 5])rotate([0,0, 90])cubeintersectcylinderminuscylinder(40,VALUE_2-0.02, VALUE_0+0.02, 20);
        translate([-80,-80, 5])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40,VALUE_2-0.02, VALUE_0+0.02, 20);
        //bot
        translate([-80, 80, 0])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([ 80, 80, 0])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([ 80,-80, 0])rotate([0,0, 90])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        translate([-80,-80, 0])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 5);
        }
        */
        difference(){
        union(){
        translate([-80, 80, 0])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 30);
        translate([ 80, 80, 0])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 30);
        translate([ 80,-80, 0])rotate([0,0, 90])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 30);
        translate([-80,-80, 0])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40,60, VALUE_0, 30);
        }
        translate([ 47, 47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([-47, 47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([ 47,-47,0])cylinder(300, r=5,center=true,$fn=50);
        translate([-47,-47,0])cylinder(300, r=5,center=true,$fn=50);
        }
    }
/*
    //yuan 3
    difference(){
        union(){
        //
        translate([-80, 80,0])rotate([0,0,270])cubeintersectcylinderminuscylinder(40,60, VALUE_2, 5);
        translate([ 80, 80,0])rotate([0,0,180])cubeintersectcylinderminuscylinder(40,60, VALUE_2, 5);
        translate([ 80,-80,0])rotate([0,0, 90])cubeintersectcylinderminuscylinder(40,60, VALUE_2, 5);
        translate([-80,-80,0])rotate([0,0,  0])cubeintersectcylinderminuscylinder(40,60, VALUE_2, 5);
        }
        //corner hole
        translate([-50+5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5, 50-5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([-50+5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
        translate([ 50-5,-50+5,1])cylinder(300, r=1.6,center=true,$fn=50);
        //corner hole
        translate([-50+5, 50-5,5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5,5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5,5])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5,5])cylinder(3.01, r=4,center=true,$fn=50);
        //
        translate([-50+5, 50-5,0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5, 50-5,0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([-50+5,-50+5,0])cylinder(3.01, r=4,center=true,$fn=50);
        translate([ 50-5,-50+5,0])cylinder(3.01, r=4,center=true,$fn=50);
    }
*/
    //popup for corner
    translate([-40+5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([-40+5,-40+5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5,-40+5, 2])screwhelper(3, 1.6, 2);

    //-side hole
    translate([ 20, 70, 2])screwhelper(3, 1.6, 2);
    translate([  0, 70, 2])screwhelper(3, 1.6, 2);
    translate([-20, 70, 2])screwhelper(3, 1.6, 2);
    translate([ 20, 50, 2])screwhelper(3, 1.6, 2);
    translate([  0, 50, 2])screwhelper(3, 1.6, 2);
    translate([-20, 50, 2])screwhelper(3, 1.6, 2);
    translate([ 20,-50, 2])screwhelper(3, 1.6, 2);
    translate([  0,-50, 2])screwhelper(3, 1.6, 2);
    translate([-20,-50, 2])screwhelper(3, 1.6, 2);
    translate([ 20,-70, 2])screwhelper(3, 1.6, 2);
    translate([  0,-70, 2])screwhelper(3, 1.6, 2);
    translate([-20,-70, 2])screwhelper(3, 1.6, 2);

    //main
    difference(){
    union(){
    translate([0, 0, 1])cube([80, 160, 2],center=true);
    translate([0, 0, 1])cube([160, 80, 2],center=true);
    //+l298n
    translate([-27.5,  40-8, 3])cube([10, 16, 2],center=true);
    translate([ 27.5,  40-8, 3])cube([10, 16, 2],center=true);
    translate([-14.5, -40+8, 3])cube([10, 16, 2],center=true);
    translate([ 14.5, -40+8, 3])cube([10, 16, 2],center=true);
    }

    //screw hole
    translate([-35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([ 35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0,-35,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0, 35,0])cylinder(10, r=2.4,center=true,$fn=50);
    //corner hole
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);

    //
    translate([0, 0, 1.11])cube([66, 66, 1.8],center=true);
    //-l298n hole
    translate([-27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
/*
    //-l298n signal cable
    translate([0, 65/2-11/2,0])cube([48,11,10],center=true);
    //-l298n capacitor
    translate([0, 65/2-(14+24)/2,0])cube([26,10,13],center=true);
    //-l298n heat speater
    translate([0,-65/2+3+15/2,0])cube([54,16,10],center=true);
*/
    //battpack right
    translate([60-10,    30-1, 1])cube([16, 20, 10],center=true);
    translate([60+10,    30-1, 1])cube([16, 20, 10],center=true);
    translate([60-10,     0, 1.5])cube([10, 40, 1.01],center=true);
    translate([60+10,     0, 1.5])cube([10, 40, 1.01],center=true);
    translate([60-10,   -30+1, 1])cube([16, 20, 10],center=true);
    translate([60+10,   -30+1, 1])cube([16, 20, 10],center=true);
    //battpack left
    translate([-60-10,  30-1,  1])cube([16, 20, 10],center=true);
    translate([-60+10,  30-1,  1])cube([16, 20, 10],center=true);
    translate([-60-10,     0,1.5])cube([10, 40, 1.01],center=true);
    translate([-60+10,     0,1.5])cube([10, 40, 1.01],center=true);
    translate([-60-10, -30+1,  1])cube([16, 20, 10],center=true);
    translate([-60+10, -30+1,  1])cube([16, 20, 10],center=true);
    //cable far
    translate([-20, 70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([  0, 70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 20, 70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-20, 50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([  0, 50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 20, 50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    //cable near
    translate([-20, -50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([  0, -50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 20, -50,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-20, -70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([  0, -70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 20, -70,  1])cylinder(10, r=1.6,center=true,$fn=50);
    }
}

module football(){
translate([0,0,-110])sphere(d=220, $fn=100);
}





module xh254_3pin_left(){
    /*
    difference(){
    union(){
    translate([0, 0, 10-8/2])cube([14, 20, 8],center=true);
    translate([-0.5/2, 0, 0+2/2])cube([13.5, 20, 2],center=true);
    }
    //left
    translate([0,21/2-1/2, 10-7/2])cube([   6,1.01,7.01],center=true);
    //
    translate([0, 0, 10-2])cube([12.4, 20, 4.01],center=true);
    hull(){
    translate([0, 0, 6])cube([12.4, 19.8, 0.01],center=true);
    translate([0, 0, 1])cube([12.4, 18.6, 0.01],center=true);
    }
    //normal
    translate([0,-21/2+1/2, 10-7/2])cube([9,1.01,7.01],center=true);
    }
    */

    difference(){
    translate([0, -10+21/2, 14/2])cube([13, 21, 14],center=true);
    //-wire
    translate([1.2, 10, 1+13/2])cube([2, 2, 13.01],center=true);
    translate([1.2+2.75, 10, 1+13/2])cube([3.5, 1, 13.01],center=true);
    //-body
    translate([1.2, 0, 1+13/2])cube([9, 19, 13.01],center=true);
    //-door
    translate([1.2,-10, 1+13/2])cube([5.6, 2, 13.01],center=true);
    }
}
module xh254_3pin_right(){
    /*
    difference(){
    union(){
    translate([0, 0, 10-9/2])cube([14, 20, 9],center=true);
    }

    //right
    translate([ 0, 10-3/2, 5+2])cube([6,3.01,6.01],center=true);
    translate([ 0, 0, 5+1])cube([8.2,15,8.01],center=true);
    translate([ 0, 0-15/2+7/2, 5+1])cube([10.0,7.01,8.01],center=true);
    translate([ 0, 0-15/2-0.5, 5+1])cube([8.0,1,8.01],center=true);
    translate([ 0, -10+1.6/2, 5.4])cube([13, 1.6, 9.21],center=true);
    }
    */
    difference(){
    translate([0, 0, 12/2])cube([13, 20, 12],center=true);
    //-wire
    //translate([-2, 5, 12-10/2])cube([3.8, 20, 10.01],center=true);
    translate([-2-0.2, 5, 12-10/2])cube([5.6, 20, 10.01],center=true);
    //-head
    //translate([-2, -10+1+8/2, 12-10.5/2])cube([6.0, 8, 10.6],center=true);
    translate([-2, -10+1+7/2, 12-10.5/2])cube([6.0, 7, 10.6],center=true);
    //-door
    translate([-2,-10, 12-10/2])cube([5, 3, 10.01],center=true);
    }
}
module xh254_2pin(){
    
    //bot.down.2pin
    difference(){
    translate([0,5,-7/2])cube([10,10,7], center=true);
    //
    translate([0,15,-1-6/2])cube([6,20,6.01], center=true);
    translate([0, 5,-1-6/2])cube([7.6,7.2,6.01], center=true);
    translate([0, 0,-1-6/2])cube([6,10.01,6.01], center=true);
    }
}
module powerswitch3(){
    difference(){
    union(){
    translate([0,24/2,0])cube([15, 24, 22],center=true);
    //
    translate([0,-1,0])cube([18,6,10],center=true);
    //
    //translate([-20+11/2, 1, 0])cube([11,2,10],center=true);
    //translate([ 20-11/2, 1, 0])cube([11,2,10],center=true);
    }

    //-switch
    translate([0,23-40/2,0])cube([12.6,40,19],center=true);
    translate([0,23-7/2,0])cube([99,7,19],center=true);
    //-hole cube
    translate([0,1+6/2,0])cube([6,6.8,99],center=true);
    //-hole cylinder
    //translate([ 0, 20, 0])cylinder(99, r=1.6,center=true,$fn=50);
    //-place for xh254 left
    //translate([-7+0.5/2, 10, 11-2/2])cube([0.51, 20, 2],center=true);
    //-place for xh254 right
    //translate([ 7-0.5/2, 0+1.6/2, 11-2.4/2])cube([0.51, 1.61, 2.41],center=true);
    
    //outer
    translate([ 0, -1, 0])cube([15.4, 2, 22],center=true);
    }

}
module powerpcb(){
    //back
    difference(){
    translate([0, 30, 0])cube([40,20,36],center=true);
    
    translate([0, 40-4-4/2, 0])cube([32,4.01,99],center=true);
    translate([0, 40-8-4/2, 0])cube([30,4.01,99],center=true);
    translate([0, 40-14-4/2, 0])cube([32,8.01,99],center=true);
    //
    translate([0, 40-2+1+1/2, 0])cube([30,1.01,30],center=true);
    translate([0, 40-2, 0])cube([34,2,34],center=true);
    translate([0, 40-2-1-1/2, 0])cube([30,1.01,30],center=true);
    //
    //translate([0, 20+8/2, 0])cube([32,8.01,99],center=true);
    }
}
module powerraw_top(){
    translate([-20+13/2,10,4])xh254_3pin_left();
    translate([ 20-13/2,10,6])xh254_3pin_right();

    intersection(){
    translate([0, 0, 0])powerswitch3();
    translate([0, 0, 20])cube([99,99,40],center=true);
    }
/**/
    //side
    translate([-20+4/2, 10, 4/2])cube([4,20,4],center=true);
    translate([ 20-4/2, 10, 6/2])cube([4,20,6],center=true);

    //connect
    translate([-12, 5, -5])screwhelper(2.9, 1.6, 9);
    translate([ 12, 5, -5])screwhelper(2.9, 1.6, 11);

    //pcb
    intersection(){
    translate([0, 0, 0])powerpcb();
    translate([0, 0, 20])cube([99,99,40],center=true);
    }
}
module powerraw_bot(){
/**/
    //left
    translate([-12, 5, -5])screwhelper(4, 3.1, 5);
    translate([-12, 5, -10])screwhelper(4, 1.6, 5);
    //right
    translate([ 12, 5, -5])screwhelper(4, 3.1, 5);
    translate([ 12, 5, -10])screwhelper(4, 1.6, 5);

    //
    intersection(){
    translate([0, 0, 0])powerswitch3();
    translate([0, 0,-20])cube([99,99,40],center=true);
    }
    //
    translate([-20+13/2, 20/2, -10-1/2])cube([13,20,1],center=true);
    translate([ 20-13/2, 20/2, -10-1/2])cube([13,20,1],center=true);
    //
    translate([-11, 0,-11])xh254_2pin();
    translate([ 11, 0,-11])xh254_2pin();

    //side
    translate([-20+4/2, 10, -9])cube([4,20,18],center=true);
    translate([ 20-4/2, 10, -9])cube([4,20,18],center=true);

    //pcb
    intersection(){
    translate([0, 0, 0])powerpcb();
    translate([0, 0,-20])cube([99,99,40],center=true);
    }
}



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

//--------for preview--------
/*

//color("#7f0000")translate([-20,0,-20+4])notprint_rpizero();
//color("#7f0000")translate([ 20,0,-20+4])notprint_wavesharesensehat();
//translate([0,0,-20])bot_seperater_above();
//translate([0,0,-20])bot_seperater_below();
//translate([0,0,-20-4])rotate([0,180,0])notprint_l298n();
//color([0.5,0.5,0,0.5])bot_motorseat();
//translate([-60,0,-20])conn_bms();*/
//translate([60,0,-20])conn_xh254();
/*
cam_mount();
*/


//color([0.3,0.45,0.1,0.8])translate([ 0,0,80])mid_top();

//color([0.5,0,0.1,0.8])translate([ 0,0,40])mid_bot();

//color([0.0,0.2,0.9,0.8])translate([ 0,0,40])bot_top();

//color([0.5,0,0.5,0.8])translate([ 0,0,0])bot_bot();


/*
notprint_battery();
tmp_motorseat_all();
notprint_wheel();
*/




difference(){
powerraw_top();
translate([-20, 10,0])cylinder(99, r=3,center=true,$fn=50);
translate([ 20, 10,0])cylinder(99, r=3,center=true,$fn=50);
translate([-20,30,0])cylinder(99, r=3,center=true,$fn=50);
translate([ 20,30,0])cylinder(99, r=3,center=true,$fn=50);
}

difference(){
powerraw_bot();
translate([-20, 10,0])cylinder(99, r=3,center=true,$fn=50);
translate([ 20, 10,0])cylinder(99, r=3,center=true,$fn=50);
translate([-20,30,0])cylinder(99, r=3,center=true,$fn=50);
translate([ 20,30,0])cylinder(99, r=3,center=true,$fn=50);
}





//--------for print--------
//conn_motor();
/*
difference(){
    bot_motorseat();
    translate([100,0,0])cube([200,200,100],center=true);
}
*/
//bot_connector_triangle();
//translate([42,0,20])rotate([180,0,0])conn_xh254_upper();
//translate([0,0,20])conn_xh254_below();
//translate([42,0,20])rotate([180,0,0])conn_typec_above();
//translate([0,0,20])conn_typec_below();
//bot_top();
//translate([0,0,-40])bot_bot();
//tmp_motorseat_intersection();
/*
color([0.5,0,0.5,0.8])translate([ 0,0,0])bot_bot();
translate([ 0,0,-40])last_bot();
*/


//--------for test--------
//football();
//color([0.0,0,0.5,0.8])translate([ 0,0,-20])last_top();
//color([0.5,0,0.0,0.8])translate([ 0,0,-40])last_bot();