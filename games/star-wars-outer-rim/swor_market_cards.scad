// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

slots = 3;

depth = calc_card_stack(25);

card_display(amer_card_dim(), depth, slots);
