
module one(){
difference(){
    translate([0,0,1/2])cube([50,50,1],center=true);
    cylinder(20, r=2.6,center=true,$fn=50);
    translate([-25/2,-25/2,0])cylinder(20, r=2.6,center=true,$fn=50);
    translate([ 25/2,-25/2,0])cylinder(20, r=2.6,center=true,$fn=50);
    translate([-25/2, 25/2,0])cylinder(20, r=2.6,center=true,$fn=50);
    translate([ 25/2, 25/2,0])cylinder(20, r=2.6,center=true,$fn=50);

    translate([0,   25,1.01-0.2/2])cube([50,0.2,0.2],center=true);
    translate([0, 12.5,1.01-0.2/2])cube([50,0.2,0.2],center=true);
    translate([0,    0,1.01-0.2/2])cube([50,0.2,0.2],center=true);
    translate([0,-12.5,1.01-0.2/2])cube([50,0.2,0.2],center=true);
    translate([0,-  25,1.01-0.2/2])cube([50,0.2,0.2],center=true);

    translate([   25,0,1.01-0.2/2])cube([0.2,50,0.2],center=true);
    translate([ 12.5,0,1.01-0.2/2])cube([0.2,50,0.2],center=true);
    translate([    0,0,1.01-0.2/2])cube([0.2,50,0.2],center=true);
    translate([-12.5,0,1.01-0.2/2])cube([0.2,50,0.2],center=true);
    translate([-  25,0,1.01-0.2/2])cube([0.2,50,0.2],center=true);
}
}

for(y=[0:1:3]){
for(x=[0:1:3]){
translate([25+50*x,25+50*y,0])one();
}
}
translate([    0.5,     100, 10])cube([1,200,20],center=true);
translate([200-0.5,     100, 10])cube([1,200,20],center=true);
translate([    100, 200-0.5, 10])cube([200,1,20],center=true);
translate([    100,     0.5, 10])cube([200,1,20],center=true);