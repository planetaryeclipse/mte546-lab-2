function [p] = circle_intersect(center_1,dist_1, ...
    center_2,dist_2,center_3,dist_3)
%CIRCLE_INTERSECT Computes the intersection point of 3 circles
% Computes the intersection of three (3) fully defined circles

% shifts the coordinate system so the center of circle 1 is at (0,0)
c2_p = center_2 - center_1;
c3_p = center_3 - center_1;

x2_p = c2_p(1);
y2_p = c2_p(2);
x3_p = c3_p(1);
y3_p = c3_p(2);

% forms the linear system coefficients
alpha_1 = -2*x2_p;
alpha_2 = -2*y2_p;
alpha_3 = x2_p^2 + y2_p^2 + dist_1^2 - dist_2^2;
beta_1 = -2*x3_p;
beta_2 = -2*y3_p;
beta_3 = x3_p^2 + y3_p^2 + dist_1^2 - dist_3^2;

% solves the linear system for the intersection point (in shifted
% coordinates prior to restoring global coordinates)
A = [alpha_1 alpha_2 ; beta_1 beta_2];
B = [-alpha_3 ; -beta_3];

p =  linsolve(A,B) + center_1;

end