function [dist_mm] = ir_short_v_to_dist(v)
% a = -0.0075;
% b = 4.1530;
% c = 0.0184;
% d = 0.7548;

global short_coeffs;

a = short_coeffs(1);
b = short_coeffs(2);
c = short_coeffs(3);
d = short_coeffs(4);

dist_mm = (b - v.*d) ./ (v.*c - a);
end