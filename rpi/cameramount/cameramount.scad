//upper
difference(){
translate([0,0,4])cylinder(h=8,r=40,center=true,$fn=100);
translate([0,0,4])cylinder(h=9,r=38,center=true,$fn=100);
translate([0,40,4])cube([16,8,8],center=true);
}

//bottom
difference(){
translate([0,0,-4])cylinder(h=8,r=40,center=true,$fn=100);
translate([0,0,-4])cylinder(h=9,r=38,center=true,$fn=100);
translate([0,0,-4])cube([81,16,10],center=true);
translate([0,-40,-4])cube([1,5,10],center=true);
}

//#
translate([0,-9,-4])cube([80,2,8],center=true);
translate([0, 9,-4])cube([80,2,8],center=true);
translate([-9,-25,-4])cube([2,30,8],center=true);
translate([ 9,-25,-4])cube([2,30,8],center=true);
translate([-9, 25,-4])cube([2,30,8],center=true);
translate([ 9, 25,-4])cube([2,30,8],center=true);