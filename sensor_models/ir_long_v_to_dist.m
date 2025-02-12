function [dist_mm] = ir_long_v_to_dist(v)
a = 0.0295;
b = 43.1601;
c = 0.0943;
d = 0.6177;

dist_mm = (b - v.*d) ./ (v.*c - a);
end