
motor_diameter = 28;
motor_hole_dx = 16;
motor_hole_dy = 19;
//
propeller = 254;
motor_to_motor = 260;       //210 > bambu_p1s volume, propeller*1.5 = best
center_to_motor = motor_to_motor/1.414;

module haha(){
    width=center_to_motor-60-16;
    rotate([90, 0, 0]){
        difference(){
        scale([1, 1.25, 1])cylinder(width, r=16, center=true,$fn=50);
        scale([1, 1.25, 1])cylinder(199, r=15, center=true,$fn=50);
        translate([0, -80/2, 0])cube([ 80, 80, 999],center=true);
        }
    }
    difference(){
        translate([0, 0, -20/2])cube([32, width, 20],center=true);
        translate([0, 0, -20/2])cube([30, width+1, 99],center=true);
    }
}

difference(){
    union(){
    //motor seat
    translate([ motor_to_motor/2, motor_to_motor/2, 5/2])cylinder(5, r=15, center=true,$fn=50);
    translate([-motor_to_motor/2, motor_to_motor/2, 5/2])cylinder(5, r=15, center=true,$fn=50);
    translate([ motor_to_motor/2,-motor_to_motor/2, 5/2])cylinder(5, r=15, center=true,$fn=50);
    translate([-motor_to_motor/2,-motor_to_motor/2, 5/2])cylinder(5, r=15, center=true,$fn=50);
    //arm
    hull(){
    rotate([0, 0, 45])translate([0, 0, 5/2])cube([center_to_motor*2, 30, 5],center=true);
    rotate([0, 0, 45])translate([0, 0, 20/2])cube([120, 30, 20],center=true);
    }
    hull(){
    rotate([0, 0,-45])translate([0, 0, 5/2])cube([center_to_motor*2, 30, 5],center=true);
    rotate([0, 0,-45])translate([0, 0, 20/2])cube([120, 30, 20],center=true);
    }
    //battery
    translate([0, 0, 40/2])cube([100, 100, 40],center=true);
    //power
    //translate([0, 0,-40/2])cube([motor_to_motor/2,motor_to_motor/2,40],center=true);
    }

    //-motor seat hole
    for(a=[0:90:270]){
        rotate([0,0,a]){
        //
        translate([motor_to_motor/2, motor_to_motor/2, 2+20/2])cylinder(20, r=motor_diameter/2, center=true,$fn=50);
        translate([motor_to_motor/2-10, motor_to_motor/2-10, 1+20/2])cylinder(20, r=5, center=true,$fn=50);
        //hole
        translate([motor_to_motor/2, motor_to_motor/2, 0])cylinder(99, r=4.5, center=true,$fn=50);
        translate([motor_to_motor/2, motor_to_motor/2+motor_hole_dy/2, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([motor_to_motor/2, motor_to_motor/2-motor_hole_dy/2, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([motor_to_motor/2+motor_hole_dx/2, motor_to_motor/2, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([motor_to_motor/2-motor_hole_dx/2, motor_to_motor/2, 0])cylinder(99, r=1.6, center=true,$fn=50);
        }
    }
    //-arm
    for(a=[45:90:360]){
        width=center_to_motor-60-16;
        rotate([0, 0, a])translate([-60-width/2, 0, 2+50/2])cube([width, 26, 50],center=true);
        //
        rotate([0, 0, a])translate([-60, 0, 10/2])cube([20, 12, 10.01],center=true);
    }
    //-battery
    translate([0, 0, 40/2+0.01])cube([ 80, 80, 40],center=true);
    translate([0, 45, 0])cube([50, 6, 99],center=true);
    translate([0,-45, 0])cube([50, 6, 99],center=true);
    translate([ 45,0, 0])cube([6, 50, 99],center=true);
    translate([-45,0, 0])cube([6, 50, 99],center=true);
    //-power
    translate([0, 0,-40+38/2])cube([ 80, 80,38.01],center=true);
    translate([-40+10/2, 0,0-2/2])cube([ 10, 10, 3],center=true);
    translate([ 40-10/2, 0,0-2/2])cube([ 10, 10, 3],center=true);
}
width=center_to_motor-60-16;
rotate([0, 0, 45])translate([0, 60+width/2, 20])haha();