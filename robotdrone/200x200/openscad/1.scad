
motor_diameter = 28;
motor_hole_dx = 16;
motor_hole_dy = 19;
//
propeller = 254;
motor_to_motor = 260;       //210 > bambu_p1s volume, propeller*1.5 = best
center_to_motor = motor_to_motor/1.414;

module thecurve(){
    width=50;
    //to motor
    difference(){
        union(){
        hull(){
        translate([-75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=15, center=true,$fn=50);
        translate([-25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=6, center=true,$fn=50);
        }
        hull(){
        translate([-75, 0, -20/2])cube([0.001, 30, 20],center=true);
        translate([-25, 0, -20/2])cube([0.001, 12, 20],center=true);
        }
        }
        //-upper
        hull(){
        translate([-75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=14, center=true,$fn=50);
        translate([-25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=5, center=true,$fn=50);
        }
        //-below
        hull(){
        translate([-75, 0, -20/2])cube([0.001, 28, 18],center=true);
        translate([-25, 0, -20/2])cube([0.001, 10, 18],center=true);
        }
        translate([-25-25/2, 0, -40/2])cube([25, 10, 20],center=true);
    }

    //esc
    difference(){
        rotate([0, 90, 0])scale([2, 1, 1])cylinder(width, r=6, center=true,$fn=50);
        rotate([0, 90, 0])scale([2, 1, 1])cylinder(999, r=5, center=true,$fn=50);
        translate([0, 0, -80/2])cube([ 999, 80, 80],center=true);
    }
    difference(){
        translate([0, 0, -20/2])cube([50, 12, 20],center=true);
        translate([0, 0, 1-20/2])cube([999, 10, 20],center=true);
        //
        translate([-25+25/2, 0, -40/2])cube([25, 10, 20],center=true);
        //translate([ 25-10/2, 0, -40/2])cube([10, 10, 20],center=true);
    }

    //to body
    difference(){
        union(){
        hull(){
        translate([ 75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=15, center=true,$fn=50);
        translate([ 25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=6, center=true,$fn=50);
        }
        hull(){
        translate([ 75, 0, -20/2])cube([0.001, 30, 20],center=true);
        translate([ 25, 0, -20/2])cube([0.001, 12, 20],center=true);
        }
        }
        //
        hull(){
        translate([ 75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=14, center=true,$fn=50);
        translate([ 25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=5, center=true,$fn=50);
        }
        hull(){
        translate([ 75, 0, -20/2])cube([0.001, 28, 20],center=true);
        translate([ 25, 0, -20/2])cube([0.001, 10, 20],center=true);
        }
        translate([ 25+25/2, 0, -40/2])cube([25, 10, 20],center=true);
    }
}
module wing(){

    difference(){
        union(){
            //curve
            translate([75, 0, 20])thecurve();
            //motor seat
            translate([0, 0, 5/2])cylinder(5, r=15, center=true,$fn=50);
            //arm
/*            hull(){
            translate([0, 0, 1.2/2])cube([0.1, 30, 1.2],center=true);
            translate([150, 0, 1.2/2])cube([0.1, 30, 1.2],center=true);
            }*/
            //tobody
            translate([150-10/2, 0, 32/2])rotate([0,90,0])cylinder(10, r=16, center=true,$fn=50);
            translate([150-10/2, 0, 16/2])cube([10, 32, 16],center=true);
        }

        //
        translate([0,0,5])rotate([0,30,0])translate([-20/2,0,20])cube([20, 99, 40],center=true);

        //-motor seat hole
        translate([0, 0, 2+20/2])cylinder(20, r=motor_diameter/2, center=true,$fn=50);
        translate([0+15, 0, 1+20/2])cylinder(20, r=5, center=true,$fn=50);

        //hole
        translate([0, 0, 0])cylinder(9, r=4.5, center=true,$fn=50);
        translate([0, 0, 0])rotate([0,0,-45]){
        translate([0, 0+motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0, 0-motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0+motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0-motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        }

        //-arm
        //translate([150/2, 0, 1.2/2])cube([100, 10, 10],center=true);
        
        //tobody
        translate([150, 0, 32/2])cube([30, 20, 20],center=true);
        translate([150-5, 0, 0])cylinder(99, r=1.6, center=true,$fn=50);
        translate([150-5, 0, 32/2])rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
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

module test()
{
    translate([-25,0,0])difference(){
        union(){
        cube([ 10, 20-0.2, 20-0.2],center=true);
        }
        translate([0, 0, 0])cube([ 99, 16, 16],center=true);
        //
        cylinder(99, r=1.6, center=true,$fn=50);
        //
        rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
    }
    translate([-15,0,0])difference(){
        cube([ 10, 24, 24],center=true);
        cube([ 10, 10, 99],center=true);
        rotate([0,90,0])cylinder(99, r=8, center=true,$fn=50);
    }
    difference(){
        rotate([0,90,0])cylinder(20, r=10, center=true,$fn=50);
        rotate([0,90,0])cylinder(99, r=8, center=true,$fn=50);
    }
    
    translate([ 15,0,0])difference(){
        cube([ 10, 24, 24],center=true);
        cube([ 10, 10, 99],center=true);
        rotate([0,90,0])cylinder(99, r=8, center=true,$fn=50);
    }
    translate([ 25,0,0])difference(){
        union(){
        cube([ 10, 20-0.2, 20-0.2],center=true);
        }
        translate([0, 0, 0])cube([ 99, 16, 16],center=true);
        //
        cylinder(99, r=1.6, center=true,$fn=50);
        //
        rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
    }
}


if(0){      //------------preview-----------
wing();
//translate([50+20,0,0])body();
}

else{       //-------------print------------
//wing();
translate([50,50,0])test();
}