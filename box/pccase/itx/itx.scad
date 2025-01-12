thickness=1.5;

module pci_bracket() {
union() {
difference() {
union () {
translate([0,-0.25,0]) cube([115,18.5,thickness],center=true);
translate([58.5,2.5,0]) cube([8,18.5,thickness],center=true);
}
translate([57,-13.7,0]) rotate([0,0,40]) cube([10,10,10],center=true);
translate([55,16,0]) rotate([0,0,40]) cube([10,10,10],center=true);
translate([-50,-12.5,0]) rotate([0,0,45]) cube([10,10,10],center=true);
translate([-50,12.5,0]) rotate([0,0,45]) cube([10,10,10],center=true);
translate([-55,-10.5,0]) cube([10,10,10],center=true);
translate([-55,10.5,0]) cube([10,10,10],center=true);
}
difference() {
translate([62,2.5,6]) cube([thickness,18.5,11],center=true);
translate([62,10.75,5.5]) cube([2,6,4],center=true);
translate([62,8,5.5]) rotate([0,90,0]) cylinder(r=2,h=2,center=true);
}
}
}

module pcie_pcbboard() {
    difference(){
    cube([2, 150, 110],center=true);
    }
}

module pcie10g()
{
    //translate([0,-2.5,1])cube([30, 5, 2],center=true);
    //translate([0,1,-60])cube([20, 2, 120],center=true);
    translate([-8,78,-120+15+110/2])pcie_pcbboard();
    translate([0,1.5/2,-62.5])rotate([90,-90,0])pci_bracket();
}

module pciegpu()
{
    translate([0,-2.5,1])cube([30, 5, 2],center=true);
    translate([0,1,-60])cube([20, 2, 120],center=true);
    translate([-9,125,-60])cube([2, 250, 120],center=true);
}





module itxboard()
{
    difference(){
    translate([0,0,1])cube([170, 170, 2]);
    //translate([170/2,170/2,0])cube([150, 150, 10],center=true);
    //0.25, h-0.4
    translate([6.35, 170-10.16,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25+6.2, h-0.4-0.9
    translate([6.35+157.48, 170-10.16-22.86,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35+157.48, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    }
}

module itxtop(){
    //top
    translate([120,170,0])cube([50,10,2]);
    translate([60,170,0])cube([50,10,2]);
    translate([0,170,0])cube([50,10,2]);

    //bot
    translate([120,-10,0])cube([50,10,2]);
    translate([60,-10,0])cube([50,10,2]);
    translate([0,-10,0])cube([50,10,2]);

    //left
    translate([-10,120,0])cube([10,50,2]);
    translate([-10,60,0])cube([10,50,2]);
    translate([-10,0,0])cube([10,50,2]);

    //right
    translate([170,120,0])cube([10,50,2]);
    translate([170,60,0])cube([10,50,2]);
    translate([170,0,0])cube([10,50,2]);

    difference(){
    translate([0, 0, 0])cube([170, 170, 2]);
    translate([170/2,170/2,0])cube([150, 150, 10],center=true);
    //0.25, h-0.4
    translate([6.35, 170-10.16,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25+6.2, h-0.4-0.9
    translate([6.35+157.48, 170-10.16-22.86,0])cylinder(10, r=2,center=true,$fn=50);
    //0.25, h-0.4-6.1
    translate([6.35+157.48, 170-10.16-154.94,0])cylinder(10, r=2,center=true,$fn=50);
    }
}

module power()
{
    cube([80, 150, 150],center=true);
}

module itxcase()
{
    translate([0,1,0])cube([200,2,150],center=true);
    difference(){
        translate([0,199,0])cube([200,2,150],center=true);
        translate([0,199,-15])cube([180,3,130],center=true);
    }
    difference(){
        translate([-99,100,0])cube([2,200,150],center=true);
        translate([-99,100,0])cube([4,180,100],center=true);
    }
    difference(){
        translate([ 99,100,0])cube([2,200,150],center=true);
        translate([ 99,100,0])cube([3,180,100],center=true);
    }
}


/*
//color("#ff00ff")translate([15,15,150+2])itxboard();

translate([185, 185, 150])rotate([0,0,180])itxtop();

color("#ff0000")translate([40+2,75+2,75])power();
color("#00ff00")translate([110, 2, 120])pcie10g();
color("#00ff00")translate([160, 2, 120])pciegpu();

translate([100, 0, 75])itxcase();
*/


pcie10g();