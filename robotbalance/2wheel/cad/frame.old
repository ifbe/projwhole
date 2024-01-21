difference(){
    union(){
        cube([150+2,200+2,50],center=true);
        //cube([200+2,    2,50],center=true);

        translate([  0, 25,0])cube([160, 10,50],center=true);
        translate([  0,-25,0])cube([160, 10,50],center=true);
        //cube([202,25,50],center=true);

        //translate([-100,0,0])cube([2,25,50],center=true);
        //translate([ 100,0,0])cube([2,25,50],center=true);
    }


    //--------------------left--------------------
    translate([-100,0, 25])rotate([0,-45,0])cube([200,200,17.67766952966369],center=true);
    translate([-100,0,-25])rotate([0, 45,0])cube([200,200,17.67766952966369],center=true);


    //--------------------right--------------------
    translate([ 100,0, 25])rotate([0, 45,0])cube([200,200,17.67766952966369],center=true);
    translate([ 100,0,-25])rotate([0,-45,0])cube([200,200,17.67766952966369],center=true);


    //---------------- ??? to top ----------------
    translate([  0,100, 25])rotate([-45,0,0])cube([200,200,17.67766952966369],center=true);
    translate([  0,100,-25])rotate([ 45,0,0])cube([200,200,17.67766952966369],center=true);


    //--------------------top------------------
    translate([  0, 75,0])cube([60,44,51],center=true);
    translate([  0, 75,0])cube([60,48,46],center=true);

    translate([  0, 75,0])cube([48,48,51],center=true);
    translate([-50, 75,0])cube([48,48,51],center=true);
    translate([ 50, 75,0])cube([48,48,51],center=true);

    rotate([0,90,0])translate([    0,      75,0])cylinder(1000, r=11.2,center=true,$fn=50);
    rotate([0,90,0])translate([ 15.5, 15.5+75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5, 15.5+75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5,-15.5+75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([ 15.5,-15.5+75,0])cylinder(1000, r=1.6,center=true,$fn=20);


    //----------------- top to mid+ ---------------
    translate([  0, 50,0])cube([148,3,18],center=true);


    //--------------------- mid+ ------------------
    translate([  0, 25,0])cube([60,44,51],center=true);
    translate([  0, 25,0])cube([60,48,46],center=true);

    translate([  0, 25,0])cube([48,48,51],center=true);
    translate([-50, 25,0])cube([48,48,51],center=true);
    translate([ 50, 25,0])cube([48,48,51],center=true);

    translate([  0, 25,0])cube([156,2.4,51],center=true);
    translate([  0, 25,0])cube([190, 25, 16],center=true);


    //-------------------- z=0 plane --------------------
    translate([  0, 0,0])cube([148,3,18],center=true);


    //--------------------- mid- --------------------
    translate([  0,-25,0])cube([60,44,51],center=true);
    translate([  0,-25,0])cube([60,48,46],center=true);

    translate([  0,-25,0])cube([48,48,51],center=true);
    translate([-50,-25,0])cube([48,48,51],center=true);
    translate([ 50,-25,0])cube([48,48,51],center=true);

    translate([  0,-25,0])cube([156,2.4,51],center=true);
    translate([  0,-25,0])cube([190, 25, 16],center=true);


    //----------------- bot to mid+ ---------------
    translate([  0,-50,0])cube([148,3,18],center=true);


    //--------------------- bot -------------------
    //translate([0,-75,0])rotate([0,90,0])cylinder(1000, r=25,center=true,$fn=50);
    translate([  0,-75,0])cube([60,44,51],center=true);
    translate([  0,-75,0])cube([60,48,46],center=true);

    translate([  0,-75,0])cube([48,48,51],center=true);
    translate([-50,-75,0])cube([48,48,51],center=true);
    translate([ 50,-75,0])cube([48,48,51],center=true);

    rotate([0,90,0])translate([    0,     -75,0])cylinder(1000, r=11.2,center=true,$fn=50);
    rotate([0,90,0])translate([ 15.5, 15.5-75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5, 15.5-75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5,-15.5-75,0])cylinder(1000, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([ 15.5,-15.5-75,0])cylinder(1000, r=1.6,center=true,$fn=20);


    //---------------- ??? to bot ----------------
    translate([0,-100, 25])rotate([ 45,0,0])cube([200,200,17.67766952966369],center=true);
    translate([0,-100,-25])rotate([-45,0,0])cube([200,200,17.67766952966369],center=true);
}