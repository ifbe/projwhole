
module screwhelper(rout, rin, height)
{
    difference(){
        translate([0,0,height/2])cylinder(height, r=rout,center=true,$fn=50);
        translate([0,0,height/2])cylinder(height+0.01, r=rin,center=true,$fn=50);
    }
}

module conn40_one(){
    /*
    difference(){
    translate([0, 0, 0])screwhelper(5, 1.6, 40-4);
    translate([0, 0, 40-4-1])cylinder(2.01, r=4,center=true,$fn=50);
    translate([0, 0, 1])cylinder(2.01, r=4,center=true,$fn=50);
    }
    */
    
    translate([0, 0, 36-2])screwhelper(5, 4, 2);
    difference(){
        hull(){
        translate([0, 0, 36-2])cylinder(0.01, r=5,center=true,$fn=50);
        translate([0, 0, 36-4])cylinder(0.01, r=3,center=true,$fn=50);
        }
        cylinder(99, r=1.6,center=true,$fn=50);
    }
    
    translate([0, 0, 4])screwhelper(3, 1.6, 36-8);
    
    difference(){
        hull(){
        translate([0, 0, 4])cylinder(0.01, r=3,center=true,$fn=50);
        translate([0, 0, 2])cylinder(0.01, r=5,center=true,$fn=50);
        }
        cylinder(99, r=1.6,center=true,$fn=50);
    }
    translate([0, 0, 0])screwhelper(5, 4, 2);
}

module conn40(){
    translate([ 35, 35, 2])conn40_one();
    translate([-35, 35, 2])conn40_one();
    translate([ 35,-35, 2])conn40_one();
    translate([-35,-35, 2])conn40_one();
}


module cam(){
difference(){
    cube([28,28,1.6],center=true);
    //middle
    translate([0,-2,0])cube([12,24,10],center=true);
    //edge
    //translate([-15,15,0])cube([10,4,10],center=true);
    //translate([ 15,15,0])cube([10,4,10],center=true);
    //hole
    translate([-21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2,4-12.5,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([-21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
    translate([ 21/2, 4,0])cylinder(110, r=1.2,center=true,$fn=50);
}
}
module cam_bottom(){
    difference(){
        translate([0,50,42+2])cube([20,20,4],center=true);
        translate([0,50,42+1.1])cube([50,10,2.2],center=true);
        translate([0,50,0.5])cylinder(100, r=1.6,center=true,$fn=50);
        translate([0,58,42+3])cube([100,2,2],center=true);
    }
}
module cam_beside(){
    translate([0,60-0.8,56])rotate([90,0,0])cam();
    cam_bottom();
}

module spk_ontv(){
    difference(){
        translate([0,0, 10])cube([48, 24, 20],center=true);
        //mid
        translate([0,0, 12])cube([45, 21, 20],center=true);
        //y
        translate([-10,0, 10])rotate([90,0,0])cylinder(99, r=8,center=true,$fn=50);
        translate([ 10,0, 10])rotate([90,0,0])cylinder(99, r=8,center=true,$fn=50);
        //x
        translate([0,0, 12])cube([55, 15, 20],center=true);
    }

    //
    difference(){
        hull(){
        translate([0,0,  0])cube([48,20,0.01],center=true);
        translate([0,0,-10+0.01])cube([48,14,0.01],center=true);
        }
        translate([0,0,-5])cube([99,13,10],center=true);
    }
}

module top(){
    //+35
    translate([ 35,  35, 2])screwhelper(4, 1.6, 2);
    translate([-35,  35, 2])screwhelper(4, 1.6, 2);
    translate([ 35, -35, 2])screwhelper(4, 1.6, 2);
    translate([-35, -35, 2])screwhelper(4, 1.6, 2);

    //+29
    translate([-0+29,  24.5   ,2])screwhelper(4, 1.6, 2);
    difference(){
    translate([-0+29,  24.5-23,2])screwhelper(4, 1.6, 2);
    translate([-0+29, -24.5+23,2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-0+29, -24.5+23,2])screwhelper(4, 1.6, 2);
    translate([-0+29,  24.5-23,2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-0+29, -24.5,   2])screwhelper(4, 1.6, 2);

    //-29
    translate([-0-29,  24.5,   2])screwhelper(4, 1.6, 2);
    difference(){
    translate([-0-29,  24.5-23,2])screwhelper(4, 1.6, 2);
    translate([-0-29, -24.5+23,2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    difference(){
    translate([-0-29, -24.5+23,2])screwhelper(4, 1.6, 2);
    translate([-0-29,  24.5-23,2])cylinder(11.01, r=1.6,center=true,$fn=50);
    }
    translate([-0-29, -24.5,   2])screwhelper(4, 1.6, 2);

    //board
    difference(){
    union(){
    //pi5
    translate([0, 0, 1])cube([80, 80, 2],center=true);
    //cam
    translate([-30, 50, 3])cube([9.9, 9.9, 2],center=true);
    translate([-30, 50, 1])cube([20, 20, 2],center=true);
    translate([ 30, 50, 3])cube([9.9, 9.9, 2],center=true);
    translate([ 30, 50, 1])cube([20, 20, 2],center=true);
    }

    //-center
    translate([ 30, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 20, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 10, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([  0, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-10, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-20, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30, 0, 0])cylinder(99, r=1.6,center=true,$fn=50);

    //hole @ cam
    translate([ 30, 50, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([-30, 50, 0])cylinder(99, r=1.6,center=true,$fn=50);
    translate([ 30, 50, 1])cylinder(2.01, r=3,center=true,$fn=50);
    translate([-30, 50, 1])cylinder(2.01, r=3,center=true,$fn=50);

    //hole @ 35
    translate([ 35, 35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([-35, 35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([ 35,-35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([-35,-35, 0])cylinder(99, r=3.0,center=true,$fn=50);

    //-rpi3 hole
    translate([0+29, 24.5, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0+29,-24.5, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0-29, 24.5, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0-29,-24.5, 0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpizero hole
    translate([0+29, 24.5-23, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0-29, 24.5-23, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0+29,-24.5+23, 0])cylinder(1000, r=3.0,center=true,$fn=50);
    translate([0-29,-24.5+23, 0])cylinder(1000, r=3.0,center=true,$fn=50);

    //-rpi 40pin
    translate([0, 49/2, 0])cube([52-0.4,5.8,99],center=true);
    translate([0,-49/2, 0])cube([52-0.4,5.8,99],center=true);

    //-rpizero 40pin
    translate([0, 49/2-23, 0])cube([52-0.4,5.8,99],center=true);
    translate([0,-49/2+23, 0])cube([52-0.4,5.8,99],center=true);

    }//difference
}

module bot(){
    //+35
    translate([ 35,  35, 2])screwhelper(4, 1.6, 2);
    translate([-35,  35, 2])screwhelper(4, 1.6, 2);
    translate([ 35, -35, 2])screwhelper(4, 1.6, 2);
    translate([-35, -35, 2])screwhelper(4, 1.6, 2);

    //board
    difference(){
    union(){
    translate([0, 0, 1])cube([80, 80, 2],center=true);
    }
/*
    //-near far hole
    for(y=[-40:10:40]){
    for(x=[-40:10:40]){
        translate([x,y,0])cylinder(1000, r=1.6,center=true,$fn=50);
    }
    }
*/
    //hole @ 35
    translate([ 35, 35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([-35, 35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([ 35,-35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    translate([-35,-35, 0])cylinder(99, r=3.0,center=true,$fn=50);
    }

    difference(){
        hull(){
        translate([0,0,  0])cube([80,20,0.01],center=true);
        translate([0,0,-10+0.01])cube([80,14,0.01],center=true);
        }
        translate([0,0,-5])cube([99,13,10],center=true);
    }
}

/*
translate([0,0,40])rotate([0,180,0])top();
conn40();
bot();
*/

cam_beside();
//spk_ontv();
//conn40_one();
//top();
//bot();