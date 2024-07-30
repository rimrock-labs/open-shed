use <wall.scad>
use <sloped-roof.scad>
use <door.scad>

Object_Spacing = 0.0625;

color("#ffbb00")
translate([0, 192 - 3.5 + Object_Spacing, 0])
wall([192, 100.5]);

color("#ffbb00")
wall([192, 100.5]);

color("#ffbb00")
translate([3.5, 3.5 + Object_Spacing, 0])
rotate([0, 0, 90])
wall([192 - 7, 100.5]);

color("#ffbb00")
translate([0, 0, 100.5 + (Object_Spacing * 2)])
mirror([1, 0, 0])
rotate([0, 0, 90])
roof([192, 30, 192]);

color("#ffbb00")
translate([192, 3.5 + Object_Spacing, 0])
rotate([0, 0, 90])
wall([192 - 7, 100.5], skip_studs = [3,4,5]);

color("#ffbb00")
translate([0, 192 / 2 - 72 / 2, 1.5])
translate([192, 0, 0])
rotate([0, 0, 90])
door([72, 80, 3.5]);