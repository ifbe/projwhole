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

module top_support_one(){
    translate([0, 0, 20-2/2])cube([9.96, 9.96, 2],center=true);

    difference(){
    union(){
    translate([0, 0, 0])cube([20,20,36],center=true);
    translate([0, 0, 0])cube([10,26,36],center=true);
    }
    translate([0, 0, 0])cube([1.8,24,40],center=true);
    translate([0, 0, 0])cube([99,20,28],center=true);
    }

    translate([0, 0,-20+2/2])cube([9.96, 9.96, 2],center=true);
}
module top_support_speaker(){
    translate([0, 0, 20-2/2])cube([9.96, 9.96, 2],center=true);

    difference(){
    union(){
    translate([0, 0, 0])cube([20,20,36],center=true);
    translate([5, 0, 0])cube([10,24,36],center=true);
    }
    //left
    translate([0-5, 0, 0])cube([8,18,34],center=true);
    translate([0-5, 0, 0])cube([2,99,20],center=true);
    //mid
    //translate([0, 0, 0])cube([2.0,21,24],center=true);
    translate([0  , 0, 0])cube([16,6,99],center=true);
    //right
    translate([0+5, 0, 0])cube([8,21,30],center=true);
    translate([0+6, 0, 0])cube([10,21,24],center=true);
    }

    translate([0, 0,-20+2/2])cube([9.96, 9.96, 2],center=true);
}
module top_support(){
    translate([-50, 20, 60])top_support_one();
    translate([ 50, 20, 60])top_support_one();

    translate([-50,-20, 60])top_support_speaker();
    translate([ 50,-20, 60])top_support_speaker();
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
translate([-30,0,120])mirror([0,0,1])cam_mount();
translate([ 30,0,120])mirror([0,0,1])cam_mount();
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

module bezier(h){
linear_extrude(height=h)polygon([
    for(t=[0:0.1:1.0])    [20*t*t, 40*(1-t)*(1-t)],
    [0, 0]
    ]);
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


module screwhelper(rout, rin, height)
{
    difference(){
        translate([0,0,height/2])cylinder(height, r=rout,center=true,$fn=50);
        translate([0,0,height/2])cylinder(height+0.01, r=rin,center=true,$fn=50);
    }
}

module rpi_popup_add()
{
    //40+58/2
    translate([ 24.5,    58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 24.5-23, 58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-24.5,    58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 15+23/2, 58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 15-23/2, 58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-15+23/2, 58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-15-23/2, 58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    //40-58/2
    translate([ 24.5,   -58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 24.5-23,-58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-24.5,   -58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 15+23/2,-58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([ 15-23/2,-58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-15+23/2,-58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
    translate([-15-23/2,-58/2, 2+2/2])cylinder(2, r=4,center=true,$fn=50);
}
module rpi_popup_sub_hole(){
    //40+58/2
    translate([ 24.5,    58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 24.5-23, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-24.5+23, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-24.5,    58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 15+23/2, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 15-23/2, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-15+23/2, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-15-23/2, 58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    //40-58/2
    translate([ 24.5,   -58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 24.5-23,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-24.5+23,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-24.5,   -58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 15+23/2,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([ 15-23/2,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-15+23/2,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
    translate([-15-23/2,-58/2, 2+2/2])cylinder(9, r=1.5,center=true,$fn=50);
}
module rpi_popup_sub_40pin(){
    //rpi 40pin @ 40
    translate([ 15+23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 49/2,    0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 15-23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 49/2-23, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-49/2+23, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-49/2,    0,0])cube([5.8,52-0.4,999],center=true);
    translate([-15+23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-15-23/2, 0,0])cube([5.8,52-0.4,999],center=true);
}
module rpi_popup()
{
    difference(){
        rpi_popup_add();
        rpi_popup_sub_hole();
        rpi_popup_sub_40pin();
    }
}
module rpi_popup2()
{
    difference(){
        union(){
        rotate([0,0,90])rpi_popup_add();
        rpi_popup_add();
        }
        rotate([0,0,90])rpi_popup_sub_hole();
        rotate([0,0,90])rpi_popup_sub_40pin();
        rpi_popup_sub_hole();
        rpi_popup_sub_40pin();
    }
}
module rpi_cut_hole()
{/*
    translate([ 51/2, 0+58/2, 2/2])cube([7,5.2,99],center=true);
    translate([    0, 0+58/2, 2/2])cube([12,5.2,99],center=true);
    translate([-51/2, 0+58/2, 2/2])cube([7,5.2,99],center=true);
    
    translate([ 51/2, 0-58/2, 2/2])cube([7,5.2,99],center=true);
    translate([    0, 0-58/2, 2/2])cube([12,5.2,99],center=true);
    translate([-51/2, 0-58/2, 2/2])cube([7,5.2,99],center=true);
   */
    //40+58/2
    translate([ 24.5,    58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 24.5-23, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-24.5+23, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-24.5,    58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 15+23/2, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 15-23/2, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-15+23/2, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-15-23/2, 58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    //40-58/2
    translate([ 24.5,   -58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 24.5-23,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-24.5+23,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-24.5,   -58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 15+23/2,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([ 15-23/2,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-15+23/2,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
    translate([-15-23/2,-58/2, 2+2/2])cylinder(99, r=2.8,center=true,$fn=50);
}
module rpi_cut_40pin(){
    //rpi 40pin @ 40
    translate([ 15+23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 49/2,    0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 15-23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([ 49/2-23, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-49/2+23, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-49/2,    0,0])cube([5.8,52-0.4,999],center=true);
    translate([-15+23/2, 0,0])cube([5.8,52-0.4,999],center=true);
    translate([-15-23/2, 0,0])cube([5.8,52-0.4,999],center=true);
}
module topsupport()
{
    difference(){
    union(){
    translate([ 30,      -60, 84-1.9/2])cube([ 20, 34, 1.9],center=true);
    translate([ 40-1.8/2,-60, 80      ])cube([1.8, 20,   5],center=true);
    translate([ 30,      -60, 76+1.9/2])cube([ 20, 34, 1.9],center=true);

    translate([ 40-1.8/2,-60, 60      ])cube([1.8, 34,  36],center=true);

    translate([ 30,      -60, 44-1.9/2])cube([ 20, 34, 1.9],center=true);
    translate([ 40-1.8/2,-60, 40      ])cube([1.8, 20,   5],center=true);
    translate([ 30,      -60, 36+1.9/2])cube([ 20, 34, 1.9],center=true);
    }
/*
    for(y=[-75:2:-45]){
        translate([ 20+14/2, y,  45])cube([14,0.2,10],center=true);
    }
*/
    translate([ 20+12/2, -60, 45])cube([12,40,10],center=true);
    translate([ 30,-60, 60])rotate([0,90,0])cylinder(999, r=5,center=true,$fn=50);

    }//difference
}
module top_locktop(){
    difference(){
    union(){
    translate([0, 0, -10/2])cube([15, 14, 10],center=true);
    translate([0, 0, -20])cube([14, 14, 20],center=true);
    }
    translate([0, 0, -20])cube([10.1, 10.1, 20.1],center=true);
    translate([0, 0, -20])rotate([90,0,0])cylinder(40, r=1.6,center=true,$fn=50);
    }
}
module top_lockbot(){
    difference(){
    union(){
    translate([0, 0, 20])cube([9.9, 9.9, 20],center=true);
    translate([0, 0, 10/2])cube([14, 14, 10],center=true);
    }
    translate([0,0,20])cylinder(40, r=1.6,center=true,$fn=50);
    translate([0,0,20])rotate([90,0,0])cylinder(40, r=1.6,center=true,$fn=50);
    translate([0,0,20])rotate([0,90,0])cylinder(40, r=1.6,center=true,$fn=50);
    }
}
module top_top(){
    //translate([0, 40, 74])rpi_popup();
    translate([0,-40, 74])rpi_popup();

    difference(){
    union(){
    translate([0, 0, 80-2/2])cube([160,120,2],center=true);
    translate([0, 0, 80-2/2])cube([120,160,2],center=true);
    translate([-30, 80-20/2, 78-2/2])cube([9.9, 9.9, 2],center=true);
    translate([ 30, 80-20/2, 78-2/2])cube([9.9, 9.9, 2],center=true);
    translate([-60, 60, 80-1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 60, 60, 80-1])cylinder(2, r=20,center=true,$fn=50);
    translate([-60,-60, 80-1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 60,-60, 80-1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 70, 0, 80])top_locktop();
    translate([-70, 0, 80])top_locktop();
    }

    //left
    translate([-70, 20, 2/2])cube([10,10,999],center=true);
    translate([-70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-70,-20, 2/2])cube([10,10,999],center=true);
    translate([-50, 20, 2/2])cube([10,10,999],center=true);
    translate([-50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-50,-20, 2/2])cube([10,10,999],center=true);
    //translate([-30, 20, 2/2])cube([10,10,999],center=true);
    //translate([-30,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    //translate([-30,-20, 2/2])cube([10,10,999],center=true);
    //right
    //translate([ 30, 20, 2/2])cube([10,10,999],center=true);
    //translate([ 30,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    //translate([ 30,-20, 2/2])cube([10,10,999],center=true);
    translate([ 50, 20, 2/2])cube([10,10,999],center=true);
    translate([ 50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 50,-20, 2/2])cube([10,10,999],center=true);
    translate([ 70, 20, 2/2])cube([10,10,999],center=true);
    translate([ 70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 70,-20, 2/2])cube([10,10,999],center=true);

    //rightfar
    //translate([ 50, 60, 80-2/2])cube([20,32,99],center=true);
    //translate([ 40-2/2, 60, 80-2/2])cube([2,20,99],center=true);
    translate([ 60, 60, 80-2/2])cylinder(h=99,r=10,center=true,$fn=50);
    //leftfar
    //translate([-50, 60, 80-2/2])cube([20,32,99],center=true);
    //translate([-40+2/2,  60, 80-2/2])cube([2,20,99],center=true);
    translate([-60, 60, 80-2/2])cylinder(h=99,r=10,center=true,$fn=50);
    //rightnear
    //translate([ 50, -60, 80-2/2])cube([20,32,99],center=true);
    //translate([ 40-2/2, -60, 80-2/2])cube([2,20,99],center=true);
    translate([ 60, -60, 80-2/2])cylinder(h=99,r=10,center=true,$fn=50);
    //leftnear
    //translate([-50, -60, 80-2/2])cube([20,32,99],center=true);
    //translate([-40+2/2, -60, 80-2/2])cube([2,20,99],center=true);
    translate([-60, -60, 80-2/2])cylinder(h=99,r=10,center=true,$fn=50);

    //camera hole
    translate([-30, 80-20/2, 80])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30, 80-20/2, 80])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 0, 30, 80-0.21-1.8/2])cube([80,60,1.8],center=true);

    translate([0,-40, 80])rpi_cut_hole();
    translate([ 0, -40, 80])rpi_popup_sub_hole();
    translate([ 0, -40, 80])cube([55,51.6,10],center=true);
    translate([ 0, -40, 80])cube([42,64,10],center=true);
    }

}

module top_bot(){
    translate([0, 40, 0])rpi_popup();
    translate([0,-40, 0])rpi_popup();

    difference(){
    union(){
    translate([0, 0, 2/2])cube([160,120,2],center=true);
    translate([0, 0, 2/2])cube([120,160,2],center=true);
    translate([-60, 60, 1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 60, 60, 1])cylinder(2, r=20,center=true,$fn=50);
    translate([-60,-60, 1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 60,-60, 1])cylinder(2, r=20,center=true,$fn=50);
    translate([ 70, 0, 0])top_lockbot();
    translate([-70, 0, 0])top_lockbot();
        
    //leftright
    //translate([-70,0,2+2/2])cube([24,84,2],center=true);
    }

    //center
    //translate([0,0,1.11])cube([40,40,1.8],center=true);
    //translate([-35,0,2/2])cube([10,50,3],center=true);
    //translate([ 35,0,2/2])cube([10,50,3],center=true);

    //left
    translate([-70, 20, 2/2])cube([10,10,999],center=true);
    translate([-70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-70,-20, 2/2])cube([10,10,999],center=true);
    translate([-50, 20, 2/2])cube([10,10,999],center=true);
    translate([-50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-50,-20, 2/2])cube([10,10,999],center=true);
    //
    translate([ 30,  0, 2/2])cylinder(h=999,r=3,center=true,$fn=50);
    translate([  0,  0, 2/2])cylinder(h=999,r=3,center=true,$fn=50);
    translate([-30,  0, 2/2])cylinder(h=999,r=3,center=true,$fn=50);
    //right
    translate([ 50, 20, 2/2])cube([10,10,999],center=true);
    translate([ 50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 50,-20, 2/2])cube([10,10,999],center=true);
    translate([ 70, 20, 2/2])cube([10,10,999],center=true);
    translate([ 70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 70,-20, 2/2])cube([10,10,999],center=true);
    //mid-left
    translate([-14,  4, 2/2])cylinder(h=999,r=4,center=true,$fn=50);
    translate([-14, -4, 2/2])cylinder(h=999,r=4,center=true,$fn=50);
    //mid-right
    translate([ 14,  4, 2/2])cylinder(h=999,r=4,center=true,$fn=50);
    translate([ 14, -4, 2/2])cylinder(h=999,r=4,center=true,$fn=50);
/*
    //hole @ 35
    translate([ 35,  35, 2/2])cylinder(h=99,r=3,center=true,$fn=50);
    translate([-35,  35, 2/2])cylinder(h=99,r=3,center=true,$fn=50);
    translate([ 35, -35, 2/2])cylinder(h=99,r=3,center=true,$fn=50);
    translate([-35, -35, 2/2])cylinder(h=99,r=3,center=true,$fn=50);
*/
    //translate([0, 40, 0])rotate([0,0,90])rpi_cut();
    translate([0, 40, 0])rpi_cut_hole();
    translate([0,-40, 0])rpi_cut_hole();
    translate([0, 40, 0])rpi_cut_40pin();
    translate([0,-40, 0])rpi_cut_40pin();

    //rightfar
    translate([ 50, 60, 2/2])cube([20,32,99],center=true);
    translate([ 40-2/2, 60, 2/2])cube([2,20,99],center=true);
    translate([ 60, 60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
    for(t=[-90:45:90]){
    translate([ 60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
    //leftfar
    translate([-50, 60, 2/2])cube([20,32,99],center=true);
    translate([-40+2/2, 60, 2/2])cube([2,20,99],center=true);
    translate([-60, 60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
    for(t=[90:45:270]){
    translate([-60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
    //rightnear
    translate([ 50, -60, 2/2])cube([20,32,99],center=true);
    translate([ 40-2/2, -60, 2/2])cube([2,20,99],center=true);
    translate([ 60, -60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
    for(t=[-90:45:90]){
    translate([ 60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
    //leftnear
    translate([-50, -60, 2/2])cube([20,32,99],center=true);
    translate([-40+2/2, -60, 2/2])cube([2,20,99],center=true);
    translate([-60, -60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
    for(t=[90:45:270]){
    translate([-60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }

}//difference
}

module mid_connect(){
    difference(){
    translate([30   , -60, -20])cube([20,22,8],center=true);
    translate([40-10, -60, -20])cube([20,24,4.2],center=true);
    }

    difference(){
    translate([50   , -60, -20])cube([20,40,8],center=true);
    translate([50   , -60, -20])cube([16,50,4],center=true);
    }
    
    difference(){
    translate([40   , -40-7/2, -20])cube([40,7,35.8],center=true);
    translate([40   , -40-7/2, -20])cube([36,8,32],center=true);
    translate([ 30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([40   , -80+7/2, -20])cube([40,7,35.8],center=true);
    translate([40   , -80+7/2, -20])cube([36,8,32],center=true);
    translate([ 30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
}
module mid_thattop(){
    difference(){
    translate([0, 0, -20/2])cube([14, 14, 20],center=true);
    translate([0, 0, -10-10/2])cube([10.1, 10.1, 10.1],center=true);
    translate([0,0, -10-10/2])rotate([90,0,0])cylinder(40, r=1.6,center=true,$fn=50);
    }
}
module mid_thatbot(){
    /*
    hull(){
    translate([0, 2/2, 20+10/2])cube([20,2,10],center=true);
    translate([0, 20/2, 20])cube([20,20,0.01],center=true);
    }
    */
    difference(){
    translate([0, 0, 20+10/2])cube([9.9, 9.9, 10],center=true);
    translate([0,0,20+10/2])cylinder(40, r=1.6,center=true,$fn=50);
    translate([0,0,20+10/2])rotate([90,0,0])cylinder(40, r=1.6,center=true,$fn=50);
    translate([0,0,20+10/2])rotate([0,90,0])cylinder(40, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([0, 0, 20/2])cube([20,40,20],center=true);
    translate([0, 0, 18/2])cube([99,26,18],center=true);
    cylinder(99, r=1.6,center=true,$fn=50);
    translate([0, 20-7/2, 0])cylinder(99, r=3.5,center=true,$fn=50);
    translate([0,-20+7/2, 0])cylinder(99, r=3.5,center=true,$fn=50);
    }
}
module mid_top(){
    difference(){
        union(){
        translate([0, 0, -1])cube([160,120,2],center=true);
        translate([0, 0, -1])cube([120,160,2],center=true);
        translate([ 60, 60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60, 60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([ 60,-60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60,-60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        //
        translate([ 30, 60,0])mid_thattop();
        translate([-30, 60,0])mid_thattop();
        translate([ 30,-60,0])mid_thattop();
        translate([-30,-60,0])mid_thattop();
        }
        //translate([0, 0, -1])cube([60,60,99],center=true);
        translate([0, 0, -1])cylinder(h=99,r=40,center=true,$fn=50);

        //xy.far
        translate([0, 60, -1])cylinder(h=99,r=5,center=true,$fn=50);
        for(y=[50:10:70]){
        for(x=[-30:10:30]){
        translate([x, y, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        }
        }
        //xy.near
        translate([0, -60, -1])cylinder(h=99,r=5,center=true,$fn=50);
        for(y=[-70:10:-50]){
        for(x=[-30:10:30]){
        translate([x, y, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        }
        }
        //xy.right
        translate([60, 0, -1])cylinder(h=99,r=5,center=true,$fn=50);
        for(y=[-30:10:30]){
        for(x=[50:10:70]){
        translate([x, y, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        }
        }
        //xy.left
        translate([-60, 0, -1])cylinder(h=99,r=5,center=true,$fn=50);
        for(y=[-30:10:30]){
        for(x=[-70:10:-50]){
        translate([x, y, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        }
        }
/*
        //@ 60
        translate([ 60, 60, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-60, 60, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([ 60,-60, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-60,-60, -1])cylinder(h=99,r=1.6,center=true,$fn=50);

        //@ 70
        translate([ 70, 70, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-70, 70, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([ 70,-70, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-70,-70, -1])cylinder(h=99,r=1.6,center=true,$fn=50);
*/     
    //left
    translate([-70, 20, 2/2])cube([10,10,999],center=true);
    translate([-70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-70,-20, 2/2])cube([10,10,999],center=true);
    translate([-50, 20, 2/2])cube([10,10,999],center=true);
    translate([-50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([-50,-20, 2/2])cube([10,10,999],center=true);
    //translate([-30, 20, 2/2])cube([10,10,999],center=true);
    //translate([-30,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    //translate([-30,-20, 2/2])cube([10,10,999],center=true);
    //right
    //translate([ 30, 20, 2/2])cube([10,10,999],center=true);
    //translate([ 30,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    //translate([ 30,-20, 2/2])cube([10,10,999],center=true);
    translate([ 50, 20, 2/2])cube([10,10,999],center=true);
    translate([ 50,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 50,-20, 2/2])cube([10,10,999],center=true);
    translate([ 70, 20, 2/2])cube([10,10,999],center=true);
    translate([ 70,  0, 2/2])cylinder(h=999,r=5,center=true,$fn=50);
    translate([ 70,-20, 2/2])cube([10,10,999],center=true);

        //rightfar
        //translate([ 40-2/2, 60, 2/2])cube([2,20,99],center=true);
        translate([ 50, 60, 2/2])cube([20,32,99],center=true);
        translate([ 60, 60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
        for(t=[-90:45:90]){
        translate([ 60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //leftfar
        //translate([-40+2/2, 60, 2/2])cube([2,20,99],center=true);
        translate([-50, 60, 2/2])cube([20,32,99],center=true);
        translate([-60, 60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
        for(t=[90:45:270]){
        translate([-60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //rightnear
        //translate([ 40-2/2, -60, 2/2])cube([2,20,99],center=true);
        translate([ 50, -60, 2/2])cube([20,32,99],center=true);
        translate([ 60, -60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
        for(t=[-90:45:90]){
        translate([ 60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //leftnear
        //translate([-40+2/2, -60, 2/2])cube([2,20,99],center=true);
        translate([-50, -60, 2/2])cube([20,32,99],center=true);
        translate([-60, -60, 2/2])cylinder(h=99,r=10,center=true,$fn=50);
        for(t=[90:45:270]){
        translate([-60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }

    }
/*
    //-motor
    difference(){
    union(){
    translate([-40+20/2,  60, -20/2])cube([20,26,20],center=true);
    translate([ 40-20/2,  60, -20/2])cube([20,26,20],center=true);
    translate([-40+20/2, -60, -20/2])cube([20,26,20],center=true);
    translate([ 40-20/2, -60, -20/2])cube([20,26,20],center=true);
    }
    //through x
    translate([-40+20/2,  60, -2-16/2])cube([22,23,16],center=true);
    translate([ 40-20/2,  60, -2-16/2])cube([22,23,16],center=true);
    translate([-40+20/2, -60, -2-16/2])cube([22,23,16],center=true);
    translate([ 40-20/2, -60, -2-16/2])cube([22,23,16],center=true);
    //through y
    translate([-40+20/2,  60, -20/2])cube([10,30,10],center=true);
    translate([ 40-20/2,  60, -20/2])cube([10,30,10],center=true);
    translate([-40+20/2, -60, -20/2])cube([10,30,10],center=true);
    translate([ 40-20/2, -60, -20/2])cube([10,30,10],center=true);
    //through z
    translate([-40+20/2,  60, -20/2])cube([10,20,22],center=true);
    translate([ 40-20/2,  60, -20/2])cube([10,20,22],center=true);
    translate([-40+20/2, -60, -20/2])cube([10,20,22],center=true);
    translate([ 40-20/2, -60, -20/2])cube([10,20,22],center=true);
    }
*/
}
module mid_bot(){
    //+l298n
    translate([-27.5, 65/2-5.3, 2])screwhelper(4, 1.6, 2);
    translate([ 27.5, 65/2-5.3, 2])screwhelper(4, 1.6, 2);
    translate([-14.5,-65/2+5.3, 2])screwhelper(4, 1.6, 2);
    translate([ 14.5,-65/2+5.3, 2])screwhelper(4, 1.6, 2);

    //mid
    difference(){
        union(){
        translate([0, 0, 1])cube([160,120,2],center=true);
        translate([0, 0, 1])cube([120,160,2],center=true);
        //4 corner
        translate([ 60, 60, 1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60, 60, 1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([ 60,-60, 1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60,-60, 1])cylinder(h=2,r=20,center=true,$fn=50);
        //
        translate([ 30, 60,0])mid_thatbot();
        translate([-30, 60,0])mid_thatbot();
        translate([ 30,-60,0])mid_thatbot();
        translate([-30,-60,0])mid_thatbot();
        }
        //center left
        translate([-60, 0, 1.11])cube([40, 80, 1.8],center=true);
        //center
        translate([0, 0, 1.11])cube([60, 40, 1.8],center=true);
        //center right
        translate([ 60, 0, 1.11])cube([40, 80, 1.8],center=true);
        
        //hole @ 35
        translate([ 35, 35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-35, 35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([ 35,-35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-35,-35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        //hole @ 60
        translate([ 60, 60, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-60, 60, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([ 60,-60, ])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-60,-60, ])cylinder(h=99,r=1.6,center=true,$fn=50);

        //batt cable
        translate([ 40,0, 0])cube([8, 8, 10],center=true);
        translate([-40,0, 0])cube([8, 8, 10],center=true);
        translate([0, 40, 0])cube([8, 8, 10],center=true);
        translate([0,-40, 0])cube([8, 8, 10],center=true);
        //l298n hole
        translate([-27.5, 65/2-5,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 27.5, 65/2-5,0])cylinder(100, r=3,center=true,$fn=50);
        translate([-14.5,-65/2+5,0])cylinder(100, r=3,center=true,$fn=50);
        translate([ 14.5,-65/2+5,0])cylinder(100, r=3,center=true,$fn=50);

        translate([0,-60, 0])cylinder(99, r=5,center=true,$fn=50);
        translate([0, 60, 0])cylinder(99, r=5,center=true,$fn=50);

        //hole,far
        translate([-10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([ 10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([-10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([ 10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([ 30,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([ 10,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([-10,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([-30,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        //hole,near
        translate([ 30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([ 10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([-10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([-30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
        translate([-10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([ 10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([-10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        translate([ 10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
        //-motor
        //motorhole leftfar
        translate([-30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30, 60, 0])cube([20,26,20],center=true);
        translate([-50, 60, 0])cube([20,32,40],center=true);
        translate([-60, 60, 0])cylinder(100, r=10,center=true,$fn=50);
        //leftfar
        for(t=[90:45:270]){
        translate([-60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //motorhole rightfar
        translate([ 30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30, 60, 0])cube([20,26,20],center=true);
        translate([ 50, 60, 0])cube([20,32,40],center=true);
        translate([ 60, 60, 0])cylinder(100, r=10,center=true,$fn=50);
        for(t=[-90:45:90]){
        translate([ 60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //motorhole leftnear
        translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([-30, -60, 0])cube([20,26,20],center=true);
        translate([-50, -60, 0])cube([20,32,40],center=true);
        translate([-60, -60, 0])cylinder(100, r=10,center=true,$fn=50);
        for(t=[90:45:270]){
        translate([-60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        //
        //motorhole rightnear
        translate([ 30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
        translate([ 30, -60, 0])cube([20,26,20],center=true);
        translate([ 50, -60, 0])cube([20,32,40],center=true);
        translate([ 60, -60, 0])cylinder(100, r=10,center=true,$fn=50);
        //rightnear
        for(t=[-90:45:90]){
        translate([ 60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        }
    }
}
module bot_lock(){
    //connect bot_bot left
    translate([-2/2, 0, 0-10/2])cube([1.9,20,10],center=true);
    translate([ 2/2, 0, 0-30/2])cube([1.9,20,30],center=true);
    //connect bot_bot
    translate([0,  20-10/2, 0-20/2])cube([4,10,20],center=true);
    translate([0, -20+10/2, 0-20/2])cube([4,10,20],center=true);
}
module bot_that(){
    difference(){
    hull(){
        translate([0, -20/2, 10])cube([20,20,20],center=true);
        translate([0, -20/2, 30])cylinder(h=20,r=10,center=true,$fn=50);
    }
    //-z
    translate([0, -20/2, 0])cylinder(h=999,r=8,center=true,$fn=50);
    //-x
    translate([-10, -2-6, 40-2-6])rotate([0,90,0])cylinder(h=10,r=5.8,center=true,$fn=50);
    translate([-10, -2-6, 40-2-6])rotate([0,90,0])cylinder(h=999,r=1.6,center=true,$fn=50);
    //-wheel
    translate([0, -40, 00])rotate([0,90,0])cylinder(h=999,r=38,center=true,$fn=50);
    }
}
module bot_top(){
    intersection(){
    union(){
    translate([-50, -20, -40])mirror([1,0,0])bot_that();
    translate([ 50, -20, -40])bot_that();
    mirror([0,1,0])translate([-50, -20, -40])mirror([1,0,0])bot_that();
    mirror([0,1,0])translate([ 50, -20, -40])bot_that();
    }
    translate([0, 0, -9.9])cube([120,160,20],center=true);
    }

    //mid
    difference(){
    union(){
        //main body
        translate([0, 0, -1])cube([120,160,2],center=true);
        translate([0, 0, -1])cube([168,120,2],center=true);
        //4 corner
        translate([ 60, 60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60, 60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([ 60,-60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        translate([-60,-60, -1])cylinder(h=2,r=20,center=true,$fn=50);
        //mid
        translate([0, 20+2/2, -20/2])cube([20, 2, 20],center=true);
        translate([0,      0, -20/2])cube([1.2, 40, 20],center=true);
        translate([0,-20-2/2, -20/2])cube([20, 2, 20],center=true);
        //left
        translate([-168/2+1.9/2, 0, -30/2])cube([1.9, 40, 30],center=true);
        translate([-168/2+4/2, 0, -10/2])cube([4, 40, 10],center=true);
        translate([-168/2+4/2,-20-2/2, -20/2])cube([4, 2, 20],center=true);
        translate([-168/2+4/2, 20+2/2, -20/2])cube([4, 2, 20],center=true);
        //right
        translate([168/2-1.9/2, 0, -30/2])cube([1.9, 40, 30],center=true);
        translate([168/2-4/2, 0, -10/2])cube([4, 40, 10],center=true);
        translate([168/2-4/2,-20-2/2, -20/2])cube([4, 2, 20],center=true);
        translate([168/2-4/2, 20+2/2, -20/2])cube([4, 2, 20],center=true);
    }
    //-connect bot_bot
    translate([0,0,-20])rotate([0,90,0])cylinder(999, r=1.6,center=true,$fn=50);
    //
    translate([ 80, 10, -30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80,-10, -30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80, 10, -10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80,-10, -10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80, 10, -30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80,-10, -30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80, 10, -10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80,-10, -10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    //to bot_bot
    translate([ 50, 30, 0])cylinder(999, r=10,center=true,$fn=50);
    translate([-50, 30, 0])cylinder(999, r=10,center=true,$fn=50);
    translate([ 50,-30, 0])cylinder(999, r=10,center=true,$fn=50);
    translate([-50,-30, 0])cylinder(999, r=10,center=true,$fn=50);
    //
    translate([ 70, 30, 0])cylinder(999, r=9,center=true,$fn=50);
    translate([ 70, 40, 0.1-40])bot_that();
    translate([-70, 30, 0])cylinder(999, r=9,center=true,$fn=50);
    translate([-70, 40, 0.1-40])bot_that();
    translate([ 70,-30, 0])cylinder(999, r=9,center=true,$fn=50);
    translate([ 70,-20, 0.1-40])bot_that();
    translate([-70,-30, 0])cylinder(999, r=9,center=true,$fn=50);
    translate([-70,-20, 0.1-40])bot_that();
    //battpack left
    translate([-40+30-1,0-10, -1])cube([20, 16, 10],center=true);
    translate([-40+30-1,0+10, -1])cube([20, 16, 10],center=true);
    translate([-40+ 0,  0-10, -1.5])cube([40, 10, 1.01],center=true);
    translate([-40+ 0,  0+10, -1.5])cube([40, 10, 1.01],center=true);
    translate([-40-30+1,0-10, -1])cube([20, 16, 10],center=true);
    translate([-40-30+1,0+10, -1])cube([20, 16, 10],center=true);
    //battpack right
    translate([40+30-1,0-10, -1])cube([20, 16, 10],center=true);
    translate([40+30-1,0+10, -1])cube([20, 16, 10],center=true);
    translate([40+ 0,  0-10, -1.5])cube([40, 10, 1.01],center=true);
    translate([40+ 0,  0+10, -1.5])cube([40, 10, 1.01],center=true);
    translate([40-30+1,0-10, -1])cube([20, 16, 10],center=true);
    translate([40-30+1,0+10, -1])cube([20, 16, 10],center=true);
    //batt cable
    translate([ 40,0, 0])cube([8, 8, 10],center=true);
    translate([-40,0, 0])cube([8, 8, 10],center=true);
    translate([0, 40, 0])cube([8, 8, 10],center=true);
    translate([0,-40, 0])cube([8, 8, 10],center=true);

    //hole edge
    translate([ 35, 35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-35, 35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([ 35,-35, ])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-35,-35, ])cylinder(h=99,r=1.6,center=true,$fn=50);

    //-motor
    //motorhole leftfar
    translate([-30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30,  60, 0])cube([20,26,40],center=true);
    translate([-50,  60, 0])cube([20,32,40],center=true);
    translate([-60, 60, 0])cylinder(100, r=10,center=true,$fn=50);
    //motorhole rightfar
    translate([ 30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30,  60, 0])cube([20,26,40],center=true);
    translate([ 50,  60, 0])cube([20,32,40],center=true);
    translate([ 60, 60, 0])cylinder(100, r=10,center=true,$fn=50);
    //motorhole leftnear
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30, -60, 0])cube([20,26,40],center=true);
    translate([-50, -60, 0])cube([20,32,40],center=true);
    translate([-60, -60, 0])cylinder(100, r=10,center=true,$fn=50);
    //motorhole rightnear
    translate([ 30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30, -60, 0])cube([20,26,40],center=true);
    translate([ 50, -60, 0])cube([20,32,40],center=true);
    translate([ 60, -60, 0])cylinder(100, r=10,center=true,$fn=50);
/*
    //-wheel
    translate([ 60,  60, 0])cube([30,60,99],center=true);
    translate([-60,  60, 0])cube([30,60,99],center=true);
    translate([ 60, -60, 0])cube([30,60,99],center=true);
    translate([-60, -60, 0])cube([30,60,99],center=true);
*/
    //hole,far
    translate([0, 60, 0])cylinder(99, r=5,center=true,$fn=50);
    translate([-10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 10,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30,  30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    //hole,near
    translate([ 30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([0, -60, 0])cylinder(99, r=5,center=true,$fn=50);
        //right,far
        for(t=[-90:45:90]){
        translate([ 60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //leftfar
        for(t=[90:45:270]){
        translate([-60, 60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //rightnear
        for(t=[-90:45:90]){
        translate([ 60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
        //leftnear
        for(t=[90:45:270]){
        translate([-60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
        }
    }
/*
    //corner
    translate([ 40, 20,-8])bezier(8);
    translate([ 40,-20,-8])mirror([0,1,0])bezier(8);
    translate([-40, 20,-8])mirror([1,0,0])bezier(8);
    translate([-40,-20,-8])rotate([0,0,180])bezier(8);
*/
}

module bot_bot()
{
    //outer
    translate([-70, -20, 0])bot_that();
    translate([ 70, -20, 0])mirror([1,0,0])bot_that();
    mirror([0,1,0])translate([-70, -20, 0])bot_that();
    mirror([0,1,0])translate([ 70, -20, 0])mirror([1,0,0])bot_that();

    //inner
    intersection(){
    union(){
    translate([-50, -20, 0])mirror([1,0,0])bot_that();
    translate([ 50, -20, 0])bot_that();
    mirror([0,1,0])translate([-50, -20, 0])mirror([1,0,0])bot_that();
    mirror([0,1,0])translate([ 50, -20, 0])bot_that();
    }
    translate([0, 0, 9.9])cube([120,160,20],center=true);
    }


    difference(){
    union(){
    //+baseboard
    translate([0, 0, 1])cube([80, 160, 2],center=true);
    translate([0, 0, 1])cube([168, 40, 2],center=true);
    //mid
    translate([0, 20+2/2, 10/2])cube([80, 2, 10],center=true);
    translate([0, 20+2/2, 20/2])cube([20, 2, 20],center=true);
    translate([0,      0, 20/2])cube([1.2, 40, 20],center=true);
    translate([0,-20-2/2, 20/2])cube([20, 2, 20],center=true);
    translate([0,-20-2/2, 10/2])cube([80, 2, 10],center=true);
    //left
    translate([-80-1.9/2, 0, 30/2])cube([1.9, 40, 30],center=true);
    translate([-168/2+4/2, 0, 10/2])cube([4, 40, 10],center=true);
    translate([-168/2+4/2,-20-2/2, 20/2])cube([4, 2, 20],center=true);
    translate([-168/2+4/2, 20+2/2, 20/2])cube([4, 2, 20],center=true);
    //right
    translate([80+1.9/2, 0, 30/2])cube([1.9, 40, 30],center=true);
    translate([168/2-4/2, 0, 10/2])cube([4, 40, 10],center=true);
    translate([168/2-4/2,-20-2/2, 20/2])cube([4, 2, 20],center=true);
    translate([168/2-4/2, 20+2/2, 20/2])cube([4, 2, 20],center=true);
    }
    //-connect bot_bot
    translate([0,  0, 20])rotate([0,90,0])cylinder(999, r=1.6,center=true,$fn=50);
    //
    translate([ 80, 10, 30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80,-10, 30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80, 10, 10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([ 80,-10, 10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80, 10, 30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80,-10, 30])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80, 10, 10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    translate([-80,-10, 10])rotate([0,90,0])cylinder(10, r=5,center=true,$fn=50);
    /*
    translate([-50, 20+2.2/2, 1])cube([20, 2.2, 10],center=true);
    translate([ 50, 20+2.2/2, 1])cube([20, 2.2, 10],center=true);
    translate([-50,-20-2.2/2, 1])cube([20, 2.2, 10],center=true);
    translate([ 50,-20-2.2/2, 1])cube([20, 2.2, 10],center=true);
    */
    //battpack left
    translate([-40+30-1,0-10, 1])cube([20, 16, 10],center=true);
    translate([-40+30-1,0+10, 1])cube([20, 16, 10],center=true);
    translate([-40+ 0,  0-10, 1.5])cube([40, 10, 1.01],center=true);
    translate([-40+ 0,  0+10, 1.5])cube([40, 10, 1.01],center=true);
    translate([-40-30+1,0-10, 1])cube([20, 16, 10],center=true);
    translate([-40-30+1,0+10, 1])cube([20, 16, 10],center=true);
    //battpack right
    translate([40+30-1,0-10, 1])cube([20, 16, 10],center=true);
    translate([40+30-1,0+10, 1])cube([20, 16, 10],center=true);
    translate([40+ 0,  0-10, 1.5])cube([40, 10, 1.01],center=true);
    translate([40+ 0,  0+10, 1.5])cube([40, 10, 1.01],center=true);
    translate([40-30+1,0-10, 1])cube([20, 16, 10],center=true);
    translate([40-30+1,0+10, 1])cube([20, 16, 10],center=true);

    //-motor
    translate([-40+20/2,  60, 0])cube([20,26,40],center=true);
    translate([ 40-20/2,  60, 0])cube([20,26,40],center=true);
    translate([-40+20/2, -60, 0])cube([20,26,40],center=true);
    translate([ 40-20/2, -60, 0])cube([20,26,40],center=true);
    //-wheel
    translate([ 60,  60, 0])cube([40,66,99],center=true);
    translate([-60,  60, 0])cube([40,66,99],center=true);
    translate([ 60, -60, 0])cube([40,66,99],center=true);
    translate([-60, -60, 0])cube([40,66,99],center=true);

    //-shaft
    translate([ 20-7/2, 60, 0])cube([7,7,7],center=true);
    translate([-20+7/2, 60, 0])cube([7,7,7],center=true);
    translate([ 20-7/2, -60, 0])cube([7,7,7],center=true);
    translate([-20+7/2, -60, 0])cube([7,7,7],center=true);

    //
    translate([-30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    //
    translate([ 30, 80-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30, 40+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    //
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    //
    translate([ 30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    translate([ 30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    //
    translate([0, 60, 0])cylinder(99, r=5,center=true,$fn=50);
    translate([0, 40, 0])cube([8, 8, 10],center=true);
    translate([0,-40, 0])cube([8, 8, 10],center=true);
    translate([0, -60, 0])cylinder(99, r=5,center=true,$fn=50);
    //hole,far
    translate([-30, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30, 70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-30, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30, 50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30, 30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 10, 30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10, 30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30, 30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    //hole,near
    translate([ 30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30, -30, 20-6])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30,-50,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-30,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([-10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 10,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    translate([ 30,-70,1])cylinder(h=8,r=1.6,center=true,$fn=50);
    }
}

module belowbot()
{
    intersection(){
    translate([0,0,-2])bot_bot();
    translate([0, -60,4/2])cube([80,40,40],center=true);
    }
}


sizeofmotor = 22.4;
module motorseat(){
difference(){
    translate([0, 30/2-5,4/2])cube([sizeofmotor,30,4],center=true);

    //shaft hole
    translate([0, 0,0])cylinder(20, r=3.6,center=true,$fn=50);

    //shaft hole
    translate([0,0+11.5,0])cylinder(20, r=2.2,center=true,$fn=50);

    //screw hole
    translate([-8.6,0+21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([ 8.6,0+21,0])cylinder(20, r=1.6,center=true,$fn=50);
    translate([-8.6,0+21,2/2-0.01])cylinder(2, r=3,center=true,$fn=50);
    translate([ 8.6,0+21,2/2-0.01])cylinder(2, r=3,center=true,$fn=50);
}
}
module motorseat_test(){
translate([0,0,60])cube([120,120,0.1],center=true);
translate([-20,-60,0])rotate([90,0,0])rotate([0,-90,0])motorseat();
translate([-30,-60,0])rotate([90,0,0])translate([-10,55/2,0])cube([10,55,sizeofmotor],center=true);
translate([0,0,26])cube([66,66,0.1],center=true);
translate([0,0,20])cube([66,66,0.1],center=true);
translate([-20,-60+20/2,20])cube([0.1,20,40],center=true);
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
module bot_seat_leftnear(){
    //core
    translate([-20,-60, -40])rotate([90,0,0])rotate([0,-90,0])motorseat();

    //z far@75
    difference(){
        translate([-30,-60+26/2-(26-sizeofmotor)/2/2, 20-70/2])cube([20,(26-sizeofmotor)/2,70],center=true);
        translate([-30, -60+10, 20-2-6/2])cylinder(h=6,r=3,center=true,$fn=50);
        translate([-30, -60+10,-40-2+6/2])cylinder(h=6,r=3,center=true,$fn=50);
    }

    //z near@75
    difference(){
        translate([-30,-60-26/2+(26-sizeofmotor)/2/2, 20-70/2])cube([20,(26-sizeofmotor)/2,70],center=true);
        translate([-30, -60-10, 20-2-6/2])cylinder(h=6,r=3,center=true,$fn=50);
        translate([-30, -60-10,-40-2+6/2])cylinder(h=6,r=3,center=true,$fn=50);
    }

    //x.top
    difference(){
        translate([-30,-60, 20-2/2])cube([20,26,2],center=true);
        translate([-30, -60+10,-3+1.1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-30, -60-10,-3+1.1])cylinder(h=99,r=1.6,center=true,$fn=50);
    }

    //x.mid @+2
    difference(){
    translate([-30,-60+26/2+3/2, 0+2.1+2/2])cube([20,3,2],center=true);
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-30,-60-26/2-3/2, 0+2.1+2/2])cube([20,3,2],center=true);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    //x.mid @-2
    difference(){
    translate([-30,-60+26/2+3/2, 0-2.1-2/2])cube([20,3,2],center=true);
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-30,-60-26/2-3/2, 0-2.1-2/2])cube([20,3,2],center=true);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }

    //x.bot @-38
    difference(){
    translate([-30,-60+40/2-(40-26)/2/2, -40+2.1+2/2])cube([20,(40-26)/2,2],center=true);
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-30,-60-40/2+(40-26)/2/2, -40+2.1+2/2])cube([20,(40-26)/2,2],center=true);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    //x.bot @-42
    difference(){
    translate([-30,-60+40/2-(40-26)/2/2, -40-2.1-2/2])cube([20,(40-26)/2,2],center=true);
    translate([-30,-40-3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-30,-60-40/2+(40-26)/2/2, -40-2.1-2/2])cube([20,(40-26)/2,2],center=true);
    translate([-30,-80+3.5,0])cylinder(100, r=1.6,center=true,$fn=50);
    }
    /*
    difference(){
        translate([-30,-60, -40-4+2/2])cube([20,sizeofmotor,2],center=true);
        //translate([-35,-60, 0])cube([10,5,99],center=true);
        translate([-30, -60+10,-3+1.1])cylinder(h=99,r=1.6,center=true,$fn=50);
        translate([-30, -60-10,-3+1.1])cylinder(h=99,r=1.6,center=true,$fn=50);
    }*/
}
module bot_seat(){
    bot_seat_leftnear();
}

module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([-60,-60,-40])wheel();
    translate([ 60,-60,-40])wheel();
    translate([-60, 60,-40])wheel();
    translate([ 60, 60,-40])wheel();
}

module midsupport(){
    difference(){
    union(){
    translate([ 60,-60, 44-1.9/2])cylinder(1.9, r=16,center=true,$fn=50);
    translate([ 70,-60, 44-1.9/2])cube([20,20,1.9],center=true);

    translate([ 60,-60, 40])cylinder(5, r=9.6,center=true,$fn=50);

    translate([ 60,-60, 36+1.9/2])cylinder(1.9, r=16,center=true,$fn=50);
    translate([ 70,-60, 36+1.9/2])cube([20,20,1.9],center=true);
        
    translate([ 60,-60, 20])cylinder(32, r=10,center=true,$fn=50);

    translate([ 60,-60,  4-1.9/2])cylinder(1.9, r=16,center=true,$fn=50);
    translate([ 70,-60,  4-1.9/2])cube([20,20,1.9],center=true);

    translate([ 60,-60,  0])cylinder(5, r=9.6,center=true,$fn=50);

    translate([ 60,-60, -4+1.9/2])cylinder(1.9, r=16,center=true,$fn=50);
    translate([ 70,-60, -4+1.9/2])cube([20,20,1.9],center=true);
    }

    translate([ 50,-60, 20])cube([20,40,99],center=true);
    translate([ 60,-60, 20])cylinder(99, r=8,center=true,$fn=50);
    for(t=[-90:45:90]){
    translate([ 60,-60, 20])rotate([0,0,t])translate([15,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }

    }//difference
}

module xh254_3pin_left(){
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
}
module xh254_3pin_right(){
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
}
module xh254_2pin(){
    
    //bot.down.2pin
    difference(){
    translate([0,10,-7/2])cube([10,20,7], center=true);
    //
    translate([0,15,-1-6/2])cube([6,20,6.01], center=true);
    translate([0, 5,-1-6/2])cube([7.6,7.2,6.01], center=true);
    translate([0, 0,-1-6/2])cube([6,10.01,6.01], center=true);
    }
}
/*
module powerswitch(){
    difference(){
    translate([0,14/2,0])cube([15,14,21],center=true);
    translate([0,14/2,0])cube([13,14.01,18.5],center=true);
    translate([0,2+3/2,0])cube([6,3,99],center=true);
    }
}
module powerswitch2(){
    difference(){
    translate([0,20/2,0])cube([20,20,24],center=true);
    translate([0,14/2,0])cube([15.2, 99, 21.2],center=true);
    }
}*/
module powerswitch3(){
    difference(){
    union(){
    translate([0,24/2,0])cube([14, 24, 22],center=true);
    //
    translate([0,-1,0])cube([18,6,10],center=true);
    translate([-20+11/2, 1, 0])cube([11,2,10],center=true);
    translate([ 20-11/2, 1, 0])cube([11,2,10],center=true);
    }
    //-switch
    translate([0,23-40/2,0])cube([12.6,40,19],center=true);
    translate([0,23-7/2,0])cube([99,7,19],center=true);
    //-hole cube
    translate([0,1+6/2,0])cube([6,6.8,99],center=true);
    //-hole cylinder
    translate([ 0, 20, 0])cylinder(99, r=1.6,center=true,$fn=50);
    //-place for xh254 left
    translate([-7+0.5/2, 10, 11-2/2])cube([0.51, 20, 2],center=true);
    //-place for xh254 right
    translate([ 7-0.5/2, 0+1.6/2, 11-2.4/2])cube([0.51, 1.61, 2.41],center=true);
    
    //outer
    translate([ 0, -1, 0])cube([15.4, 2, 22],center=true);
    }

}
module powerpcb(){
    //back
    difference(){
        translate([0, 30, 0])cube([40,20,36],center=true);
        
        translate([0, 40-8/2, 0])cube([38,8.01,99],center=true);
        translate([0, 40-10+1+1/2, 0])cube([30,1.01,30],center=true);
        translate([0, 40-10, 0])cube([34,2,34],center=true);
        translate([0, 40-10-1-1/2, 0])cube([30,1.01,30],center=true);
        translate([0, 20+8/2, 0])cube([38,8.01,99],center=true);
    }
}
module powerraw_top(){
    //
    translate([0, 20, 20-2])screwhelper(4.9, 1.6, 2);
    translate([0, 20, 20-9])screwhelper(3, 1.6, 7);

    translate([-20+14/2,10,8])xh254_3pin_left();
    translate([ 20-14/2,10,8])xh254_3pin_right();

    intersection(){
    translate([0, 0, 0])powerswitch3();
    translate([0, 0, 20])cube([99,99,40],center=true);
    }
    
    //left
    translate([-15, 10, 5])screwhelper(5, 1.6, 4);
    translate([-15, 10, -5])screwhelper(2.9, 1.6, 10);
    translate([-20+0.8/2, 10, 5])cube([0.8,20,10],center=true);
    
    //right
    translate([ 15, 10, 5])screwhelper(5, 1.6, 4);
    translate([ 15, 10, -5])screwhelper(2.9, 1.6, 10);
    translate([ 20-0.8/2, 10, 5])cube([0.8,20,10],center=true);

    //pcb
    intersection(){
    translate([0, 0, 0])powerpcb();
    translate([0, 0, 20])cube([99,99,40],center=true);
    }
}
module powerraw_bot(){
    //left
    translate([-15, 10, -5])screwhelper(4, 3.1, 10);
    translate([-15, 10, -10])screwhelper(5, 1.6, 5);
    translate([-20+1/2, 10,-5])cube([1,20,10],center=true);
    //right
    translate([ 15, 10, -5])screwhelper(4, 3.1, 10);
    translate([ 15, 10, -10])screwhelper(5, 1.6, 5);
    translate([ 20-1/2, 10,-5])cube([1,20,10],center=true);


    //
    intersection(){
    translate([0, 0, 0])powerswitch3();
    translate([0, 0,-20])cube([99,99,40],center=true);
    }
    //
    translate([-20+13/2, 20/2, -10-1/2])cube([13,20,1],center=true);
    translate([ 20-13/2, 20/2, -10-1/2])cube([13,20,1],center=true);
    //
    translate([-20+10/2, 0,-11])xh254_2pin();
    translate([ 20-10/2, 0,-11])xh254_2pin();
    //
    translate([0, 20, -20+2])screwhelper(3, 1.6, 7);
    translate([0, 20, -20])screwhelper(4.9, 1.6, 2);

    //pcb
    intersection(){
    translate([0, 0, 0])powerpcb();
    translate([0, 0,-20])cube([99,99,40],center=true);
    }
}
module powerraw(){
    powerraw_top();
    powerraw_bot();
}


module powerconv_top(){
    translate([ 0, 0, 40-2/2])cylinder(2, r=4.98,center=true,$fn=50);
    difference(){
    translate([0, 0, 40-2-28/2])cube([40, 40, 28],center=true);
    translate([0, 0, 40-3-7/2])cube([36, 36, 7],center=true);
    translate([0, 0, 40-10-20/2])cube([38.1, 38.1, 20],center=true);
    //
    translate([-15,0, 35])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0, 35])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0, 35])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0, 35])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15,0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0, 25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15,0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0, 15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
}
module powerconv_bot(){
    difference(){
    union(){
    translate([0,0,10+20/2])cube([37.9,37.9,20],center=true);
    translate([0,0,2+8/2])cube([40,40,8],center=true);
    }
    translate([0,0,3.01+27/2])cube([36,36,27],center=true);
    //
    translate([-15,0,25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0,25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0,25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0,25])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15,0,15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0,15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0,15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0,15])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-15,0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([- 5,0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  5,0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 15,0, 5])rotate([90,0,0])cylinder(99, r=1.6,center=true,$fn=50);
    }
    translate([ 0, 0, 2/2])cylinder(2, r=4.98,center=true,$fn=50);
}
module powerconv(){
    powerconv_top();
    powerconv_bot();
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
color("#ff0000")top_cam();
//color("#ff0000")top_mic();
color("#ff0000")top_support();
*/

//top
//color("#5f00f0")top_top();
//translate([0,120,0])topsupport();
//color("#ff0000")translate([0,0,40])top_bot();
/*
//mid
translate([0,0,40])mid_top();
//midsupport();
translate([0,-60,0])powerconv();
color([0.1,0.7,0,0.9])mid_bot();
*/
/*
//bot
color([0.5,0.5,0,0.8])mirror([1,0,0])bot_seat();
color([0.5,0,0.5,0.8])translate([0,0,-40])bot_bot();
color("#ffff00")bot_top();
*/

/*
belowbot();

notprint_wheel();
*/


//--------for print--------
//top_bot();

//midsupport();
//mid_top();
//mid_bot();

//bot_seat();

//bot_top();
//bot_bot();
//bot_lock();
//belowbot();

powerraw_top();
//powerraw_bot();
//powerconv_top();
//powerconv_bot();
/*
intersection(){
top_support_one();
//top_support_speaker();
translate([0,0,-50])cube([99,99,100],center=true);
}
mid_that();
*/


//--------for test--------
/*
translate([0,0,-1])cylinder(2, r=5,center=true,$fn=50);
intersection(){
top_locktop();
translate([0,0,-2-38/2])cube([99,99,38],center=true);
}

intersection(){
top_lockbot();
translate([0,0,2+38/2])cube([99,99,38],center=true);
}
translate([0,0,1])cylinder(2, r=5,center=true,$fn=50);
*/
