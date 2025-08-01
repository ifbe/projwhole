module hat(mystr){
    difference(){
        hull(){
            translate([0,0,2-0.001/2])cube([18, 18, 0.001],center=true);
            translate([0,0,  0.001/2])cube([19, 19, 0.001],center=true);
        }
        translate([0,0,2.001-1])linear_extrude(height=1)text(mystr, size=10, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
    }
    difference(){
        hull(){
            translate([0,0, 0])cube([19, 19, 0.001],center=true);
            translate([0,0, -2+0.001/2])cube([19.8, 19.8, 0.001],center=true);
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
    }
}

module hat_xy(xsize, ysize, mystr){
    difference(){
        hull(){
            translate([0,0,2-0.001/2])cube([20*xsize-2, 18, 0.001],center=true);
            translate([0,0,  0.001/2])cube([20*xsize-1, 19, 0.001],center=true);
        }
        translate([0,0,2.001-1])linear_extrude(height=1)text(mystr, size=10, halign="center", valign = "center", spacing=1, direction="ltr", language="zh", script="latin");
    }
    difference(){
        hull(){
            translate([0,0, 0])cube([20*xsize-1, 19, 0.001],center=true);
            translate([0,0, -2+0.001/2])cube([20*xsize-0.2, 19.8, 0.001],center=true);
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
    translate([ 10, 10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
    translate([-10, 10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
    translate([ 10,-10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
    translate([-10,-10, 0])cylinder(h=99,r=1.2,center=true,$fn=50);
    //
    translate([ 0, 10, 0])cylinder(h=99,r=1.0,center=true,$fn=50);
    translate([ 0,-10, 0])cylinder(h=99,r=1.0,center=true,$fn=50);
}
}


module bot(){
difference(){
    cube([20,20,2],center=true);
    //
    cylinder(h=99,r=2.1,center=true,$fn=50);
    //
    translate([-3.81, 2.54, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([ 2.54, 5.08, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
    //
    translate([0, -6, 0])cube([4,4,99],center=true);
    //
    translate([-10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([ 10, 0, 1-0.2/2])cube([0.2,20,0.2],center=true);
    translate([0, -10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    translate([0,  10, 1-0.2/2])cube([20,0.2,0.2],center=true);
    //
    translate([ 10, 10, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-10, 10, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([ 10,-10, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
    translate([-10,-10, 0])cylinder(h=99,r=1.6,center=true,$fn=50);
}
}


module aa(){
    difference(){
    translate([10, 10-(10-2.6)/2, 1+4])cube([20-5.2, 10-2.6, 10],center=true);
    translate([10, 10, 1+4])cube([12,12,99],center=true);
    }
    difference(){
    translate([10, 10, 1])cube([20,20,2],center=true);
    translate([10, 10, 1])cube([20-5.2, 20-5.2, 99],center=true);
    for(x=[0:2.5:20])translate([x, 20, 0])cylinder(h=9,r=0.8,center=true, $fn=8);
    for(x=[0:2.5:20])translate([x,  0, 0])cylinder(h=9,r=0.8,center=true, $fn=8);
    for(y=[2.5:2.5:17.5])translate([20, y, 0])cylinder(h=9,r=0.8,center=true, $fn=8);
    for(y=[2.5:2.5:17.5])translate([ 0, y, 0])cylinder(h=9,r=0.8,center=true, $fn=8);
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
        //
        cube([15, 15, 99], center=true);
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


xx=9;
if(xx==0){
translate([ 10, 10, 0])hat("d");
translate([-10, 10, 0])hat("c");
translate([ 10,-10, 0])hat("b");
translate([-10,-10, 0])hat("a");
}
else if(xx==1){
translate([ 0,100, 0])hat_xy(2, 1, "esc");
translate([ 0, 80, 0])hat_xy(2, 1, "~");
translate([ 0, 60, 0])hat_xy(2, 1, "tab");
translate([ 0, 40, 0])hat_xy(2, 1, "cap");
translate([ 0, 20, 0])hat_xy(2, 1, "shift");
translate([ 0,  0, 0])hat_xy(2, 1, "ctrl");
}
else if(xx==2){
translate([ 10, 10, 0])top();
translate([-10, 10, 0])top();
translate([ 10,-10, 0])top();
translate([-10,-10, 0])top();
}
else if(xx==3){
translate([ 10, 10, 0])bot();
translate([-10, 10, 0])bot();
translate([ 10,-10, 0])bot();
translate([-10,-10, 0])bot();
}
else if(xx==4){
    for(y=[0:20:70]){
    for(x=[0:20:70]){
    translate([10+x, 10+y, 0])top();
    }
    }
}
else if(xx==5){
    for(y=[0:20:140]){
        for(x=[0:20:60]){
            translate([x,y,0])aa();
        }
    }
}
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
else if(xx==8){
    kkkkk();
}
else if(xx==9){
    for(y=[0:20:150]){
    for(x=[0:20:70]){
        translate([10+x,10+y,0])kkkkk();
    }
    }
}
