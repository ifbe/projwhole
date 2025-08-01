
motor_diameter = 28;
motor_hole_dx = 16;
motor_hole_dy = 19;
//
propeller = 254;
motor_to_motor = 260;       //210 > bambu_p1s volume, propeller*1.5 = best
center_to_motor = motor_to_motor/1.414;

module arm_toseat(){
    //to motor
    difference(){
        union(){
        hull(){
        translate([-75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=16, center=true,$fn=50);
        translate([-35,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=6, center=true,$fn=50);
        }
        hull(){
        translate([-75, 0, -20/2])cube([0.001, 32, 20],center=true);
        translate([-35, 0, -20/2])cube([0.001, 12, 20],center=true);
        }
        }
        //-upper
        hull(){
        translate([-75,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=15, center=true,$fn=50);
        translate([-35,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=5, center=true,$fn=50);
        }
        //-below
        hull(){
        translate([-75, 0, -20/2])cube([0.001, 30, 18],center=true);
        translate([-35, 0, -20/2])cube([0.001, 10, 18],center=true);
        }
        translate([-35-25/2, 0, -40/2])cube([25, 10, 20],center=true);
    }
}
module arm_center(){
    width=60;
    translate([-5,0,0])difference(){
        rotate([0, 90, 0])scale([2, 1, 1])cylinder(width, r=6, center=true,$fn=50);
        rotate([0, 90, 0])scale([2, 1, 1])cylinder(999, r=5, center=true,$fn=50);
        translate([0, 0, -80/2])cube([ 999, 80, 80],center=true);
    }
    difference(){
        translate([-5, 0, -20/2])cube([width, 12, 20],center=true);
        translate([-5, 0, 1-20/2])cube([999, 10, 20],center=true);
        //
        translate([-25+25/2, 0, -40/2])cube([25, 10, 20],center=true);
        //translate([ 25-10/2, 0, -40/2])cube([10, 10, 20],center=true);
    }
}
module arm_tobody(){
    difference(){
        union(){
        hull(){
        translate([ 65,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=16, center=true,$fn=50);
        translate([ 25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=6, center=true,$fn=50);
        }
        hull(){
        translate([ 65, 0, -20/2])cube([0.001, 32, 20],center=true);
        translate([ 25, 0, -20/2])cube([0.001, 12, 20],center=true);
        }
        }

        hull(){
        translate([ 65,0,0])rotate([0, 90, 0])scale([0.8, 1, 1])cylinder(0.001, r=15, center=true,$fn=50);
        translate([ 25,0,0])rotate([0, 90, 0])scale([2, 1, 1])cylinder(0.001, r=5, center=true,$fn=50);
        }

        hull(){
        translate([ 75, 0, -20/2])cube([0.001, 30, 20],center=true);
        translate([ 25, 0, -20/2])cube([0.001, 10, 20],center=true);
        }

        translate([ 25+25/2, 0, -40/2])cube([25, 10, 20],center=true);
    }
}
module wing(){

    difference(){
        union(){
            //motor seat
            translate([0, 0, 5/2])cylinder(5, r=16, center=true,$fn=50);
            //curve
            translate([75, 0, 20])arm_toseat();
            translate([75, 0, 20])arm_center();
            translate([75, 0, 20])arm_tobody();
            //tobody
            //translate([150-10/2, 0, 32/2])rotate([0,90,0])cylinder(10, r=16, center=true,$fn=50);
            //translate([150-10/2, 0, 16/2])cube([10, 32, 16],center=true);
        }

        //motor area
        translate([0,0,5])rotate([0,20,0])translate([-20/2,0,20])cube([20, 99, 40],center=true);

        //-motor seat hole
        translate([0, 0, 3+20/2])cylinder(20, r=motor_diameter/2, center=true,$fn=50);

        //-cable
        translate([0+15, 0, 1+20/2])cylinder(20, r=5, center=true,$fn=50);

        //-screw hole
        translate([0, 0, 0])cylinder(9, r=4.5, center=true,$fn=50);
        translate([0, 0, 0])rotate([0,0,-45]){
        translate([0, 0+motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0, 0-motor_hole_dy/2, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0+motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        translate([0-motor_hole_dx/2, 0, 0])cylinder(9, r=1.6, center=true,$fn=50);
        //
        translate([0, 0+motor_hole_dy/2, 0.49])cylinder(1, r=3, center=true,$fn=50);
        translate([0, 0-motor_hole_dy/2, 0.49])cylinder(1, r=3, center=true,$fn=50);
        translate([0+motor_hole_dx/2, 0, 0.49])cylinder(1, r=3, center=true,$fn=50);
        translate([0-motor_hole_dx/2, 0, 0.49])cylinder(1, r=3, center=true,$fn=50);
        }

        //-arm
        //translate([150/2, 0, 1.2/2])cube([100, 10, 10],center=true);
        
        //tobody
        //translate([150, 0, 32/2])cube([30, 20, 20],center=true);
        //translate([150-5, 0, 0])cylinder(99, r=1.6, center=true,$fn=50);
        //translate([150-5, 0, 32/2])rotate([90,0,0])cylinder(99, r=1.6, center=true,$fn=50);
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


module outercircle(){
    height=16;
    difference(){
        translate([0,0,height/2])intersection(){
            cube([280,280,height],center=true);
            rotate([0,0,30])cube([280,280,height],center=true);
            rotate([0,0,60])cube([280,280,height],center=true);
        }
        //center
        cylinder(99, r=135, center=true,$fn=50);
        //
        translate([0,0,height/2])for(a=[0:30:350]){
            rotate([0,0,a]){
                cube([270+4, 5.8, 5.8],center=true);
                translate([0,-25,0])cube([280-6, 5.6, 5.8],center=true);
                translate([0, 25,0])cube([280-6, 5.6, 5.8],center=true);
            }
            //
            rotate([0,90,a]){
                cylinder(h=999, r=1.6, center=true, $fn=20);
                translate([0,-25,0])cylinder(h=999, r=1.6, center=true, $fn=20);
                translate([0, 25,0])cylinder(h=999, r=1.6, center=true, $fn=20);
            }
        }
        //debug
        translate([-100,0,11])cube([200, 999, 20],center=true);
        translate([100, 90,11])cube([200, 120, 20],center=true);
        translate([100,-90,11])cube([200, 120, 20],center=true);
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

xxx=2;
if(xxx==0){
wing();
//translate([50+20,0,0])body();
outercircle();
}
else if(xxx==1){
//wing();
translate([50,50,0])test();
}
else if(xxx==2){
    length = 140*tan(15)*0.999;
    height = length * sqrt(3)/2;
    points = [
        [0, 0],
        [length, 0],
        [length/2, height]
    ];

    linear_extrude(height = 2) polygon(points);
}