// Copyright 2023 Joshua Star, All Rights Reserved

module cylinder_cube(size, r1=1, r2=1, r=undef) {
	r1 = r != undef ? r : r1;
	r2 = r != undef ? r : r2;

	r_max = max(r1, r2);
	hull() {
		translate([r_max, r_max, 0])
			cylinder(size.z, r1, r2);
		translate([size.x - r_max, r_max, 0])
			cylinder(size.z, r1, r2);
		translate([r_max, size.y - r_max, 0])
			cylinder(size.z, r1, r2);
		translate([size.x - r_max, size.y - r_max, 0])
			cylinder(size.z, r1, r2);
	}
}

module cylinder_ngon(width, h, n=6, r=1) {
	hull() {
		for (i=[0:1:n-1]) {
			angl_off = 360 / n;
			posx_off = width / 2 - r;
			rotate([0, 0, i * angl_off]) translate([posx_off, 0, 0])
				cylinder(r=r, h=h);
		}
	}
}

module cylinder_trap(size, ratio, radius=1) {
	hull() {
		half_size_x = size.x / 2;
		translate([radius - half_size_x, radius, 0])
			cylinder(r=radius, h=size.z);
		translate([half_size_x - radius, radius, 0])
			cylinder(r=radius, h=size.z);
		translate([radius - ratio * half_size_x, size.y - radius, 0])
			cylinder(r=radius, h=size.z);
		translate([ratio * half_size_x - radius, size.y - radius, 0])
			cylinder(r=radius, h=size.z);
	}
}

module rounded_cube(size, r=1, flat_top=false) {
	
	half_z = size.z / 2;
	radius = min(r, half_z);
	
	hull() {
		// bottom 'points'
		translate([radius,radius,radius]) sphere(r=radius);
		translate([size.x-radius,radius,radius]) sphere(r=radius);
		translate([radius,size.y-radius,radius]) sphere(r=radius);
		translate([size.x-radius,size.y-radius,radius]) sphere(r=radius);

		// top 'points'
		pos_z = size.z - radius;
		if (flat_top) {
			translate([radius, radius, pos_z]) cylinder(r=radius, h=radius);
			translate([size.x-radius, radius, pos_z]) cylinder(r=radius, h=radius);
			translate([radius, size.y-radius, pos_z]) cylinder(r=radius, h=radius);
			translate([size.x-radius, size.y-radius, pos_z]) cylinder(r=radius, h=radius);
		}
		else {
			translate([radius, radius, pos_z]) sphere(r=radius);
			translate([size.x-radius, radius, pos_z]) sphere(r=radius);
			translate([radius, size.y-radius, pos_z]) sphere(r=radius);
			translate([size.x-radius, size.y-radius, pos_z]) sphere(r=radius);
		}
	}
}

// --- TESTING ---

//cylinder_cube([240, 120, 30], r=8);

//cylinder_cube([240, 120, 16], r1=4, r2=8);
//cylinder_cube([240, 120, 16], r1=8, r2=4);

//cylinder_ngon(10, 5, 7, 1);

//cylinder_trap([100, 50, 30], 0.5, radius=8);

//rounded_cube([240, 120, 30], r=12);
//rounded_cube([240, 120, 30], r=12, flat_top=true);
//rounded_cube([240, 120, 30], r=30, flat_top=true);
