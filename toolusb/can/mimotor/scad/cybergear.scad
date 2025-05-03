

module onecircle(){
    difference(){
        union(){
        translate([0, 0, 2/2])cylinder(r=45, h=2, center=true, $fn=50);
        }
        cylinder(r=32, h=10, center=true, $fn=50);
        translate([30, 0, 0])cube([20, 15, 99],center=true);
        //
        for(x=[0:360/9:359])rotate([0,0,x])translate([-75/2,0,0])cylinder(r=1.6, h=10, center=true, $fn=50);
    }
}

module rect(){
    difference(){
        union(){
        translate([0, 0, 0])cube([40, 40, 2],center=true);
        }
        for(x=[30:60:380])rotate([0,0,x])translate([12,0,0])cylinder(r=2, h=10, center=true, $fn=50);
    }
}


translate([50-2/2, 0, 40/2])rotate([0,90,0])rect();

translate([50-(10)/2, 0, 2/2])cube([9, 40, 2],center=true);
onecircle();