// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

slots = 4;

tile_pad = 1;
tile_dim = 51 + tile_pad;

dim_x = tile_dim * slots + default_thickness() * (slots - 1);
dim_z = gamebox_ffg_10().z - default_thickness() - 2;

tray_notched([dim_x, tile_dim, dim_z], div_x=4);
