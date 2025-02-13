function [dist_mm] = V2_ir_short_v_to_dist(v)
 
a = 2.317;
b = 0.02002;
c = -0.1557; 

dist_mm = (a ./ v - c) ./ b;
end