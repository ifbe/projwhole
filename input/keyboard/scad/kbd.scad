module hat(mystr){
    difference(){
        hull(){
            translate([0,0, 1])cube([18, 18, 0.001],center=true);
            translate([0,0, 0])cube([19, 19, 0.001],center=true);
        }
        //rotate([0,0,45])
        translate([0, 0, 0.801])linear_extrude(height=.2)text(mystr, size=8, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
    }
    difference(){
        hull(){
            translate([0,0, 0])cube([19, 19, 0.001],center=true);
            translate([0,0, -2+0.001/2])cube([19.6, 19.6, 0.001],center=true);
        }
        hull(){
            translate([0,0, 0])cube([16, 16, 0.001],center=true);
            translate([0,0, -2])cube([18, 18, 0.001],center=true);
        }
    }
    difference(){
        translate([0,0,-3/2])cylinder(h=3,r=5.8/2,center=true,$fn=50);
        cube([4.2, 1.2, 99],center=true);
        cube([1.2, 4.2, 99],center=true);
        //
        translate([-2,0,0])cube([0.4, 1.4, 99],center=true);
        translate([ 2,0,0])cube([0.4, 1.4, 99],center=true);
        translate([0,-2,0])cube([1.4, 0.4, 99],center=true);
        translate([0, 2,0])cube([1.4, 0.4, 99],center=true);
    }
}
module hat_chem(id, mystr){
    difference(){
        hull(){
            translate([0,0, 1])cube([18, 18, 0.001],center=true);
            translate([0,0, 0])cube([19, 19, 0.001],center=true);
        }
        if(57==id){
        translate([9, 6.8, 0.801])linear_extrude(height=.2)text("57-71", size=4, halign="right", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        translate([0, 0, 0.801])linear_extrude(height=.2)text(mystr, size=5, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        }
        else if(89==id){
        translate([9, 6.8, 0.801])linear_extrude(height=.2)text("89-103", size=4, halign="right", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        translate([0, 0, 0.801])linear_extrude(height=.2)text(mystr, size=5, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        }
        else{
        translate([9, 6.8, 0.801])linear_extrude(height=.2)text(str(id), size=4, halign="right", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        translate([0, 0, 0.801])linear_extrude(height=.2)text(mystr, size=8, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
        }
    }
    difference(){
        hull(){
            translate([0,0, 0])cube([19, 19, 0.001],center=true);
            translate([0,0, -2+0.001/2])cube([19.6, 19.6, 0.001],center=true);
        }
        hull(){
            translate([0,0, 0])cube([16, 16, 0.001],center=true);
            translate([0,0, -2])cube([18, 18, 0.001],center=true);
        }
    }
    difference(){
        translate([0,0,-3/2])cylinder(h=3,r=5.8/2,center=true,$fn=50);
        cube([4.2, 1.2, 99],center=true);
        cube([1.2, 4.2, 99],center=true);
        //
        translate([-2,0,0])cube([0.4, 1.4, 99],center=true);
        translate([ 2,0,0])cube([0.4, 1.4, 99],center=true);
        translate([0,-2,0])cube([1.4, 0.4, 99],center=true);
        translate([0, 2,0])cube([1.4, 0.4, 99],center=true);
    }
}

module hat_xy(xsize, ysize, mystr){
    difference(){
        hull(){
            translate([0,0, 1])cube([20*xsize-2, 18, 0.001],center=true);
            translate([0,0, 0])cube([20*xsize-1, 19, 0.001],center=true);
        }
        translate([0, 0, 0.801])linear_extrude(height=.2)text(mystr, size=10, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
    }
    difference(){
        hull(){
            translate([0,0, 0])cube([20*xsize-1, 19, 0.001],center=true);
            translate([0,0, -2+0.001/2])cube([20*xsize-0.4, 19.6, 0.001],center=true);
        }
        hull(){
            translate([0,0, 0])cube([20*xsize-4, 16, 0.001],center=true);
            translate([0,0, -2])cube([20*xsize-2, 18, 0.001],center=true);
        }
    }
    for(x=[-1:xsize:1]){
        translate([x*10, 0, 0])difference(){
            translate([0, 0, -3/2])cylinder(h=3,r=5.8/2,center=true,$fn=50);
            cube([4.2, 1.2, 99],center=true);
            cube([1.2, 4.2, 99],center=true);
            //
            translate([-2,0,0])cube([0.4, 1.4, 99],center=true);
            translate([ 2,0,0])cube([0.4, 1.4, 99],center=true);
            translate([0,-2,0])cube([1.4, 0.4, 99],center=true);
            translate([0, 2,0])cube([1.4, 0.4, 99],center=true);
        }
    }
}

module top(){
difference(){
    cube([20,20,2],center=true);
    cube([14,14,99],center=true);
    //
    translate([-10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([ 10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([0, -10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    translate([0,  10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    //
    translate([ 10, 10, 0])cylinder(h=99,r=0.9,center=true,$fn=10);
    translate([-10, 10, 0])cylinder(h=99,r=0.9,center=true,$fn=10);
    translate([ 10,-10, 0])cylinder(h=99,r=0.9,center=true,$fn=10);
    translate([-10,-10, 0])cylinder(h=99,r=0.9,center=true,$fn=10);
    //
    translate([ 0, 10, 0])cylinder(h=99,r=1.0,center=true,$fn=10);
    translate([ 0,-10, 0])cylinder(h=99,r=1.0,center=true,$fn=10);
}
}


module bot(){
difference(){
    cube([20,20,2],center=true);
    //
    cylinder(h=99,r=2.1,center=true,$fn=50);
    //
    translate([-3.81, 2.54, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
    translate([ 2.54, 5.08, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
    //
    translate([0, -6, 0])cube([4,4,99],center=true);
    //
    translate([-10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([ 10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([0, -10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    translate([0,  10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    //
    translate([ 10, 10, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
    translate([-10, 10, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
    translate([ 10,-10, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
    translate([-10,-10, 0])cylinder(h=99,r=1.6,center=true,$fn=10);
}
}


module aa(){
    difference(){
    translate([10, 10-(10-2.6)/2, (8+1.6)/2])cube([20-5.2, 10-2.6, 8+1.6],center=true);
    translate([10, 10, 0])cube([12,10,99],center=true);
    translate([10, 10, 1.6+6])cube([10,99,4],center=true);
    }


    difference(){
    union(){
    translate([10, 10, 0.8])cube([20, 20, 1.6],center=true);
    translate([   1.25,    1.25, 1.6+1])cube([2.5, 2.5, 2],center=true);
    translate([20-1.25,    1.25, 1.6+1])cube([2.5, 2.5, 2],center=true);
    translate([   1.25, 20-1.25, 1.6+1])cube([2.5, 2.5, 2],center=true);
    translate([20-1.25, 20-1.25, 1.6+1])cube([2.5, 2.5, 2],center=true);
    }
    translate([10, 10, 1])cube([20-5.2, 20-5.2, 99],center=true);
    //
    translate([ 0, 20, 0])cylinder(h=9,r=1,center=true, $fn=10);
    translate([20, 20, 0])cylinder(h=9,r=1,center=true, $fn=10);
    translate([ 0, 0, 0])cylinder(h=9,r=1,center=true, $fn=10);
    translate([20, 0, 0])cylinder(h=9,r=1,center=true, $fn=10);
    //
    translate([ 0, 20, 0.8])cylinder(h=1.6,r=2,center=true, $fn=10);
    translate([20, 20, 0.8])cylinder(h=1.6,r=2,center=true, $fn=10);
    translate([ 0, 0, 0.8])cylinder(h=1.6,r=2,center=true, $fn=10);
    translate([20, 0, 0.8])cylinder(h=1.6,r=2,center=true, $fn=10);
    }
}

module bb(){
    //left
    translate([-20+1.25, 40-2.5, 2+4])cube([2.5, 5, 8],center=true);
    translate([-20+1.25,-40+2.5, 2+4])cube([2.5, 5, 8],center=true);
    //left mid
    translate([-20+1.25*3, 20, 2+4])cube([2.5, 5, 8],center=true);
    translate([-20+1.25*3,  0, 2+4])cube([2.5, 5, 8],center=true);
    translate([-20+1.25*3,-20, 2+4])cube([2.5, 5, 8],center=true);
    //mid
    //translate([-1.25, 5, 2+4])cube([2.5, 10, 8],center=true);
    //translate([-1.25, -37.5/2, 2+4])cube([2.5, 37.5, 8],center=true);
    //right
    translate([20-1.25*3,  20+2.5+7.5/2, 2+4])cube([2.5, 7.5, 8],center=true);
    translate([20-1.25*3,   0+2.5+7.5/2, 2+4])cube([2.5, 7.5, 8],center=true);
    translate([20-1.25*3, -20+2.5+7.5/2, 2+4])cube([2.5, 7.5, 8],center=true);
    translate([20-1.25*3, -40+2.5+7.5/2, 2+4])cube([2.5, 7.5, 8],center=true);
    //
    difference(){
    translate([0, 0, 1])cube([40,80,2],center=true);
    translate([5, 40-15, 1])cube([14,30,99],center=true);
    //l
    translate([-10,  30, 0])cube([10, 10, 99],center=true);
    translate([-10,  10, 0])cube([10, 10, 99],center=true);
    translate([-10, -10, 0])cube([10, 10, 99],center=true);
    translate([-10, -30, 0])cube([10, 10, 99],center=true);
    //r
    translate([ 10, -10, 0])cube([10, 10, 99],center=true);
    translate([ 10, -30, 0])cube([10, 10, 99],center=true);
    }
}


module connect()
{
    difference(){
        cube([2.5, 2.5, 8]);
        translate([1.25, 1.25, 4])cylinder(h=99, r=0.6, center=true, $fn=10);
    }
}
module connectall()
{
    translate([-10+1.25, 2.5, 3])cube([2.5, 5, 2],center=true);
    translate([ 10-1.25, 2.5, 3])cube([2.5, 5, 2],center=true);
    difference(){
        union(){
        //right
        translate([  0, 10, 0])connect();
        translate([2.5, 10, 0])connect();
        translate([2.5, 7.5, 0])connect();
        translate([2.5, 5, 0])connect();
        translate([2.5, 2.5, 0])connect();
        translate([  5, 2.5, 0])connect();
        translate([  5, 0, 0])connect();
        translate([  5, -2.5, 0])connect();
        translate([  5, -5, 0])connect();
        translate([2.5, -5, 0])connect();
        translate([2.5, -7.5, 0])connect();
        translate([  0, -7.5, 0])connect();
        //left
        translate([-2.5, 10, 0])connect();
        translate([  -5, 10, 0])connect();
        translate([-5, 7.5, 0])connect();
        translate([-5, 5, 0])connect();
        translate([-5, 2.5, 0])connect();
        translate([  -7.5, 2.5, 0])connect();
        translate([  -7.5, 0, 0])connect();
        translate([  -7.5, -2.5, 0])connect();
        translate([  -7.5, -5, 0])connect();
        translate([-5, -5, 0])connect();
        translate([-5, -7.5, 0])connect();
        translate([-2.5, -7.5, 0])connect();
        }
        //top
        translate([0, 12.5, 6])cube([15.01, 5.01, 4.01],center=true);
        translate([0, 12.5, 1.2])cube([15.01, 7.51, 2.41],center=true);
        //mid
        cube([10.8, 5.6, 99],center=true);
        translate([0, 2.5, 0])cube([5.6, 15.6, 99],center=true);
        //bot
        translate([0, -2.5, 6])cube([15.01, 10.01, 4.01],center=true);
        translate([0, -7.5, 1.2])cube([15.01, 10.01, 2.41],center=true);
        //left
        translate([-5-1.25, 2.5, 6])cube([2.51, 15.2, 4.01],center=true);
        //right
        translate([ 5+1.25, 2.5+1.25, 6])cube([2.51, 2.51, 4.01],center=true);
    }
}
module kkkkk(){
    difference(){
        translate([0,0,2])cube([20, 20, 4], center=true);
        //center
        cube([16, 16, 99], center=true);
        //ws2812b
        translate([0,0,3])cube([9.6, 19.2, 2], center=true);
        //
        translate([ 10, 10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
        //translate([ 10-1.25, 10-1.25, 3])cylinder(h=2.01,r=.6,center=true,$fn=50);
        //
        translate([-10, 10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
        //translate([-10+1.25, 10-1.25, 3])cylinder(h=2.01,r=.6,center=true,$fn=50);
        //
        translate([ 10,-10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
        //translate([ 10-1.25,-10+1.25, 3])cylinder(h=2.01,r=.6,center=true,$fn=50);
        //
        translate([-10,-10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
        //translate([-10+1.25,-10+1.25, 3])cylinder(h=2.01,r=.6,center=true,$fn=50);
        

        //top left
        translate([-10+1.25*3, 10-1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25,   10-1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25,   10-1.25*3, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);

        //top right
        translate([ 10-1.25*3, 10-1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([ 10-1.25,   10-1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([ 10-1.25,   10-1.25*3, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);

        //bot left
        translate([-10+1.25,-10+1.25*7, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25,-10+1.25*5, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25,-10+1.25*3, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25,-10+1.25*1, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([-10+1.25*3,-10+1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
       
        //bot right
        translate([10-1.25,-10+1.25*7, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([10-1.25,-10+1.25*5, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([10-1.25,-10+1.25*3, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([10-1.25,-10+1.25*1, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
        translate([10-1.25*3,-10+1.25, 3.21])cylinder(h=1.6,r=1,center=true,$fn=10);
    }
}


module special_8x18()
{
    difference(){
        union(){
            translate([0, 0, -1.6/2])cube([40, 80, 1.6], center=true);
            //
            translate([-20+1.25,  20-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([-20+1.25,   0-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([-20+1.25, -20-2.5, 6/2])cube([2.5, 5, 6], center=true);
        }
        translate([-10, 20, -1.6+0.4])cube([12.5, 40, 0.8], center=true);
        translate([-10, 20, 0-0.4])cube([15, 40, 0.8], center=true);
        //
        translate([10, 30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, 10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, -10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, -30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, -10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, -30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        //
        translate([0, 20, 0])cylinder(h=9,r=1,center=true,$fn=10);
        translate([0,  0, 0])cylinder(h=9,r=1,center=true,$fn=10);
        translate([0,-20, 0])cylinder(h=9,r=1,center=true,$fn=10);
        //
        for(y=[-40+1.25:2.5:40])translate([-20+1.25, y, 0])cylinder(h=99,r=0.6,center=true,$fn=10);
    }
}

module special_4x4()
{
    difference(){
        union(){
            translate([0, 0, -1.6/2])cube([40, 80, 1.6], center=true);
            //top
            translate([0,  40-0.5, 6/2])cube([10, 1, 6], center=true);
            translate([0,  20+0.5, 6/2])cube([10, 1, 6], center=true);
            //bot
            translate([0, -20-0.5, 6/2])cube([10, 1, 6], center=true);
            translate([0, -40+0.5, 6/2])cube([10, 1, 6], center=true);
            //left
            translate([-20+1.25,  40-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([-20+1.25,  20-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([-20+1.25,   0-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([-20+1.25, -20-2.5, 6/2])cube([2.5, 5, 6], center=true);
            //right
            translate([20-1.25,  40-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([20-1.25,  20-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([20-1.25,   0-2.5, 6/2])cube([2.5, 5, 6], center=true);
            translate([20-1.25, -20-2.5, 6/2])cube([2.5, 5, 6], center=true);
        }
        //
        translate([10, 30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, 30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, 10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, 10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, -10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, -10, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([10, -30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        translate([-10, -30, 0])cylinder(h=9,r=5,center=true,$fn=20);
        //
        translate([0, 20, 0])cylinder(h=99,r=1,center=true,$fn=10);
        translate([0,  0, 0])cylinder(h=99,r=1,center=true,$fn=10);
        translate([0,-20, 0])cylinder(h=99,r=1,center=true,$fn=10);
        //
        for(y=[40-1.25:-20:-40]){
            translate([-20+1.25, y, 0])cylinder(h=99,r=0.6,center=true,$fn=10);
            translate([-20+1.25, y-2.5, 0])cylinder(h=99,r=0.6,center=true,$fn=10);
            //
            translate([ 20-1.25, y, 0])cylinder(h=99,r=0.6,center=true,$fn=10);
            translate([ 20-1.25, y-2.5, 0])cylinder(h=99,r=0.6,center=true,$fn=10);
        }
    }
}




xx=2;
if(xx==0){
translate([ 10, 10, 0])hat("←");
translate([-10, 10, 0])hat("→");
translate([ 10,-10, 0])hat("↑");
translate([-10,-10, 0])hat("↓");
}
else if(xx==1){
translate([ 0,100, 0])hat("esc");
translate([ 0, 80, 0])hat("~");
translate([ 0, 60, 0])hat("tab");
translate([ 0, 40, 0])hat("cap");
translate([ 0, 20, 0])hat("shift");
translate([ 0,  0, 0])hat("ctrl");
//
//translate([ 0,100, 0])hat_xy(2, 1, "esc");
//translate([ 0, 80, 0])hat_xy(2, 1, "~");
//translate([ 0, 60, 0])hat_xy(2, 1, "tab");
//translate([ 0, 40, 0])hat_xy(2, 1, "cap");
//translate([ 0, 20, 0])hat_xy(2, 1, "shift");
//translate([ 0,  0, 0])hat_xy(2, 1, "ctrl");
}
else if(xx==2){
//translate([ 10, -10, 0])hat_chem(1, "H");
//
//translate([150, -10, 0])hat_chem(2, "He");
//
translate([ 10, -30, 0])hat_chem(3, "Li");
translate([ 30, -30, 0])hat_chem(4, "Be");
//
translate([ 50, -30, 0])hat_chem(5, "B");
translate([ 70, -30, 0])hat_chem(6, "C");
translate([ 90, -30, 0])hat_chem(7, "N");
translate([110, -30, 0])hat_chem(8, "O");
translate([130, -30, 0])hat_chem(9, "F");
translate([150, -30, 0])hat_chem(10,"Ne");
//
translate([ 10, -50, 0])hat_chem(11, "Na");
translate([ 30, -50, 0])hat_chem(12, "Mg");
//
translate([ 50, -50, 0])hat_chem(13, "Al");
translate([ 70, -50, 0])hat_chem(14, "Si");
translate([ 90, -50, 0])hat_chem(15, "P");
translate([110, -50, 0])hat_chem(16, "S");
translate([130, -50, 0])hat_chem(17, "Cl");
translate([150, -50, 0])hat_chem(18, "Ar");
//
translate([ 10, -70, 0])hat_chem(19, "K");
translate([ 30, -70, 0])hat_chem(20, "Ca");
//
translate([ 50, -70, 0])hat_chem(31, "Ga");
translate([ 70, -70, 0])hat_chem(32, "Ge");
translate([ 90, -70, 0])hat_chem(33, "As");
translate([110, -70, 0])hat_chem(34, "Se");
translate([130, -70, 0])hat_chem(35, "Br");
translate([150, -70, 0])hat_chem(36, "Kr");
//
translate([ 10, -90, 0])hat_chem(37, "Rb");
translate([ 30, -90, 0])hat_chem(38, "Sr");
//
translate([ 50, -90, 0])hat_chem(49, "In");
translate([ 70, -90, 0])hat_chem(50, "Sn");
translate([ 90, -90, 0])hat_chem(51, "Sb");
translate([110, -90, 0])hat_chem(52, "Te");
translate([130, -90, 0])hat_chem(53, "I");
translate([150, -90, 0])hat_chem(54, "Xe");
//
translate([ 10, -110, 0])hat_chem(55, "Cs");
translate([ 30, -110, 0])hat_chem(56, "Ba");
//
translate([ 50, -110, 0])hat_chem(81, "Tl");
translate([ 70, -110, 0])hat_chem(82, "Pb");
translate([ 90, -110, 0])hat_chem(83, "Bi");
translate([110, -110, 0])hat_chem(84, "Po");
translate([130, -110, 0])hat_chem(85, "At");
translate([150, -110, 0])hat_chem(86, "Rn");
//
translate([ 10, -130, 0])hat_chem(87, "Fr");
translate([ 30, -130, 0])hat_chem(88, "Ra");
//
translate([ 50, -130, 0])hat_chem(113, "Nh");
translate([ 70, -130, 0])hat_chem(114, "Fl");
translate([ 90, -130, 0])hat_chem(115, "Mc");
translate([110, -130, 0])hat_chem(116, "Lv");
translate([130, -130, 0])hat_chem(117, "Ts");
translate([150, -130, 0])hat_chem(118, "Og");
//
translate([ 10, -150, 0])hat_chem(119, "?");
translate([ 30, -150, 0])hat_chem(120, "?");
}
else if(xx==3){
//
translate([ 10, -10, 0])hat_chem(21, "Sc");
translate([ 30, -10, 0])hat_chem(22, "Ti");
translate([ 50, -10, 0])hat_chem(23, "V");
translate([ 70, -10, 0])hat_chem(24, "Cr");
translate([ 90, -10, 0])hat_chem(25, "Mn");
translate([110, -10, 0])hat_chem(26, "Fe");
translate([130, -10, 0])hat_chem(27, "Co");
translate([150, -10, 0])hat_chem(28, "Ni");
translate([170, -10, 0])hat_chem(29, "Cu");
translate([190, -10, 0])hat_chem(30, "Zn");
//
translate([ 10, -30, 0])hat_chem(39, "Y");
translate([ 30, -30, 0])hat_chem(40, "Zr");
translate([ 50, -30, 0])hat_chem(41, "Nb");
translate([ 70, -30, 0])hat_chem(42, "Mo");
translate([ 90, -30, 0])hat_chem(43, "Tc");
translate([110, -30, 0])hat_chem(44, "Ru");
translate([130, -30, 0])hat_chem(45, "Rh");
translate([150, -30, 0])hat_chem(46, "Pd");
translate([170, -30, 0])hat_chem(47, "Ag");
translate([190, -30, 0])hat_chem(48, "Cd");
//
translate([ 10, -50, 0])hat_chem(57, "La-Lu");
translate([ 30, -50, 0])hat_chem(72, "Hf");
translate([ 50, -50, 0])hat_chem(73, "Ta");
translate([ 70, -50, 0])hat_chem(74, "W");
translate([ 90, -50, 0])hat_chem(75, "Re");
translate([110, -50, 0])hat_chem(76, "Os");
translate([130, -50, 0])hat_chem(77, "Ir");
translate([150, -50, 0])hat_chem(78, "Pt");
translate([170, -50, 0])hat_chem(79, "Au");
translate([190, -50, 0])hat_chem(80, "Hg");
//
translate([ 10, -70, 0])hat_chem(89, "Ac-Lr");
translate([ 30, -70, 0])hat_chem(104, "Rf");
translate([ 50, -70, 0])hat_chem(105, "Db");
translate([ 70, -70, 0])hat_chem(106, "Sg");
translate([ 90, -70, 0])hat_chem(107, "Bh");
translate([110, -70, 0])hat_chem(108, "Hs");
translate([130, -70, 0])hat_chem(109, "Mt");
translate([150, -70, 0])hat_chem(110, "Ds");
translate([170, -70, 0])hat_chem(111, "Rg");
translate([190, -70, 0])hat_chem(112, "Cn");
}
else if(xx==10){
translate([ 10, 10, 0])top();
translate([-10, 10, 0])top();
translate([ 10,-10, 0])top();
translate([-10,-10, 0])top();
}
else if(xx==11){
translate([ 10, 10, 0])bot();
translate([-10, 10, 0])bot();
translate([ 10,-10, 0])bot();
translate([-10,-10, 0])bot();
}
else if(xx==12){
    for(y=[0:20:150]){
    for(x=[0:20:20]){
    translate([10+x, 10+y, 0])top();
    }
    }
}
else if(xx==13){
    difference(){
        union(){
            for(y=[0:20:140]){
                for(x=[0:20:60]){
                    translate([x,y,0])aa();
                }
            }
        }
        translate([50, 80, 1.6+1])cube([200, 5, 2], center=true);
    }
}
/*
else if(xx==6){
    bb();
}
else if(xx==7){
    for(y=[-20:20:20]){
    for(x=[-20:20:20]){
        translate([x,y,0])connectall();
    }
    }
}
*/
else if(xx==20){
    kkkkk();
}
else if(xx==21){
    for(y=[0:20:150]){
    for(x=[0:20:350]){
        translate([10+x,10+y,0])kkkkk();
    }
    }
}
else if(xx==30){
    special_8x18();
}
else if(xx==31){
    special_4x4();
}
else if(xx==99){
translate([ 10, -10, 0])hat_chem(1, "H");
translate([ 30, -10, 0])hat_chem(2, "He");
}