// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

tile_tray_y = 105.6;
dim_y = tile_tray_y - 2 * default_thickness();

card_tray(std_card_dim(), [dim_y]);
