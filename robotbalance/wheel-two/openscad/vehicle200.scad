
module bezier(h){
linear_extrude(height=h)polygon([
    for(t=[0:0.1:1.0])    [20*t*t, 40*(1-t)*(1-t)],
    [0, 0]
    ]);
}

module recthelper(rout, rin, height)
{
    difference(){
        translate([0,0,height/2])cube([rout,rout,height],center=true);
        translate([0,0,height/2])cylinder(height+0.01, r=rin,center=true,$fn=50);
    }
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

module batterypack(){
    translate([ 0,29,0])cube([40,20,40],center=true);
    translate([-10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0, 10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([-10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 10,0,-10])rotate([90,0,0])cylinder(65, r=9,center=true,$fn=50);
    translate([ 0,-29,0])cube([40,20,40],center=true);
}
module notprint_battery(){
    translate([-75, 0,-25])batterypack();
    translate([ 75, 0,-25])batterypack();
}


module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([-100,0,0])wheel();
    translate([ 100,0,0])wheel();
}

module bot_seperater_above()
{
    //zhu zi
difference(){
    translate([0,0, 2+21/2])cube([80,80,21],center=true);
    //
    translate([0,0, 2+16])cube([60,90,32],center=true);
    translate([0,0, 2+16])cube([90,60,32],center=true);
    //
    translate([0,0, 2+25/2])cube([76,64,25],center=true);
    translate([0,0, 2+25/2])cube([64,76,25],center=true);
    //corner
    translate([-40+5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(50, r=1.6,center=true,$fn=50);
    //corner
    translate([-40+5, 40-5,23-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,23-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,23-1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,23-1])cylinder(2.01, r=3.1,center=true,$fn=50);
}

    //+pizero hole
    translate([ 49/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([-49/2, 58/2, 2])screwhelper(4, 1.6, 2);
    translate([ 49/2,-58/2, 2])screwhelper(4, 1.6, 2);
    translate([-49/2,-58/2, 2])screwhelper(4, 1.6, 2);
difference(){
    union(){
    translate([0,0, 1])cube([80,80,2],center=true);
    }
    //hole @ 35
    translate([-40+5, 40-5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(2.01, r=3.1,center=true,$fn=50);
    //
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    //hole @ x,y
    translate([ 0, 40-5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 0,-40+5,1])cylinder(10, r=4,center=true,$fn=50);
    translate([-40+5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    translate([ 40-5, 0,1])cylinder(10, r=4,center=true,$fn=50);
    //-pi3 hole
    translate([-24.5, 58/2, 1])cylinder(99, r=2.6,center=true,$fn=50);
    translate([ 24.5, 58/2, 1])cylinder(99, r=2.6,center=true,$fn=50);
    translate([-24.5,-58/2, 1])cylinder(99, r=2.6,center=true,$fn=50);
    translate([ 24.5,-58/2, 1])cylinder(99, r=2.6,center=true,$fn=50);
    /*
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
    */
    //-l298n hole
    translate([-27.5, 65/2-5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-14.5, 65/2-5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 14.5, 65/2-5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-27.5,-65/2+5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 27.5,-65/2+5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-14.5,-65/2+5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 14.5,-65/2+5.3, 1])cylinder(2.01, r=3,center=true,$fn=50);
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

module battpack_test(){
    difference(){
    union(){
    translate([0, 0, 5/2])cube([50, 100, 5],center=true);
    translate([0, 0, 25/2])cube([50, 84, 25],center=true);
    }
    //1865
    translate([0, 0, 25])cube([40.4, 80.4, 40.4],center=true);
    //4680
    translate([0, 0, 25])rotate([90,0,0])cylinder(80, r=46.8/2,center=true,$fn=50);
    //batt hole z
    translate([0, 0, 25])cube([40, 40, 49.6],center=true);
    //batt hole y
    translate([0, 0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    //batt hole x
    for(y=[-50:12.5:50]){
        //left
        translate([0, y, 25/2])rotate([0,90,0])cylinder(46, r=3,center=true,$fn=50);
        translate([0, y, 25/2])rotate([0,90,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
    //wire tunnel left
    for(y=[-40:40:40]){
    translate([ 25, y, 25])cube([10, 10, 10],center=true);
    translate([-25, y, 25])cube([10, 10, 10],center=true);
    }
    //wire tunnel right
    for(y=[-40:40:40]){
    translate([ 25, y, 25])cube([10, 10, 10],center=true);
    translate([-25, y, 25])cube([10, 10, 10],center=true);
    }

    //-left right hole
    for(y=[-37.5:12.5:37.5]){
    for(x=[-12.5:12.5:12.5]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([x,y,2+8/2])cylinder(8, r=3,center=true,$fn=50);
    }
    }

    //special hole
    translate([25-5,-50+5,0])cylinder(1000, r=1.6,center=true,$fn=50);

    }//difference
}
module battpack_oneside(){
    battpack_test();
    translate([0,0,50])mirror([0,0,1])battpack_test();
}

motorwidth = 23;
thatsize = (40-motorwidth)/2;

module motorseat(){
    difference(){
    translate([0, 12.5, 4/2])cube([motorwidth,25,4],center=true);

    //shaft hole
    translate([0,0,0])cylinder(99, r=4,center=true,$fn=50);

    //fixer hole
    translate([0, 0+11.5,0])cylinder(99, r=2.2,center=true,$fn=50);

    //screw hole
    translate([-8.6, 0+21,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 8.6, 0+21,0])cylinder(99, r=1.6,center=true,$fn=50);

    translate([-8.6, 0+21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 8.6, 0+21,2/2])cylinder(2.01, r=3,center=true,$fn=50);
    }
}

module bot_motorseat_helper()
{
    difference(){
    cube([25,25,thatsize],center=true);

    translate([0, 0, thatsize/2-3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    translate([0, 0, 0])cylinder(h=17,r=1.6,center=true,$fn=50);
    translate([0, 0,-thatsize/2+3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    }
}
module bot_motorseat_leftnear(){
    translate([-75+12.5, -75+12.5, -5-thatsize/2])bot_motorseat_helper();
    translate([-75+12.5, -75-12.5, -5-thatsize/2])bot_motorseat_helper();

    translate([-50-10,-100,-25])rotate([0,-90,0])motorseat();

    translate([-75+12.5, -75+12.5, -45+2+thatsize/2])bot_motorseat_helper();
    translate([-75+12.5, -75-12.5, -45+2+thatsize/2])bot_motorseat_helper();
}
module bot_motorseat(){
    bot_motorseat_leftnear();
}
sizeofmotor = 22.4;
module bot_battery(){
    //left,right
    difference(){
        union(){
        translate([-40-2/2,  20-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([-40-2/2,  10-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([-40-2/2,   0-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([-40-2/2, -20+10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([ 40+2/2,  20-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([ 40+2/2,  10-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([ 40+2/2,   0-10/2, 20+10/2])cube([2, 9, 10],center=true);
        translate([ 40+2/2, -20+10/2, 20+10/2])cube([2, 9, 10],center=true);
        }
        translate([0, 20-5, 20+5])rotate([0,90,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([0, 10-5, 20+5])rotate([0,90,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([0,  0-5, 20+5])rotate([0,90,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([0,-20+5, 20+5])rotate([0,90,0])cylinder(h=100,r=1.5,center=true,$fn=50);
    }
    //near,far
    difference(){
        union(){
        translate([ 40-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 30-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 20-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 10-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([  0-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-10-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-20-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-30-10/2, -20- 2/2, 20+10/2])cube([9, 2, 10],center=true);
        //
        translate([ 40-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 30-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 20-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([ 10-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([  0-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-10-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-20-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        translate([-30-10/2,  20+ 2/2, 20+10/2])cube([9, 2, 10],center=true);
        }
        translate([-40+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([-30+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([-20+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([-10+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([  0+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([ 10+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([ 20+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
        translate([ 30+5, 0, 20+5])rotate([90,0,0])cylinder(h=100,r=1.5,center=true,$fn=50);
    }
/*
    translate([-15, -20-2.5/2, 20+5/2])cube([20, 2.5, 5],center=true);
    translate([ 15, -20-2.5/2, 20+5/2])cube([20, 2.5, 5],center=true);

    translate([-40-2.5/2, 0, 20+5/2])cube([2.5, 10, 5],center=true);
    translate([ 40+2.5/2, 0, 20+5/2])cube([2.5, 10, 5],center=true);
*/
    //battery
    difference(){
        union(){
        translate([0, 20,-20])rotate([0,90,0])cylinder(h=80,r=2.5,center=true,$fn=50);
        translate([0,  0,-20])rotate([0,90,0])cylinder(h=80,r=2.5,center=true,$fn=50);
        translate([0,-20,-20])rotate([0,90,0])cylinder(h=80,r=2.5,center=true,$fn=50);
        }
        translate([0, 0,-20-10/2])cube([100, 50, 10],center=true);
    }
    difference(){
    translate([0, 0, 0])cube([85, 45, 40],center=true);
    translate([0, 0,25])cube([80, 40, 40],center=true);
    translate([0, 0, 0])cube([80, 40, 40],center=true);
    translate([  0, 0, 0])rotate([  0,90,0])cylinder(h=100,r=10,center=true,$fn=50);
    //
    translate([ 30, 0, 0])rotate([-90, 0,0])cylinder(h=100,r=10,center=true,$fn=50);
    translate([  0, 0, 0])rotate([ 90, 0,0])cylinder(h=100,r=10,center=true,$fn=50);
    translate([-30, 0, 0])rotate([-90, 0,0])cylinder(h=100,r=10,center=true,$fn=50);
    }

}
module bot_motorseat_connector(){
    bot_battery();

    //left motor
    translate([-60, 0,0])rotate([90,0,-90])motorseat();
    hull(){
        translate([-40-2.5,-20+(20-sizeofmotor/2)/2, 0])cube([0.001,20-sizeofmotor/2,40],center=true);
        translate([-70,-sizeofmotor/2, 0])cube([0.001,0.001,40],center=true);
    }
    hull(){
        translate([-40-2.5, 20-(20-sizeofmotor/2)/2, 0])cube([0.001,20-sizeofmotor/2,40],center=true);
        translate([-70, sizeofmotor/2, 0])cube([0.001,0.001,40],center=true);
    }

    //right motor
    translate([ 60, 0,0])rotate([90,0, 90])motorseat();
    hull(){
        translate([ 40+2.5,-20+(20-sizeofmotor/2)/2, 0])cube([0.001,20-sizeofmotor/2,40],center=true);
        translate([ 70,-sizeofmotor/2, 0])cube([0.001,0.001,40],center=true);
    }
    hull(){
        translate([ 40+2.5, 20-(20-sizeofmotor/2)/2, 0])cube([0.001,20-sizeofmotor/2,40],center=true);
        translate([ 70, sizeofmotor/2, 0])cube([0.001,0.001,40],center=true);
    }
}
module bot_motorseat_stepper(){
    bot_battery();

    //left
    difference(){
    translate([-65+2.5/2, 0, 0])cube([42.5, 45, 40],center=true);
    translate([-65+2.5/2, 0,0])cube([37.5, 42, 1000],center=true);
    //translate([-50, 0,  0])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    //translate([-60, 0, 10])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    translate([-60, 0,  0])rotate([90, 0, 0])cylinder(h=100,r=10,center=true,$fn=50);
    //translate([-60, 0,-10])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    //translate([-70,  0, 0])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);

    translate([-90,  22.5,  0])rotate([90, 0, 0])cylinder(h=3,r=10,center=true,$fn=50);
    translate([-90, -22.5,  0])rotate([90, 0, 0])cylinder(h=3,r=10,center=true,$fn=50);

    translate([-80, 31/2, 31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([-80,-31/2, 31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([-80, 31/2,-31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([-80,-31/2,-31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([-80, 0, 0])rotate([0, 90, 0])cylinder(h=20,r=23/2,center=true,$fn=50);
    translate([-80, 0, -20])cube([20, 23, 42],center=true);

    translate([-45+2.5/2, 0, 0])cube([2.6, 20, 100],center=true);
    }
    //right
    difference(){
    translate([ 65-2.5/2, 0, 0])cube([42.5, 45, 40],center=true);
    translate([ 65-2.5/2, 0,0])cube([37.5, 42, 1000],center=true);
    //translate([ 50, 0, 0])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    //translate([ 60, 0, 10])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    translate([ 60, 0,  0])rotate([90, 0, 0])cylinder(h=100,r=10,center=true,$fn=50);
    //translate([ 60, 0,-10])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);
    //translate([ 70, 0, 0])rotate([90, 0, 0])cylinder(h=100,r=1.5,center=true,$fn=50);

    translate([ 90,  22.5,  0])rotate([90, 0, 0])cylinder(h=3,r=10,center=true,$fn=50);
    translate([ 90, -22.5,  0])rotate([90, 0, 0])cylinder(h=3,r=10,center=true,$fn=50);

    translate([80, 31/2, 31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([80,-31/2, 31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([80, 31/2,-31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([80,-31/2,-31/2])rotate([0, 90, 0])cylinder(h=20,r=1.5,center=true,$fn=50);
    translate([80, 0, 0])rotate([0, 90, 0])cylinder(h=20,r=23/2,center=true,$fn=50);
    translate([80, 0, -20])cube([20, 23, 42],center=true);

    translate([ 45-2.5/2, 0, 0])cube([2.6, 20, 100],center=true);
    }
}
module bot_motorseat_connector1(){
/*
    //top
    translate([ 75-12.5, -62.5, -2-10])screwhelper(4, 1.6, 10);
    translate([ 50-12.5, -62.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-50+12.5, -62.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, -62.5, -2-10])screwhelper(4, 1.6, 10);
    //bot
    translate([ 75-12.5, -62.5, -50+2])screwhelper(4, 1.6, 10);
    translate([ 50-12.5, -62.5, -50+2])screwhelper(4, 1.6, 2);
    translate([-50+12.5, -62.5, -50+2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, -62.5, -50+2])screwhelper(4, 1.6, 10);
*/
    difference(){
    union(){
    //top
    translate([0, -62.5, -1])cube([52,25,2],center=true);
    //mid
    translate([0, -50-2/2, -25])cube([100,2,36],center=true);
    translate([0, -50-2/2, -25])cube([80,2,42],center=true);
    translate([0, -50-2/2, -25])cube([66,2,46],center=true);
    //side 100 leftright
    //translate([-100+10/2, -50-2/2, -25])cube([10,2,50],center=true);
    //translate([ 100-10/2, -50-2/2, -25])cube([10,2,50],center=true);
    //side 50 leftright
    //translate([-50-10/2, -50-2/2, -25])cube([10,2,50],center=true);
    //translate([ 50+10/2, -50-2/2, -25])cube([10,2,50],center=true);
    //bot
    translate([0, -62.5, -50+1])cube([52,25,2],center=true);
    //top-left
    hull(){
        translate([-54/2,-75,-1])cube([2,50,2],center=true);
        translate([-75+15/2,-75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    //top-right
    hull(){
        translate([ 54/2,-75,-1])cube([2,50,2],center=true);
        translate([ 75-15/2,-75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    translate([-50-10,-100,-25])rotate([0,-90,0])motorseat();
    translate([ 50+10,-100,-25])rotate([0, 90,0])motorseat();
    //bot-left
    hull(){
        translate([-75+15/2,-75,-25-sizeofmotor/2])cube([15,50,0.01],center=true);
        translate([-54/2,-75,-50+1])cube([2,50,2],center=true);
    }
    //bot-right
    hull(){
        translate([ 75-15/2,-75,-25-sizeofmotor/2])cube([15,50,0.01],center=true);
        translate([ 54/2,-75,-50+1])cube([2,50,2],center=true);
    }

    }//union

    //-board
    translate([0, -87.5, -5])cube([100,25,10],center=true);
    translate([0, -87.5, -50+5])cube([100,25,10],center=true);
/*
    translate([-50+2/2, -62.5, -12.5])cube([3,5,5],center=true);
    translate([-50+2/2, -62.5, -25])cube([3,5,5],center=true);
    translate([-50+2/2, -62.5, -25-12.5])cube([3,5,5],center=true);
    translate([ 50-2/2, -62.5, -12.5])cube([3,5,5],center=true);
    translate([ 50-2/2, -62.5, -25])cube([3,5,5],center=true);
    translate([ 50-2/2, -62.5, -25-12.5])cube([3,5,5],center=true);
*/

    //-rpi eth/usb
    translate([0, -50, -25])cube([56,5,46],center=true);

    //-wheel
    translate([-87.5, -87.5, -1])cube([25,25,99],center=true);
    translate([ 87.5, -87.5, -1])cube([25,25,99],center=true);
    /*
    translate([-100, -87.5, -1])cube([36,40,99],center=true);
    translate([ 100, -87.5, -1])cube([36,40,99],center=true);
*/
    //-hole z
    translate([ 75+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([ 50+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([ 25+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([  0+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([-25+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([-50+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([-75+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    translate([-100+12.5, -50-12.5, 0])cylinder(h=999,r=1.6,center=true,$fn=50);
    //right,top
    translate([ 25+12.5, -50-12.5, -4/2])cylinder(h=4,r=5,center=true,$fn=50);
    translate([ 50+12.5, -50-12.5, -12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    translate([ 50+12.5, -75-12.5, -12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    //right,bot
    translate([ 25+12.5, -50-12.5, -50+4/2])cylinder(h=4,r=5,center=true,$fn=50);
    translate([ 50+12.5, -50-12.5, -50+12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    translate([ 50+12.5, -75-12.5, -50+12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    //left,top
    translate([-50+12.5, -50-12.5, -4/2])cylinder(h=4,r=5,center=true,$fn=50);
    translate([-75+12.5, -50-12.5, -12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    translate([-75+12.5, -75-12.5, -12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    //left,bot
    translate([-50+12.5, -50-12.5, -50+4/2])cylinder(h=4,r=5,center=true,$fn=50);
    translate([-75+12.5, -50-12.5, -50+12/2])cylinder(h=12,r=3.2,center=true,$fn=50);
    translate([-75+12.5, -75-12.5, -50+12/2])cylinder(h=12,r=3.2,center=true,$fn=50);

    //-hole y
    translate([ 50-12.5, -50, -12.5])rotate([90,0,0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-50+12.5, -50, -12.5])rotate([90,0,0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([ 50-12.5, -50, -25-12.5])rotate([90,0,0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-50+12.5, -50, -25-12.5])rotate([90,0,0])cylinder(h=99,r=1.6,center=true,$fn=50);

    //-stepper
    translate([-30-10/2, -50, -25])cube([10,10,16.8],center=true);
    translate([ 30+10/2, -50, -25])cube([10,10,16.8],center=true);
    }
}

module outer_top(){
    //left,near
    translate([-50+12.5, -50-12.5, -2-2])screwhelper(4.8, 1.6, 2);
    translate([-75+12.5, -50-12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, -75-12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, -50-12.5, -2-10])screwhelper(3, 1.6, 10);
    translate([-75+12.5, -75-12.5, -2-10])screwhelper(3, 1.6, 10);
    //right,near
    translate([ 50-12.5, -50-12.5, -2-2])screwhelper(4.8, 1.6, 2);
    translate([ 75-12.5, -50-12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([ 75-12.5, -75-12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([ 75-12.5, -50-12.5, -2-10])screwhelper(3, 1.6, 10);
    translate([ 75-12.5, -75-12.5, -2-10])screwhelper(3, 1.6, 10);
    //left,far
    translate([-50+12.5, 50+12.5, -2-2])screwhelper(4.8, 1.6, 2);
    translate([-75+12.5, 50+12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, 75+12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([-75+12.5, 50+12.5, -2-10])screwhelper(3, 1.6, 10);
    translate([-75+12.5, 75+12.5, -2-10])screwhelper(3, 1.6, 10);
    //right,far
    translate([ 50-12.5, 50+12.5, -2-2])screwhelper(4.8, 1.6, 2);
    translate([ 75-12.5, 50+12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([ 75-12.5, 75+12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([ 75-12.5, 50+12.5, -2-10])screwhelper(3, 1.6, 10);
    translate([ 75-12.5, 75+12.5, -2-10])screwhelper(3, 1.6, 10);
    //37.5,37.5
    translate([-50+12.5, 50-12.5, -5])screwhelper(5, 1.6, 3);
    translate([-50+12.5, 50-12.5, -10])screwhelper(4, 1.6, 5);
    translate([-50+12.5, 50-12.5, -15])screwhelper(2.9, 1.6, 5);
    translate([ 50-12.5, 50-12.5, -5])screwhelper(5, 1.6, 3);
    translate([ 50-12.5, 50-12.5, -10])screwhelper(4, 1.6, 5);
    translate([ 50-12.5, 50-12.5, -15])screwhelper(2.9, 1.6, 5);
    translate([-50+12.5,-50+12.5, -5])screwhelper(5, 1.6, 3);
    translate([-50+12.5,-50+12.5, -10])screwhelper(4, 1.6, 5);
    translate([-50+12.5,-50+12.5, -15])screwhelper(2.9, 1.6, 5);
    translate([ 50-12.5,-50+12.5, -5])screwhelper(5, 1.6, 3);
    translate([ 50-12.5,-50+12.5, -10])screwhelper(4, 1.6, 5);
    translate([ 50-12.5,-50+12.5, -15])screwhelper(2.9, 1.6, 5);
    //37.5, 0
    translate([-50+12.5, 0, -2-2])screwhelper(4, 1.6, 2);
    translate([ 50-12.5, 0, -2-2])screwhelper(4, 1.6, 2);
    //0, 37.5
    translate([ 0, 50-12.5, -2-2])screwhelper(4, 1.6, 2);
    translate([ 0,-50+12.5, -2-2])screwhelper(4, 1.6, 2);

    difference(){
    union(){
    translate([0, 0, -1])cube([150, 200, 2],center=true);
    translate([0, 0, -1])cube([200, 150, 2],center=true);
    //batt
    translate([ 75, 0, -15/2])cube([50, 100, 15],center=true);
    translate([-75, 0, -15/2])cube([50, 100, 15],center=true);
    //wall-batt
    translate([-50+1, 0, -10/2])cube([2, 100, 10],center=true);
    translate([ 50-1, 0, -10/2])cube([2, 100, 10],center=true);
    //wall-motor
    translate([ 0, 50-1, -10/2])cube([100, 2, 10],center=true);
    translate([ 0,-50+1, -10/2])cube([100, 2, 10],center=true);
    for(y=[-37.5:25:37.5]){
        translate([ 50-1, y,-12.5])cube([2, 12.5, 5],center=true);
        translate([-50+1, y,-12.5])cube([2, 12.5, 5],center=true);
    }
    }

    //batt left
    translate([-50-2.5, 42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-50-2.5, 42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-100+2.5, 42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-100+2.5, 42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-50-2.5,-42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-50-2.5,-42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-100+2.5,-42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-100+2.5,-42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-75, 0, 0])cube([30, 70, 99],center=true);
    translate([-75, 0, -5-15/2])cube([40, 80, 15.01],center=true);
    translate([-75, 0, -2-13/2])cube([20, 100, 15.01-2],center=true);
    //batt left
    translate([-75, 50-5/2, -2-13/2])cube([40, 5, 15.01-2],center=true);
    translate([-75, 0, -2-13/2])cube([50, 60, 15.01-2],center=true);
    translate([-75,-50+5/2, -2-13/2])cube([40, 5, 15.01-2],center=true);
    //batt right
    translate([50+2.5, 42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([50+2.5, 42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([100-2.5, 42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([100-2.5, 42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([50+2.5,-42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([50+2.5,-42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([100-2.5,-42.5, -1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([100-2.5,-42.5, 2])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 75, 0, 0])cube([30, 70, 99],center=true);
    translate([ 75, 0, -5-15/2])cube([40, 80, 15.01],center=true);
    translate([ 75, 0, -2-13/2])cube([20, 100, 15.01-2],center=true);
    //batt right
    translate([ 75, 50-5/2, -2-13/2])cube([40, 5, 15.01-2],center=true);
    translate([ 75, 0, -2-13/2])cube([50, 60, 15.01-2],center=true);
    translate([ 75,-50+5/2, -2-13/2])cube([40, 5, 15.01-2],center=true);

    //wall-motor
    translate([ 0, 50-1, -2-8/2])cube([75, 2, 8],center=true);
    translate([ 0,-50+1, -2-8/2])cube([75, 2, 8],center=true);

    //center
    translate([0, 0, -1])cube([75, 50, 99],center=true);
    //nearfar
    translate([ 0, 75, 0])cube([56, 50, 99],center=true);
    translate([ 0,-75, 0])cube([56, 50, 99],center=true);
    //hole @ leftright
    translate([ 37.5, 0, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-37.5, 0, 2])cylinder(11.01, r=3,center=true,$fn=50);
    //hole @ nearfar
    translate([ 0, 37.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([ 0,-37.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    /*
    //hole @ 45
    translate([-50+5, 50-5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-5, 50-5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([-50+5, -50+5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-5, -50+5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    //hole @ 40
    translate([-50+10, 50-10, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-10, 50-10, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([-50+10, -50+10, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-10, -50+10, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    */
    //hole @ 37.5
    translate([-50+12.5, 50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([ 50-12.5, 50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-50+12.5,-50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([ 50-12.5,-50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    /*
    //hole @ 35
    translate([-50+15, 50-15, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-15, 50-15, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([-50+15, -50+15, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50-15, -50+15, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    */
    //hole @ far
    translate([ 75+12.5, 50+12.5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50+12.5, 50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([ 25+12.5, 50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-50+12.5, 50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-75+12.5, 50+12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-100+12.5, 50+12.5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    //hole @ near
    translate([ 75+12.5, -50-12.5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    translate([ 50+12.5, -50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([ 25+12.5, -50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-50+12.5, -50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-75+12.5, -50-12.5, 2])cylinder(11.01, r=3,center=true,$fn=50);
    translate([-100+12.5, -50-12.5, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    //far-left
    hull(){
        translate([-54/2, 75,-1])cube([2,50,2],center=true);
        translate([-75+15/2, 75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    //far-right
    hull(){
        translate([ 54/2, 75,-1])cube([2,50,2],center=true);
        translate([ 75-15/2, 75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    //near-left
    hull(){
        translate([-54/2,-75,-1])cube([2,50,2],center=true);
        translate([-75+15/2,-75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    //near-right
    hull(){
        translate([ 54/2,-75,-1])cube([2,50,2],center=true);
        translate([ 75-15/2,-75,-25+sizeofmotor/2])cube([15,50,0.01],center=true);
    }
    //less print
    translate([-50, 75, -1])cylinder(99, r=12.5,center=true,$fn=50);
    translate([ 50, 75, -1])cylinder(99, r=12.5,center=true,$fn=50);
    translate([-50,-75, -1])cylinder(99, r=12.5,center=true,$fn=50);
    translate([ 50,-75, -1])cylinder(99, r=12.5,center=true,$fn=50);
    }
}

module outer_bot(){
    difference(){
    translate([0, 0, 1])cube([200, 200, 2],center=true);
    //batt
    translate([-75, 0, 0])cube([50, 100, 99],center=true);
    translate([ 75, 0, 0])cube([50, 100, 99],center=true);
    }
}

module inner_top(){
    /*
    //popup for motorseat
    translate([-50-12.5, 75+12.5,2])screwhelper(4.9, 1.6, 2);
    translate([ 50+12.5, 75+12.5,2])screwhelper(4.9, 1.6, 2);
    translate([-50-12.5, 75-12.5,2])screwhelper(4.9, 1.6, 2);
    translate([ 50+12.5, 75-12.5,2])screwhelper(4.9, 1.6, 2);
    translate([-50-12.5,-75+12.5,2])screwhelper(4.9, 1.6, 2);
    translate([ 50+12.5,-75+12.5,2])screwhelper(4.9, 1.6, 2);
    translate([-50-12.5,-75-12.5,2])screwhelper(4.9, 1.6, 2);
    translate([ 50+12.5,-75-12.5,2])screwhelper(4.9, 1.6, 2);

    //popup for corner
    translate([-40+5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5, 40-5, 2])screwhelper(3, 1.6, 2);
    translate([-40+5,-40+5, 2])screwhelper(3, 1.6, 2);
    translate([ 40-5,-40+5, 2])screwhelper(3, 1.6, 2);
*/
    //
    translate([ 50-12.5, 50-12.5, 10])screwhelper(4, 3.2, 5);
    translate([ 50-12.5, 50-12.5, 5])screwhelper(4, 1.6, 5);
    translate([ 50-12.5, 50-12.5, 2])screwhelper(5, 1.6, 3);
    translate([-50+12.5, 50-12.5, 10])screwhelper(4, 3.2, 5);
    translate([-50+12.5, 50-12.5, 5])screwhelper(4, 1.6, 5);
    translate([-50+12.5, 50-12.5, 2])screwhelper(5, 1.6, 3);
    translate([ 50-12.5,-50+12.5, 10])screwhelper(4, 3.2, 5);
    translate([ 50-12.5,-50+12.5, 5])screwhelper(4, 1.6, 5);
    translate([ 50-12.5,-50+12.5, 2])screwhelper(5, 1.6, 3);
    translate([-50+12.5,-50+12.5, 10])screwhelper(4, 3.2, 5);
    translate([-50+12.5,-50+12.5, 5])screwhelper(4, 1.6, 5);
    translate([-50+12.5,-50+12.5, 2])screwhelper(5, 1.6, 3);

    //rpi
    //40+29
    translate([ 24.5,    40+29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23, 40+29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23, 40+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23, 40+29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23, 40+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,    40+29, 2])screwhelper(4, 1.6, 2);
    //40-29
    translate([ 24.5,    40-29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23, 40-29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23, 40-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23, 40-29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23, 40-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,    40-29, 2])screwhelper(4, 1.6, 2);

    //40+29
    translate([ 24.5,    -40+29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23, -40+29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23, -40+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23, -40+29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23, -40+29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,    -40+29, 2])screwhelper(4, 1.6, 2);
    //40-29
    translate([ 24.5,    -40-29, 2])screwhelper(4, 1.6, 2);
    difference(){
    translate([ 24.5-23, -40-29, 2])screwhelper(4, 1.6, 2);
    translate([-24.5+23, -40-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-24.5+23, -40-29, 2])screwhelper(4, 1.6, 2);
    translate([ 24.5-23, -40-29, 2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-24.5,    -40-29, 2])screwhelper(4, 1.6, 2);

/*
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
*/
    difference(){
    union(){
    translate([0, 0, 1])cube([100, 100, 2],center=true);
    //
    translate([0, 0, 1])cube([56, 150, 2],center=true);
    //wall-batt
    translate([-50+1, 0, 15/2])cube([2, 100, 15],center=true);
    translate([ 50-1, 0, 15/2])cube([2, 100, 15],center=true);
    //wall-motor
    translate([ 0, 50-1, 15/2])cube([100, 2, 15],center=true);
    translate([ 0,-50+1, 15/2])cube([100, 2, 15],center=true);
    }

    //center
    translate([0, -40, 1.11])cube([40, 40, 1.8],center=true);
    translate([0,  0, 1.11])cube([60, 10, 1.8],center=true);
    translate([0,  40, 1.11])cube([40, 40, 1.8],center=true);

    //l298n signal
    translate([ 37.5, 25, 1.11])cube([10, 10, 1.8],center=true);
    translate([-37.5, 25, 1.11])cube([10, 10, 1.8],center=true);
    translate([ 37.5,-25, 1.11])cube([10, 10, 1.8],center=true);
    translate([-37.5,-25, 1.11])cube([10, 10, 1.8],center=true);

    //batt wire tunnel left
    for(y=[-40:40:40]){
    translate([ 50, y, 0])cube([10, 10, 10],center=true);
    translate([-50, y, 0])cube([10, 10, 10],center=true);
    }
    //batt wall x
    for(y=[-37.5:25:37.5]){
        translate([ 50, y,12.5])cube([10, 12.5, 5],center=true);
        translate([-50, y,12.5])cube([10, 12.5, 5],center=true);
    }
    //batt hole x
    for(y=[-37.5:12.5:37.5]){
        translate([0, y, 25/2])rotate([0,90,0])cylinder(999, r=1.6,center=true,$fn=50);
    }

    //-holes for motorseat
    translate([-75+12.5, 75+12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 75-12.5, 75+12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-75+12.5, 75-12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 75-12.5, 75-12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-75+12.5,-75+12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 75-12.5,-75+12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([-75+12.5,-75-12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
    translate([ 75-12.5,-75-12.5,1])cylinder(h=8,r=3,center=true,$fn=50);
/*
    //corner hole @ 45
    translate([-50+5, 50-5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5, 50-5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-50+5,-50+5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5,-50+5,1])cylinder(99, r=1.6,center=true,$fn=50);

    //corner hole @ 40
    translate([-40, 40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40, 40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40,-40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40,-40,1])cylinder(10, r=1.6,center=true,$fn=50);
*/
    //corner hole @ 37.5
    translate([-37.5, 37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([ 37.5, 37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([-37.5,-37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([ 37.5,-37.5,1])cylinder(10, r=3,center=true,$fn=50);
/*
    //corner hole @ 35
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
*/
/*
    //xy hole @ 35
    translate([-35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([ 35,0,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0,-35,0])cylinder(10, r=2.4,center=true,$fn=50);
    translate([0, 35,0])cylinder(10, r=2.4,center=true,$fn=50);
*/
    //-pi3 hole
    translate([-24.5, 40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5, 40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5, 40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5, 40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5, -40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5, -40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5, -40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5, -40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);

    //-pi0 hole
    translate([-24.5+23, 40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5-23, 40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5+23, 40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5-23, 40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5+23, -40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5-23, -40+58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([-24.5+23, -40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);
    translate([ 24.5-23, -40-58/2, 1])cylinder(99, r=2.5,center=true,$fn=50);

    //-pi rj45/usb
    translate([0, 50, 2+23/2])cube([56, 10, 23],center=true);
    translate([0,-50, 2+23/2])cube([56, 10, 23],center=true);
/*
    //-near far hole
    for(x=[-37.5:12.5:37.5]){
    for(y=[-87.5:12.5:-62.5]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    for(y=[62.5:12.5:87.5]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }
*/
    //-stepper motor
    translate([-30-10/2,  50-10/2, 0])cube([10, 10.01, 16.8],center=true);
    translate([ 30+10/2,  50-10/2, 0])cube([10, 10.01, 16.8],center=true);
    translate([-30-10/2, -50+10/2, 0])cube([10, 10.01, 16.8],center=true);
    translate([ 30+10/2, -50+10/2, 0])cube([10, 10.01, 16.8],center=true);

    translate([-37.5, 0, 25/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([ 37.5, 0, 25/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);

    }//difference

/*
    //to motorseat connect
    difference(){
    union(){
    translate([-50+5, -50-25, 20/2])cube([10,50,20],center=true);
    translate([ 50-5, -50-25, 20/2])cube([10,50,20],center=true);
    }
    //l
    translate([-50+5, -75+25/2, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-50+5, -75+25/2, 20-3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    translate([-50+5, -75-25/2, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-50+5, -75-25/2, 20-3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    //r
    translate([ 50-5, -75+25/2, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5, -75+25/2, 20-3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    translate([ 50-5, -75-25/2, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5, -75-25/2, 20-3/2])cylinder(h=3.01,r=5,center=true,$fn=50);
    }
*/
}

module inner_bot(){

    //popup for l298n
    translate([-14.5, 65/2-5.3-40,-4])screwhelper(4, 1.6, 2);
    translate([ 14.5, 65/2-5.3-40,-4])screwhelper(4, 1.6, 2);
    translate([-27.5,-65/2+5.3-40,-4])screwhelper(4, 1.6, 2);
    translate([ 27.5,-65/2+5.3-40,-4])screwhelper(4, 1.6, 2);

    //
    translate([ 50-12.5, 50-12.5, -10-5])screwhelper(4, 3.2, 5);
    translate([ 50-12.5, 50-12.5, -5-5])screwhelper(4, 1.6, 5);
    translate([ 50-12.5, 50-12.5, -2-3])screwhelper(5, 1.6, 3);
    translate([-50+12.5, 50-12.5, -10-5])screwhelper(4, 3.2, 5);
    translate([-50+12.5, 50-12.5, -5-5])screwhelper(4, 1.6, 5);
    translate([-50+12.5, 50-12.5, -2-3])screwhelper(5, 1.6, 3);
    translate([ 50-12.5,-50+12.5, -10-5])screwhelper(4, 3.2, 5);
    translate([ 50-12.5,-50+12.5, -5-5])screwhelper(4, 1.6, 5);
    translate([ 50-12.5,-50+12.5, -2-3])screwhelper(5, 1.6, 3);
    translate([-50+12.5,-50+12.5, -10-5])screwhelper(4, 3.2, 5);
    translate([-50+12.5,-50+12.5, -5-5])screwhelper(4, 1.6, 5);
    translate([-50+12.5,-50+12.5, -2-3])screwhelper(5, 1.6, 3);

    //mid
    difference(){
    union(){
    translate([  0,  0, -1])cube([100, 100, 2],center=true);
    //
    translate([  0,  0, -1])cube([70, 150, 2],center=true);
    //batt
    translate([-50+1, 0, -15/2])cube([2, 100, 15],center=true);
    translate([ 50-1, 0, -15/2])cube([2, 100, 15],center=true);
    //motor
    translate([ 0, 50-1, -15/2])cube([100, 2, 15],center=true);
    translate([ 0,-50+1, -15/2])cube([100, 2, 15],center=true);
    }

    //center
    translate([0, -40, -1.11])cube([40, 40, 1.8],center=true);
    translate([0,   0, -1.11])cube([60, 10, 1.8],center=true);
    translate([0,  40, -1.11])cube([40, 40, 1.8],center=true);

    //nearfar wall
    translate([0,  50, -2-25/2])cube([65, 40, 25],center=true);
    translate([0, -50, -2-25/2])cube([65, 40, 25],center=true);

    //batt wall x
    for(y=[-37.5:25:37.5]){
        translate([ 50, y,-12.5])cube([10, 12.5, 5],center=true);
        translate([-50, y,-12.5])cube([10, 12.5, 5],center=true);
    }
    //batt hole x
    for(y=[-37.5:12.5:37.5]){
        translate([0, y, -25/2])rotate([0,90,0])cylinder(999, r=1.6,center=true,$fn=50);
    }

    //batt wire tunnel left
    for(y=[-40:40:40]){
    translate([ 50, y, 0])cube([10, 10, 10],center=true);
    translate([-50, y, 0])cube([10, 10, 10],center=true);
    }

    //l298n signal
    translate([ 37.5, 25, -1.11])cube([10, 10, 1.8],center=true);
    translate([-37.5, 25, -1.11])cube([10, 10, 1.8],center=true);
    translate([ 37.5,-25, -1.11])cube([10, 10, 1.8],center=true);
    translate([-37.5,-25, -1.11])cube([10, 10, 1.8],center=true);

    //hole left
    translate([-37.5,   25, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([-37.5, 12.5, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([-37.5,    0, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([-37.5,-12.5, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([-37.5,  -25, 0])cylinder(999, r=2,center=true,$fn=50);
    //hole right
    translate([ 37.5,   25, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([ 37.5, 12.5, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([ 37.5,    0, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([ 37.5,-12.5, 0])cylinder(999, r=2,center=true,$fn=50);
    translate([ 37.5,  -25, 0])cylinder(999, r=2,center=true,$fn=50);

    //bms hole
    for(y=[12.5:12.5:75]){
    for(x=[-25:12.5:25]){
    translate([ x, y, 0])cylinder(999, r=2,center=true,$fn=50);
    }
    }
/*
    //corner hole @ 45
    translate([-50+5, 50-5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5, 50-5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-50+5,-50+5,1])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 50-5,-50+5,1])cylinder(99, r=1.6,center=true,$fn=50);

    //corner hole @ 40
    translate([-40, 40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40, 40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40,-40,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40,-40,1])cylinder(10, r=1.6,center=true,$fn=50);
*/
    //corner hole @ 37.5
    translate([-37.5, 37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([ 37.5, 37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([-37.5,-37.5,1])cylinder(10, r=3,center=true,$fn=50);
    translate([ 37.5,-37.5,1])cylinder(10, r=3,center=true,$fn=50);
/*
    //corner hole @ 35
    translate([-40+5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5, 40-5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40+5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
    translate([ 40-5,-40+5,1])cylinder(10, r=1.6,center=true,$fn=50);
*/
    //-l298n hole
    translate([-27.5, 65/2-5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([-14.5, 65/2-5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([ 14.5, 65/2-5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([-27.5,-65/2+5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([ 27.5,-65/2+5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([-14.5,-65/2+5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
    translate([ 14.5,-65/2+5.3-40, 1])cylinder(92.01, r=3,center=true,$fn=50);
/*
    //-l298n signal cable
    translate([0, 65/2-11/2,0])cube([48,11,10],center=true);
    //-l298n capacitor
    translate([0, 65/2-(14+24)/2,0])cube([26,10,13],center=true);
    //-l298n heat speater
    translate([0,-65/2+3+15/2,0])cube([54,16,10],center=true);
    //-l298n hole
    translate([-27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
*/
    //translate([-14.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 14.5, 65/2-5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([-27.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 27.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([-14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);
    //translate([ 14.5,-65/2+5.3,-10])cylinder(100, r=1.6,center=true,$fn=50);

    /*
    //-rpi 40pin
    translate([-20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
    translate([-20-23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
    //-sensehat 40pin
    translate([ 20+23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
    translate([ 20-23/2,0,-10-2])cube([5.8,52-0.4,40],center=true);
    translate([ 20,65/2-11/2,-10-2])cube([11,11,40],center=true);
    //translate([ 20-30/2+3/2,65/2-16,-10-2])cube([3,11,40],center=true);
    */
    //-stepper motor hole
    translate([-30-10/2, 50-10/2, 0])cube([10,10,16.8],center=true);
    translate([ 30+10/2, 50-10/2, 0])cube([10,10,16.8],center=true);
    translate([-30-10/2,-50+10/2, 0])cube([10,10,16.8],center=true);
    translate([ 30+10/2,-50+10/2, 0])cube([10,10,16.8],center=true);

    translate([-37.5, 0, -25/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([ 37.5, 0, -25/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);

    }
}

module helpfixesp32(){
    difference(){
        union(){
        translate([0, 15, 4/2])cube([6, 6, 2+2],center=true);
        translate([0, 0, 2/2])cube([6, 40, 2],center=true);
        translate([3+4/2, 0, 2/2])cube([2+2, 20, 2],center=true);
        }
        translate([0, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
}
module logicboard_esp32s3_weact(){
}

module logicboard_esp32s3_muselab(){
    //translate([-50,0,0])helpfixesp32();

    //
    difference(){
    translate([0, 0, 10/2])cube([80-0.2, 40-0.2, 10],center=true);
    //
    translate([0, 0, 2/2])cube([40,20,1000],center=true);
    //
    translate([0, 0, 2+8/2])cube([61, 32, 8.01],center=true);
    //
    translate([0, 0, 2+8/2])cube([99, 32-12, 8.01],center=true);
    translate([0, 0, 2+8/2])cube([60-12, 99, 8.01],center=true);
    //
    translate([-40+5, 0, 0])cube([3, 10, 10],center=true);
    translate([ 40-5, 0, 0])cube([3, 10, 10],center=true);
    //
    for(t=[-40:70:30]){
    //
    translate([t+5, 15, 2+8/2])cylinder(8.01, r=4,center=true,$fn=50);
    translate([t+5,  5, 2+8/2])cylinder(8.01, r=4,center=true,$fn=50);
    translate([t+5,- 5, 2+8/2])cylinder(8.01, r=4,center=true,$fn=50);
    translate([t+5,-15, 2+8/2])cylinder(8.01, r=4,center=true,$fn=50);
    //
    translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    //
    translate([-35, 0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 35, 0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    //
    translate([ 0,-15, 5])rotate([0,90,0])cylinder(199, r=1.6,center=true,$fn=50);
    translate([ 0, 15, 5])rotate([0,90,0])cylinder(199, r=1.6,center=true,$fn=50);
    }

    /*
    difference(){
        union(){
        translate([0, 0, 2/2])cube([80+0.2, 40+0.2, 2],center=true);
        }

        translate([0, 0, 2/2])cube([40,20,1000],center=true);

        translate([-40+5, 0, 0])cube([3, 10, 10],center=true);
        translate([ 40-5, 0, 0])cube([3, 10, 10],center=true);
        
        for(t=[-40:70:30]){
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }*/
}

module mainbody_head(){
    difference(){
        union(){
        translate([0,0,2/2])cube([80,40,2],center=true);
        }
    }
}

module mainbody_rpi(){
    //top
    difference(){
        union(){
        translate([0,0,40-2/2])cube([80,60,2],center=true);
        }
        translate([0,0,40-2/2])cube([70,50,1000],center=true);
    }

    //bot
    translate([ 58/2, 49/2, 2])screwhelper(3.5, 1.6, 2);
    translate([-58/2, 49/2, 2])screwhelper(3.5, 1.6, 2);
    translate([ 58/2,-49/2, 2])screwhelper(3.5, 1.6, 2);
    translate([-58/2,-49/2, 2])screwhelper(3.5, 1.6, 2);
    difference(){
        union(){
        translate([0,0,2/2])cube([160,40,2],center=true);
        translate([0,0,2/2])cube([80,60,2],center=true);
        }
        translate([0+29,  24.5   ,2])cylinder(1000, r=2.9,center=true,$fn=50);
        translate([0-29,  24.5   ,2])cylinder(1000, r=2.9,center=true,$fn=50);
        translate([0+29, -24.5   ,2])cylinder(1000, r=2.9,center=true,$fn=50);
        translate([0-29, -24.5   ,2])cylinder(1000, r=2.9,center=true,$fn=50);
        //mid
        for(t=[-40:70:30]){
        translate([t+5, 25, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-25, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
        //leftright
        cylinder(1000, r=25,center=true,$fn=50);
        translate([ 40+15/2,0,0])cube([15,24,1000],center=true);
        translate([-40-15/2,0,0])cube([15,24,1000],center=true);
        translate([ 70,0,0])cube([20,24,1000],center=true);
        translate([-70,0,0])cube([20,24,1000],center=true);
        for(t=[-60:120:70]){
        translate([t+15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }

    //nearfar
    difference(){
        union(){
        translate([0, 30-2/2,40/2])cube([80,2,36],center=true);
        translate([0,-30+2/2,40/2])cube([80,2,36],center=true);
        }
        translate([0,0,40/2])cube([60,1000,32],center=true);
    }
}
module mainbody_drv8833_help(){
    difference(){
        union(){
        translate([0, 0, -20/2])cube([22-0.2, 24, 20],center=true);
        translate([-10, 0, - 5])cube([1.8, 36-0.2, 10],center=true);
        translate([-10, 0, -15])cube([1.8, 30-0.2, 10],center=true);
        }
        translate([0, 10/2, -5])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-10/2, -5])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, -5])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, -5])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, -15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, -15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, -25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, -25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        //
        translate([0, 0, -18/2])cube([18.6,21.6,18.01],center=true);

        translate([0, 0, 0])cube([10,10,999],center=true);
        
        translate([-22/2+2/2, 0, -15])cube([2.01,10,10],center=true);
        translate([ 22/2-2/2, 0, -15])cube([2.01,10,10],center=true);
        
        translate([0,-24/2+1.5/2, -15])cube([10,1.51,10],center=true);
        translate([0, 24/2-1.5/2, -15])cube([10,1.51,10],center=true);

    }
}
module mainbody_drv8833(){
    //drv8833
    translate([-40-22/2, 0, 40])mirror([1,0,0])mainbody_drv8833_help();
    translate([ 40+22/2, 0, 40])mainbody_drv8833_help();
/*
    //cube
    difference(){
        union(){
        //
        translate([ 60, 0,40/2])cube([40,40,40],center=true);
        translate([-60, 0,40/2])cube([40,40,40],center=true);
        }
        //-top hole
        for(t=[-60:120:70]){
        translate([t+15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
        //-top
        translate([ 40+22/2,0,0])cube([22,24,1000],center=true);
        translate([-40-22/2,0,0])cube([22,24,1000],center=true);
        //translate([ 80-2-16/2,0,0])cube([16,24,1000],center=true);
        //translate([-80+2+16/2,0,0])cube([16,24,1000],center=true);
        //-mid
        translate([ 60, 0, 40/2])rotate([90,0,0])scale([1, 1, 1])cylinder(100, r=15,center=true,$fn=50);
        translate([-60, 0, 40/2])rotate([90,0,0])scale([1, 1, 1])cylinder(100, r=15,center=true,$fn=50);
        translate([ 60, 0,40/2])cube([36,36,36],center=true);
        translate([-60, 0,40/2])cube([36,36,36],center=true);
        translate([ 60, 0,35/2])cube([41,24,35],center=true);
        translate([-60, 0,35/2])cube([41,24,35],center=true);
        //-bot side
        translate([ 40+5/2, 0,10/2])cube([5,41,10],center=true);
        translate([-40-5/2, 0,10/2])cube([5,41,10],center=true);
        translate([ 80-5/2, 0,10/2])cube([5,41,10],center=true);
        translate([-80+5/2, 0,10/2])cube([5,41,10],center=true);
        //-bot mid
        translate([ 60, 0,0])cube([41,24,9],center=true);
        translate([-60, 0,0])cube([41,24,9],center=true);
        translate([ 60, 0,1.2/2])cube([41,41,1.2],center=true);
        translate([-60, 0,1.2/2])cube([41,41,1.2],center=true);
    }
    */
    
    /*
    //connect
    difference(){
        union(){
        translate([ 40,  20+2/2,40/2])cube([20,2,20],center=true);
        translate([ 40, -20-2/2,40/2])cube([20,2,20],center=true);
        translate([-40,  20+2/2,40/2])cube([20,2,20],center=true);
        translate([-40, -20-2/2,40/2])cube([20,2,20],center=true);
        }
        translate([ 45, 0, 15])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 45, 0, 25])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 35, 0, 15])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 35, 0, 25])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-35, 0, 25])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-35, 0, 15])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-45, 0, 25])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-45, 0, 15])rotate([90,0,0])cylinder(100, r=1.6,center=true,$fn=50);
    }*/
}
module mainbody_drv8825(){
}
module mainbody_power222(){
    //top
    difference(){
        union(){
        translate([0,0,40-2/2])cube([80,40,2],center=true);
        }
        //translate([  0,0,0])cylinder(1000, r=15,center=true,$fn=50);
        translate([0,0,2/2])cube([60,30,1000],center=true);
        /*
        translate([ 40+15/2,0,0])cube([15,24,1000],center=true);
        translate([-40-15/2,0,0])cube([15,24,1000],center=true);
        translate([ 70,0,0])cube([20,24,1000],center=true);
        translate([-70,0,0])cube([20,24,1000],center=true);
        */
        for(t=[-40:70:30]){
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }/*
        for(t=[-60:120:70]){
        translate([t+15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t-15,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }*/
    }

    //nearfar
    difference(){
        union(){
        //far top
        translate([0, 20-2/2, 25])cube([80,2,30],center=true);
        //near mid
        translate([0, 20-2/2, 20])cube([74,2,40],center=true);
        //near top
        translate([0,-20+2/2, 25])cube([80,2,30],center=true);
        //near mid
        translate([0,-20+2/2, 20])cube([74,2,40],center=true);
        }
        //
        translate([-30, 0, 40/2])rotate([90,0,0])cylinder(100, r=10,center=true,$fn=50);
        translate([  0, 0, 40/2])rotate([90,0,0])cylinder(100, r=10,center=true,$fn=50);
        translate([ 30, 0, 40/2])rotate([90,0,0])cylinder(100, r=10,center=true,$fn=50);
        //
        for(t=[-40:10:30]){
        translate([t+5, 0, 70/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 50/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 30/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 10/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }

    //leftright
    difference(){
        union(){
        translate([-40+2/2, 0,35])cube([2,40,10],center=true);
        translate([ 40-2/2, 0,35])cube([2,40,10],center=true);
        //
        translate([-40+2/2, 10,10/2])cube([2,14,10],center=true);
        translate([-40+2/2,-10,10/2])cube([2,14,10],center=true);
        translate([ 40-2/2, 10,10/2])cube([2,14,10],center=true);
        translate([ 40-2/2,-10,10/2])cube([2,14,10],center=true);
        }
        translate([0, 30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 10/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-10/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        //
        translate([0, 30/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 10/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-10/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    difference(){
        union(){
        //right,far
        translate([ 40+2/2, 20-2/2,20])cube([2,2,20],center=true);
        translate([ 40+2+2/2, 20-7.9/2,25])cube([2,7.9,30],center=true);
        //right,near
        translate([ 40+2/2,-20+2/2,20])cube([2,2,20],center=true);
        translate([ 40+2+2/2,-20+7.9/2,25])cube([2,7.9,30],center=true);
        //left,far
        translate([-40-2/2, 20-2/2,20])cube([2,2,20],center=true);
        translate([-40-2-2/2, 20-7.9/2,25])cube([2,7.9,30],center=true);
        //left,near
        translate([-40-2/2,-20+2/2,20])cube([2,2,20],center=true);
        translate([-40-2-2/2,-20+7.9/2,25])cube([2,7.9,30],center=true);
        }
        translate([0, 30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, 25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, 15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }

    //bot.bot
    difference(){
        union(){
        translate([0,0,2/2])cube([74,40,2],center=true);
        translate([0, 10,2/2])cube([80,14,2],center=true);
        translate([0,-10,2/2])cube([80,14,2],center=true);
        }
        translate([0,0,2/2])cube([60,30,1000],center=true);
        for(t=[-40:10:30]){
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }
}
module switchport(){
    difference(){
    union(){
    translate([0, 10/2, 0])cube([15, 10, 22],center=true);
    }

    //-switch
    translate([0,23-40/2,0])cube([12.6,40,20],center=true);
    //-hole cube
    translate([0,1+6/2,0])cube([6,4,99],center=true);
    }
}
module xh254_3pin_female(){
    difference(){
    union(){
    translate([0, 0, 10-7/2])cube([12, 16, 7],center=true);
    }

    //right
    translate([ 0, 10-3/2, 10.01-5/2])cube([6, 3.01, 5],center=true);
    translate([ 0, 0, 10.01-6.2/2])cube([8.2, 15, 6.2],center=true);
    translate([ 0, 0-15/2+7/2, 10.01-7/2])cube([10.0, 7.01, 7.03],center=true);
    translate([ 0, 0-15/2-0.5, 10.01-6/2])cube([8.0, 1, 6],center=true);
    }
}
module xh254_3pin_male(){
    difference(){
    union(){
    translate([0, 0, 10-9/2])cube([14, 20, 9],center=true);
    }
    //cable
    translate([0,21/2-1/2, 10-5/2])cube([   6,1.01,5.01],center=true);
    //
    translate([0, 0, 10-2])cube([12.4, 20, 4.01],center=true);
    //
    hull(){
    translate([0, 0, 6])cube([12.4, 19.8, 0.01],center=true);
    translate([0, 0, 1.5])cube([12.4, 18.6, 0.01],center=true);
    }
    //head
    translate([0,-21/2+1/2, 10-7/2])cube([9,1.01,7.01],center=true);
    }
}
module mainbody_power(){
    //y+30
    translate([0,20-2-4,40-9-0.99/2])cube([80,8,0.99],center=true);

    //above board: 7v to 5v
    difference(){
    union(){
    translate([-20, -20+1, 25])cube([20, 2, 10],center=true);
    translate([-35, -20+8+1, 25])cube([10, 2, 10],center=true);
    //
    translate([-40+15, -20+2+4, 15])cube([30, 8, 10],center=true);
    translate([-40+20, -20+1, 15])cube([20, 2, 10],center=true);
    }
    translate([-40+15, -15, 15])cube([26,6,10],center=true);
    translate([-40+15, -15, 15])cube([50,2,10],center=true);
    //
    translate([-35, 0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-25, 0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15, 0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-35, 0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-25, 0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15, 0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }

    //above board: -20
    //translate([-20, -12, 6])xh254_3pin_female();

    //above board: 0
    difference(){
        translate([0, -20, 20])switchport();
        //cable through it
        translate([0, -20, 30])cube([0.2, 20, 10],center=true);
    }

    //above board: 20
    translate([ 20, -10, 9])xh254_3pin_male();

    //board
    difference(){
        translate([0,0,9+0.99/2])cube([80,40,0.99],center=true);
        //pcb
        translate([0,20-2/2,10])cube([60,2,10],center=true);
        //hole to below level
        translate([0,20-10/2,9+0.4/2])cube([10,10,10],center=true);
        //xt254
        //translate([-20, -12, 10])cube([12, 16, 10],center=true);
        //switchport
        translate([0, -20+10/2, 10])cube([15, 10, 22],center=true);
    }

    //below board: batt out
    translate([-10.2, 0, 10])rotate([0,0,90])mirror([0,0,1])xh254_3pin_male();
    //below board: power in
    translate([8.2, 0, 9-1/2])cube([16, 14, 1],center=true);
    translate([8.2, 0, 11])rotate([0,0,-90])mirror([0,0,1])xh254_3pin_female();




    //top
    difference(){
        hull(){
        translate([0, 0, 50-0.1])cube([84, 44, 0.2],center=true);
        translate([0, 0, 36+0.1])cube([84, 40, 0.2],center=true);
        }
        translate([0, 0, 45])cube([80, 40, 20],center=true);
        translate([0, 0, 45])cube([99, 36.4, 20],center=true);
        translate([0, 0, 45])cube([60, 99, 20],center=true);
        //
        translate([-40+5, 0, 40])cube([3, 10, 10],center=true);
        translate([ 40-5, 0, 40])cube([3, 10, 10],center=true);
        //
        for(t=[-40:10:30]){
        translate([t+5, 0, 45])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }
    difference(){
        union(){
        translate([0,0,40-2/2])cube([80,40,2],center=true);
        }

        translate([0,0,2/2])cube([60,30,1000],center=true);

        translate([-40+5, 0, 40])cube([3, 10, 10],center=true);
        translate([ 40-5, 0, 40])cube([3, 10, 10],center=true);

        for(t=[-40:70:30]){
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }

    //nearfar
    difference(){
        union(){
        //far top
        //translate([0, 20-2/2, 25])cube([80,2,30],center=true);
        //translate([0, 20-2/2, 20])cube([74,2,40],center=true);
        translate([0, 20-2/2, 20])cube([80,2,40],center=true);
        //near top
        //translate([0,-20+2/2, 25])cube([80,2,30],center=true);
        //translate([0,-20+2/2, 20])cube([74,2,40],center=true);
        translate([0,-20+2/2, 20])cube([80,2,40],center=true);
        }
        //
        translate([  0, 0, 40/2])cube([60,100,36],center=true);
        //
        for(t=[-40:10:30]){
        translate([t+5, 0, 70/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 50/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 30/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5, 0, 10/2])rotate([90,0,0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
    }

    //leftright
    difference(){
        union(){
        //right,far
        //translate([ 40+2/2, 20-2/2,20])cube([2,2,20],center=true);
        //translate([ 40+2+2/2, 20-7.9/2,25])cube([2,7.9,30],center=true);
        translate([ 40+4/2, 20-7.9/2,35])cube([4,7.9,10],center=true);
        //right,near
        //translate([ 40+2/2,-20+2/2,20])cube([2,2,20],center=true);
        //translate([ 40+2+2/2,-20+7.9/2,25])cube([2,7.9,30],center=true);
        translate([ 40+4/2,-20+7.9/2,35])cube([4,7.9,10],center=true);
        //left,far
        //translate([-40-2/2, 20-2/2,20])cube([2,2,20],center=true);
        //translate([-40-2-2/2, 20-7.9/2,25])cube([2,7.9,30],center=true);
        translate([-40-4/2, 20-7.9/2,35])cube([4,7.9,10],center=true);
        //left,near
        //translate([-40-2/2,-20+2/2,20])cube([2,2,20],center=true);
        //translate([-40-2-2/2,-20+7.9/2,25])cube([2,7.9,30],center=true);
        translate([-40-4/2,-20+7.9/2,35])cube([4,7.9,10],center=true);
        }
        //
        translate([-40-2/2, 0, 35])cube([2, 36.4, 20],center=true);
        translate([ 40+2/2, 0, 35])cube([2, 36.4, 20],center=true);
        //
        translate([0, 30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, 25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 25])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 30/2, 15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 15])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    hull(){ //right,near
        translate([40+0.1, -20+0.1, 20+0.1])cube([0.2, 0.2, 0.2],center=true);
        translate([40+2, -20+2.5, 30-0.1])cube([4, 5, 0.2],center=true);
    }
    hull(){ //right,far
        translate([40+0.1, 20-0.1, 20+0.1])cube([0.2, 0.2, 0.2],center=true);
        translate([40+2,   20-2.5, 30-0.1])cube([4, 5, 0.2],center=true);
    }
    hull(){ //left,near
        translate([-40-0.1, -20+0.1, 20+0.1])cube([0.2, 0.2, 0.2],center=true);
        translate([-40-2, -20+2.5, 30-0.1])cube([4, 5, 0.2],center=true);
    }
    hull(){ //left,far
        translate([-40-0.1, 20-0.1, 20+0.1])cube([0.2, 0.2, 0.2],center=true);
        translate([-40-2,   20-2.5, 30-0.1])cube([4, 5, 0.2],center=true);
    }
    difference(){
        union(){
        translate([-40+2/2, 0,35])cube([2,40,10],center=true);
        translate([ 40-2/2, 0,35])cube([2,40,10],center=true);
        //
        translate([-40+2/2, 10,10/2])cube([2,14,10],center=true);
        translate([-40+2/2,-10,10/2])cube([2,14,10],center=true);
        translate([ 40-2/2, 10,10/2])cube([2,14,10],center=true);
        translate([ 40-2/2,-10,10/2])cube([2,14,10],center=true);
        }
        translate([0, 30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 10/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-10/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 35])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        //
        translate([0, 30/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0, 10/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-10/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([0,-30/2, 10/2])rotate([0,90,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }

    //bot.bot
    difference(){
        union(){
        translate([0,0,2/2])cube([74,40,2],center=true);
        translate([0, 10,2/2])cube([80,14,2],center=true);
        translate([0,-10,2/2])cube([80,14,2],center=true);
        }
        translate([0,0,2/2])cube([60,30,1000],center=true);
        for(t=[-40:10:30]){
        translate([t+5, 15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,  5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,- 5, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        translate([t+5,-15, 0])cylinder(1000, r=1.6,center=true,$fn=50);
        }
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

/*
color([0.1,0.2,0.3,0.8])translate([ 0,0, 0])outer_top();
color([0.5,0,0.5,0.8])translate([ 0,0, -25])inner_top();

translate([0,-40,-25-2-2])rotate([180,0,0])notprint_l298n();

color([0.7,0.2,0.9,0.8])translate([ 0,0,-25])inner_bot();
//color([0.3,0.2,0.1,0.8])translate([ 0,0,-50])outer_bot();
*/

//--------for preview--------
//translate([0, 0, 80])mainbody_head();
//translate([0, 0, 40])mainbody_rpi();
//translate([0, 0, 40])logicboard_esp32s3_muselab();

//mainbody_power();
//translate([0, 0, 0])mainbody_drv8833();

//color([0.3,0.7,0,0.8])translate([0,-60,-20])bot_motorseat_connector();
//color([0.1,0,0.5,0.2])notprint_wheel();




//--------for print--------
//logicboard_esp32s3_muselab();

//mainbody_power();
mainbody_drv8833_help();

//bot_motorseat();
//bot_motorseat_connector();
//outer_top();
//translate([ 0,0, -25])inner_top();
//rotate([180,0,0])inner_bot();
//xh254_3pin_male();
