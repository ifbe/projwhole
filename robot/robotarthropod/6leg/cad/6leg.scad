
module claw(){
    shaft_to_left = 6;
    shaft_to_edge = 23;
    difference(){
    union(){
    //top
    translate([14/2, 0, 31+3/2])cube([8+14, 9, 3],center=true);
    //main
    translate([-shaft_to_left+(shaft_to_left+shaft_to_edge+2)/2, 0, -2+(2+2+27+2)/2])cube([shaft_to_left+shaft_to_edge+2, 10, 2+2+27+2],center=true);
    }
    //-top
    hull(){
    translate([0, 0, 34-2/2])cylinder(r=3, h=2.01, center=true, $fn=50);
    translate([14.5, 0, 34-2/2])cylinder(r=2, h=2.01, center=true, $fn=50);
    }
    //center
    translate([-shaft_to_left+(shaft_to_left+shaft_to_edge)/2,0,0])translate([0, 0, (2+27)/2])cube([shaft_to_left+shaft_to_edge, 99, 2+27],center=true);
    //hole top
    translate([0, 0, 31])cylinder(r=3.5+0.1, h=10, center=true, $fn=50);
    }
    //hole bot
    translate([0, 0, 2/2])cylinder(r=3.5-0.1, h=2, center=true, $fn=50);
}


module nearmotor(){
    armlen = 31.8;
    holedist = 27.7;
    bodylen = 22.4;
    bodythick = 12.5;
    bodyheight = 16.1;

    difference(){
    translate([0,0,(bodyheight+2)/2])cube([armlen, bodythick, bodyheight+2],center=true);
    //-body
    translate([0,0,2+bodyheight/2])cube([bodylen+0.4, 99, bodyheight],center=true);
    //-cable
    translate([ 25/2-4/2, 0, 2+99/2])cube([4, 4, 99],center=true);
    translate([-25/2+4/2, 0, 2+99/2])cube([4, 4, 99],center=true);
    translate([0, 0, 2+8/2])cube([400, 4, 8],center=true);
    //-hole to frame
    translate([-holedist/2, 0, 0])cylinder(r=1, h=99, center=true, $fn=50);
    translate([ holedist/2, 0, 0])cylinder(r=1, h=99, center=true, $fn=50);
    //-hole to shaft
    translate([ bodylen/2-6, 0, -2/2])cylinder(r=3.5+0.1, h=99, center=true, $fn=50);
    translate([-bodylen/2+6, 0, -2/2])cylinder(r=3.5+0.1, h=99, center=true, $fn=50);
    }
    //+shaft

}


module body(){
    difference(){
        union(){
        translate([ 20+2/2, 0, 40/2])cube([2, 40, 40],center=true);
        translate([-20-2/2, 0, 40/2])cube([2, 40, 40],center=true);
        translate([ 20+2/2, 0, 20/2])cube([2, 80, 20],center=true);
        translate([-20-2/2, 0, 20/2])cube([2, 80, 20],center=true);
        }
        translate([0, 10, 30])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        translate([0,-10, 30])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        //
        translate([0, 30, 10])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        translate([0, 10, 10])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        translate([0,-10, 10])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        translate([0,-30, 10])rotate([0,90,0])cylinder(r=1.6, h=99, center=true, $fn=50);
    }
    //
    difference(){
        union(){
        translate([0, 0, 2/2])cylinder(r=60, h=2, center=true, $fn=100);
        }
        //batt
        translate([ 10, 40-20/2, 0])cube([16, 20, 20],center=true);
        translate([-10, 40-20/2, 0])cube([16, 20, 20],center=true);
        translate([ 10,       0, 1+1/2])cube([12, 40, 1.01],center=true);
        translate([-10,       0, 1+1/2])cube([12, 40, 1.01],center=true);
        translate([ 10,-40+20/2, 0])cube([16, 20, 20],center=true);
        translate([-10,-40+20/2, 0])cube([16, 20, 20],center=true);
        //outer hole for leg
        for(i=[0:60:350]){
            rotate([0,0,i])translate([60,0, 0])cylinder(r=5, h=99, center=true, $fn=50);
        }
        //outer hole between leg
        for(i=[30:60:350]){
            rotate([0,0,i])translate([60,0, 0])cylinder(r=8.5, h=99, center=true, $fn=50);
        }
        //screw hole
        for(i=[-30:30:59]){
        rotate([0,0,i])translate([40,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        rotate([0,0,i])translate([-40,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
        }
    }
}


type=10;
if(type==0){    //body
    //translate([60, 0, 0])rotate([0, 0, 100])claw();
    bodylen = 22.4;
    for(i=[0:60:350]){
        rotate([0,0,i])translate([-60,0,0])rotate([0, 0, 0])translate([-bodylen/2+6,0,0])nearmotor();
    }
    body();
}
else if(type==1){   //motor1.shaft to motor 2
    translate([31.25, -13.1, 29/2])rotate([0, 90, 90])nearmotor();
    mirror([0,1,0])claw();
}
else if(type==2){       //motor2.shaft to finger
    claw();
    difference(){
        hull(){
            translate([25, 0, 14.5])cube([0.1, 10, 33], center=true);
            translate([50, 0, 15])sphere(r=5, $fn=50);
        }
        hull(){
            translate([25, 0, 14.5])cube([0.1, 99, 33-4], center=true);
            translate([50, 0, 15])cube([0.1, 99, 6], center=true);
        }
    }
}
else if(type==10){      //bulk box
    difference(){
        union(){
            translate([0, 0, 30+10/2])cube([54, 50, 10], center=true);
            hull(){
            translate([0, 0, 30])cube([54, 50, 0.001], center=true);
            translate([0, 0, 20])cube([54, 30, 0.001], center=true);
            }
        }
        //hole x
        translate([ 0, 10, 40-5])rotate([0,90,0])cylinder(r=2, h=99, center=true, $fn=50);
        translate([ 0,-10, 40-5])rotate([0,90,0])cylinder(r=2, h=99, center=true, $fn=50);
        //hole y
        translate([ 10, 0, 40-5])rotate([90,0,0])cylinder(r=2, h=99, center=true, $fn=50);
        translate([-10, 0, 40-5])rotate([90,0,0])cylinder(r=2, h=99, center=true, $fn=50);
        //upper
        translate([0, 0, 40-10/2])cube([52, 48, 11], center=true);
        //bottom
        translate([0, 0, 20+9/2])cube([99, 16, 9], center=true);
    }
    
    
    difference(){
    translate([0, 0, 20/2])cube([80, 40, 20], center=true);
    //upper
    translate([0, 0, 20-4/2])cube([99, 16, 4], center=true);
    //bot.switch
    translate([40-28/2, 0, 10])cube([28.01, 36, 20], center=true);
    //bot.bulk
    translate([-80/2+52/2, 0, 1+(14)/2])cube([52.01, 30+0.4, 14], center=true);
    //hole y
    translate([ 30, 0, 10])rotate([90,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([ 10, 0, 10])rotate([90,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([-10, 0, 10])rotate([90,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([-30, 0, 10])rotate([90,0,0])cylinder(r=1.6, h=99, center=true, $fn=50);
    //hole z
    translate([ 30, 0, 0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([ 10, 0, 0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([-10, 0, 0])cylinder(r=1.6, h=99, center=true, $fn=50);
    translate([-30, 0, 0])cylinder(r=1.6, h=99, center=true, $fn=50);
    }
}
else if(type==99){
    nearmotor();
    translate([0, 20, 0])claw();
}