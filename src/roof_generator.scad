// https://www.mycarpentry.com/rafter-span-tables.html

// Dimensions of the requested roof
Roof_Dimensions = [192, 30, 192];

// Dimensions of the rafters to use
Rafter_Dimensions = [1.5, 3.5, 192];

// On center rafter spacing
Rafter_Spacing = 24;

// Object spacing to avoid merging on export
Object_Spacing = 0.0625;

// Scale factor useful when importing to other software (ex. 25.4 for inches);
Scale_Factor = 25.4;

module rafter(i, angle, length, e = 0) {
	translate([-(e/2), Rafter_Dimensions[0] + i - Rafter_Dimensions[0] - (e / 2), - (e/2)])
	rotate([0, 90 - angle, 0])
	rotate([0, 0, 90])
	cube([Rafter_Dimensions[0] + e, Rafter_Dimensions[1] + e, length + e]);
}

module roof() {
	angle = atan(Roof_Dimensions[1] / Roof_Dimensions[0]);
	rafter_length = sqrt(pow(Roof_Dimensions[0], 2) + pow(Roof_Dimensions[1], 2));

	for (i = [0:Rafter_Spacing:Roof_Dimensions[2]]) {
		rafter(i, angle, rafter_length);
		
		difference() {
			union() {
				// span
				translate([0, Rafter_Dimensions[0] + i - Rafter_Dimensions[0], 0])
				rotate([0, 90, 0])
				rotate([0, 0, 90])
				cube([Rafter_Dimensions[0], Rafter_Dimensions[1], Roof_Dimensions[0]]);
				
				// riser
				translate([Roof_Dimensions[0], Rafter_Dimensions[0] + i - Rafter_Dimensions[0], Rafter_Dimensions[1] + Object_Spacing])
				rotate([0, 0, 90])
				cube([Rafter_Dimensions[0], Rafter_Dimensions[1], Roof_Dimensions[1] - Rafter_Dimensions[1] - (Object_Spacing * 2)]);
			}

			rafter(i, angle, rafter_length, Object_Spacing);
		}
	}
	
	/* spacers
	for (i = [1:Rafter_Spacing:Roof_Dimensions[2]]) {
		translate([Roof_Dimensions[0], Rafter_Dimensions[0] + Object_Spacing, 0])
		rotate([-90, -180, 0])
		cube([Rafter_Dimensions[0], Rafter_Dimensions[1], Rafter_Spacing - (Rafter_Dimensions[0]) - (Object_Spacing * 2)]);
	}
	*/
};

scale([Scale_Factor, Scale_Factor, Scale_Factor])
roof();