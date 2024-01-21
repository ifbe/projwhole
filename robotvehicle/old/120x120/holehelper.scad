
module support(){
difference(){
    union(){
        //bottom 4mm
        translate([0,0, -4/2])cube([8, 40+8, 4],center=true);
        //middle 20mm
        translate([0,-20, 10])cube([8, 8, 20],center=true);
        translate([0, 20, 10])cube([8, 8, 20],center=true);
        //top 4mm
        translate([0,-20,20+2/2])cylinder(2, r=2.5,center=true,$fn=50);
        translate([0, 20,20+2/2])cylinder(2, r=2.5,center=true,$fn=50);
    }
    //bottom
    translate([0,-20, -2])cylinder(4.01, r=2.5,center=true,$fn=50);
    translate([0, 20, -2])cylinder(4.01, r=2.5,center=true,$fn=50);
}
}

module botone(){
    //left
    difference(){
        translate([-40, 0, 0])support();
        translate([-40-5+2.5/2,0, 0])cube([2.51,100,100],center=true);
    }
/*    difference(){
    translate([-50, 0, -4/2])cube([20+8, 8, 4],center=true);
    translate([-60, 0, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-40, 0, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }*/

    //right
    difference(){
    translate([ 40, 0, 0])support();
        translate([40+5-2.5/2,0, 0])cube([2.51,100,100],center=true);
    }
/*    difference(){
    translate([50, 0, -4/2])cube([20+8, 8, 4],center=true);
    translate([60, 0, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([40, 0, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }*/

    //near
    difference(){
    translate([0,-20, -4/2])cube([75, 8, 4],center=true);
    translate([0,-20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-20, -20+5, 0])cube([20, 5, 10],center=true);
    translate([ 20, -20+5, 0])cube([20, 5, 10],center=true);
    }
    difference(){
    translate([0, -40, -4/2])cube([8, 40+8, 4],center=true);
    translate([0, -20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([0, -60, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }

    //far
    difference(){
    translate([0, 20, -4/2])cube([75, 8, 4],center=true);
    translate([0, 20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([-20, 20-5, 0])cube([20, 5, 10],center=true);
    translate([ 20, 20-5, 0])cube([20, 5, 10],center=true);
    }
    difference(){
    translate([0, 40, -4/2])cube([8, 40+8, 4],center=true);
    translate([0, 20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([0, 60, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }
}

module topone(){
    //left
    difference(){
    translate([-40, 40, 0])support();
    }

    //right
    difference(){
    translate([ 40, 40, 0])support();
    }

    //near
    difference(){
    translate([0, 20, -4/2])cube([75, 8, 4],center=true);
    translate([0, 20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([0, 20, -2/2])cylinder(2.01, r=3,center=true,$fn=50);
    }

    //far
    difference(){
    translate([0, 60, -4/2])cube([75, 8, 4],center=true);
    translate([0, 60, 0])cylinder(10, r=1.6,center=true,$fn=50);
    translate([0, 60, -2/2])cylinder(2.01, r=3,center=true,$fn=50);
    }

    //center
    translate([-40, 0, -4/2])cube([8, 40, 4],center=true);
    translate([-20, 0, -4/2])cube([8, 40, 4],center=true);
    translate([ 20, 0, -4/2])cube([8, 40, 4],center=true);
    translate([ 40, 0, -4/2])cube([8, 40, 4],center=true);

    //batt
    difference(){
        translate([0, -40, -4/2])cube([120, 40, 4],center=true);

        translate([-40, -40, 0-0.2])cube([120, 0.4, 0.4],center=true);
        translate([0, -40, 0-0.2])cube([0.4, 40, 0.4],center=true);

        translate([0, -40, -4/2])cube([100, 20, 10],center=true);

        translate([-60,-40, -2/2])cube([10, 40, 2.01],center=true);
        translate([-40,-40, -2/2])cube([10, 40, 2.01],center=true);
        translate([-20,-40, -2/2])cube([10, 40, 2.01],center=true);
        translate([ 20,-40, -2/2])cube([10, 40, 2.01],center=true);
        translate([ 40,-40, -2/2])cube([10, 40, 2.01],center=true);
        translate([ 60,-40, -2/2])cube([10, 40, 2.01],center=true);

        translate([0, -20, -2/2])cylinder(2.01, r=3,center=true,$fn=50);
        translate([0, -20, 0])cylinder(10, r=1.6,center=true,$fn=50);

        translate([0, -40, -1])cylinder(2.01, r=3,center=true,$fn=50);
        translate([0, -40, 0])cylinder(10, r=1.6,center=true,$fn=50);

        translate([0, -60, -1])cylinder(2.01, r=3,center=true,$fn=50);
        translate([0, -60, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }

    //extra
    difference(){
    translate([0, -20+4/2, -4+4/2])cube([10, 4, 4],center=true);
    translate([0, -20, -2+10/2])cylinder(10, r=3,center=true,$fn=50);
    translate([0, -20, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([0, -60-4/2, -4+4/2])cube([10, 4, 4],center=true);
    translate([0, -60, -2+10/2])cylinder(10, r=3,center=true,$fn=50);
    translate([0, -60, 0])cylinder(10, r=1.6,center=true,$fn=50);
    }

    translate([-20, -20, -4+10/2])cylinder(10, r=2.4,center=true,$fn=50);
    translate([-40, -20, -4+10/2])cylinder(10, r=2.4,center=true,$fn=50);
    translate([20, -20, -4+10/2])cylinder(10, r=2.4,center=true,$fn=50);
    translate([40, -20, -4+10/2])cylinder(10, r=2.4,center=true,$fn=50);

    translate([-50, -60-4/2, -4+10/2])cube([10, 4, 10],center=true);
    translate([-30, -60-4/2, -4+10/2])cube([10, 4, 10],center=true);
    translate([ 30, -60-4/2, -4+10/2])cube([10, 4, 10],center=true);
    translate([ 50, -60-4/2, -4+10/2])cube([10, 4, 10],center=true);
}

topone();