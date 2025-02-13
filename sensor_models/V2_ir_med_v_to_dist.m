function [dist_mm] = V2_ir_med_v_to_dist(v)

a = 1.629;
b = 0.005387;
c = 0.07977; 

dist_mm = (a ./ v - c) ./ b;
end