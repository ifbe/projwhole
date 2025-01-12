
module cam(){
difference(){
    cube([28,28,1.6],center=true);
    //middle
    translate([0, 0, 0])cube([12,20,10],center=true);
    //hole
    translate([-21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}

translate([-65/2,40/2+28/2,-0.2])rotate([0,0,-90])cam();
translate([ 65/2,40/2+28/2,-0.2])rotate([0,0, 90])cam();

difference(){
cube([160,40,2],center=true);
//
translate([0,-20,0])cylinder(110, r=18,center=true,$fn=50);
//
translate([-65/2,0,0])cylinder(110, r=18,center=true,$fn=50);
translate([ 65/2,0,0])cylinder(110, r=18,center=true,$fn=50);
//
translate([-70,0,0])cube([2,20,9],center=true);
translate([ 70,0,0])cube([2,20,9],center=true);
}