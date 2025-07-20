
module starship_top(){
    //up left
    hull(){
    translate([-3,0,50-12+6])cube([0.01,0.1,0.01],center=true);
    translate([-4-4/2,0,50-12+3])cube([3.2,0.1,0.01],center=true);
    translate([-4.5-3/2,0,50-10])cube([3.2,0.1,0.01],center=true);
    }
    translate([-4.5-3/2,0,50-12+2/2])cube([3.2,0.1,2],center=true);
    //up right
    hull(){
    translate([ 3,0,50-12+6])cube([0.01,0.1,0.01],center=true);
    translate([ 4+4/2,0,50-12+3])cube([3.2,0.1,0.01],center=true);
    translate([ 4.5+3/2,0,50-10])cube([3.2,0.1,0.01],center=true);
    }
    translate([ 4.5+3/2,0,50-12+2/2])cube([3.2,0.1,2],center=true);

    //body top
    difference(){
    hull(){
    translate([0,0,38+12])cylinder(h=0.01,r=0.1,center=true,$fn=50);
    translate([0,0,38+6])cylinder(h=0.01,r=3,center=true,$fn=50);
    translate([0,0,40])cylinder(h=0.01,r=4.5,center=true,$fn=50);
    translate([0,0,38])cylinder(h=0.01,r=4.5,center=true,$fn=50);
    }
    hull(){
    translate([0,0,38+11.9])cylinder(h=0.01,r=0.1,center=true,$fn=50);
    translate([0,0,38+6])cylinder(h=0.01,r=2.92,center=true,$fn=50);
    translate([0,0,40])cylinder(h=0.01,r=4.42,center=true,$fn=50);
    }
    translate([0,0,38+2/2])cylinder(h=2.02,r=4.4,center=true,$fn=50);
    }
}
module starship_mid(){
    //body mid
    difference(){
    union(){
    translate([0,0,20+18/2])cylinder(h=18,r=4.5,center=true,$fn=50);
    translate([0,0,20+18/2])cylinder(h=20,r=4.4-0.02,center=true,$fn=50);
    }
    translate([0,0,20+18/2-1])cylinder(h=99,r=4.3,center=true,$fn=50);
    }
}

module starship_bot(){
    //body bot
    difference(){
    translate([0,0,20/2])cylinder(h=20,r=4.5,center=true,$fn=50);
    translate([0,0,20/2])cylinder(h=99,r=4.4,center=true,$fn=50);
    }
    
    //bottom left
    hull(){
    translate([-3-3/2,  0,     12])cube([0.01,0.1,0.01],center=true);
    translate([-4.5-3/2,0,      8])cube([3,0.1,0.01],center=true);
    translate([-4.5-3/2,0, 0.01/2])cube([3,0.1,0.01],center=true);
    }
    //bottom right
    hull(){
    translate([ 3+3/2,  0,     12])cube([0.01,0.1,0.01],center=true);
    translate([ 4.5+3/2,0,      8])cube([3,0.1,0.01],center=true);
    translate([ 4.5+3/2,0, 0.01/2])cube([3,0.1,0.01],center=true);
    }

    //engine
    translate([0,0,1+0.1/2])cylinder(h=0.1,r=4.5,center=true,$fn=50);
    difference(){
    union(){
    for(a=[0:120:360])rotate([0,0,a])translate([0.8,0,1/2])cylinder(h=1,r=0.6,center=true,$fn=50);
    for(a=[60:120:360])rotate([0,0,a])translate([2,0,1/2])cylinder(h=1,r=1,center=true,$fn=50);
    }
    for(a=[0:120:360])rotate([0,0,a])translate([0.8,0,0])sphere(r=0.4,$fn=50);
    for(a=[60:120:360])rotate([0,0,a])translate([2,0,0])sphere(r=0.8,$fn=50);
    }

    //connect
    difference(){
    union(){
    translate([-4.4+1/2,0,1/2])cube([1,1,1],center=true);
    translate([ 4.4-1/2,0,1/2])cube([1,1,1],center=true);
    }
    translate([-4+0.2/2,0,1/2])cylinder(h=11,r=0.5,center=true,$fn=50);
    translate([ 4-0.2/2,0,1/2])cylinder(h=11,r=0.5,center=true,$fn=50);
    }
}

module starship(){
    //starship_top();
    //starship_mid();
    starship_bot();
}

module superheavy(){
    //connector
    translate([-4+0.2/2,0,69+1/2])cylinder(h=1,r=0.5,center=true,$fn=50);
    translate([ 4-0.2/2,0,69+1/2])cylinder(h=1,r=0.5,center=true,$fn=50);
    translate([0,0,69-0.2/2])cylinder(h=0.2,r=4.5,center=true,$fn=50);

    //Grille rudder
    rotate([0,0,30])translate([4.5+2/2,0,68])cube([2,2,0.5],center=true);
    rotate([0,0,-30])translate([4.5+2/2,0,68])cube([2,2,0.5],center=true);
    rotate([0,0,180+30])translate([4.5+2/2,0,68])cube([2,2,0.5],center=true);
    rotate([0,0,180-30])translate([4.5+2/2,0,68])cube([2,2,0.5],center=true);

    //cylinder
    difference(){
    translate([0,0,1+68/2])cylinder(h=68,r=4.5,center=true,$fn=50);
    translate([0,0,69/2])cylinder(h=99,r=4.4,center=true,$fn=50);
    }
    
    //engine
    translate([0,0,1+1/2])cylinder(h=1,r=4.5,center=true,$fn=50);
    difference(){
    union(){
    for(a=[0:120:360])rotate([0,0,a])translate([0.8,0,1/2])cylinder(h=1,r=0.6,center=true,$fn=50);
    for(a=[0:36:360])rotate([0,0,a])translate([2.0,0,1/2])cylinder(h=1,r=0.6,center=true,$fn=50);
    for(a=[0:18:360])rotate([0,0,a])translate([4,0,1/2])cylinder(h=1,r=0.6,center=true,$fn=50);
    }
    for(a=[0:120:360])rotate([0,0,a])translate([0.8,0,0])sphere(r=0.4,$fn=50);
    for(a=[0:36:360])rotate([0,0,a])translate([2.0,0,0])sphere(r=0.4,$fn=50);
    for(a=[0:18:360])rotate([0,0,a])translate([4,0,0])sphere(r=0.4,$fn=50);
    }
}


translate([0,0,69])starship();
//superheavy();



//starship_bot();