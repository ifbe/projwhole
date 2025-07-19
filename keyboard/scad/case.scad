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


xx=2;
if(xx==1){
    for(y=[0:20:140]){
        for(x=[0:20:60]){
            translate([x,y,0])aa();
        }
    }
}
else if(xx==2){
    bb();
}