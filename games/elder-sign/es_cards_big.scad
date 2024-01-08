// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

slots = 2;

dim_z = gamebox_ffg_10().z - default_thickness() - 3;
echo("Tray should hold approximately ", calc_card_count(dim_z), " cards per slot.");

card_display(tarot_card_dim(), dim_z, slots);
