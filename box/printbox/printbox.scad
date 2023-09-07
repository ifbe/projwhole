/*bambu:
height=56;
width=54;
router=100+0.3;
*/
height=56;
width=56;
r_outer=100;
r_inner=r_outer-width;

module outer(){
difference(){
translate([0,0,height/2])cylinder(h=height,r=r_outer,center=true,$fn=100);
translate([0,0,(height-1)/2+1.01])cylinder(h=height-1,r=99,center=true,$fn=100);
cylinder(h=100,r=r_inner,center=true,$fn=100);
}
}
module inner(){
difference(){
translate([0,0,height/2])cylinder(h=height,r=r_inner+1,center=true,$fn=100);
translate([0,0,(height-1)/2+1.01])cylinder(h=height-1,r=r_inner,center=true,$fn=100);
cylinder(h=100,r=r_inner,center=true,$fn=100);
}
}
module xxxx(){
    for(i=[0:18:359]){
        rotate([0,0, i])translate([ r_outer-width/2,0,height/2])cube([width,2+0.2,height],center=true);
    }
/*
translate([-100+width/2,0,height/2])cube([width,3,height],center=true);
translate([ 100-width/2,0,height/2])cube([width,3,height],center=true);
rotate([0,0, 60])translate([-100+width/2,0,height/2])cube([width,3,height],center=true);
rotate([0,0, 60])translate([ 100-width/2,0,height/2])cube([width,3,height],center=true);
rotate([0,0,120])translate([-100+width/2,0,height/2])cube([width,3,height],center=true);
rotate([0,0,120])translate([ 100-width/2,0,height/2])cube([width,3,height],center=true);
    */
}
module yyyy(){
    for(i=[0:18:360]){
    rotate([0,0, i])cube([250,0.2,200],center=true);
    }
}

module aaaa(){
outer();
inner();
xxxx();
}



difference(){
    aaaa();
    yyyy();
}



module cover_bottom(){
difference(){
    translate([0,0,2/2])cylinder(h=2,r=r_outer,center=true,$fn=100);
    translate([0,0,2/2])cylinder(h=3,r=90,center=true,$fn=100);
    for(i=[0:60:359]){
        rotate([0,0,30+i])translate([95,0,0])cylinder(h=100,r=1.6,center=true,$fn=100);
    }
}
}
module cover_outer(){
difference(){
    translate([0,0,10/2])cylinder(h=10,r=r_outer+2,center=true,$fn=100);
    translate([0,0,10/2])cylinder(h=11,r=r_outer,center=true,$fn=100);
    translate([100,0,10/2])cylinder(h=11,r=15.691819145568989,center=true,$fn=100); //100*math.sin(math.pi/20/2)*2
}
}


/*
cover_bottom();
cover_outer();
*/