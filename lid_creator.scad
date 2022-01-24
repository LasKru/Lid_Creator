$fn = 100;
diameter_lid = 56;
wall_size = 2;
notch_size = 3;
notch_length = 10;
notch_number = 4;
notch_height = 1;
height_lid = 10;
angle = 360 / notch_number;


rotate(180,[0,1,0])
difference(){
cylinder(h=height_lid, d=diameter_lid); //outer lid
cylinder(h=height_lid - wall_size, d=diameter_lid - 2*wall_size); //inner_lid
}

module Notch(length, width, height){
    difference(){
        linear_extrude(height=height)
    hull() {
        translate([0,length/2-width/2,0]) circle(width/2);
        translate([0, -length/2+width/2,0]) circle(width/2);
    }
    translate([-width/2,0, height/2]) cube([width,length,height], center=true);
    }
}

for (i = [0:notch_number-1]){
    X = ((diameter_lid/2) - wall_size) * cos(angle*i); //Kreisgleichung X = r * cos(phi)
    Y = ((diameter_lid/2) - wall_size) * sin(angle*i);

    translate([X,Y,- notch_height]) rotate(180,[0,0,1])
    rotate(angle*i,[0,0,1]) Notch(notch_length,notch_size,notch_height);
}

*Notch(notch_length,notch_size,notch_height);