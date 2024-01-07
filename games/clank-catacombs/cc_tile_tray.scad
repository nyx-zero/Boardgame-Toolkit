// Copyright 2023 Joshua Star, All Rights Reserved

use <../../boardgame_tk.scad>

dim = 100 + default_padding();

tray_notched([dim, dim, std_card_dim().x + 0.8], thickness=2);
