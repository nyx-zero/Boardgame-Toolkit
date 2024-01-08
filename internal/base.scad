// Copyright 2023 Joshua Star, All Rights Reserved

fn = $preview ? 16 : 128;
$fn = fn;

SMALL_NUM = $preview ? 0.02 : 0.001;

DEFAULT_PADDING = 1.6;
DEFAULT_THICKNESS = 1.2;

function default_padding() = DEFAULT_PADDING;
function default_thickness() = DEFAULT_THICKNESS;

function make_list(v, n) = [for(i=[0:n-1]) v];
function sum_list(v) = [for(p=v) 1] * v;
