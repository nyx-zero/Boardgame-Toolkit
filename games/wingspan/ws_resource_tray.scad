// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

card_tray_x = 187.8;

dim_x = card_tray_x - 2 * default_thickness();
dim_y = 86;
dim_z = 27;

div_z = dim_z - 6; // lets you rest a scorepad on top

tray_divided([dim_x, dim_y, dim_z], r=8, div_x=5, div_height=div_z);
