// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

depth = 16;
dim = 55 - 2 * default_thickness();

tray_basic([dim, dim, depth], r=12);
