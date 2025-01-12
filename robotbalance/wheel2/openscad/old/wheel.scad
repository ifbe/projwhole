difference(){
    cylinder(26, r=26,center=true,$fn=50);
    difference(){
        cylinder(30, r=2.6,center=true,$fn=50);
        translate([0,2.5,0])cube([10,0.3,100],center=true);
    }
    difference(){
        cylinder(20, r=30,center=true,$fn=50);
        cylinder(20, r=24,center=true,$fn=50);
    }
}