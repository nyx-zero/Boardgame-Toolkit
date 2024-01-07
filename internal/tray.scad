// Copyright 2023 Joshua Star, All Rights Reserved

include <base.scad>
include <prim.scad>

module tray_basic(inner_size, r=0, thickness=DEFAULT_THICKNESS, bottom_thickness=undef) {

	half_z = inner_size.z / 2;
	radius = min(r, half_z);

	bottom_thk = bottom_thickness != undef ? bottom_thickness : thickness;

	thk2 = thickness * 2;

	outer_size = inner_size + [thk2, thk2, bottom_thk];
	echo("tray outer dimensions are: ", outer_size);

	inner_radius = radius - thickness;

	union() {
		difference() {
			// outer shell
			if (0 < r) {
				union() {
					translate([0, 0, bottom_thk])
						cylinder_cube([outer_size.x, outer_size.y, outer_size.z - bottom_thk], r=radius);
					cylinder_cube([outer_size.x, outer_size.y, bottom_thk], inner_radius, radius);
				}
			}
			else {
				cube(outer_size);
			}
			
			// lip cutout
			if (0 < radius) {
				translate([0, 0, inner_size.z + SMALL_NUM])
					cylinder_cube([outer_size.x, outer_size.y, bottom_thk], r1=inner_radius, r2=radius);
			}

			// inner cutout
			if (0 < radius) {
				translate([thickness, thickness, bottom_thk])
					rounded_cube(inner_size + [0, 0, bottom_thk], r=inner_radius, flat_top=true);
			}
			else {
				translate([thickness, thickness, bottom_thk])
						cube(inner_size + [0, 0, bottom_thk]);
			}
		}
	}
}

module tray_divided(size, r=0, div_x=1, div_y=1, thickness=DEFAULT_THICKNESS, bottom_thickness=undef, div_height=undef, div_thickness=undef) {

	bottom_thk = bottom_thickness != undef ? bottom_thickness : thickness;

	div_thk = div_thickness != undef ? div_thickness : thickness;
	div_z = div_height != undef ? div_height : size.z;

	max_div_z = 0 == r ? size.z : size.z - bottom_thk;
	clamped_div_z = min(div_z, max_div_z);

	x_minus_div = size.x - (div_thk * (div_x - 1));
	y_minus_div = size.y - (div_thk * (div_y - 1));

	x_off = (x_minus_div / div_x) + div_thk;
	y_off = (y_minus_div / div_y) + div_thk;
	
	union() {
		tray_basic(size, r=r, thickness=thickness, bottom_thickness=bottom_thk);

		// columns, along x
		for (i=[1:1:div_x-1]) {
			translate([i * x_off, thickness, bottom_thk])
				cube([div_thk, size.y, clamped_div_z]);
		}

		// rows, along y
		for (i=[1:1:div_y-1]) {
			translate([thickness, i * y_off, bottom_thk])
				cube([size.x, div_thk, clamped_div_z]);
		}
	}
}

module notch_cutter(h, r) {
	n = 6;
	rotate([0, 0, 180 / n]) cylinder_ngon(2 * r, h, n);
}

module tray_notched(size, div_x=1, div_y=1, thickness=DEFAULT_THICKNESS, bottom_thickness=undef, div_height=undef, div_thickness=undef, notch_lo_x=true, notch_hi_x=true) {

	bottom_thk = bottom_thickness != undef ? bottom_thickness : thickness;

	div_thk = div_thickness != undef ? div_thickness : thickness;
	div_z = div_height != undef ? div_height : size.z;

	x_minus_div = size.x - (div_thk * (div_x - 1));

	x_off = (x_minus_div / div_x) + div_thk;
	
	div_bias = (div_thk - x_off) / 2;

	notch_h = size.z + bottom_thk + 2 * SMALL_NUM;
	notch_r = x_off / 3;

	difference() {
		tray_divided(size, div_x=div_x, div_y=div_y, thickness=thickness, bottom_thickness=bottom_thk, div_height=div_z, div_thickness=div_thk);

		// notch along x
		for (i=[1:1:div_x]) {

			if (notch_lo_x) {
				translate([i * x_off + div_bias, thickness, -SMALL_NUM])
					notch_cutter(notch_h, notch_r);
			}

			if (notch_hi_x) {
				translate([i * x_off + div_bias, size.y + thickness, -SMALL_NUM])
					notch_cutter(notch_h, notch_r);
			}
		}
	}
}

// --- TESTING ---

//tray_basic([240, 120, 30], r=4);

//translate([-1.2, -1.2, 0]) tray_divided([200, 100, 5], div_x=20, div_y=10);
//tray_divided([180, 120, 30], r=15, div_x=3, div_y=2, div_height=25);

//translate([-1.2, -1.2, 0]) tray_notched([200, 100, 30], div_x=20, div_y=10);
