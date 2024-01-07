// Copyright 2023 Joshua Star, All Rights Reserved

TOLERANCE_MIN = [0.4, 0.4];
TOLERANCE_MAX = [0.8, 0.8];

function std_card_dim() = [67, 93] + TOLERANCE_MIN; // gray
function amer_card_dim() = [59, 91] + TOLERANCE_MIN; // green
function euro_card_dim() = [62, 94] + TOLERANCE_MIN; // purple

function mini_amer_card_dim() = [44, 67] + TOLERANCE_MIN; // yellow
function mini_euro_card_dim() = [46, 71] + TOLERANCE_MIN; // ruby

function 7won_card_dim() = [67, 103] + TOLERANCE_MAX; // brown
function tarot_card_dim() = [73, 122] + TOLERANCE_MAX; // orange

function per_card_thickness() = 0.68;

function calc_card_stack(n, padding=1.2) = n * per_card_thickness() + padding;
