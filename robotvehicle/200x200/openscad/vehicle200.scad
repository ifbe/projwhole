

module wheel(){
    rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}
module notprint_wheel(){
    translate([-100,-100,-20])wheel();
    translate([ 100,-100,-20])wheel();
    translate([-100, 100,-20])wheel();
    translate([ 100, 100,-20])wheel();
}

module battone(){
    cube([40,80,40],center=true);
}
module notprint_batt(){
    translate([-40, 40,-20])battone();
    translate([  0, 40,-20])battone();
    translate([ 40, 40,-20])battone();
    translate([-40,-40,-20])battone();
    translate([  0,-40,-20])battone();
    translate([ 40,-40,-20])battone();
}

module boardone(){
    difference(){
        cube([200,200,40],center=true);
        cube([120,160,50],center=true);
        translate([-80,-70,0])cube([40,60,50],center=true);
    }
}
module board(){
    translate([0,0,-20])boardone();
}


/*
color("#ffff00")translate([0,0,80])cube([2,200,0.00000001],center=true);
color("#ffff00")translate([0,0,80])cube([200,2,0.00000001],center=true);

color("#ff00ff")translate([0,0,40])cube([2,200,0.00000001],center=true);
color("#ff00ff")translate([0,0,40])cube([200,2,0.00000001],center=true);

color("#ff00ff")cube([2,200,0.00000001],center=true);
color("#ff00ff")cube([200,2,0.00000001],center=true);

color("#ffff00")translate([0,0,-40])cube([2,200,0.00000001],center=true);
color("#ffff00")translate([0,0,-40])cube([200,2,0.00000001],center=true);
*/


//--------for preview--------
board();
notprint_batt();
notprint_wheel();


//--------for print--------


//--------for test--------


//--------for delete--------