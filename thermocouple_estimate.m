function [mu, sigma] = thermocouple_estimate(props,tl_temp,tr_temp,br_temp,bl_temp)
%THERMOCOUPLE_ESTIMATE Estimate the location and covariance of the Peltier
%heater on the plate

tl_dist = props.tl_linear(1)+props.tl_linear(2)*tl_temp;
tr_dist = props.tr_linear(1)+props.tr_linear(2)*tr_temp;
br_dist = props.br_linear(1)+props.br_linear(2)*br_temp;
bl_dist = props.bl_linear(1)+props.bl_linear(2)*bl_temp;

% combination of tl,tr,br
[mu_1,sigma_1] = circle_gauss_estimate(...
    props.tl_pos,tl_dist,props.tl_linear_var,...
    props.tr_pos,tr_dist,props.tr_linear_var,...
    props.br_pos,br_dist,props.br_linear_var);

% combination of tr,br,bl
[mu_2,sigma_2] = circle_gauss_estimate(...
    props.tr_pos,tr_dist,props.tr_linear_var,...
    props.br_pos,br_dist,props.br_linear_var,...
    props.bl_pos,bl_dist,props.bl_linear_var);

% combination of br,bl,tl
[mu_3,sigma_3] = circle_gauss_estimate(...
    props.br_pos,br_dist,props.br_linear_var,...
    props.bl_pos,bl_dist,props.bl_linear_var,...
    props.tl_pos,tl_dist,props.tl_linear_var);

% combination of bl,tl,tr
[mu_4,sigma_4] = circle_gauss_estimate(...
    props.bl_pos,bl_dist,props.bl_linear_var,...
    props.tl_pos,tl_dist,props.tl_linear_var,...
    props.tr_pos,tr_dist,props.tr_linear_var);

% fuse these sensor estimates so all thermocouples are considered
[mu,sigma] = multiply_gauss(mu_1,sigma_1,mu_2,sigma_2);
[mu,sigma] = multiply_gauss(mu,sigma,mu_3,sigma_3);
[mu,sigma] = multiply_gauss(mu,sigma,mu_4,sigma_4);

end

