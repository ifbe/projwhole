module aa_pipe(){
    difference(){
        union(){
            cylinder(h=100,r=12.4,center=true,$fn=50);
            cylinder(h=80,r=15,center=true,$fn=50);
        }
        cylinder(h=1000,r=10,center=true,$fn=50);
    }
}


module aa_connect(){
difference(){
    union(){
    cube([30,10,40],center=true);
    }
    rotate([90,0,0])cylinder(h=100,r=1.6,center=true,$fn=50);
}
}


module aa_mid(){
difference(){
    union(){
    cube([40,20,200],center=true);
    //rotate([90,0,0])cylinder(h=100,r=15,center=true,$fn=50);
    }
    //
    cube([30.2,10.2,999],center=true);
    //
    translate([0,0,  50])rotate([90,0,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    translate([0,0,   0])rotate([90,0,0])cylinder(h=999,r=12.6,center=true,$fn=50);
    translate([0,0, -50])rotate([90,0,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    //
    translate([0,0, 100-20])rotate([90,0,0])cylinder(h=100,r=1.6,center=true,$fn=50);
    translate([0,0,-100+20])rotate([90,0,0])cylinder(h=100,r=1.6,center=true,$fn=50);
    //
    translate([0,0, 100])rotate([90,0,0])cylinder(h=100,r=1.6,center=true,$fn=50);
    translate([0,0,-100])rotate([90,0,0])cylinder(h=100,r=1.6,center=true,$fn=50);
}
}

module aa_bot_1(){
    difference(){
        union(){
        translate([0,-5/2,20+40/2])cube([30,5,40],center=true);
        //
        translate([0,-10/2,20/2])cube([40,10,20],center=true);
        }
        translate([0,-10+5/2,20+20])rotate([90,0,0])cylinder(h=55,r=1.6,center=true,$fn=50);
    }
}
module aa_bot(){
    aa_bot_1();
    translate([0,-100,0])mirror([0,1,0])aa_bot_1();
    
    difference(){
        translate([0,-100/2, 10/2])cube([200,100,10],center=true);
        translate([0,-100/2, 10/2])cube([120,80,100],center=true);
        //
        translate([-100+20, -25, -10/2])cylinder(h=55,r=1.6,center=true,$fn=50);
        translate([-100+20, -50, -10/2])cylinder(h=55,r=10,center=true,$fn=50);
        translate([-100+20, -75, -10/2])cylinder(h=55,r=1.6,center=true,$fn=50);
        //
        translate([ 100-20, -25, -10/2])cylinder(h=55,r=1.6,center=true,$fn=50);
        translate([ 100-20, -50, -10/2])cylinder(h=55,r=10,center=true,$fn=50);
        translate([ 100-20, -75, -10/2])cylinder(h=55,r=1.6,center=true,$fn=50);
    }
}


en_d = 1;
if(en_d){
    aa_pipe();
}

en_c = 0;
if(en_c==1){
translate([0,0,240])aa_connect();
}

en_b = 0;
if(en_b==1){
translate([0,0,120+2])aa_mid();
}

en_a1 = 0;
if(en_a1){
translate([0,100,0])aa_bot_1();
translate([0,100,0])mirror([0,1,0])aa_bot_1();
//
aa_bot_1();
mirror([0,1,0])aa_bot_1();
//
translate([0,50,10/2])cube([40,100,10],center=true);
}

en_a = 0;
if(en_a==1){
translate([0,-60,0/2])aa_bot_1();
translate([0,-40,0/2])mirror([0,1,0])aa_bot_1();

//translate([0,100,0/2])aa_bot();
translate([0,0,0/2])aa_bot();
}

//translate([0,-100/2, 200/2])rotate([90,0,0])cylinder(h=62,r=100,center=true,$fn=50);



















module connect(){
    difference(){
        union(){
        rotate([90,0,0])cylinder(h=40,r=12.5,center=true,$fn=50);
        cube([30-0.2,30-0.2,40],center=true);
        }
        rotate([90,0,0])cylinder(h=100,r=10,center=true,$fn=50);
        cube([20,20,100],center=true);
    }
}

module bb(){
translate([0,-100+10/2,100])rotate([90,0,0])cylinder(h=10,r=20,$fn=50);
translate([0,0,100])rotate([90,0,0])cylinder(h=100,r=12.5,$fn=50);
}

module aa(){
difference(){
    cube([40,40,200],center=true);
    cube([30,30,200],center=true);
    translate([0,0, 100])rotate([90,0,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    translate([0,0,  50])rotate([0,90,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    translate([0,0,   0])rotate([90,0,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    translate([0,0, -50])rotate([0,90,0])cylinder(h=100,r=12.6,center=true,$fn=50);
    translate([0,0,-100])rotate([90,0,0])cylinder(h=100,r=12.6,center=true,$fn=50);
}
}

module top(){
difference(){
    union(){
    translate([0,0,20+20/2])cube([30-0.2,30-0.2,20],center=true);
    translate([0,0,10+10/2])cube([40,40,10],center=true);
    rotate([0,0, 45])translate([0,0,10/2])cube([28,200,10],center=true);
    rotate([0,0,-45])translate([0,0,10/2])cube([28,200,10],center=true);
    }
    translate([0,0,20+20/2])cube([20.2,20.2,20.02],center=true);
}
}

module bottom(){
difference(){
    union(){
    translate([0,0,20+20/2])cube([30-0.2,30-0.2,20],center=true);
    translate([0,0,10+10/2])cube([40,40,10],center=true);
    translate([0,0,10/2])cube([40,200,10],center=true);
    translate([0, 100-40/2,10/2])cube([200,40,10],center=true);
    translate([0,-100+40/2,10/2])cube([200,40,10],center=true);
    }
    translate([0,0,20+20/2])cube([20.2,20.2,20.02],center=true);
    //translate([0,0, 100])rotate([0,90,0])cylinder(h=100,r=100,center=true,$fn=50);
}
}
/*
translate([0,0,260])connect();
translate([0,0,120])aa();
bottom();
*/