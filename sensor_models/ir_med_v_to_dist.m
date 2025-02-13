function [dist_mm] = ir_med_v_to_dist(v)
% a = 0.0299;
% b = 81.4808;
% c = 0.3768;
% d = -4.1426;

global med_coeffs;

a = med_coeffs(1);
b = med_coeffs(2);
c = med_coeffs(3);
d = med_coeffs(4);

dist_mm = (b - v.*d) ./ (v.*c - a);
end