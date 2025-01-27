
module bezier(h){
linear_extrude(height=h)polygon([
    for(t=[0:0.1:1.0])    [20*t*t, 40*(1-t)*(1-t)],
    [0, 0]
    ]);
}

module screwhelper(rout, rin, height)
{
    difference(){
        translate([0,0,height/2])cylinder(height, r=rout,center=true,$fn=50);
        translate([0,0,height/2])cylinder(height+0.01, r=rin,center=true,$fn=50);
    }
}

module kuangkuang(sizex, sizey, sizez){
    difference(){
    translate([0,0,sizez/2])cube([sizex+2,sizey+2,sizez],center=true);
    translate([0,0,sizez/2])cube([sizex+0.01,sizey+0.01,sizez+0.01],center=true);
    translate([0,0,sizez/2])cube([sizex-6+0.01,sizey+2.01,sizez+0.01],center=true);
    translate([0,0,sizez/2])cube([sizex+2.01,sizey-6+0.01,sizez+0.01],center=true);
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
    translate([0,0, 8])cube([32,32,16.01], center=true);
    translate([0,0, 8])cube([60,20,16.01], center=true);
    }
}
module conn_xh254_below()
{
    difference(){
        union(){
        translate([-10, 20-4/2,-5/2])cube([10,4,5], center=true);
        translate([-10, 20,0])cylinder(10,r=3,center=true,$fn=50);
        translate([ 10, 20-4/2,-5/2])cube([10,4,5], center=true);
        translate([ 10, 20,0])cylinder(10,r=3,center=true,$fn=50);
        
        translate([-10,-20+4/2,-5/2])cube([10,4,5], center=true);
        translate([-10,-20,0])cylinder(10,r=3,center=true,$fn=50);
        translate([ 10,-20+4/2,-5/2])cube([10,4,5], center=true);
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
    translate([0,0,-8])cube([32,32,16.01], center=true);
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

module batterypack(){
    translate([ 0,29,0])cube([40,20,40],center=true);
    translate([-10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([-10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 0,-29,0])cube([40,20,40],center=true);
}
module notprint_battery(){
    translate([-80, 0,-25])batterypack();
    translate([ 80, 0,-25])batterypack();
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
    translate([-100,-100,-25])wheel();
    translate([ 100,-100,-25])wheel();
    translate([-100, 100,-25])wheel();
    translate([ 100, 100,-25])wheel();
}

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

module bot_top(){
    //popup for motorseat
    translate([-50, 70,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50, 70,-4])screwhelper(4.9, 1.6, 2);
    translate([-50, 50,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50, 50,-4])screwhelper(4.9, 1.6, 2);
    translate([-50,-50,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50,-50,-4])screwhelper(4.9, 1.6, 2);
    translate([-50,-70,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50,-70,-4])screwhelper(4.9, 1.6, 2);

    //popup for corner
    translate([-40+5, 40-5, -4])screwhelper(3, 1.6, 2);
    translate([ 40-5, 40-5, -4])screwhelper(3, 1.6, 2);
    translate([-40+5,-40+5, -4])screwhelper(3, 1.6, 2);
    translate([ 40-5,-40+5, -4])screwhelper(3, 1.6, 2);

    //-side hole
    translate([ 70, 20, -4])screwhelper(3, 1.6, 2);
    translate([ 70,  0, -4])screwhelper(3, 1.6, 2);
    translate([ 70,-20, -4])screwhelper(3, 1.6, 2);
    translate([ 50, 20, -4])screwhelper(3, 1.6, 2);
    translate([ 50,  0, -4])screwhelper(3, 1.6, 2);
    translate([ 50,-20, -4])screwhelper(3, 1.6, 2);
    translate([-50, 20, -4])screwhelper(3, 1.6, 2);
    translate([-50,  0, -4])screwhelper(3, 1.6, 2);
    translate([-50,-20, -4])screwhelper(3, 1.6, 2);
    translate([-70, 20, -4])screwhelper(3, 1.6, 2);
    translate([-70,  0, -4])screwhelper(3, 1.6, 2);
    translate([-70,-20, -4])screwhelper(3, 1.6, 2);

    //mid
    difference(){
        union(){
        translate([  0,  0, -1])cube([ 80, 80, 2],center=true);
        translate([  0, 60, -1])cube([120, 40, 2],center=true);
        translate([  0,-60, -1])cube([120, 40, 2],center=true);
        translate([-60,  0, -1])cube([ 40, 80, 2],center=true);
        translate([ 60,  0, -1])cube([ 40, 80, 2],center=true);
        }
        //battpack far
        translate([  30-2, 60-10,  -1])cube([20, 16, 10],center=true);
        translate([  30-2, 60+10,  -1])cube([20, 16, 10],center=true);
        translate([     0, 60-10,-1.5])cube([40, 10, 1.01],center=true);
        translate([     0, 60+10,-1.5])cube([40, 10, 1.01],center=true);
        translate([ -30+2, 60-10,  -1])cube([20, 16, 10],center=true);
        translate([ -30+2, 60+10,  -1])cube([20, 16, 10],center=true);
        //battpack near
        translate([  30-2,-60-10,  -1])cube([20, 16, 10],center=true);
        translate([  30-2,-60+10,  -1])cube([20, 16, 10],center=true);
        translate([     0,-60-10,-1.5])cube([40, 10, 1.01],center=true);
        translate([     0,-60+10,-1.5])cube([40, 10, 1.01],center=true);
        translate([ -30+2,-60-10,  -1])cube([20, 16, 10],center=true);
        translate([ -30+2,-60+10,  -1])cube([20, 16, 10],center=true);

        //corner hole
        translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
        translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);

        //
        translate([ 0, 40-5,1])cylinder(10, r=4,center=true,$fn=50);
        translate([ 0,-40+5,1])cylinder(10, r=4,center=true,$fn=50);
        //translate([-40+5, 0,1])cylinder(10, r=4,center=true,$fn=50);
        //translate([ 40-5, 0,1])cylinder(10, r=4,center=true,$fn=50);

        //-side hole
        translate([ 70, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 70,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 70,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 50, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 50,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([ 50,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-50, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-50,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-50,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-70, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-70,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
        translate([-70,-20,0])cylinder(100, r=2.4,center=true,$fn=50);

        //-hole for motorseat
        translate([-50, 70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50, 70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50, 50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50, 50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50,-50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50,-50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50,-70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50,-70,-1])cylinder(h=8,r=3,center=true,$fn=50);

        //-rpi 40pin
        translate([-20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        translate([-20-23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        //-sensehat 40pin
        translate([ 20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        translate([ 20-23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
        translate([ 20,65/2-11/2,-10-2])cube([11,11,40],center=true);
        //translate([ 20-30/2+3/2,65/2-16,-10-2])cube([3,11,40],center=true);
    }

    //corner
    translate([ 60, 40,-8.5])bezier(8.5);
    translate([ 60,-40,-8.5])mirror([0,1,0])bezier(8.5);
    translate([-60, 40,-8.5])mirror([1,0,0])bezier(8.5);
    translate([-60,-40,-8.5])rotate([0,0,180])bezier(8.5);
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

module battpack_holder_left()
{
    //battpack left
    difference(){
	translate([-75, 0, 25])cube([50,80+4,46],center=true);
        //batt body
	    translate([-75, 0, 25])cube([55,80,42],center=true);
        //hole y
        translate([-75, 0, 25])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        //hole z
        translate([-75+25/2, 25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-75+25/2,  0,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-75+25/2,-25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-75-25/2, 25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-75-25/2,  0,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-75-25/2,-25,0])cylinder(100, r=3,center=true,$fn=50);
    }
}
module battpack_holder_right()
{
    //battpack right
    difference(){
	translate([ 75, 0, 25])cube([50,80+4,46],center=true);
        //batt body
	    translate([ 75, 0, 25])cube([55,80,42],center=true);
        //hole y
        translate([ 75, 0, 25])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        //hole z
        translate([ 75+25/2, 25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 75+25/2,  0,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 75+25/2,-25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 75-25/2, 25,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 75-25/2,  0,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 75-25/2,-25,0])cylinder(100, r=3,center=true,$fn=50);
    }
}

module bot_bot(){
    //popup for motorseat
    translate([-50, 70,2])screwhelper(4.9, 1.6, 2);
    translate([ 50, 70,2])screwhelper(4.9, 1.6, 2);
    translate([-50, 50,2])screwhelper(4.9, 1.6, 2);
    translate([ 50, 50,2])screwhelper(4.9, 1.6, 2);
    translate([-50,-50,2])screwhelper(4.9, 1.6, 2);
    translate([ 50,-50,2])screwhelper(4.9, 1.6, 2);
    translate([-50,-70,2])screwhelper(4.9, 1.6, 2);
    translate([ 50,-70,2])screwhelper(4.9, 1.6, 2);

    //popup for corner
    translate([-40+5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([-40+5,-40+5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5,-40+5, 2])screwhelper(3, 1.6, 2);

    //-side hole
    translate([ 70, 20, 2])screwhelper(3, 1.6, 2);
    translate([ 70,  0, 2])screwhelper(3, 1.6, 2);
    translate([ 70,-20, 2])screwhelper(3, 1.6, 2);
    translate([ 50, 20, 2])screwhelper(3, 1.6, 2);
    translate([ 50,  0, 2])screwhelper(3, 1.6, 2);
    translate([ 50,-20, 2])screwhelper(3, 1.6, 2);
    translate([-50, 20, 2])screwhelper(3, 1.6, 2);
    translate([-50,  0, 2])screwhelper(3, 1.6, 2);
    translate([-50,-20, 2])screwhelper(3, 1.6, 2);
    translate([-70, 20, 2])screwhelper(3, 1.6, 2);
    translate([-70,  0, 2])screwhelper(3, 1.6, 2);
    translate([-70,-20, 2])screwhelper(3, 1.6, 2);

    difference(){
    union(){
    //+baseboard
    translate([0, 0, 1])cube([200, 150, 2],center=true);
    translate([0, 0, 1])cube([150, 200, 2],center=true);
    }

    //-heng
    translate([0, 75, 0.1])cube([200,0.2,0.2],center=true);
    translate([0, 50, 0.1])cube([200,0.2,0.2],center=true);
    translate([0, 25, 0.1])cube([200,0.2,0.2],center=true);
    translate([0,  0, 0.1])cube([200,0.2,0.2],center=true);
    translate([0,-25, 0.1])cube([200,0.2,0.2],center=true);
    translate([0,-50, 0.1])cube([200,0.2,0.2],center=true);
    translate([0,-75, 0.1])cube([200,0.2,0.2],center=true);
    //-shu
    translate([ 75,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([ 50,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([ 25,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([  0,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([-25,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([-50,0, 0.1])cube([0.2,200,0.2],center=true);
    translate([-75,0, 0.1])cube([0.2,200,0.2],center=true);

    //screw hole
    translate([-35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([ 35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0,-35,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0, 35,0])cylinder(10, r=2.4,center=true,$fn=50);

    //-holes for motorseat
    translate([-50, 70,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 50, 70,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-50, 50,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 50, 50,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-50,-50,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 50,-50,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-50,-70,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 50,-70,1])cylinder(h=8,r=3,center=true,$fn=50);

    //-l298n signal cable
    translate([0, 65/2-11/2,0])cube([48,11,10],center=true);
    //-l298n capacitor
    translate([0, 65/2-(14+24)/2,0])cube([26,10,13],center=true);
    //-l298n heat speater
    translate([0,-65/2+3+15/2,0])cube([54,16,10],center=true);
    //-l298n hole
    translate([-27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([-14.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 14.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([-27.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 27.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([-14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);

    //corner hole
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);

    //-side hole
    translate([ 70, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([ 70,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([ 70,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([ 50, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([ 50,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([ 50,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-50, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-50,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-50,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-70, 20,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-70,  0,0])cylinder(100, r=2.4,center=true,$fn=50);
    translate([-70,-20,0])cylinder(100, r=2.4,center=true,$fn=50);
    }

/*
    //corner
    translate([ 60, 40, 0])bezier(8.5);
    translate([ 60,-40, 0])mirror([0,1,0])bezier(8.5);
    translate([-60, 40, 0])mirror([1,0,0])bezier(8.5);
    translate([-60,-40, 0])rotate([0,0,180])bezier(8.5);
*/
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
//color([0.7,0.2,0.9,0.8])bot_top();
color("#7f0000")translate([-20,0,-20+4])notprint_rpizero();
color("#7f0000")translate([ 20,0,-20+4])notprint_wavesharesensehat();
translate([0,0,-20])bot_seperater_above();
//translate([0,0,-20])bot_seperater_below();
translate([0,0,-20-4])rotate([0,180,0])notprint_l298n();
color([0.5,0.5,0,0.5])bot_motorseat();
translate([60,0,-20])conn_xh254();
translate([-60,0,-20])conn_bms();
*/
translate([ 0,0,-50])battpack_holder_left();
//color([0.5,0,0.5,0.8])translate([ 0,0,-50])bot_bot();


//notprint_battery();
//notprint_wheel();



//--------for print--------
//rotate([-180,0,0])top_top();
//rotate([-90,0,0])cam_mount();
//rotate([0,-90,0])top_speaker_l();
//top_mic();
//top_support_one();
//top_bot();

//mid_kuang_left();
//mid_kuang_right();
//special_board_lowhalf();

//rotate([180,0,0])bot_top();
//notprint_l298n();
//translate([90,0,0])bot_seperater_above();
//rotate([180,0,0])bot_seperater_below();

//conn_motor();
/*
difference(){
    bot_motorseat();
    translate([100,0,0])cube([200,200,100],center=true);
}
*/
//translate([42,0,20])rotate([180,0,0])conn_xh254_upper();
//translate([0,0,20])conn_xh254_below();
//translate([42,0,20])rotate([180,0,0])conn_typec_above();
//translate([0,0,20])conn_typec_below();
//translate([0,0,-40])bot_bot();

//--------for test--------
//cam_mount();
//top_speaker();
//screwhelper();
//kuangkuang(20,30,10);

//translate([0,0,40])bot_top();
//translate([60,0,20])conn_xh254();
//translate([-60,0,20])conn_bms();
//bot_bot();
