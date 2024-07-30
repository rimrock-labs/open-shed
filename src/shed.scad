use <wall.scad>
use <sloped-roof.scad>

Object_Spacing = 0.0625;

translate([0, 192 - 3.5 + Object_Spacing, 0])
wall([192, 100.5]);

wall([192, 100.5]);

translate([3.5, 3.5 + Object_Spacing, 0])
rotate([0, 0, 90])
wall([192 - 7, 100.5]);

translate([0, 0, 100.5])
mirror([1, 0, 0])
rotate([0, 0, 90])
roof([192, 30, 192]);