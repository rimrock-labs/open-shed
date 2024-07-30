// https://www.mycarpentry.com/rafter-span-tables.html

// Dimensions of the requested roof (W x H x D)
Roof_Dimensions = [192, 30, 192];

// Dimensions of the rafters to use (W X H x L)
Rafter_Dimensions = [1.5, 3.5, 192];

// On center rafter spacing
Rafter_Spacing = 24;

// Object spacing to avoid merging on export
Object_Spacing = 0.0625;

// Scale factor useful when importing to other software (ex. 25.4 for inches);
Scale_Factor = 25.4;

module rafter(i, angle, length, rafter_dimensions, e = 0) {
    translate([-(e / 2), i - (e / 2), - (e/2)])
    rotate([0, 90 - angle, 0])
    rotate([0, 0, 90])
    cube([rafter_dimensions[0] + e, rafter_dimensions[1] + e, length + e]);
}

module rafter2(i, run, rise, rafter_dimensions) {
    length = sqrt(pow(run, 2) + pow(rise, 2));
    angle = atan(rise / run);

    translate([0, i, 0])
    rotate([0, 90 - angle, 0])
    rotate([0, 0, 90])
    cube([rafter_dimensions[0], rafter_dimensions[1], length]);
}

module truss(i, angle, length, roof_dimensions, rafter_dimensions, rafter_spacing, object_spacing) {
    rafter(i, angle, length, rafter_dimensions);
    difference() {
        union() {
            // span
            translate([0, rafter_dimensions[0] + i - rafter_dimensions[0], 0])
            rotate([0, 90, 0])
            rotate([0, 0, 90])
            cube([rafter_dimensions[0], rafter_dimensions[1], roof_dimensions[0]]);

            for (ii = [rafter_spacing:rafter_spacing:roof_dimensions[0]]) {
                // riser
                translate([ii, rafter_dimensions[0] + i - rafter_dimensions[0], rafter_dimensions[1] + object_spacing])
                rotate([0, 0, 90])
                cube([rafter_dimensions[0], rafter_dimensions[1], (tan(angle) * ii) - rafter_dimensions[1] - (object_spacing * 2)]);
            }
        }

        rafter(i, angle, length, rafter_dimensions, object_spacing);
    }
}

module roof(roof_dimensions, rafter_dimensions = [1.5, 3.5, 192], rafter_spacing = 24, object_spacing = 0.0625, scale_factor = 25.4) {
    angle = atan(roof_dimensions[1] / roof_dimensions[0]);
    rafter_length = sqrt(pow(roof_dimensions[0], 2) + pow(roof_dimensions[1], 2));

    // first truss
    truss(0, angle, rafter_length, roof_dimensions, rafter_dimensions, rafter_spacing, object_spacing);

    for (i = [rafter_spacing:rafter_spacing:roof_dimensions[2] - rafter_spacing]) {
        truss(i, angle, rafter_length, roof_dimensions, rafter_dimensions, rafter_spacing, object_spacing);
    }

    // last truss
    truss(roof_dimensions[2] - rafter_dimensions[0], angle, rafter_length, roof_dimensions, rafter_dimensions, rafter_spacing, object_spacing);

    // TODO: furring strips (1x2x96) on top of rafters
};

scale([Scale_Factor, Scale_Factor, Scale_Factor])
roof(Roof_Dimensions, Rafter_Dimensions, Rafter_Spacing, Object_Spacing, Scale_Factor);