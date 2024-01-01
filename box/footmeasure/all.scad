
module aa(){
difference(){
cube([200,100,100],center=true);
translate([2,2,2])cube([200,100,100],center=true);
}
}


module bb(){
difference(){
cylinder(r=9,h=20,center=true,$fn=100);
cylinder(r=7,h=20,center=true,$fn=100);
}
}


bb();