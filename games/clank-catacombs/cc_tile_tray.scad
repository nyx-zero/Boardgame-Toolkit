// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

thk = 2;

dim_xy = 100 + default_padding();
dim_z = 69.4 - thk;

tray_notched([dim_xy, dim_xy, dim_z], thickness=thk);
