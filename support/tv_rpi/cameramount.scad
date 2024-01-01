holerad=2.5;
module pi(){
difference(){
translate([0,0,-5])cube([90,13+4,10],center=true);
translate([0,0,-5])cube([90.01,13.01,10],center=true);
}
difference(){
    translate([0,0,1])cube([90,60,2],center=true);
    translate([20-60,-24.5, 1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-60, 24.5, 1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-2,-24.5,  1])cylinder(4, r=holerad,center=true,$fn=50);
    translate([20-2, 24.5,  1])cylinder(4, r=holerad,center=true,$fn=50);
}
}


module speaker(){
    
    difference(){
    translate([0,0,-5])cube([50,13+4,10],center=true);
    translate([0,0,-5])cube([50.01,13.01,10],center=true);
    }

    difference(){
        translate([0,0,10])cube([50,25,20],center=true);
        translate([0,0,10+2])cube([45,21,20],center=true);
        translate([0,0,10+2])cube([55,15,20],center=true);
    }
}



module landing(){
    difference(){
    translate([0,0,-5])cube([100,13+4,10],center=true);
    translate([0,0,-5])cube([100.01,13.01,10],center=true);
    }
    difference(){
        translate([0,0,5])cube([100,70,10],center=true);
        translate([0,0,6])cube([96,66,8],center=true);
    }
}




//pi();

speaker();

//landing();