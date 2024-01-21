module height14(x,y){
    difference(){
        cylinder(14, r=2.5,center=true,$fn=50);
        cylinder(20, r=1.6,center=true,$fn=50);
    }
}
translate([0,0,0])rotate([0,0,-90])height14();
translate([6,0,0])rotate([0,0,-90])height14();
translate([12,0,0])rotate([0,0,-90])height14();
translate([0,6,0])rotate([0,0,-90])height14();
translate([6,6,0])rotate([0,0,-90])height14();
translate([12,6,0])rotate([0,0,-90])height14();
