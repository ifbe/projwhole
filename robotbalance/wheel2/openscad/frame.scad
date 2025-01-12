module old(){
difference(){
    union(){
        //translate([0, 75,0])cube([200+2,50+2,50],center=true);
        //translate([0, 25,0])cube([100+2,50+2,50],center=true);
        //translate([0,-25,0])cube([100+2,50+2,50],center=true);
        translate([0,-75,0])cube([200+2,50+2,50],center=true);
    }

    //--------------------- y=75 --------------------
    translate([  0,75,0])cube([98,40,51],center=true);

    translate([-75,75,0])cube([48,48,55],center=true);
    rotate([0,-90,0])translate([0, 75, 100])cylinder(10, r=11.2,center=true,$fn=50);

    translate([ 75,75,0])cube([48,48,55],center=true);
    rotate([0, 90,0])translate([0, 75, 100])cylinder(10, r=11.2,center=true,$fn=50);

    //--------------------- y=50 --------------------
    translate([  0,50  ,0])cube([50,2,51],center=true);
    translate([  0,50  ,0])cube([140,25,18],center=true);
    translate([  0,50+2,0])cube([100,6,30],center=true);

    //--------------------- y=25 --------------------
    translate([  0,25,0])cube([98,40,51],center=true);

    //--------------------- y=0 --------------------
    //.center
    translate([  0,0  ,0])cube([50,2,51],center=true);
    translate([  0,0  ,0])cube([80,20,30],center=true);
    translate([  0,0+2,0])cube([100,6,30],center=true);
    //.left
    translate([-60,0,0])cube([20,30,18],center=true);
    translate([-50,0,0])cube([2.01,30,30],center=true);
    //.right
    translate([ 60,0,0])cube([20,30,18],center=true);
    translate([ 50,0,0])cube([2.01,30,30],center=true);

    //--------------------- y=-25 --------------------
    translate([  0,-25,0])cube([98,40,51],center=true);
    translate([-45,-25,-10])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);
    translate([-45,-25, 10])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);
    translate([-45,-25,  0])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);
    translate([ 45,-25,  0])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);
    translate([ 45,-25,-10])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);
    translate([ 45,-25, 10])rotate([90,0,0])cylinder(70, r=1.6,center=true,$fn=50);

    //--------------------- y=-50 --------------------
    //.center
    translate([  0,-50  ,0])cube([50,2,51],center=true);
    translate([  0,-50  ,0])cube([80,20,30],center=true);
    translate([  0,-50+2,0])cube([100,6,30],center=true);
    //.left
    translate([-60,-50,0])cube([20,30,18],center=true);
    translate([-50,-50,0])cube([2.01,30,30],center=true);
    //.right
    translate([ 60,-50,0])cube([20,30,18],center=true);
    translate([ 50,-50,0])cube([2.01,30,30],center=true);

    //--------------------- y=-75 -------------------
    translate([  0,-75,0])cube([98,40,51],center=true);
    translate([-75,-75,0])cube([10,10,51],center=true);
    translate([ 75,-75,0])cube([10,10,51],center=true);

    translate([-75,-75,0])cube([48,48,48],center=true);
    translate([-100,-100,0])cube([10,50,6],center=true);
    rotate([0,-90,0])translate([    0,     -75,100])cylinder(10, r=11.2,center=true,$fn=50);
    rotate([0,-90,0])translate([ 15.5, 15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,-90,0])translate([-15.5, 15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,-90,0])translate([-15.5,-15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,-90,0])translate([ 15.5,-15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);

    translate([ 75,-75,0])cube([48,48,48],center=true);
    translate([ 100,-100,0])cube([10,50,6],center=true);
    rotate([0,90,0])translate([    0,     -75,100])cylinder(10, r=11.2,center=true,$fn=50);
    rotate([0,90,0])translate([ 15.5, 15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5, 15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([-15.5,-15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);
    rotate([0,90,0])translate([ 15.5,-15.5-75,100])cylinder(10, r=1.6,center=true,$fn=20);


    //---------------- y=-100 ----------------
    translate([-75,-80,0])cube([48,48,48],center=true);
    translate([ 75,-80,0])cube([48,48,48],center=true);

    translate([0,-100, 25])rotate([ 45,0,0])cube([1000,1000,17.67766952966369],center=true);
    translate([0,-100,-25])rotate([-45,0,0])cube([1000,1000,17.67766952966369],center=true);
}
}


module board_power(){
    difference(){
    translate([0,0,25/2])cube([100,100,25],center=true);
    //center
    translate([0,0,25-12])cube([90,90,24.01],center=true);
    //batt screw
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    //batt cable
    translate([ 50,0,0])cube([20,10,10],center=true);
    translate([-50,0,0])cube([20,10,10],center=true);
    }
}


module board_rpi(){
    difference(){
    translate([0,0,25/2])cube([100,100,25],center=true);
    //-center
    translate([0,0,25-12])cube([90,90,24.01],center=true);
    //-rpi
    translate([0,-50,25-12])cube([60,90,24.01],center=true);
    //-batt screw
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(96, r=3,center=true,$fn=20);
    //batt cable
    translate([ 50,0,0])cube([20,10,10],center=true);
    translate([-50,0,0])cube([20,10,10],center=true);
    }
}


module haha(){
    difference(){
    translate([0,0,25])cube([50,50,50],center=true);

    translate([0,-50,-75])rotate([ 45,0,0])cube([1000,1000,17.67766952966369],center=true);
    translate([0,50,-75])rotate([-45,0,0])cube([1000,1000,17.67766952966369],center=true);

    //top
    translate([25-10,0,50])cube([20,18,20],center=true);
    //bot
    translate([2,0,25-2])cube([50.01,46,50.01],center=true);
    translate([-25,0,25/2])cube([10,6,25],center=true);

    translate([0, 0,25])rotate([0,90,0])cylinder(100, r=11.2,center=true,$fn=50);
    translate([0, 15.5, 15.5+25])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0, 15.5,-15.5+25])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0,-15.5,-15.5+25])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0,-15.5, 15.5+25])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    }
}

module battery(){
    cube([40,40,80],center=true);
}
module batthold(){
    difference(){
    translate([ 0,0,25/2])cube([50,82,25],center=true);
    translate([ 0,0, 10])cube([40,80,25],center=true);
    //
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0, 20, 25/2])rotate([0,90,0])cylinder(46, r=3,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0,  0, 25/2])rotate([0,90,0])cylinder(46, r=3,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(100, r=1.6,center=true,$fn=20);
    translate([0,-20, 25/2])rotate([0,90,0])cylinder(46, r=3,center=true,$fn=20);
    //screw to main
    translate([ 25-2.5, 30, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([ 25-2.5, 10, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([ 25-2.5,-10, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([ 25-2.5,-30, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([-25+2.5, 30, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([-25+2.5, 10, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([-25+2.5,-10, 0])cylinder(200, r=1.6,center=true,$fn=20);
    translate([-25+2.5,-30, 0])cylinder(200, r=1.6,center=true,$fn=20);
    //batt cable
    translate([ 25,0,0])cube([20,10,10],center=true);
    translate([-25,0,0])cube([20,10,10],center=true);
    }
}

module wheel(){
    translate([ 100,0,25])rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
    translate([-100,0,25])rotate([0,90,0])cylinder(25, r=65/2,center=true,$fn=50);
}



//main board
translate([0,0,100])rotate([-90,0,0])board_power();
translate([0,0,100])rotate([ 90,0,0])board_rpi();

//battery left,right
//translate([ 50+25,0,100])rotate([-90,0,0])batthold();
translate([ 50+25,0,100])rotate([ 90,0,0])batthold();
translate([-50-25,0,100])rotate([-90,0,0])batthold();
//translate([-50-25,0,100])rotate([ 90,0,0])batthold();

//42stepper left,right
translate([ 60,0,0])mirror([1,0,0])haha();
translate([-60,0,0])haha();
//wheel left,right
//translate([0,0,150])wheel();
wheel();

