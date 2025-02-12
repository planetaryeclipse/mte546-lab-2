function [dist_mm] = ir_med_v_to_dist(v)
a = 0.0299;
b = 81.4808;
c = 0.3768;
d = -4.1426;

dist_mm = (b - v.*d) ./ (v.*c - a);
end