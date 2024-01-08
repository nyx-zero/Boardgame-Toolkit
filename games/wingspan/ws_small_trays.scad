// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

dim_x = 110 - 2 * default_thickness();
dim_y = 84 - 2 * default_thickness();

// cubes
tray_divided([dim_x, dim_y, 15], r=6, div_x=5);

// eggs
*tray_basic([dim_x, dim_y, 27], r=6);

// dice
*tray_divided([dim_x, dim_y, 21], r=6, div_x=2);

// nectar
*tray_basic([dim_x, dim_y, 12], r=6);
