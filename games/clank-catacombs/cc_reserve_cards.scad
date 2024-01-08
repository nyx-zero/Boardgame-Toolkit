// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

slots = 3;

depth = calc_card_stack(20);

card_display(std_card_dim(), depth, slots);
