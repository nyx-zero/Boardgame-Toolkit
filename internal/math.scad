// Copyright 2023 Joshua Star, All Rights Reserved

function clamp(x, lower, upper) = x < lower ? lower : (upper < x ? upper : x);
function lerp(lower, upper, s) = (upper - lower) * s + lower;
