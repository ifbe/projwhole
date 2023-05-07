module one(x,y){
    difference(){
        translate([0,0,10/2])cube([20,20,10],center=true);

        translate([0,0,0])cylinder(200, r=9.4,center=true,$fn=50);
        //translate([0,0,0])cylinder(100, r=2.5,center=true,$fn=50);

        translate([+10,+10,0])cylinder(200, r=2.7,center=true,$fn=50);
        translate([-10,-10,0])cylinder(200, r=2.7,center=true,$fn=50);
        translate([-10,+10,0])cylinder(200, r=2.7,center=true,$fn=50);
        translate([+10,-10,0])cylinder(200, r=2.7,center=true,$fn=50);

    }
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

translate([10,50,0])rotate([0,0,-90])one();
translate([30,50,0])rotate([0,0,-90])one();
translate([50,50,0])rotate([0,0,-90])one();
translate([70,50,0])rotate([0,0,-90])one();
translate([90,50,0])rotate([0,0,-90])one();
translate([110,50,0])rotate([0,0,-90])one();

translate([10,70,0])one();
translate([30,70,0])one();
translate([50,70,0])one();
translate([70,70,0])one();
translate([90,70,0])one();
translate([110,70,0])one();

translate([10,90,0])one();
translate([30,90,0])one();
translate([50,90,0])one();
translate([70,90,0])one();
translate([90,90,0])one();
translate([110,90,0])one();

translate([10,110,0])one();
translate([30,110,0])one();
translate([50,110,0])one();
translate([70,110,0])one();
translate([90,110,0])one();
translate([110,110,0])one();