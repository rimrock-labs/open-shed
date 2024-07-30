// Dimensions of the requested wall
Wall_Dimensions = [144, 100.5];

// Dimensions of the studs to use
Stud_Dimensions = [1.5, 3.5, 96];

// On center stud spacing
Stud_Spacing = 24;

// Object spacing to avoid merging on export
Object_Spacing = 0.0625;

// Determines if middle studs are included
Include_Studs = true;

// Scale factor useful when importing to other software (ex. 25.4 for inches);
Scale_Factor = 25.4;

module wall(wall_dimensions, stud_dimensions = [1.5, 3.5, 96], stud_spacing = 24, object_spacing = 0.0625, include_studs = true) {
    length = wall_dimensions[0];
    height = wall_dimensions[1];

    stud_length = stud_dimensions[2];

    // sill plate
    plate_parts = floor(length / stud_length);
    plate_overflow = length % stud_length;

    for (i = [1:1:plate_parts]) {
        rotate([0, 90, 0])
        translate([-stud_dimensions[0], 0, (i - 1) * stud_length])
        cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - object_spacing]);
    }

    if (plate_overflow > 0) {
        rotate([0, 90, 0])
        translate([-stud_dimensions[0], 0, plate_parts * stud_length])
        cube([stud_dimensions[0], stud_dimensions[1], plate_overflow]);
    }

    // studs
    // first
    translate([0, 0, stud_dimensions[0] + object_spacing])
    cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - (object_spacing * 2)]);

    if (include_studs) {
        // studs
        stud_count = length % stud_spacing == 0 ? (length / stud_spacing) - 1 : (length / stud_spacing);
        for (i = [1:1:stud_count]) {
            translate([i * (stud_spacing - stud_dimensions[0]/2), 0, stud_dimensions[0] + object_spacing])
            cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - (object_spacing * 2)]);
        }
    }

    // last
    translate([length - stud_dimensions[0], 0, stud_dimensions[0] + object_spacing])
    cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - (object_spacing * 2)]);

    // top plates
    if (plate_overflow > 0) {
        rotate([0, 90, 0])
        translate([-height + stud_dimensions[0], 0, 0])
        cube([stud_dimensions[0], stud_dimensions[1], plate_overflow]);

        rotate([0, 90, 0])
        translate([-height - stud_dimensions[0] - object_spacing + stud_dimensions[0], 0, plate_parts * stud_length + object_spacing])
        cube([stud_dimensions[0], stud_dimensions[1], plate_overflow]);
    }

    for (i = [1:1:plate_parts]) {
        rotate([0, 90, 0])
        translate([-height + stud_dimensions[0], 0, plate_overflow + object_spacing + (i - 1) * stud_length])
        cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - object_spacing]);

        rotate([0, 90, 0])
        translate([-height - stud_dimensions[0] - object_spacing + stud_dimensions[0], 0, (i - 1) * stud_length])
        cube([stud_dimensions[0], stud_dimensions[1], stud_dimensions[2] - object_spacing]);
    }
}

scale([Scale_Factor, Scale_Factor, Scale_Factor])
wall(Wall_Dimensions, Stud_Dimensions, Stud_Spacing, Object_Spacing, Include_Studs);