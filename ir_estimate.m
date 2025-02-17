function [mu, sigma] = ir_estimate(props,top_left_volt,top_right_volt,left_bottom_volt,left_top_volt)
%IR_ESTIMATE Estimate the locaiton and covariance of the center of the
%block on the plate (using the same shared datum)

% estimate the raw distances and variance from the sensors
[top_left_rng, top_left_rng_var] = estimate_dist(top_left_volt, ...
    props.top_left_volt_var,props.top_left_dist_model_coeffs);
[top_right_rng, top_right_rng_var] = estimate_dist(top_right_volt, ...
    props.top_right_volt_var,props.top_right_dist_model_coeffs);
[left_bottom_rng, left_bottom_rng_var] = estimate_dist(...
    left_bottom_volt,props.left_bottom_volt_var,...
    props.left_bottom_dist_model_coeffs);
[left_top_rng, left_top_rng_var] = estimate_dist(left_top_volt,...
    props.left_top_volt_var,props.left_top_dist_model_coeffs);

% estimate the refit distance and variance
[top_left_datum_dist, top_left_datum_dist_var] = remap_dist(top_left_rng,top_left_rng_var,props.top_left_calibrate_linear);
[top_right_datum_dist, top_right_datum_dist_var] = remap_dist(top_right_rng,top_right_rng_var,props.top_right_calibrate_linear);
[left_bottom_datum_dist, left_bottom_datum_dist_var] = remap_dist(left_bottom_rng,left_bottom_rng_var,props.left_bottom_calibrate_linear);
[left_top_datum_dist,left_top_datum_dist_var] = remap_dist(left_top_rng,left_top_rng_var,props.left_top_calibrate_linear);

% fuse the left distance
% x_pos = (left_bottom_datum_dist*left_top_datum_dist_var + left_top_datum_dist*left_bottom_datum_dist_var)/(left_bottom_datum_dist_var+left_top_datum_dist_var);
% x_pos_var = (left_bottom_datum_dist_var*left_top_datum_dist_var)/(left_bottom_datum_dist_var+left_top_datum_dist_var);
% 
% y_pos = (top_left_datum_dist*top_right_datum_dist_var + top_right_datum_dist*top_left_datum_dist_var)/(top_left_datum_dist_var+top_right_datum_dist_var);
% y_pos_var = (top_left_datum_dist_var*top_right_datum_dist_var)/(top_left_datum_dist_var+top_right_datum_dist_var);

% conditionally choose which data to keep based on distance from the center
% of the plate
plate_datum_center = 10.8/2;
if abs(top_left_datum_dist - plate_datum_center) < abs(top_right_datum_dist - plate_datum_center)
    y_pos = top_left_datum_dist;
    y_pos_var = top_left_datum_dist_var;
else
    y_pos = top_right_datum_dist;
    y_pos_var = top_right_datum_dist_var;
end
if abs(left_bottom_datum_dist - plate_datum_center) < abs(left_top_datum_dist - plate_datum_center)
    x_pos = left_bottom_datum_dist;
    x_pos_var = left_bottom_datum_dist_var;
else
    x_pos = left_top_datum_dist;
    x_pos_var = left_top_datum_dist_var;
end

% assume independent sampling on the x and y positions
mu = [x_pos y_pos]';
sigma = [x_pos_var 0 ; 0 y_pos_var];

    function [dist,dist_var] = estimate_dist(volt,volt_var,coeffs)
        a = coeffs(1);
        b = coeffs(2);
        c = coeffs(3);
        d = coeffs(4);

        % converts to centimeters for convenience
        dist = 1/10 * (b-d*volt)/(c*volt-a);

        % computes the variance of this distance measurement bsaed on the
        % first order approximation of the distance function seen above
        eval_func_diff = d/(c*volt-a) + (b-d*volt)/(c*volt-a)^2;
        dist_var = 1/100*eval_func_diff^2*volt_var;
    end

    function [datum_dist,datum_dist_var] = remap_dist(dist,dist_var,calibrate_linear)
        datum_dist = calibrate_linear(1) + calibrate_linear(2)*dist;
        datum_dist_var = calibrate_linear(2)^2*dist_var;
    end
end