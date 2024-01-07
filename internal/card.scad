// Copyright 2023 Joshua Star, All Rights Reserved

SMALL_TOLERANCE = [0.4, 0.4];
BIG_TOLERANCE = [1, 1];

function std_card_dim() = [67, 93] + SMALL_TOLERANCE; // gray
function amer_card_dim() = [59, 91] + SMALL_TOLERANCE; // green
function euro_card_dim() = [62, 94] + SMALL_TOLERANCE; // purple

function mini_amer_card_dim() = [44, 67] + SMALL_TOLERANCE; // yellow
function mini_euro_card_dim() = [46, 71] + SMALL_TOLERANCE; // ruby

function 7won_card_dim() = [67, 103] + BIG_TOLERANCE; // brown
function tarot_card_dim() = [73, 122] + BIG_TOLERANCE; // orange

function per_card_thickness() = 0.68;

function calc_card_stack(n, padding=1.2) = n * per_card_thickness() + padding;
