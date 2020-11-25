module haha(xx,yy){
difference(){
    translate([xx,yy,0])cube([30,10,10],center=true);

    translate([xx+5,yy,0])cube([20+1,10+1,2.4],center=true);

    translate([xx+ 0,yy,0])cylinder(11, r=1.6,center=true,$fn=50);
    translate([xx+10,yy,0])cylinder(11, r=1.6,center=true,$fn=50);
    translate([xx-10,yy,0])cylinder(11, r=1.6,center=true,$fn=50);
}
}

haha(-20,-30);
haha( 20,-30);
haha(-20,-10);
haha( 20,-10);
haha(-20, 10);
haha( 20, 10);
haha(-20, 30);
haha( 20, 30);