
motor_diameter = 28;
motor_hole_dx = 16;
motor_hole_dy = 19;
//
propeller = 254;
motor_to_motor = 260;       //210 > bambu_p1s volume, propeller*1.5 = best
center_to_motor = motor_to_motor/1.414;

module thecurve(){
    width=200;
        difference(){
        rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(width, r=16, center=true,$fn=50);
        rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(999, r=15, center=true,$fn=50);
        translate([0, 0, -80/2])cube([ 999, 80, 80],center=true);
    }
    difference(){
        translate([0, 0, -20/2])cube([200, 32, 20],center=true);
        translate([0, 0, -20/2])cube([999, 30, 99],center=true);
    }
}
module wing(){

    difference(){
        union(){
            //curve
            translate([-100, 0, 20])thecurve();
            //motor seat
            translate([-200, 0, 5/2])cylinder(5, r=15, center=true,$fn=50);
            //arm
            hull(){
            translate([-200, 0, 1.2/2])cube([0.1, 30, 1.2],center=true);
            translate([-100, 0, 1.2/2])cube([0.1, 30, 1.2],center=true);
            }
            //
            translate([-10/2, 0, 32/2])cube([10, 32, 32],center=true);
        }

        //-motor seat hole
        translate([-200, 0, 2+20/2])cylinder(20, r=motor_diameter/2, center=true,$fn=50);
        translate([-200+15, 0, 1+20/2])cylinder(20, r=5, center=true,$fn=50);

        //hole
        translate([-200, 0, 0])cylinder(9, r=4.5, center=true,$fn=50);
        translate([-200, 0, 0])rotate([0,0,-45]){
        translate([0, 0+motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0, 0-motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0+motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0-motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        }

        //-arm
       // translate([-200, 0, 2+50/2])cube([width, 26, 50],center=true);
        //rotate([0, 0, a])translate([-60, 0, 10/2])cube([20, 12, 10.01],center=true);
        
        //
        translate([-2, 0, 32/2])cube([20, 20, 20],center=true);
        translate([-5, 0, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([-5, 0, 32/2])rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
    }
}

module body(){
    difference(){
        union(){
        //battery
        translate([0, 0, 40/2])cube([100, 100, 40],center=true);
        //power
        //translate([0, 0,-40/2])cube([motor_to_motor/2,motor_to_motor/2,40],center=true);
        }

        //-battery
        translate([0, 0, 40/2+0.01])cube([ 80, 80, 40],center=true);
        //-power
        translate([0, 0,-40+38/2])cube([ 80, 80,38.01],center=true);
        translate([-40+10/2, 0,0-2/2])cube([ 10, 10, 3],center=true);
        translate([ 40-10/2, 0,0-2/2])cube([ 10, 10, 3],center=true);
    }
    
    //
    difference(){
        translate([-50-10/2, 0, 32/2])cube([ 10, 20, 20],center=true);
        //
        translate([-50-5, 0, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([-50-5, 0, 32/2])rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
    }
}




//------------preview-----------
/*
wing();
translate([50+20,0,0])body();
*/



//-------------print------------
intersection(){
translate([200,0,0])wing();
translate([0,0,50/2])cube([ 50, 50, 50],center=true);
}