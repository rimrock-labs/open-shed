// Door opening dimension (W x H x D)
Door_Dimensions = [72, 80, 3.5];

// Dimensions of the studs material to use (W x H x L)
Stud_Dimensions = [1.5, 3.5, 96];

// Dimensions of the header material.
Header_Dimensions = [1.5, 5.5, 96];

// Cripple stud spacing.
Cripple_Stud_Spacing = 24;

// Object spacing to avoid merging on export.
Object_Spacing = 0.0625;

module door(door_dimensions, stud_dimensions = [1.5, 3.5, 96], header_dimensions = [1.5, 5.5, 96], cripple_stud_spacing = 24, object_spacing = 0.0625) {
    // left king stub
    translate([-(stud_dimensions[0] * 2) - object_spacing, 0, 0])
    cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - object_spacing]);

    // left jack stud
    translate([-stud_dimensions[0], 0, 0])
    cube([stud_dimensions[0], stud_dimensions[1], door_dimensions[1] - object_spacing]);

    // header layer 1
    translate([-stud_dimensions[0], 0, door_dimensions[1]])
    cube([door_dimensions[0] + (stud_dimensions[0] * 2), header_dimensions[0], header_dimensions[1]]);

    // header layer 2
    translate([-stud_dimensions[0], header_dimensions[0], door_dimensions[1]])
    cube([door_dimensions[0] + (stud_dimensions[0] * 2), header_dimensions[0], header_dimensions[1]]);

    // right jack stud
    translate([door_dimensions[0], 0, 0])
    cube([stud_dimensions[0], stud_dimensions[1], door_dimensions[1] - object_spacing]);

    // right king stud
    translate([door_dimensions[0] + stud_dimensions[0] + object_spacing, 0, 0])
    cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - object_spacing]);

    // cripple studs above header
    for(i = [cripple_stud_spacing:cripple_stud_spacing:door_dimensions[0] - cripple_stud_spacing]) {
        translate([i, 0, door_dimensions[1] + header_dimensions[1] + object_spacing])
        cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - door_dimensions[1] - header_dimensions[1] - (object_spacing * 2)]);
    }

   // cube([door_dimensions[0], door_dimensions[2], door_dimensions[1]]);
}

door(Door_Dimensions, Stud_Dimensions, Header_Dimensions, Cripple_Stud_Spacing, Object_Spacing);