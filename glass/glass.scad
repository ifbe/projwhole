
module cam(){
difference(){
    translate([0,0,0.8])cube([28,28,1.6],center=true);
    //middle
    translate([0, 0, 0])cube([12,20,10],center=true);
    //hole
    translate([-21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}

radius=100;
module left(){
    difference(){
    union(){
        intersection(){
            translate([0,0,radius])rotate([90,0,0]){
                difference(){
                cylinder(h=50, r=radius,center=true,$fn=50);
                cylinder(h=99, r=radius-2,center=true,$fn=50);
                }
            }
            translate([0,0,25])cube([150,50,50],center=true);
        }
        translate([0, 0,1])cube([150,50,2],center=true);
    }

    //nose
    translate([0,-5,0])cylinder(110, r=9,center=true,$fn=50);
    translate([0,-15+0,0])cylinder(110, r=13,center=true,$fn=50);
    translate([0,-25+0,0])cylinder(110, r=18,center=true,$fn=50);
    //eye
    translate([-65/2,0,0])cylinder(110, r=22,center=true,$fn=50);
    translate([ 65/2,0,0])cylinder(110, r=22,center=true,$fn=50);
    //
    translate([-70,0,0])cube([2,20,99],center=true);
    translate([ 70,0,0])cube([2,20,99],center=true);
    }
    translate([ 75-1,0,18])cube([2,20,36],center=true);
    translate([-75+1,0,18])cube([2,20,36],center=true);
}


module glassframe(){
    translate([-100+1, 20, 10])cube([2,40,20],center=true);
    translate([ 100-1, 20, 10])cube([2,40,20],center=true);
    intersection(){
        translate([0,0,10])difference(){
        cylinder(h=20, r=100,center=true,$fn=50);
        cylinder(h=99, r=100-2,center=true,$fn=50);
        //
        translate([0,-100,5])cylinder(h=10, r=120,center=true,$fn=50);
        //
        translate([0, -100, 0])cube([40,100,100],center=true);
        }
        translate([0, -50, 0])cube([200,100,100],center=true);
    }
}



type = 1;
if(type==1){
    translate([-65/2,50/2+28/2,-0.2])rotate([0,0,-90])cam();
    translate([ 65/2,50/2+28/2,-0.2])rotate([0,0, 90])cam();

    left();
}
else if(type==2){
    glassframe();
}