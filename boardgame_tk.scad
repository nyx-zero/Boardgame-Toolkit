// Copyright 2023 Joshua Star, All Rights Reserved

include <internal/base.scad>
include <internal/boxes.scad>
include <internal/card.scad>
include <internal/math.scad>
include <internal/prim.scad>
include <internal/tray.scad>

module card_display(card_size, height, num_stacks, padding=DEFAULT_PADDING, thickness=DEFAULT_THICKNESS, bottom_thickness=undef, div_thickness=undef) {

	div_thk = div_thickness != undef ? div_thickness : thickness;

	dim_x = (card_size.x + padding) * num_stacks + (div_thk * (num_stacks - 1));
	dim_y = card_size.y + padding;
	dim_z = height;

	tray_notched([dim_x, dim_y, dim_z], div_x=num_stacks, thickness=thickness, bottom_thickness=bottom_thickness, div_thickness=div_thickness, notch_hi_x=false);
}

module vertical_cutter(size, r=0.5) {
	difference() {
		translate([0, size.z, 0]) rotate([90, 0, 0])
		linear_extrude(height=size.z) {
			translate([0, r, 0])
			offset(r=-r) {
				offset(r=2*r) {
					union() {
						translate([-(size.x + 2 * r) / 2, 0, 0]) square([size.x + 2 * r, 1]);
						translate([-(size.x - 2 * r)/2, -size.y, 0]) square([size.x - 2 * r, size.y]);
					}
				}
			}
		}

		translate([-(size.x + r), -size.z, 0])
			cube([2 * (size.x + r), 3 * size.z, 2 * (size.y + r)]);
	}
}

module card_tray(card_size, stacks, num_columns=1, padding=[0.8, 0.8, 0.8], thickness=DEFAULT_THICKNESS, bottom_thickness=undef, div_height=undef, div_thickness=undef) {

	bottom_thk = bottom_thickness != undef ? bottom_thickness : thickness;

	div_thk = div_thickness != undef ? div_thickness : thickness;

	col_dim_x = card_size.y + padding.x;

	dim_x = col_dim_x * num_columns + div_thk * (num_columns - 1);
	dim_y = sum_list(stacks) + (div_thk + padding.y) * (len(stacks) - 1);
	dim_z = card_size.x + padding.z;

	div_z = div_height != undef ? div_height : dim_z;

	min_card_dim = min(card_size.x, card_size.y);
	cutter_radius = min_card_dim / 6;

	difference() {
		union() {
			tray_divided([dim_x, dim_y, dim_z], div_x=num_columns, thickness=thickness, bottom_thickness=bottom_thickness);

			div_offsets = [
				for (a=0, b=stacks[0]; a < (len(stacks) - 1); a = a + 1, b = b + (stacks[a]==undef?0:stacks[a]) + padding.y + div_thk)
					b
				];

			// columns, along x
			for (c=[0:1:num_columns-1]) {
				// rows, along y
				for (y=div_offsets) {
					x_off = c * (col_dim_x + div_thk) + thickness;

					translate([x_off, y, bottom_thk])
						cube([col_dim_x, div_thk, div_z]);
				}
			}
		}

		cutout_size = [col_dim_x / 2, dim_z / 2, thickness + 2 * SMALL_NUM];
		cutout_z = bottom_thk + dim_z + SMALL_NUM;

		// cutout
		for (c=[0:1:num_columns-1]) {
			n = 8;

			x_off = c * (col_dim_x + div_thk) + (col_dim_x / 2) + thickness;

			// front cut
			translate([x_off, -SMALL_NUM, cutout_z])
					vertical_cutter(cutout_size, r=cutter_radius);
			
			// back cut
			translate([x_off, dim_y + thickness - SMALL_NUM, cutout_z])
					vertical_cutter(cutout_size, r=cutter_radius);
			
			// middle cut
			translate([x_off, thickness, bottom_thk + div_z + SMALL_NUM])
					vertical_cutter([cutout_size.x, div_z / 2, dim_y], r=cutter_radius);
		}
	}
}

module spacer(size, r=16, div_x=2, div_y=2, spacing=16) {
	difference() {
		cylinder_cube(size, r=r);

		half_spacing = spacing / 2;
		inner_radius = r - half_spacing;

		offset_x = size.x / div_x;
		offset_y = size.y / div_y;
		for (i=[0:1:div_x]) {
			for (j=[0:1:div_y]) {
				translate([i * offset_x + half_spacing, j * offset_y + half_spacing, -1])
				cylinder_cube([
					size.x / div_x - spacing,
					size.y / div_y - spacing,
					size.z + 2], r=inner_radius);
			}
		}
	}
}

module pegs_grid(rows=1, cols=1, radius=1, height=1, spacing=1, alt_pack=false) {
	x_start = spacing + radius;
	y_start = spacing + radius;

	x_alt_start = radius + spacing / 2;

	x_offset = 2 * radius + spacing;
	y_offset = alt_pack ? ((radius + spacing / 2) * sqrt(3)) : 2 * radius + spacing;

	for (r=[0:1:rows-1]) {
		is_alt = alt_pack ? (r % 2) : 0;
		for (c=[0:1:cols-(1 + is_alt)]) {
			translate([
					c * x_offset + x_start + x_alt_start * is_alt,
					r * y_offset + y_start,
					0])
				cylinder(h=height, r=radius);
		}
	}
}

module peg_board(rows=1, cols=1, radius=1, height=1, spacing=1) {
	difference() {
		cylinder_cube([
			cols * 2 * radius + (cols + 1) * spacing,
			rows * 2 * radius + (rows + 1) * spacing,
			height], r=radius);

		translate([0, 0, -height/2])
			pegs_grid(rows=rows, cols=cols, radius=radius, height=2*height, spacing=spacing, alt_pack=false);
	}
}

// --- TESTING ---

//card_display(mini_euro_card_dim(), 30, 3);

//vertical_cutter([100,50, 10], r=10);

//card_tray(std_card_dim(), [30, 30, 8, 8, 8, 16, 42], num_columns=4, div_height=55);

//spacer([240, 120, 10], r=16, div_x=4, div_y=3, spacing=8);

//pegs_grid(rows=4, cols=5, radius=32, height=4, spacing=6, alt_pack=false);
//pegs_grid(rows=4, cols=5, radius=32, height=4, spacing=6, alt_pack=true);

//peg_board(rows=3, cols=4, radius=28, height=4, spacing=6);
