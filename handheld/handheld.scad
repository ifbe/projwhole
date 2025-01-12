

module haha(){
    translate([50,0,0])difference(){
    circle(r=12,center=true,$fn=50);
    circle(r=10,center=true,$fn=50);
    translate([12,0,0])square([12,100], center=true);
    }
}

//haha();
rotate([90,0,0])rotate_extrude(angle=180)haha();

