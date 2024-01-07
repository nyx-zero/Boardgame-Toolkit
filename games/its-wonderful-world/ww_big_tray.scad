// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

card_tray_y = 108.8;
card_tray_z = 57.2;

depth = (card_tray_z / 2) - default_thickness();

dim_x = 130;
dim_y = card_tray_y - 2 * default_thickness();

tray_divided([dim_x, dim_y, depth], r=12, div_x=2);
