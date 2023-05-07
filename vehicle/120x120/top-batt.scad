module one(x,y){
    difference(){
        translate([0,0,5])cube([20,20,10],center=true);

        translate([0,0,5+1])cylinder(10, r=9.4,center=true,$fn=50);
        translate([0,0,0])cylinder(100, r=2.5,center=true,$fn=50);

        translate([+10,+10,0])cylinder(66, r=2.6,center=true,$fn=50);
        translate([-10,-10,0])cylinder(66, r=2.6,center=true,$fn=50);
        translate([-10,+10,0])cylinder(66, r=2.6,center=true,$fn=50);
        translate([+10,-10,0])cylinder(66, r=2.6,center=true,$fn=50);

        rotate([0,0,45])translate([19,0,1])cube([20,5.4,2.01],center=true);
        rotate([0,0,135])translate([19,0,1])cube([20,5.4,2.01],center=true);
        rotate([0,0,225])translate([19,0,1])cube([20,5.4,2.01],center=true);
        rotate([0,0,315])translate([19,0,1])cube([20,5.4,2.01],center=true);
    }
    translate([0,-9.75,0.5])cube([10,0.5,1],center=true);
    translate([0, 9.75,0.5])cube([10,0.5,1],center=true);
    translate([-9.75,0,0.5])cube([0.5,10,1],center=true);
    translate([ 9.75,0,0.5])cube([0.5,10,1],center=true);
}

translate([10,10,0])rotate([0,0,-90])one();
translate([30,10,0])rotate([0,0,-90])one();
translate([50,10,0])rotate([0,0,-90])one();
translate([70,10,0])rotate([0,0,-90])one();
translate([90,10,0])rotate([0,0,-90])one();
translate([110,10,0])rotate([0,0,-90])one();

translate([10,30,0])rotate([0,0,-90])one();
translate([30,30,0])rotate([0,0,-90])one();
translate([50,30,0])rotate([0,0,-90])one();
translate([70,30,0])rotate([0,0,-90])one();
translate([90,30,0])rotate([0,0,-90])one();
translate([110,30,0])rotate([0,0,-90])one();
