// Dimensions of the requested wall
Wall_Dimensions = [144, 100.5];

// Dimensions of the studs to use
Stud_Dimensions = [1.5, 3.5, 96];

// On center stud spacing
Stud_Spacing = 24;

// Object spacing to avoid merging on export
Object_Spacing = 0.001;

// Determines if middle studs are included
Include_Studs = true;

// Scale factor useful when importing to other software (ex. 25.4 for inches);
Scale_Factor = 25.4;

module wall() {
	length = Wall_Dimensions[0];
	height = Wall_Dimensions[1];
	
	stud_length = Stud_Dimensions[2];
	
	// sill plate
	plate_parts = floor(length / stud_length);
	plate_overflow = length % stud_length;
	
	for (i = [1:1:plate_parts]) {
		rotate([0, 90, 0])
		translate([-Stud_Dimensions[0], 0, (i - 1) * stud_length])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - Object_Spacing]);
	}
	
	if (plate_overflow > 0) {
		rotate([0, 90, 0])
		translate([-Stud_Dimensions[0], 0, plate_parts * stud_length])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], plate_overflow]);
	}
	
	// studs
	// first
	translate([0, 0, Stud_Dimensions[0] + Object_Spacing])
	cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - (Object_Spacing * 2)]);
	
	if (Include_Studs) {
		// studs
		stud_count = length % Stud_Spacing == 0 ? (length / Stud_Spacing) - 1 : (length / Stud_Spacing);
		for (i = [1:1:stud_count]) {
			translate([i * (Stud_Spacing - Stud_Dimensions[0]/2), 0, Stud_Dimensions[0] + Object_Spacing])
			cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - (Object_Spacing * 2)]);
		}
	}
	
	// last
	translate([length - Stud_Dimensions[0], 0, Stud_Dimensions[0] + Object_Spacing])
	cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - (Object_Spacing * 2)]);
	
	// top plates
	if (plate_overflow > 0) {
		rotate([0, 90, 0])
		translate([-height + Stud_Dimensions[0], 0, 0])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], plate_overflow]);
		
		rotate([0, 90, 0])
		translate([-height - Stud_Dimensions[0] - Object_Spacing + Stud_Dimensions[0], 0, plate_parts * stud_length + Object_Spacing])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], plate_overflow]);
	}
	
	for (i = [1:1:plate_parts]) {
		rotate([0, 90, 0])
		translate([-height + Stud_Dimensions[0], 0, plate_overflow + Object_Spacing + (i - 1) * stud_length])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - Object_Spacing]);
		
		rotate([0, 90, 0])
		translate([-height - Stud_Dimensions[0] - Object_Spacing + Stud_Dimensions[0], 0, (i - 1) * stud_length])
		cube([Stud_Dimensions[0], Stud_Dimensions[1], Stud_Dimensions[2] - Object_Spacing]);
	}
}

scale([Scale_Factor, Scale_Factor, Scale_Factor])
wall();