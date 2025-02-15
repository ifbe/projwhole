//property of dji flip circle
height=52;
diameter=115+0.4;
radius=diameter/2;

difference(){
    union(){
        //upper cylinder
        translate([0,0,60])rotate([0,90,0])cylinder(h=height+2,r=30,center=true,$fn=100);
        //bottom cylinder(half)
        intersection(){
        translate([0,0,60])rotate([0,90,0])cylinder(h=height+2,r=radius+1,center=true,$fn=100);
        translate([0,0,60/2])cube([99,999,60],center=true);
        }
        //stand
        translate([-height/2-1/2,0, 0])cube([1,42,10],center=true);
        translate([ height/2+1/2,0, 0])cube([1,42,10],center=true);
        translate([ 0,-40/2-1/2, 0])cube([height, 1,10],center=true);
        translate([ 0, 40/2+1/2, 0])cube([height, 1,10],center=true);
    }

    //1.dji flip it self
    translate([0,0,60])rotate([0,90,0])cylinder(h=height,r=radius,center=true,$fn=100);
    //2.upper cylinder: center
    translate([0,0,60])rotate([0,90,0])cylinder(h=999,r=10,center=true,$fn=100);
    //3.bottom cylinder: line
    for(i=[0:360/16:359]){
        translate([0,0,60])rotate([i,0,0])translate([0,40,0])cube([100,20,1],center=true);
    }
    //3.bottom cylinder: bottom
    translate([0,0,0])cube([height,40,100],center=true);
    //4.stand: marker line z=0, z=1
    translate([0,0,1])cube([100,20,0.2],center=true);
    translate([0,0,0])cube([100,20,0.2],center=true);
}
