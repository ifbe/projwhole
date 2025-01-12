module kuangkuang(sizex, sizey, sizez){
    difference(){
    translate([0,0,sizez/2])cube([sizex+2,sizey+2,sizez],center=true);
    translate([0,0,sizez/2])cube([sizex+0.01,sizey+0.01,sizez+0.01],center=true);
    translate([0,0,sizez/2])cube([sizex-6+0.01,sizey+2.01,sizez+0.01],center=true);
    translate([0,0,sizez/2])cube([sizex+2.01,sizey-6+0.01,sizez+0.01],center=true);
    }
}

module addon(){
    difference(){
        cylinder(2, r=4.9,center=true,$fn=50);
        cylinder(2.01, r=2.5,center=true,$fn=50);
        translate([-2.5,-2.5,0])cube([5.1,5.1,2.01],center=true);
        translate([ 2.5, 2.5,0])cube([5.1,5.1,2.01],center=true);
    }
}
module conn(height,degree){
    difference(){
        cube([height,40,20],center=true);
        cube([height-4,36,22],center=true);
        //translate([0,0,1])cube([32,36,18.01],center=true);
        //translate([0,0,5])cube([20,41,10],center=true);
        translate([0, 10,0])rotate([0,90,0])cylinder(40.01, r=2.5,center=true,$fn=50);
        translate([0,-10,0])rotate([0,90,0])cylinder(40.01, r=2.5,center=true,$fn=50);
    }
    translate([-height/2-1, 10,0])rotate([0,90,0])rotate([0,0,degree])addon();
    translate([-height/2-1,-10,0])rotate([0,90,0])rotate([0,0,degree])addon();
    translate([ height/2+1, 10,0])rotate([0,90,0])rotate([0,0,degree])addon();
    translate([ height/2+1,-10,0])rotate([0,90,0])rotate([0,0,degree])addon();
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
module conn_ear(){
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

    //speaker
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

module top_support_speaker(){
    difference(){
    union(){
    translate([-50, 30,60])cube([20,20,32-0.6],center=true);
    translate([-50, 30,60])cube([1.8,20,36],center=true);
    }
//
    translate([-50-5, 30,60])cube([8,21,30],center=true);
    translate([-50-5, 30,60])cube([10,21,24],center=true);
//
    translate([-50  , 30,60])cube([16,6,32],center=true);
//
    translate([-50+5, 30,60])cube([8,21,30],center=true);
    translate([-50+5, 30,60])cube([10,21,24],center=true);
    }
}
module top_support_one(){
    difference(){
        conn(36,45);
        //translate([0,0,6])cube([40,24,2],center=true);
    }
    //speaker
    difference(){
        translate([0, 30,0])cube([36,20,20],center=true);
        translate([0, 30,0])cube([40,24,2],center=true);
        translate([0, 30,0])cube([32,20,31],center=true);
    }
    //micphone
    difference(){
    translate([0,-30,0])cube([36,20,20],center=true);
    translate([0,-30,0])cube([40,24,2],center=true);
    translate([0,-30,0])cube([28,20,31],center=true);
    }
}
module top_support(){
    top_support_speaker();
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
    translate([-50, 10,0])cylinder(100, r=5,center=true,$fn=50);
    translate([ 50,-10,0])cylinder(100, r=5,center=true,$fn=50);
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
    translate([0, 0,0])cube([24,120,8],center=true);
    cube([26,70,20],center=true);

    //shaft hole
    translate([0, 60,0])cylinder(20, r=4,center=true,$fn=50);
    translate([0,-60,0])cylinder(20, r=4,center=true,$fn=50);

    //shaft hole
    translate([0, 60-11.5,0])cylinder(20, r=2.2,center=true,$fn=50);
    translate([0,-60+11.5,0])cylinder(20, r=2.2,center=true,$fn=50);

    //screw hole
    translate([-8.6, 60-21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([ 8.6, 60-21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([-8.6,-60+21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([ 8.6,-60+21,0])cylinder(20, r=1.6,center=true,$fn=50);
}
}

module notprint_battery(){
    translate([ 0,40,20])cube([78,40,40],center=true);
}
module notprint_battery2(){
    translate([ 0,-40,20])cube([78,40,40],center=true);
}
module notprint_l298n(){
    translate([ 0,-20,10])cube([60,80,14],center=true);
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

    translate([-40+16,0,-20])rotate([0,90,0])motorseat();

    translate([-30, -40, -40+2+3])bot_seat_helper();
    translate([-30,  40, -40+2+3])bot_seat_helper();
}
module bot_seat_right(){
    translate([ 30,  40, -2-3])bot_seat_helper();
    translate([ 30, -40, -2-3])bot_seat_helper();

    translate([ 40-16,0,-20])rotate([0,90,0])motorseat();

    translate([ 30,  40, -40+2+3])bot_seat_helper();
    translate([ 30, -40, -40+2+3])bot_seat_helper();
}
module bot_seat(){
    difference(){
        union(){
            bot_seat_left();
            bot_seat_right();
        }
        translate([0,0,-30])cube([66,66,20],center=true);
    }
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
        //hole,near
        translate([-30,-30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-30,-50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-10,-30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-10,-50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 10,-30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 10,-50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 30,-30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 30,-50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        //hole,front
        translate([-30, 30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-30, 50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-10, 30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([-10, 50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 10, 30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 10, 50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 30, 30,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        translate([ 30, 50,-3])cylinder(h=2,r=4.9,center=true,$fn=50);
        }
        //hole.near
        translate([-30,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-10,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-10,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 10,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 10,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30,-50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30,-30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30,-50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole,lf
        translate([-30, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-30, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-30, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-10, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([-10, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([-10, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 10, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 10, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 10, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 30,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30, 50,-1+0.01])cylinder(h=2,r=3,center=true,$fn=50);
        translate([ 30, 30,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        translate([ 30, 50,-2])cylinder(h=5,r=1.6,center=true,$fn=50);
        //hole
        //hole.batt
        translate([0,-40, 0])cube([40,10,10],center=true,$fn=50);
        translate([0, 40, 0])cube([40,10,10],center=true,$fn=50);
        //hole,middle
        translate([0, 0, -1])cube([70,30,10],center=true);
        translate([-40+5/2, 0,0])cube([5.2,30,30],center=true,$fn=50);
        translate([ 40-5/2, 0,0])cube([5.2,30,30],center=true,$fn=50);
        translate([0, 20-2.5,0])cube([40,5.2,30],center=true,$fn=50);
        translate([0,-20+2.5,0])cube([40,5.2,30],center=true,$fn=50);
    }

    //below battery
    difference(){
        union(){
        translate([0, -40, -5])cube([40,40,6],center=true);
        translate([0,  40, -5])cube([40,40,6],center=true);
        }
        translate([0, -40, -5])cube([36,36,6.01],center=true);
        translate([0,  40, -5])cube([36,36,6.01],center=true);
    }

    //left
    difference(){
        translate([-50, 0, -1])cube([20,40,2],center=true);
        translate([-50,-10,0])cylinder(100, r=5,center=true,$fn=50);
        translate([-50, 10,0])cylinder(100, r=5,center=true,$fn=50);
    }
    //right
    difference(){
        translate([ 50, 0, -1])cube([20,40,2],center=true);
        translate([ 50,-10,0])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50, 10,0])cylinder(100, r=5,center=true,$fn=50);
    }

    //corner
    translate([ 40, 20,-8])bezier(8);
    translate([ 40,-20,-8])mirror([0,1,0])bezier(8);
    translate([-40, 20,-8])mirror([1,0,0])bezier(8);
    translate([-40,-20,-8])rotate([0,0,180])bezier(8);
}

module special_board_highhalf_30to40()
{
    //10 to 20
    //translate([0,0,35])cube([40, 40, 10],center=true);
    translate([0, 20-5,40-0.5])cube([40, 10, 1],center=true);
    translate([0, 20-0.5,  35])cube([40, 1, 10],center=true);
    difference(){
    //.bot@20
    translate([0, 20-3,30+0.5])cube([40, 6, 1],center=true);
    //connector
    translate([0, 20-3,31])cube([4, 4, 3],center=true);
    }

    translate([0,-20+5,40-0.5])cube([40, 10, 1],center=true);
    translate([0,-20+0.5,  35])cube([40, 1, 10],center=true);
    difference(){
    //.bot@-20
    translate([0,-20+3,30+0.5])cube([40, 6, 1],center=true);
    //connector
    translate([0,-20+3,31])cube([4, 4, 3],center=true);
    }

    translate([-15, 0,34])kuangkuang(28,20, 6);
    translate([-15, 10+0.5,37])cube([30, 1, 6],center=true);
    translate([-15,-10-0.5,37])cube([30, 1, 6],center=true);
    translate([-15, 0,34+0.5])cube([30, 20, 1],center=true);
}

module special_board_highhalf_20to30()
{
    //connector
    translate([0, 20-3,31])cube([4-0.2, 4-0.2, 3],center=true);
    translate([0,-20+3,31])cube([4-0.2, 4-0.2, 3],center=true);

    //@-20
    translate([0,-20+3,30-0.5])cube([60, 6, 1],center=true);
    difference(){
        translate([0,-20+0.5,25])cube([60, 1, 10],center=true);
    }
    //translate([0,-20+4,20+0.5])cube([60, 8, 1],center=true);

    //@20
    translate([0, 20-3,30-0.5])cube([60, 6, 1],center=true);
    difference(){
        translate([0, 20-0.5,25])cube([60, 1, 10],center=true);
    }
    //translate([0, 20-3,20+0.5])cube([60, 6, 1],center=true);

    //power board
    translate([ 0,0,20])kuangkuang(23*2.54,11*2.54,10);
    difference(){
    translate([0, 0,20+0.5])cube([60, 40, 1],center=true);
    translate([0, 0,20+0.5])cube([40, 30, 1.01],center=true);
    //translate([0, 0,20+0.5])cube([10, 40, 1.01],center=true);
    //connector
    translate([-20+2,-20+3,21])cube([4, 4, 3],center=true);
    translate([ 20-2,-20+3,21])cube([4, 4, 3],center=true);
    translate([-20+2, 20-3,21])cube([4, 4, 3],center=true);
    translate([ 20-2, 20-3,21])cube([4, 4, 3],center=true);
    }
/*
    //connector
    translate([-27.5, -20+3-0.8, 20-5])cube([5, 1.6, 10],center=true);
    translate([-27.5, -20+1, 20-6])rotate([90,0,0])cylinder(2, r=2.4,center=true,$fn=50);
    translate([ 27.5, -20+3-0.8, 20-5])cube([5, 1.6, 10],center=true);
    translate([ 27.5, -20+1, 20-6])rotate([90,0,0])cylinder(2, r=2.4,center=true,$fn=50);
    translate([-27.5,  20-3+0.8, 20-5])cube([5, 1.6, 10],center=true);
    translate([-27.5,  20-1, 20-6])rotate([90,0,0])cylinder(2, r=2.4,center=true,$fn=50);
    translate([ 27.5,  20-3+0.8, 20-5])cube([5, 1.6, 10],center=true);
    translate([ 27.5,  20-1, 20-6])rotate([90,0,0])cylinder(2, r=2.4,center=true,$fn=50);
*/
}

module special_board_highhalf()
{
    //30,40
    translate([-15, 9,30])kuangkuang(28,20, 10);
    difference(){
    translate([-15, 9, 30+0.5])cube([30, 22, 1],center=true);
    }

    //back
    translate([-15, 20-0.5, 20+5])cube([30, 1, 10],center=true);

    //[20,30]
    translate([ 0,5,20])kuangkuang(23*2.54,11*2.54,10);
    difference(){
    translate([0, 0, 20+0.5])cube([80, 40, 1],center=true);
    translate([-35, 0, 20+0.5])cube([10, 20, 2],center=true);
    translate([ 35, 0, 20+0.5])cube([10, 20, 2],center=true);
        //
    translate([0, 0, 20+0.5])cube([50, 20, 2],center=true);
    translate([0, -12, 20+0.5])cube([50, 10, 2],center=true);
    //connector
    translate([-20+2,-20+3,21])cube([4, 4, 3],center=true);
    translate([ 20-2,-20+3,21])cube([4, 4, 3],center=true);
    translate([-20+2, 20-3,21])cube([4, 4, 3],center=true);
    translate([ 20-2, 20-3,21])cube([4, 4, 3],center=true);
    }
}
module special_board_lowhalf()
{/*
    //connector top
    difference(){
    translate([0,-20+1,20])cube([10,2,10],center=true);
    translate([0,-20+1,20])cube([8,3,8],center=true);
    }
    difference(){
    translate([0, 20-1,20])cube([10,2,10],center=true);
    translate([0, 20-1,20])cube([8,3,8],center=true);
    }
    */
    translate([-15,-20+2.5,20-0.5])cube([10, 5, 1],center=true);
    translate([ 15,-20+2.5,20-0.5])cube([10, 5, 1],center=true);
    translate([-20+2,-20+3,21])cube([4-0.2, 4-0.2, 2],center=true);
    translate([ 20-2,-20+3,21])cube([4-0.2, 4-0.2, 2],center=true);

    translate([-15, 20-2.5,20-0.5])cube([10, 5, 1],center=true);
    translate([ 15, 20-2.5,20-0.5])cube([10, 5, 1],center=true);
    translate([-20+2, 20-3,21])cube([4-0.2, 4-0.2, 2],center=true);
    translate([ 20-2, 20-3,21])cube([4-0.2, 4-0.2, 2],center=true);

    //[10,20]
    translate([-20+2.5, 20-5,10-0.5])cube([25, 10, 1],center=true);
    translate([ 20-2.5, 20-5,10-0.5])cube([25, 10, 1],center=true);
    //translate([-30+1, 20-5,20-0.5])cube([2, 10, 1],center=true);
    //translate([ 30-1, 20-5,20-0.5])cube([2, 10, 1],center=true);
    difference(){
        translate([0, 20-5,10])cube([80, 10, 20],center=true);
        translate([0, 20-5,10.5])cube([78, 8, 19.01],center=true);
        //
        translate([-40, 20-5,15])cube([3, 6, 6],center=true);
        translate([ 40, 20-5,15])cube([3, 6, 6],center=true);
        translate([-40, 20-5,10])cube([3, 2, 6],center=true);
        translate([ 40, 20-5,10])cube([3, 2, 6],center=true);
        translate([-40, 20-5,5])cube([3, 8, 8],center=true);
        translate([ 40, 20-5,5])cube([3, 8, 8],center=true);
        //-battery
        translate([0, 20,15])cube([10, 3, 10],center=true);
        //
        translate([0, 20-10,15])cube([60, 2.01, 10.01],center=true);
        //
        translate([-27.5,  20, 20-6])rotate([90,0,0])cylinder(14*2, r=2.5,center=true,$fn=50);
        translate([ 27.5,  20, 20-6])rotate([90,0,0])cylinder(14*2, r=2.5,center=true,$fn=50);
    }

    //[-10,10]
    union(){
        translate([-40+6, 0, 5])cube([2, 20, 10],center=true);
        translate([ 40-6, 0, 5])cube([2, 20, 10],center=true);
    }

    //[-10,10].[6,10]
    //translate([0, 20-12,5])cube([80, 4, 10],center=true);

    //[-10,10].[0,6]:298n
    difference(){
        union(){
        translate([-40+6, 3, 15])cube([2, 6, 10],center=true);
        translate([ 40-6, 3, 15])cube([2, 6, 10],center=true);
        translate([-40+10, 5, 15])cube([10, 2, 10],center=true);
        translate([ 40-10, 5, 15])cube([10, 2, 10],center=true);
        translate([-40+10, 1, 15])cube([10, 2, 10],center=true);
        translate([ 40-10, 1, 15])cube([10, 2, 10],center=true);
        }
        //holes
        translate([-27.5, 3, 20-6])rotate([90,0,0])cylinder(8, r=1.6,center=true,$fn=50);
        translate([ 27.5, 3, 20-6])rotate([90,0,0])cylinder(8, r=1.6,center=true,$fn=50);
    }

    //[-10,10].[-10,0]

    //[-20,-10]
    translate([-20+2.5,-20+5,10-0.5])cube([25, 10, 1],center=true);
    translate([ 20-2.5,-20+5,10-0.5])cube([25, 10, 1],center=true);
    //translate([-30+1, -20+5,20-0.5])cube([2, 10, 1],center=true);
    //translate([ 30-1, -20+5,20-0.5])cube([2, 10, 1],center=true);
    difference(){
        translate([0,-20+5,10])cube([80, 10, 20],center=true);
        translate([0,-20+5,10.5])cube([78, 8, 19.01],center=true);
        //
        translate([-40, -20+5,15])cube([3, 6, 6],center=true);
        translate([ 40, -20+5,15])cube([3, 6, 6],center=true);
        translate([-40, -20+5,10])cube([3, 2, 6],center=true);
        translate([ 40, -20+5,10])cube([3, 2, 6],center=true);
        translate([-40, -20+5,5])cube([3, 8, 8],center=true);
        translate([ 40, -20+5,5])cube([3, 8, 8],center=true);
        //-battery
        translate([0,-20,15])cube([10, 3, 10],center=true);
        //l298.signal
        translate([0,-20+10,15])cube([60, 2.01, 10.01],center=true);
        //
        translate([-8, -20+9, 0])rotate([90,0,0])cylinder(2, r=5,center=true,$fn=50);
        translate([ 8, -20+9, 0])rotate([90,0,0])cylinder(2, r=5,center=true,$fn=50);
        translate([-27.5, -20, 20-6])rotate([90,0,0])cylinder(2*10, r=2.5,center=true,$fn=50);
        translate([ 27.5, -20, 20-6])rotate([90,0,0])cylinder(2*10, r=2.5,center=true,$fn=50);
    }

    //connector bot
    translate([0,-20+2,-2])cube([39.8,4,4],center=true);
    translate([0, 20-2,-2])cube([39.8,4,4],center=true);
}
module special_board()
{
    //special_board_highhalf_30to40();
    //special_board_highhalf_20to30();
    special_board_highhalf();
    //special_board_lowhalf();
}

module bot_bot_mid()
{
    difference(){
    union(){
    //+baseboard
    translate([0, 0, 1])cube([80, 120, 2],center=true);
/*
    //+xt60+xh254
    //translate([0,-50, 5])cube([40, 20, 10],center=true);

    //+l298n
    translate([-29/2, -4, 25/2])cube([11, 6, 25],center=true);
    translate([ 29/2, -4, 25/2])cube([11, 6, 25],center=true);
    translate([-29/2, -5, 5])cube([11, 10, 10],center=true);
    translate([ 29/2, -5, 5])cube([11, 10, 10],center=true);
*/
    //+l298n
    //translate([-29/2, 20-23/2, 2])cube([11, 23, 4],center=true);
    //translate([    0, 20-23/2, 2])cube([4, 23, 4],center=true);
    //translate([ 29/2, 20-23/2, 2])cube([11, 23, 4],center=true);

    //hole,near
    translate([-30,-30,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([-30,-50,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([ 30,-30,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([ 30,-50,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    //hole,front
    translate([-30, 30,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([-30, 50,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([ 30, 30,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    translate([ 30, 50,3])cylinder(h=2,r=4.9,center=true,$fn=50);
    }

    //-heng
    translate([0, 40, 1.91])cube([80,0.2,0.2],center=true);
    translate([0, 20, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,  0, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,-20, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,-40, 1.91])cube([80,0.2,0.2],center=true);
    //heng
    translate([0, 40, 1.91])cube([80,0.2,0.2],center=true);
    translate([0, 20, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,  0, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,-20, 1.91])cube([80,0.2,0.2],center=true);
    translate([0,-40, 1.91])cube([80,0.2,0.2],center=true);
    //-shu
    translate([ 20,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([  0,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([-20,0, 1.91])cube([0.2,120,0.2],center=true);
    //shu
    translate([ 40,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([ 20,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([  0,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([-20,0, 1.91])cube([0.2,120,0.2],center=true);
    translate([-40,0, 1.91])cube([0.2,120,0.2],center=true);

    //-baseboard
    //translate([0, 0, 0])cube([10, 40, 36],center=true);

    //-l298n
    translate([-27.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-14.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5, 65/2-5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-27.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 27.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-14.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 14.5,-65/2+5,-10])cylinder(100, r=1.6,center=true,$fn=50);

    //-holes
    translate([-30, 50,1])cylinder(h=2,r=3,center=true,$fn=50);
    translate([ 30, 50,1])cylinder(h=2,r=3,center=true,$fn=50);
    //translate([-30, 30,1])cylinder(h=2,r=3,center=true,$fn=50);
    //translate([ 30, 30,1])cylinder(h=2,r=3,center=true,$fn=50);
    //translate([-30,-30,1])cylinder(h=2,r=3,center=true,$fn=50);
    //translate([ 30,-30,1])cylinder(h=2,r=3,center=true,$fn=50);
    translate([-30,-50,1])cylinder(h=2,r=3,center=true,$fn=50);
    translate([ 30,-50,1])cylinder(h=2,r=3,center=true,$fn=50);

    //hole,far
    translate([-30,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    //hole,near
    translate([-30, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    //-xt60
    //translate([-10,-40-2.5, 5+0.5])cube([13,5.01,9.01],center=true);
    //translate([-10,-40-10, 5+0.5])cube([16.4,16.4,9.01],center=true);
    //translate([-10,-40-20+2.5, 5+0.5])cube([14,5.01,9.01],center=true);
/*
    //-xh254.chargerside
    translate([-10,-40-10+0.5, 5+0.5])cube([12.4,19,9.01],center=true);
    translate([-10,-40-20+0.5, 5+0.5])cube([9,1.01,9.01],center=true);

    //-xh254.batteryside
    translate([ 10,-40-3/2, 5+2])cube([7,3.01,6.01],center=true);
    translate([ 10,-40-10, 5+1])cube([8.8,15,8.01],center=true);
    translate([ 10,-40-10-15/2+7/2, 5+1])cube([10.8,7.01,8.01],center=true);
    translate([ 10,-40-10-15/2-0.5, 5+1])cube([8.8,1,8.01],center=true);
    translate([ 10,-40-19.01, 5+0.4])cube([13,2,9.21],center=true);
*/
    }
}
module bot_bot(){
    difference(){
    translate([0,0,-40])bot_bot_mid();
    translate([0,0,-40+2.51])cube([66,66,3],center=true);
    }

    //left
    difference(){
        union(){
        translate([-50, 0, -40+1])cube([20,40,2],center=true);
        }
        translate([-50,-10,-40])cylinder(100, r=5,center=true,$fn=50);
        translate([-50, 10,-40])cylinder(100, r=5,center=true,$fn=50);
    }
    //right
    difference(){
        union(){
        translate([ 50, 0, -40+1])cube([20,40,2],center=true);
        }
        translate([ 50,-10,-40])cylinder(100, r=5,center=true,$fn=50);
        translate([ 50, 10,-40])cylinder(100, r=5,center=true,$fn=50);
    }

    //corner
    translate([ 40, 20,-40])bezier(8);
    translate([ 40,-20,-40])mirror([0,1,0])bezier(8);
    translate([-40, 20,-40])mirror([1,0,0])bezier(8);
    translate([-40,-20,-40])rotate([0,0,180])bezier(8);
}

module temp2(){
/*
    //bulk
    difference(){
    translate([-25, 5, 30])cube([30, 22, 8],center=true);
    translate([-25, 5, 30])cube([40, 20, 6],center=true);
    translate([-25, 5, 35])cube([40, 2, 6],center=true);
    }
*/
    //power wire
    difference(){
    translate([0, 5, 30])cube([60, 30, 20],center=true);
    translate([0, 5, 30])cube([70, 28, 18.01],center=true);
    //
    translate([0, 0, 25+0.5])cube([20, 20, 9],center=true);
    }

    //80x40x30
    //translate([0, -15, 25])cube([10, 10, 10],center=true);
    difference(){
    translate([0, -15, 30])cube([60, 10, 20],center=true);
    translate([0, -15+0.5, 30])cube([48, 9.01, 21],center=true);
    translate([0, -15+0.5, 30])cube([61, 9.01, 18],center=true);
    }
    difference(){
    translate([0, 0, 15])cube([80, 40, 10],center=true);
    translate([0, 0, 25-0.5])cube([90, 38, 29.01],center=true);
    //leftright
    translate([-35, 0, 30])cube([10.01, 40.01, 20.01],center=true);
    translate([ 35, 0, 30])cube([10.01, 40.01, 20.01],center=true);
    //batt
    translate([0, 20-5, 15])cube([10, 10.01, 10.01],center=true);
    translate([0,-20+5, 15])cube([10, 10.01, 10.01],center=true);
    //bot
    //translate([0, 0, 10])cube([80, 20, 4],center=true);
    }

    //l298n
    translate([-40+7.5, 3, 20.5])cube([5, 6, 1],center=true);
    translate([ 40-7.5, 3, 20.5])cube([5, 6, 1],center=true);
    difference(){
        union(){
        translate([-40+6, 3, 15])cube([2, 6, 10],center=true);
        translate([ 40-6, 3, 15])cube([2, 6, 10],center=true);
        translate([-40+10, 5, 15])cube([10, 2, 10],center=true);
        translate([ 40-10, 5, 15])cube([10, 2, 10],center=true);
        translate([-40+10, 1, 15])cube([10, 2, 10],center=true);
        translate([ 40-10, 1, 15])cube([10, 2, 10],center=true);
        }
        //holes
        translate([-27.5, 3, 20-6])rotate([90,0,0])cylinder(8, r=1.6,center=true,$fn=50);
        translate([ 27.5, 3, 20-6])rotate([90,0,0])cylinder(8, r=1.6,center=true,$fn=50);
    }

    //bot
    translate([-34, 3, 5])cube([2, 6, 10],center=true);
    translate([ 34, 3, 5])cube([2, 6, 10],center=true);
    difference(){
    translate([0, 0, 5])cube([80, 40, 10],center=true);
    translate([0, 0, 5])cube([66, 20, 10.01],center=true);
    //leftright
    translate([-35, 0, 5.5])cube([10.01, 38, 9.01],center=true);
    translate([ 35, 0, 5.5])cube([10.01, 38, 9.01],center=true);
    //batt wire
    translate([0,-20+5, 5])cube([81, 8, 8.01],center=true);
    translate([0, 20-5, 5])cube([81, 8, 8.01],center=true);
    //batt
    translate([0,-20+2.5, 5])cube([8, 5.01, 10.01],center=true);
    translate([0, 20-2.5, 5])cube([8, 5.01, 10.01],center=true);
    //
    translate([-(8+24)/2,-20+5.5, 5])cube([24-8, 9, 11],center=true);
    translate([ (8+24)/2,-20+5.5, 5])cube([24-8, 9, 11],center=true);
    translate([-8, -20+9, 0])rotate([90,0,0])cylinder(2, r=5,center=true,$fn=50);
    translate([ 8, -20+9, 0])rotate([90,0,0])cylinder(2, r=5,center=true,$fn=50);
    /*
    translate([-27.5, -20, 20-6])rotate([90,0,0])cylinder(2*10, r=2.5,center=true,$fn=50);
    translate([ 27.5, -20, 20-6])rotate([90,0,0])cylinder(2*10, r=2.5,center=true,$fn=50);
    */
    }
}
module temp(){
    difference(){
    translate([0, 0, 20])cube([80, 40, 40],center=true);
    //mid top,center
    translate([0,   0, 30])cube([41, 16, 20.01],center=true);
    translate([0,   0, 10.5])cube([41, 16, 19],center=true);
    //mid near,far
    translate([0,  14, 20])cube([41, 10, 38],center=true);
    translate([0, -14, 20])cube([41, 10, 38],center=true);
    //n,f batt
    translate([0,-20, 20])cube([10, 10, 40],center=true);
    translate([0, 20, 20])cube([10, 10, 40],center=true);
    //l,r vertical
    translate([-40, 0, 20])cube([4, 30, 30],center=true);
    translate([ 40, 0, 20])cube([4, 30, 30],center=true);
    //l,r edge
    translate([-30+0.5, 0, 20])cube([19, 38, 50],center=true);
    translate([ 30-0.5, 0, 20])cube([19, 38, 50],center=true);
    //bot
    translate([ 0, 0, 0])cube([10, 16, 15],center=true);
    }
    difference(){
    translate([0, 0, 10])cube([60, 18, 20],center=true);
    translate([0, 0, 10.51])cube([58, 16, 19],center=true);
    translate([ 0, 0, 0])cube([10, 16, 15],center=true);
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
//top
color("#ff0000")top_top();
color("#ff0000")top_cam();
color("#ff0000")top_mic();
color("#ff0000")top_support();
color("#ff0000")top_bot();

//mid
color("#00ffff")special_board();
//notprint_battery();
//notprint_battery2();
color([0.0,0.9,0.9,0.8])mid_kuang_right();
color("#00ff00")mid_kuang_left();

//bot
color("#ffff00")bot_top();
color([0.5,0.5,0,0.9])bot_support();
color([0.5,0.5,0,0.5])bot_seat();
color([0.5,0,0.5,0.8])bot_bot();
//notprint_wheel();
*/


//--------for print--------
//rotate([-180,0,0])top_top();
//rotate([-90,0,0])cam_mount();
//rotate([0,-90,0])top_speaker_l();
//top_mic();
top_support_speaker();
//top_support_one();
//top_bot();

//mid_kuang_left();
//mid_kuang_right();
//special_board_lowhalf();
//temp();

//mirror([0,0,1])bot_top();

//conn_motor();
//rotate([0,90,0])bot_seat_left();
/*
difference(){
    bot_seat();
    translate([100,0,0])cube([200,200,100],center=true);
}
*/
//bot_bot();


//--------for test--------
//cam_mount();
//top_speaker();
//screwhelper();
//screwhelper();
//conn_xh254();
//kuangkuang(20,30,10);


//--------for delete--------
//special_support();
//special_back();
//zhuomian();
//special_zhicheng();
//rotate([90,0,0])bot_l298n();
//rotate([-90,0,0])bot_power();
