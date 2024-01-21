
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
module conn(height,degree){
    difference(){
        cube([height,40,20],center=true);
        cube([height-4,36,22],center=true);
        //translate([0,0,1])cube([32,36,18.01],center=true);
        //translate([0,0,5])cube([20,41,10],center=true);
        translate([0, 10,0])rotate([0,90,0])cylinder(40.01, r=2.5,center=true,$fn=50);
        translate([0,  0,0])rotate([0,90,0])cylinder(40.01, r=2.5,center=true,$fn=50);
        translate([0,-10,0])rotate([0,90,0])cylinder(40.01, r=2.5,center=true,$fn=50);
    }

    translate([-height/2-1, 10,0])rotate([0,90,0])rotate([0,0,degree])addon(2);
    translate([-height/2-2,  0,0])rotate([0,90,0])rotate([0,0,degree])addon(4);
    translate([-height/2-1,-10,0])rotate([0,90,0])rotate([0,0,degree])addon(2);

    translate([ height/2+1, 10,0])rotate([0,90,0])rotate([0,0,degree])addon(2);
    translate([ height/2+2,  0,0])rotate([0,90,0])rotate([0,0,degree])addon(4);
    translate([ height/2+1,-10,0])rotate([0,90,0])rotate([0,0,degree])addon(2);
}
module conn_typec(){
    difference(){
    union(){
    conn(40,-45);
    //layer2
    translate([5,0,0])cube([10,40,20],center=true);
    //layer1
    translate([-5,0,0])cube([10,40,20],center=true);
    }

    //layer2
    translate([5.5,-10,9])cube([9.01,4,2.01],center=true);
    translate([5.5,-10,0])cube([9.01,8,16.01],center=true);
    translate([5.5,-10,-9])cube([9.01,4,2.01],center=true);
    translate([5.5, 10, 9])cube([9.01,4,2.01],center=true);
    translate([5.5, 10,0])cube([9.01,8,16.01],center=true);
    translate([5.5, 10,-9])cube([9.01,4,2.01],center=true);

    //layer1
    translate([5.5-10, 0, 0])cube([9.01,36,20.01],center=true);
    }
}
module conn_xh254(){
    difference(){
    union(){
    //+special
    translate([-10,-11,5])cube([20,2,10], center=true);
    //xh254
    translate([0,0,5])cube([40,20,10],center=true);
    //+blank
    translate([0,0,-5])cube([40,20,10],center=true);
    //+main
    rotate([0,90,90])conn(40,-45);
    }

    //-blank
    translate([0,0,-4.5])cube([36,21,9],center=true);

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
module conn_bms(){
    difference(){
        conn(36,-45);
        translate([0,0,5.01])cube([20,40.01,10],center=true);
    }
}

module conn_motor(){
    difference(){
        conn(36,45);
        translate([0,0,5.01])cube([20,40.01,10],center=true);
    }
}

module top_top(){
    /*
    translate([-40, 20, 80-0.5])linear_extrude(height=1.01,center=true)text("-A-",size=20,font= "Arial");
    translate([00, 20, 80-0.5])linear_extrude(height=1.01,center=true)text("-B-",size=20,font= "Arial");
    translate([-40,-40, 80-0.5])linear_extrude(height=1.01,center=true)text("-C-",size=20,font= "Arial");
    translate([00,-40, 80-0.5])linear_extrude(height=1.01,center=true)text("-D-",size=20,font= "Arial");
    */

    difference(){
    union(){
    translate([0, 0, 80-1])cube([120,120,2],center=true);
    }

    //middle
    translate([0, 0, 80-1.11])cube([80,80,1.8],center=true);
    translate([0, 0, 80-1])cube([40,40,3],center=true);

    //hole
    translate([-50,-10,80])cylinder(100, r=5,center=true,$fn=50);
    translate([-50, 10,80])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50,-10,80])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50, 10,80])cylinder(100, r=5,center=true,$fn=50);

    //cam
    translate([-40, 40, 80])cube([20,30,8],center=true);
    translate([ 40, 40, 80])cube([20,30,8],center=true);
    translate([-40,-40, 80])cube([20,30,8],center=true);
    translate([ 40,-40, 80])cube([20,30,8],center=true);
    }

    difference(){
    union(){
    translate([-40, 40, 80-4.5])cube([22,32,9],center=true);
    translate([ 40, 40, 80-4.5])cube([22,32,9],center=true);
    translate([-40,-40, 80-4.5])cube([22,32,9],center=true);
    translate([ 40,-40, 80-4.5])cube([22,32,9],center=true);
    }

    //cam
    translate([-40, 40, 80.01-4])cube([20,30,8],center=true);
    translate([ 40, 40, 80.01-4])cube([20,30,8],center=true);
    translate([-40,-40, 80.01-4])cube([20,30,8],center=true);
    translate([ 40,-40, 80.01-4])cube([20,30,8],center=true);

    //cam
    translate([-40, 40, 80.01-4])cube([10,40,8],center=true);
    translate([ 40, 40, 80.01-4])cube([10,40,8],center=true);
    translate([-40,-40, 80.01-4])cube([10,40,8],center=true);
    translate([ 40,-40, 80.01-4])cube([10,40,8],center=true);
    }
}

module top_support_one(){
    difference(){
        conn(36,45);
        translate([0,0,6])cube([40,24,2],center=true);
    }
}
module top_support(){
    translate([-50, 0, 60])rotate([0,90,0])top_support_one();
    translate([ 50, 0, 60])rotate([0,-90,0])top_support_one();
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
module top_cam(){
translate([-30,0.0])cam_mount();
translate([ 30,0.0])cam_mount();
}
/*
module top_speaker_l(){
difference(){
    translate([-55, 50,60])cube([10,20,36],center=true);
    translate([-50, 46,61])cube([21,8,30],center=true);
    translate([-50, 60,61])cube([21,20,28],center=true);
    translate([-50,50,43.2])cube([50,10,2.4],center=true);

    translate([-55,50,47])cylinder(4, r=3,center=true,$fn=50);
    translate([-55,50,50])cylinder(30, r=1.6,center=true,$fn=50);

    translate([-52, 46,80])cube([4,8,10],center=true);
}
}
module top_speaker_r(){
difference(){
    translate([ 55, 50,60])cube([10,20,36],center=true);
    translate([ 50, 46,61])cube([21,8,30],center=true);
    translate([ 50, 60,61])cube([21,20,26],center=true);
    translate([ 50,50,43.2])cube([50,10,2.4],center=true);

    translate([ 55,50,47])cylinder(4, r=3,center=true,$fn=50);
    translate([ 55,50,50])cylinder(30, r=1.6,center=true,$fn=50);

    translate([ 52, 46,80])cube([4,8,10],center=true);
}
}
module top_speaker(){
    top_speaker_l();
    top_speaker_r();
}
*/
module inmp441(){
    translate([0,0,1])cube([20,40,2],center=true);
    translate([0,0,2+5])cube([2.54*3,2.54*4,10],center=true);
}
module top_mic(){
translate([ 40,0,60])rotate([0, 90,0])inmp441();
translate([-40,0,60])rotate([0,-90,0])inmp441();
}

module upper_real(){
    //+hole for cam
    difference(){
        translate([0,50,3-0.1])cube([108,9.8,2],center=true);
        for(j=[-50:5:50]){
            translate([j,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
        }
    }

    //+hole for rpi
    difference(){
        union(){
        translate([-24.5,20-62, 3])cylinder(2, r=4,center=true,$fn=50);
        translate([ 24.5,20-62, 3])cylinder(2, r=4,center=true,$fn=50);
        translate([-24.5, 20-4, 3])cylinder(2, r=4,center=true,$fn=50);
        translate([ 24.5, 20-4, 3])cylinder(2, r=4,center=true,$fn=50);
        }
        translate([-24.5,20-62, 3])cylinder(3, r=1.6,center=true,$fn=50);
        translate([ 24.5,20-62, 3])cylinder(3, r=1.6,center=true,$fn=50);
        translate([-24.5, 20-4, 3])cylinder(3, r=1.6,center=true,$fn=50);
        translate([ 24.5, 20-4, 3])cylinder(3, r=1.6,center=true,$fn=50);
    }

    difference(){
    translate([0,0,2/2])cube([120,120,2],center=true);

    //center
    //translate([0,0,2/2])cube([40,40,3],center=true);

    //leftright
    translate([-35,0,2/2])cube([10,40,3],center=true);
    translate([ 35,0,2/2])cube([10,40,3],center=true);

    //cammount
    for(j=[-50:5:50]){
    //translate([j,50,0.5])cylinder(10, r=1.6,center=true,$fn=50);
    translate([j,50,1])cylinder(2.01, r=3,center=true,$fn=50);
    }

    //rpi
    translate([-24.5,20-62, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 24.5,20-62, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-24.5, 20-4, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([ 24.5, 20-4, 1])cylinder(2.01, r=3,center=true,$fn=50);

    //support hole
    translate([-50,-10,0])cylinder(100, r=5,center=true,$fn=50);
    translate([-50,  0,0])cylinder(100, r=5,center=true,$fn=50);
    translate([-50, 10,0])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50,  0,0])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50, 10,0])cylinder(100, r=5,center=true,$fn=50);

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

module top_bot(){
//translate([0,0,2+40+2])rpi();

translate([0,0,40])upper_real();
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

module mid_top(){
    difference(){
        translate([ 0, 0, 40-1])cube([120,120,2],center=true);

        translate([ 0, 0, 40-1])cube([80,80,3],center=true);

        translate([-50, 10, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,  0, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,-10, 0])cylinder(100, r=5,center=true,$fn=50);

        translate([ 50, 10, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,  0, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,-10, 0])cylinder(100, r=5,center=true,$fn=50);
    }
}

module mid_support(){
    translate([-50, 0, 20])rotate([0,90,0])conn_bms();
    translate([ 50, 0, 20])rotate([0,-90,0])conn_bms();
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
    translate([ 0, 60,-20])rotate([0,0,90])batterypack();
    translate([ 0,-60,-20])rotate([0,0,90])batterypack();
}

module part2_kuang(){
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
/*
    //zhong
    difference(){
        translate([0,0,10])cube([40,40,20],center=true);
        translate([0,0,10])cube([30,39.9,20.02],center=true);
        translate([0,10,10])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
        translate([0,-10,10])rotate([0,90,0])cylinder(100, r=2.5,center=true,$fn=50);
    }
*/
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
    translate([40,0,20])rotate([0,90,0])part2_kuang();
    translate([50,0,20])rotate([0,0,90])conn_xh254();
}
module mid_kuang_left(){
    translate([-40,0,20])rotate([0,-90,0])part2_kuang();
    translate([-50,0,20])rotate([0,-90,0])conn_typec();
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
    translate([ 0, 40-5,1])cylinder(10, r=5,center=true,$fn=50);
    translate([ 0,-40+5,1])cylinder(10, r=5,center=true,$fn=50);
    translate([-40+5, 0,1])cylinder(10, r=5,center=true,$fn=50);
    translate([ 40-5, 0,1])cylinder(10, r=5,center=true,$fn=50);
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

module mid_bot()
{
    difference(){
    union(){
    //+baseboard
    translate([0, 0, 1])cube([80, 120, 2],center=true);

    //+l298n
    translate([-27.5, 65/2-5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([ 27.5, 65/2-5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([-14.5, 65/2-5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([ 14.5, 65/2-5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([-27.5,-65/2+5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([ 27.5,-65/2+5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([-14.5,-65/2+5, 3])cylinder(2, r=5,center=true,$fn=50);
    translate([ 14.5,-65/2+5, 3])cylinder(2, r=5,center=true,$fn=50);
    }

    //translate([0,0,2.51])cube([66,66,3],center=true);
    //batt cable
    translate([0,-40, 0])cube([10,10,10],center=true,$fn=50);
    translate([0, 40, 0])cube([10,10,10],center=true,$fn=50);

    //-l298n
    translate([-27.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-14.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-27.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-14.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);

    //-l298n
    translate([-27.5, 65/2-5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([ 27.5, 65/2-5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([-14.5, 65/2-5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([ 14.5, 65/2-5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([-27.5,-65/2+5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([ 27.5,-65/2+5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([-14.5,-65/2+5,0.99])cylinder(2, r=3,center=true,$fn=50);
    translate([ 14.5,-65/2+5,0.99])cylinder(2, r=3,center=true,$fn=50);
    }

    //left
    difference(){
        union(){
        translate([-50, 0, 1])cube([20,40,2],center=true);
        }
        translate([-50, 10, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,  0, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,-10, 0])cylinder(100, r=5,center=true,$fn=50);
    }

    //right
    difference(){
        union(){
        translate([ 50, 0, 1])cube([20,40,2],center=true);
        }
        translate([ 50, 10, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,  0, 0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,-10, 0])cylinder(100, r=5,center=true,$fn=50);
    }

    //corner
    translate([ 40, 20, 0])bezier(2);
    translate([ 40,-20, 0])mirror([0,1,0])bezier(2);
    translate([-40, 20, 0])mirror([1,0,0])bezier(2);
    translate([-40,-20, 0])rotate([0,0,180])bezier(2);
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
    translate([-50, 0,-20])rotate([0,90,0])conn_motor();
    translate([ 50, 0,-20])rotate([0,-90,0])conn_motor();
}



module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([-80,-80,-20])wheel();
    translate([ 80,-80,-20])wheel();
    translate([-80, 80,-20])wheel();
    translate([ 80, 80,-20])wheel();
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
    //popup
    translate([-50, 70,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50, 70,-4])screwhelper(4.9, 1.6, 2);
    translate([-50, 50,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50, 50,-4])screwhelper(4.9, 1.6, 2);
    translate([-50,-50,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50,-50,-4])screwhelper(4.9, 1.6, 2);
    translate([-50,-70,-4])screwhelper(4.9, 1.6, 2);
    translate([ 50,-70,-4])screwhelper(4.9, 1.6, 2);

    //mid
    difference(){
        union(){
        translate([  0,  0, -1])cube([ 80, 80, 2],center=true);
        translate([  0, 60, -1])cube([120, 40, 2],center=true);
        translate([  0,-60, -1])cube([120, 40, 2],center=true);
        translate([-60,  0, -1])cube([ 40, 80, 2],center=true);
        translate([ 60,  0, -1])cube([ 40, 80, 2],center=true);
/*
        //+connect two board
        translate([-35, 35,-5])cube([10,10,10],center=true);
        translate([ 35, 35,-5])cube([10,10,10],center=true);
        translate([-35,-35,-5])cube([10,10,10],center=true);
        translate([ 35,-35,-5])cube([10,10,10],center=true);
*/
        }
/*
        //-connect two board
        translate([-30-4, 30+4,-5+0.01])cube([8.01,8.01,10],center=true);
        translate([ 30+4, 30+4,-5+0.01])cube([8.01,8.01,10],center=true);
        translate([-30-4,-30-4,-5+0.01])cube([8.01,8.01,10],center=true);
        translate([ 30+4,-30-4,-5+0.01])cube([8.01,8.01,10],center=true);

        //-screw hole
        translate([-35,0,0])cylinder(40, r=2.4,center=true,$fn=50);
        translate([ 35,0,0])cylinder(40, r=2.4,center=true,$fn=50);
        translate([0,-35,0])cylinder(40, r=2.4,center=true,$fn=50);
        translate([0, 35,0])cylinder(40, r=2.4,center=true,$fn=50);
*/
        //-battpack left
        translate([-60-10,  30-2,  -1])cube([16, 20, 10],center=true);
        translate([-60-10,     0,-1.5])cube([10, 40, 1.01],center=true);
        translate([-60-10, -30+2,  -1])cube([16, 20, 10],center=true);
        //battpack right
        translate([ 60+10,  30-2,  -1])cube([16, 20, 10],center=true);
        translate([ 60+10,     0,-1.5])cube([10, 40, 1.01],center=true);
        translate([ 60+10, -30+2,  -1])cube([16, 20, 10],center=true);
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

        //-hole for motorseat
        translate([-50, 70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50, 70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50, 50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50, 50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50,-50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50,-50,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([-50,-70,-1])cylinder(h=8,r=3,center=true,$fn=50);
        translate([ 50,-70,-1])cylinder(h=8,r=3,center=true,$fn=50);

        //space for powercable
        translate([0, 35,0])cube([40,10,100],center=true);
        translate([0,-35,0])cube([40,10,100],center=true);

        //-space for rpi 4b
        translate([-45,0,0])cube([10,60,100],center=true);
        translate([ 45,0,0])cube([10,60,100],center=true);

        //-hole for rpi 4b
        translate([-40+4,  49/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-40+4, -49/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-40+4+58,  49/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-40+4+58, -49/2,0])cylinder(100, r=1.6,center=true,$fn=50);

        //-hole for pi zero 2w
        translate([-58/2,  20+23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2,  20+23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-58/2,  20-23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2,  20-23/2,0])cylinder(100, r=1.6,center=true,$fn=50);

        //-hole for sense hat
        translate([-58/2, -20+23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2, -20+23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-58/2, -20-23/2,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 58/2, -20-23/2,0])cylinder(100, r=1.6,center=true,$fn=50);

    }
/*
    //left
    difference(){
        translate([-50, 0, -1])cube([20,40,2],center=true);
        translate([-50, 10,0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,  0,0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50,-10,0])cylinder(100, r=5,center=true,$fn=50);
    }
    //right
    difference(){
        translate([ 50, 0, -1])cube([20,40,2],center=true);
        translate([ 50, 10,0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,  0,0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50,-10,0])cylinder(100, r=5,center=true,$fn=50);
    }
*/
    //corner
    translate([ 60, 40,-8])bezier(8);
    translate([ 60,-40,-8])mirror([0,1,0])bezier(8);
    translate([-60, 40,-8])mirror([1,0,0])bezier(8);
    translate([-60,-40,-8])rotate([0,0,180])bezier(8);
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
    translate([0, 0, 1])cube([80, 80, 2],center=true);
    translate([0, 60, 1])cube([120, 40, 2],center=true);
    translate([0,-60, 1])cube([120, 40, 2],center=true);
    translate([-60, 0, 1])cube([40, 80, 2],center=true);
    translate([ 60, 0, 1])cube([40, 80, 2],center=true);
    }

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

    //battpack far
    translate([  30-2, 60-10,  1])cube([20, 16, 10],center=true);
    translate([  30-2, 60+10,  1])cube([20, 16, 10],center=true);
    translate([     0, 60-10,1.5])cube([40, 10, 1.01],center=true);
    translate([     0, 60+10,1.5])cube([40, 10, 1.01],center=true);
    translate([ -30+2, 60-10,  1])cube([20, 16, 10],center=true);
    translate([ -30+2, 60+10,  1])cube([20, 16, 10],center=true);
    //battpack near
    translate([  30-2,-60-10,  1])cube([20, 16, 10],center=true);
    translate([  30-2,-60+10,  1])cube([20, 16, 10],center=true);
    translate([     0,-60-10,1.5])cube([40, 10, 1.01],center=true);
    translate([     0,-60+10,1.5])cube([40, 10, 1.01],center=true);
    translate([ -30+2,-60-10,  1])cube([20, 16, 10],center=true);
    translate([ -30+2,-60+10,  1])cube([20, 16, 10],center=true);

    //-heng
    translate([0, 60, 1.91])cube([120,0.2,0.2],center=true);
    translate([0, 40, 1.91])cube([120,0.2,0.2],center=true);
    translate([0, 20, 1.91])cube([200,0.2,0.2],center=true);
    translate([0,  0, 1.91])cube([200,0.2,0.2],center=true);
    translate([0,-20, 1.91])cube([200,0.2,0.2],center=true);
    translate([0,-40, 1.91])cube([120,0.2,0.2],center=true);
    translate([0,-60, 1.91])cube([120,0.2,0.2],center=true);
    //-shu
    translate([ 60,0, 1.91])cube([0.2,80,0.2],center=true);
    translate([ 40,0, 1.91])cube([0.2,200,0.2],center=true);
    translate([ 20,0, 1.91])cube([0.2,200,0.2],center=true);
    translate([  0,0, 1.91])cube([0.2,200,0.2],center=true);
    translate([-20,0, 1.91])cube([0.2,200,0.2],center=true);
    translate([-40,0, 1.91])cube([0.2,200,0.2],center=true);
    translate([-60,0, 1.91])cube([0.2,80,0.2],center=true);
    }

    //corner
    translate([ 60, 40, 0])bezier(8.5);
    translate([ 60,-40, 0])mirror([0,1,0])bezier(8.5);
    translate([-60, 40, 0])mirror([1,0,0])bezier(8.5);
    translate([-60,-40, 0])rotate([0,0,180])bezier(8.5);
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
//top
color("#ff0000")top_top();
color("#ff0000")top_cam();
color("#ff0000")top_mic();
color("#ff0000")top_support();
color("#ff0000")top_bot();

//mid
mid_top();
mid_support();
mid_bot();

//bot
//color([0.7,0.2,0.9,0.8])bot_top();
color("#7f0000")translate([-20,0,-20+4])notprint_rpizero();
color("#7f0000")translate([ 20,0,-20+4])notprint_wavesharesensehat();
*/
translate([0,0,-20])bot_seperater_above();
//translate([0,0,-20])bot_seperater_below();
/*
translate([0,0,-20-4])rotate([0,180,0])notprint_l298n();
color([0.5,0.5,0,0.5])bot_motorseat();
color([0.5,0,0.5,0.8])bot_bot();

notprint_battery();
notprint_wheel();
*/


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

//bot_top();
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
//translate([0,0,-40])bot_bot();

//--------for test--------
//cam_mount();
//top_speaker();
//screwhelper();
//conn_xh254();
//kuangkuang(20,30,10);


//--------for delete--------
//special_support();
//special_back();
//zhuomian();
//special_zhicheng();
//rotate([-90,0,0])bot_power();