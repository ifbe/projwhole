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

module mid(){
difference(){
    cube([20,20,2],center=true);
    cube([14,14,99],center=true);
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




xx=5;
if(xx==0){
translate([ 10, 10, 0])hat("d");
translate([-10, 10, 0])hat("c");
translate([ 10,-10, 0])hat("b");
translate([-10,-10, 0])hat("a");
}
if(xx==1){
translate([ 0,100, 0])hat_xy(2, 1, "esc");
translate([ 0, 80, 0])hat_xy(2, 1, "~");
translate([ 0, 60, 0])hat_xy(2, 1, "tab");
translate([ 0, 40, 0])hat_xy(2, 1, "cap");
translate([ 0, 20, 0])hat_xy(2, 1, "shift");
translate([ 0,  0, 0])hat_xy(2, 1, "ctrl");
}
else if(xx==2){
translate([ 10, 10, 0])mid();
translate([-10, 10, 0])mid();
translate([ 10,-10, 0])mid();
translate([-10,-10, 0])mid();
}
else if(xx==3){
translate([ 10, 10, 0])bot();
translate([-10, 10, 0])bot();
translate([ 10,-10, 0])bot();
translate([-10,-10, 0])bot();
}
else if(xx==4){
    for(y=[-70:20:70]){
    for(x=[0:20:70]){
    translate([ x, y, 0])mid();
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



