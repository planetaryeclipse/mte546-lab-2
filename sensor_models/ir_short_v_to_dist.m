function [dist_mm] = ir_short_v_to_dist(v)
a = -0.0075;
b = 4.1530;
c = 0.0184;
d = 0.7548;

dist_mm = (b - v.*d) ./ (v.*c - a);
end