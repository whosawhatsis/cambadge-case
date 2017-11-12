w = 120.5;
bat = 18.5;
batheight = 20;
board = 7;
height = 60;
flashbox = [25, 12];
supportgap = .3;

$fs = .2;
$fa = 2;

translate([0, -3, 0]) rotate([180, 0, 0]) 
union() {
	mirror([0, 0, 1]) linear_extrude(.5) intersection() {
		profile();
		translate([w/2 - 22, -10, 0]) difference() {
			translate([-3, 0, 0]) square(100);
			//square([9, 13]);
			translate([0, 12, 0]) rotate(0) buttoncut(3, 0);
		}
	}
	translate([w/2 - 22, 2, 0]) rotate([180, 0, 0]) linear_extrude(3) intersection() {
		circle(3);
		translate([-10, -18, 0]) square(20);
	}
}

//translate([0, 8, 0]) rotate([-90, 0, 0]) 
translate([0, -2, 0])
mirror([0, 1, 0]) {
	linear_extrude(.5) difference() {
		offset(3) offset(-3) difference() {
			hull() {
				for(i = [26, 60]) translate([-w/2 + i, 1 + 6, 0]) circle(6);
				for(i = [26, 60]) translate([-w/2 + i, height + 1 - 6, 0]) circle(6);
			}
			offset(1) translate([-w/2 + 20, height / 2 + 1 - 15, 0]) square([32, 30]);
			hull() for(i = [1, -1]) translate([0, 2, 1 + i * 4]) circle(r = 6);
		}
		for(i = [26, 49]) translate([-w/2 + i, 1 + 7, 0]) rotate((i > 30) ? 90 : -90) buttoncut();
		for(i = [26, 37, 49]) translate([-w/2 + i, height + 1 - 7, 0]) rotate((i  == 37) ? 180 : (i > 30) ? 90 : -90) buttoncut();
	}
	linear_extrude(3) {
		for(i = [26, 49]) translate([-w/2 + i, 1 + 7, 0]) circle(2);
		for(i = [26, 37, 49]) translate([-w/2 + i, height + 1 - 7, 0]) circle(2);
	}
}

difference() {
	union() {
		linear_extrude(height + 2, convexity = 5) difference() {
			offset(1.5) profile();
			offset(.5) profile();
		}
		linear_extrude(1) offset(1) profile();
	}
	translate([-w/2 + 20, 2, height / 2 + 1 - 15]) difference() {
		cube([32, 100, 30]);
		//translate([supportgap, supportgap, supportgap]) cube([32 - supportgap * 2, 100 - supportgap * 2, 30 - supportgap * 2]);
	}
	translate([w/2 - 22, 2, 2]) rotate([180, 0, 0]) difference() {
		cylinder(r = 5, h = 100);
		translate([0, 0, supportgap]) cylinder(r = 5 - supportgap, h = 100);
	}
	translate([w/2 - 33, 2, 1 + 9]) rotate([90, 0, 0]) cylinder(r = 5, h = 100);
	translate([w/2 - 22, 2, 1 + 11]) rotate([90, 0, 0]) cylinder(r = 3, h = 100);
	difference() {
		hull() for(i = [1, -1]) translate([0, 2, 1 + i * 4]) rotate([90, 0, 0]) cylinder(r = 4, h = 100, center = true);
		hull() for(i = [1, -1]) translate([0, 2, 1 + i * 4]) rotate([90, 0, 0]) cylinder(r = 4 - supportgap, h = 100, center = true);
	}
	translate([w/2 - 47, 2, 0]) rotate([90, 0, 0]) difference() {
		cylinder(r = 6, h = 100, center = true);
		cylinder(r = 6 - supportgap, h = 100, center = true);
	}
	for(i = [26, 49]) translate([-w/2 + i, 2, 1 + 7]) rotate([-90, 0, 0]) cylinder(r = 3, h = 100);
	for(i = [26, 37, 49]) translate([-w/2 + i, 2, height + 1 - 7]) rotate([-90, 0, 0]) cylinder(r = 3, h = 100);
}

module buttoncut(size = 2, cut = 1) offset(.3) offset(-.3) difference() {
	union() {
		circle(size + 1);
		translate([-size - 1, 0, 0]) square([size * 2 + 2, size + cut]);
	}
	circle(size);
	translate([-size, 0, 0]) square(size * 2);
}

module profile() offset(1) offset(-1) union() {
	for(i = [1, -1]) translate([i * (w / 2 - bat / 2), 0, 0]) hull() {
		translate([0, batheight - bat/2, 0]) circle(bat/2);
		translate([0, board/2, 0]) square([bat, board], center = true);
	}
	
	hull() for(i = [1, -1]) translate([i * (w / 2 - bat / 2), 0, 0]) {
		translate([0, board/2, 0]) square([bat, board], center = true);
	}
	translate([w / 2 - flashbox[0], 0, 0]) square(flashbox);
}