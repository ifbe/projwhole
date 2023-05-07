module batt1865(x,y){
    translate([0,0,65/2])cylinder(65, r=9,center=true,$fn=50);
}

module batt2170(x,y){
    translate([0,0,65/2])cylinder(65, r=9,center=true,$fn=50);
}

module batt2665(x,y){
    translate([0,0,65/2])cylinder(65, r=9,center=true,$fn=50);
}

translate([10,10,0])batt1865();
translate([30,10,0])batt1865();
translate([10,30,0])batt1865();
translate([30,30,0])batt1865();