function [dist_mm] = V2_ir_long_v_to_dist(v)

a = 0.9578;
b = 0.002725;
c = -0.4794;

dist_mm = (a ./ v - c) ./ b;
end