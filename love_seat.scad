inches = 25.4;
slot_thickness = 5;
kerf = 3/16*inches;

module side_support (scale = 1) {
    w = 31*inches*scale;
    h = 24*inches*scale;
    difference () {
        hull () {
          upper_r = 6*inches*scale;
          lower_r = 2*inches*scale;
          square ([w-upper_r, h]);
          translate([w-upper_r,h-upper_r]) circle(upper_r);
          translate([w-lower_r,lower_r]) circle(lower_r);
        }
        translate ([0,h-2*inches*scale-slot_thickness])
          square ([7.5*inches*scale, slot_thickness]);
        
        translate ([0,h-14*inches*scale-slot_thickness])
          square ([7*inches*scale, slot_thickness]);
        
        translate ([15.25*inches*scale, h])
          rotate(180+84.938)
          square([8.5*inches*scale, slot_thickness]);
        translate ([15.25*inches*scale, h])
          mirror([1,0])
          rotate(180-84.938)
          square([1*inches*scale, slot_thickness]);
        
        translate([w,4*inches*scale])
          mirror([0,1])
          rotate(180+17.105)
          square([8.5*inches*scale, slot_thickness]);
    }
}

module other (w, slot_length, scale = 1) {
    h = 48*inches;
    difference () {
      square ([w*scale, h*scale]);
      translate([0,2.5*inches*scale])
        square([slot_length*scale, slot_thickness]);
      translate([0,(h-2.5*inches)*scale-slot_thickness])
        square([slot_length*scale, slot_thickness]);
    }
}

module all (s = 1) {
    union () {
      translate([31*inches*s+1*kerf,0])
        other(19*inches, 9.5*inches, s); // back
      translate([(31+19)*inches*s+2*kerf,0])
        other(17*inches, 8.5*inches, s); // seat
      translate([(31+19+17)*inches*s+3*kerf,0])
        other(15*inches, 7.5*inches, s); // front support
      translate([(31+19+17+15)*inches*s+4*kerf, 0])
        other(14*inches, 7*inches,s ); // back support       
      translate([0,24*inches*s+kerf])
        side_support(s);
      side_support(s);
    }
}

all(0.49);