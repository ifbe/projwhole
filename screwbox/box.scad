module box20hole18(x,y){
difference(){
    translate([0,0,20/2])cube([20,20,20],center=true);
    translate([0,0,2+18/2])cube([18,18,18.1],center=true);
}
}
module box30hole25(x,y){
difference(){
    translate([0,0,20/2])cube([30,30,20],center=true);
    translate([0,0,2+18/2])cube([25,25,18.1],center=true);
}
}

translate([10,10,0])box20hole18();
translate([30,10,0])box20hole18();
translate([10,30,0])box20hole18();
translate([30,30,0])box20hole18();

translate([15,100,0])box30hole25();
translate([45,100,0])box30hole25();
translate([15,130,0])box30hole25();
translate([45,130,0])box30hole25();