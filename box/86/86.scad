
module cover(){
    difference(){
    translate([0, 0, 10])cube([90, 90, 20],center=true);
    translate([0, 0, 20-19/2])cube([86.8, 86.8, 19.01],center=true);
    //
    translate([90/2-(90-32)/2, 0, 5])cube([90-32, 99, 10.01],center=true);
    }
}


cover();