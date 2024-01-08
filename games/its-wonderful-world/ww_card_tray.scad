// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

slots = 2;

depth = calc_card_stack(80);

card_display(7won_card_dim(), depth, slots, thickness=1.6);
