function [mu, sigma] = circle_gauss_estimate(center_1,dist_1, ...
    dist_var_1,center_2,dist_2,dist_var_2,center_3,dist_3,dist_var_3)
%CIRCLE_GAUSS_ESTIMATE Computes the position estimate and covariance
% Computes the estimate of block position based on distance from three (3)
% fully defined circles and additionally computes the positional covariance
% along the x and y axes from directional variances

mu = circle_intersect(center_1,dist_1,center_2,dist_2,center_3,dist_3);

% computes the xy covariance from each circle
sigma_1 = compute_xy_covar(mu - center_1, dist_var_1);
sigma_2 = compute_xy_covar(mu - center_2, dist_var_2);
sigma_3 = compute_xy_covar(mu - center_3, dist_var_3);

% assumes additive covariance based on all circles contributing error
sigma = sigma_1 + sigma_2 + sigma_3; 

    function sigma = compute_xy_covar(dir_vec, dir_var)
        %COMPUTE_XY_COVAR Computes the xy covariance from dir variance
        th = atan2(dir_vec(2),dir_vec(1));
        sigma = dir_var*[cos(th)^2 sin(th)*cos(th) ; ...
            sin(th)*cos(th) sin(th)^2];
    end
end