%% postlab_thermocouple_training.m
% author: Samuel Street
% date: 2025-02-12

% use datum point where leftmost edge of plate is (37.5-~.5-.35)=~36.65 cm 
% (measured distance, estimated spacing between peltier and plate, offset
% between peltier and block)

% use datum point where bottommost edge of plate is
% (22.4+3.3+.35+~.5)=~26.55 cm (measured distance, length of orange block,
% offset between peltier and block, estimated spacing betwene peltier and
% plate)

plate_datum_offset_x = 36.65;
plate_datum_offset_y = 26.55;
orange_block_half_width = 3.3/2;

% location of the thermocouples
plate_width = 10.8;
tc_spacing = 8;
tc_offset = (plate_width - tc_spacing)/2;

tc_topright = [(plate_width-tc_offset) (plate_width-tc_offset)]';
tc_topleft = [tc_offset (plate_width-tc_offset)]';
tc_bottomleft = [tc_offset tc_offset]';
tc_bottomright = [(plate_width-tc_offset) tc_offset]';
tc_locs = [tc_topright tc_bottomright tc_bottomleft tc_topleft];

% convenience functions for converting a range into datum coords
datum_x_from_rng = @(x) x - plate_datum_offset_x + orange_block_half_width;
datum_y_from_rng = @(y) plate_datum_offset_y - y - orange_block_half_width;

%% load the data

% NOTE: all coordinates below are provided with the origin at the
% bottom-left hand corner of the plate as viewed from the top

% the following are the redone trials

% ----

[bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
    bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = load_data("training_data/train_bl_2_ss.mat");
bottomleft_pos = [datum_x_from_rng(37.5) datum_y_from_rng(22.5)]';
bottomleft_dist_from_tcs = vecnorm(tc_locs-bottomleft_pos);

% ----

[bottommiddle_t,bottommiddle_ir_lsr,bottommiddle_ir_lsl,bottommiddle_ir_tsr,bottommiddle_ir_tsl, ...
    bottommiddle_tc_tr,bottommiddle_tc_br,bottommiddle_tc_bl,bottommiddle_tc_tl] = load_data("training_data/train_bm_2_ss.mat");
bottommiddle_pos = [datum_x_from_rng(40.3) datum_y_from_rng(22.3)]';
bottommiddle_dist_from_tcs = vecnorm(tc_locs-bottommiddle_pos);

% ----

% the following are not the redone trials

% ----

[bottomright_t,bottomright_ir_lsr,bottomright_ir_lsl,bottomright_ir_tsr,bottomright_ir_tsl, ...
    bottomright_tc_tr,bottomright_tc_br,bottomright_tc_bl,bottomright_tc_tl] = load_data("training_data/train_br_ss.mat");
bottomright_pos = [datum_x_from_rng(43.5) datum_y_from_rng(22.5)]';
bottomright_dist_from_tcs = vecnorm(tc_locs-bottomright_pos);

% ----

[centerleft_t,centerleft_ir_lsr,centerleft_ir_lsl,centerleft_ir_tsr,centerleft_ir_tsl, ...
    centerleft_tc_tr,centerleft_tc_br,centerleft_tc_bl,centerleft_tc_tl] = load_data("training_data/train_cl_ss.mat");
centerleft_pos = [datum_x_from_rng(37.5) datum_y_from_rng(19.5)]';
centerleft_dist_from_tcs = vecnorm(tc_locs-centerleft_pos);

% ----

[centercenter_t,centercenter_ir_lsr,centercenter_ir_lsl,centercenter_ir_tsr,centercenter_ir_tsl, ...
    centercenter_tc_tr,centercenter_tc_br,centercenter_tc_bl,centercenter_tc_tl] = load_data("training_data/train_cc_ss.mat");
centercenter_pos = [datum_x_from_rng(40.7) datum_y_from_rng(19.6)]';
centercenter_dist_from_tcs = vecnorm(tc_locs-centercenter_pos);

% ----

[centerright_t,centerright_ir_lsr,centerright_ir_lsl,centerright_ir_tsr,centerright_ir_tsl, ...
    centerright_tc_tr,centerright_tc_br,centerright_tc_bl,centerright_tc_tl] = load_data("training_data/train_cr_ss.mat");
centerright_pos = [datum_x_from_rng(43.7) datum_y_from_rng(19)]';
centerright_dist_from_tcs = vecnorm(tc_locs-centerright_pos);

% ----

[topleft_t,topleft_ir_lsr,topleft_ir_lsl,topleft_ir_tsr,topleft_ir_tsl, ...
    topleft_tc_tr,topleft_tc_br,topleft_tc_bl,topleft_tc_tl] = load_data("training_data/train_tl_ss.mat");
topleft_pos = [datum_x_from_rng(37.2) datum_y_from_rng(16.7)]';
topleft_dist_from_tcs = vecnorm(tc_locs-topleft_pos);

% ----

[topcenter_t,topcenter_ir_lsr,topcenter_ir_lsl,topcenter_ir_tsr,topcenter_ir_tsl, ...
    topcenter_tc_tr,topcenter_tc_br,topcenter_tc_bl,topcenter_tc_tl] = load_data("training_data/train_tc_ss.mat");
topcenter_pos = [datum_x_from_rng(40.3) datum_y_from_rng(16.3)]';
topcenter_dist_from_tcs = vecnorm(tc_locs-topcenter_pos);

% ----

[topright_t,topright_ir_lsr,topright_ir_lsl,topright_ir_tsr,topright_ir_tsl, ...
    topright_tc_tr,topright_tc_br,topright_tc_bl,topright_tc_tl] = load_data("training_data/train_tr_ss.mat");
topright_pos = [datum_x_from_rng(43.5) datum_y_from_rng(16.3)]';
topright_dist_from_tcs = vecnorm(tc_locs-topright_pos);

% ----

figure;
plot(topright_t,topright_tc_tr);
hold on
grid on
plot(topright_t,topright_tc_tl);
plot(topright_t,topright_tc_br);
plot(topright_t,topright_tc_bl);
xlabel('Time (s)')
ylabel('Temperature (°C)')
legend("Top-Right TC", "Top-Left TC", "Bottom-Left TC", "Bottom-Right TC")

%% generate the temp vs distance set for each thermocouple

last_percent = 10; % assume the last 10% of data is valid and steady-state
plot_dists = linspace(0,10,100); % max of 10 cm

figure
tiledlayout(2,2,"TileSpacing","compact");

thermocouple_tr_tdset = [
    bottomleft_dist_from_tcs(1) compute_stats_last_in_last_percent(bottomleft_tc_tr,last_percent) ;
    bottommiddle_dist_from_tcs(1) compute_stats_last_in_last_percent(bottommiddle_tc_tr,last_percent) ;
    bottomright_dist_from_tcs(1) compute_stats_last_in_last_percent(bottomright_tc_tr,last_percent) ;
    
    centerleft_dist_from_tcs(1) compute_stats_last_in_last_percent(centerleft_tc_tr,last_percent) ;
    centercenter_dist_from_tcs(1) compute_stats_last_in_last_percent(centercenter_tc_tr,last_percent) ;
    centerright_dist_from_tcs(1) compute_stats_last_in_last_percent(centerright_tc_tr,last_percent) ;

    topleft_dist_from_tcs(1) compute_stats_last_in_last_percent(topleft_tc_tr,last_percent) ;
    topcenter_dist_from_tcs(1) compute_stats_last_in_last_percent(topcenter_tc_tr,last_percent) ;
    topright_dist_from_tcs(1) compute_stats_last_in_last_percent(topright_tc_tr,last_percent) ;
];
thermocouple_tr_linear = robustfit(thermocouple_tr_tdset(:,1),thermocouple_tr_tdset(:,2));
thermocouple_tr_var = mean(thermocouple_tr_tdset(:,3));

nexttile
scatter(thermocouple_tr_tdset(:,1),thermocouple_tr_tdset(:,2))
grid on
hold on
plot(plot_dists,polyval(flip(thermocouple_tr_linear),plot_dists))
xlabel("Distance (cm)")
ylabel("Temperature (°C)")
title("Top-Right")

thermocouple_br_tdset = [
    bottomleft_dist_from_tcs(2) compute_stats_last_in_last_percent(bottomleft_tc_br,last_percent) ;
    bottommiddle_dist_from_tcs(2) compute_stats_last_in_last_percent(bottommiddle_tc_br,last_percent) ;
    bottomright_dist_from_tcs(2) compute_stats_last_in_last_percent(bottomright_tc_br,last_percent) ;
    
    centerleft_dist_from_tcs(2) compute_stats_last_in_last_percent(centerleft_tc_br,last_percent) ;
    centercenter_dist_from_tcs(2) compute_stats_last_in_last_percent(centercenter_tc_br,last_percent) ;
    centerright_dist_from_tcs(2) compute_stats_last_in_last_percent(centerright_tc_br,last_percent) ;

    topleft_dist_from_tcs(2) compute_stats_last_in_last_percent(topleft_tc_br,last_percent) ;
    topcenter_dist_from_tcs(2) compute_stats_last_in_last_percent(topcenter_tc_br,last_percent) ;
    topright_dist_from_tcs(2) compute_stats_last_in_last_percent(topright_tc_br,last_percent) ;
];
thermocouple_br_linear = robustfit(thermocouple_br_tdset(:,1),thermocouple_br_tdset(:,2));
thermocouple_br_var = mean(thermocouple_br_tdset(:,3));

nexttile
scatter(thermocouple_br_tdset(:,1),thermocouple_br_tdset(:,2))
grid on
hold on
plot(plot_dists,polyval(flip(thermocouple_br_linear),plot_dists))
xlabel("Distance (cm)")
ylabel("Temperature (°C)")
title("Bottom-Right")

thermocouple_bl_tdset = [
    bottomleft_dist_from_tcs(3) compute_stats_last_in_last_percent(bottomleft_tc_bl,last_percent) ;
    bottommiddle_dist_from_tcs(3) compute_stats_last_in_last_percent(bottommiddle_tc_bl,last_percent) ;
    bottomright_dist_from_tcs(3) compute_stats_last_in_last_percent(bottomright_tc_bl,last_percent) ;
    
    centerleft_dist_from_tcs(3) compute_stats_last_in_last_percent(centerleft_tc_bl,last_percent) ;
    centercenter_dist_from_tcs(3) compute_stats_last_in_last_percent(centercenter_tc_bl,last_percent) ;
    centerright_dist_from_tcs(3) compute_stats_last_in_last_percent(centerright_tc_bl,last_percent) ;

    topleft_dist_from_tcs(3) compute_stats_last_in_last_percent(topleft_tc_bl,last_percent) ;
    topcenter_dist_from_tcs(3) compute_stats_last_in_last_percent(topcenter_tc_bl,last_percent) ;
    topright_dist_from_tcs(3) compute_stats_last_in_last_percent(topright_tc_bl,last_percent) ;
];
thermocouple_bl_linear = robustfit(thermocouple_bl_tdset(:,1),thermocouple_bl_tdset(:,2));
thermocouple_bl_var = mean(thermocouple_bl_tdset(:,3));

nexttile
scatter(thermocouple_bl_tdset(:,1),thermocouple_bl_tdset(:,2))
grid on
hold on
plot(plot_dists,polyval(flip(thermocouple_bl_linear),plot_dists))
xlabel("Distance (cm)")
ylabel("Temperature (°C)")
title("Bottom-Left")

thermocouple_tl_tdset = [
    bottomleft_dist_from_tcs(4) compute_stats_last_in_last_percent(bottomleft_tc_tl,last_percent) ;
    bottommiddle_dist_from_tcs(4) compute_stats_last_in_last_percent(bottommiddle_tc_tl,last_percent) ;
    bottomright_dist_from_tcs(4) compute_stats_last_in_last_percent(bottomright_tc_tl,last_percent) ;
    
    centerleft_dist_from_tcs(4) compute_stats_last_in_last_percent(centerleft_tc_tl,last_percent) ;
    centercenter_dist_from_tcs(4) compute_stats_last_in_last_percent(centercenter_tc_tl,last_percent) ;
    centerright_dist_from_tcs(4) compute_stats_last_in_last_percent(centerright_tc_tl,last_percent) ;

    topleft_dist_from_tcs(4) compute_stats_last_in_last_percent(topleft_tc_tl,last_percent) ;
    topcenter_dist_from_tcs(4) compute_stats_last_in_last_percent(topcenter_tc_tl,last_percent) ;
    topright_dist_from_tcs(4) compute_stats_last_in_last_percent(topright_tc_tl,last_percent) ;
];
thermocouple_tl_linear = robustfit(thermocouple_tl_tdset(:,1),thermocouple_tl_tdset(:,2));
thermocouple_tl_var = mean(thermocouple_tl_tdset(:,3));

nexttile
scatter(thermocouple_tl_tdset(:,1),thermocouple_tl_tdset(:,2))
grid on
hold on
plot(plot_dists,polyval(flip(thermocouple_tl_linear),plot_dists))
xlabel("Distance (cm)")
ylabel("Temperature (°C)")
title("Top-Left")

%% invert the thermocouple fits
% gets distance of the thermocouple as a function of the temperature

inv_linear = @(p) [-p(1)/p(2) 1/p(2)];
inv_var = @(p,var) (1/p(2))^2*var;

thermocouple_tl_temp_to_dist_linear = inv_linear(thermocouple_tl_linear);
thermocouple_tl_temp_to_dist_var = inv_var(thermocouple_tl_linear,thermocouple_tl_var);

thermocouple_tr_temp_to_dist_linear = inv_linear(thermocouple_tr_linear);
thermocouple_tr_temp_to_dist_var = inv_var(thermocouple_tr_linear,thermocouple_tr_var);

thermocouple_bl_temp_to_dist_linear = inv_linear(thermocouple_bl_linear);
thermocouple_bl_temp_to_dist_var = inv_var(thermocouple_bl_linear,thermocouple_bl_var);

thermocouple_br_temp_to_dist_linear = inv_linear(thermocouple_br_linear);
thermocouple_br_temp_to_dist_var = inv_var(thermocouple_br_linear,thermocouple_br_var);

% assemble thermocouple estimate properties matrix to be used below
thermocouple_props = struct;
thermocouple_props.tl_pos = tc_topleft;
thermocouple_props.tr_pos = tc_topright;
thermocouple_props.br_pos = tc_bottomright;
thermocouple_props.bl_pos = tc_bottomleft;
thermocouple_props.tl_linear = thermocouple_tl_temp_to_dist_linear;
thermocouple_props.tr_linear = thermocouple_tr_temp_to_dist_linear;
thermocouple_props.br_linear = thermocouple_br_temp_to_dist_linear;
thermocouple_props.bl_linear = thermocouple_bl_temp_to_dist_linear;
thermocouple_props.tl_linear_var = thermocouple_tl_temp_to_dist_var;
thermocouple_props.tr_linear_var = thermocouple_tr_temp_to_dist_var;
thermocouple_props.br_linear_var = thermocouple_br_temp_to_dist_var;
thermocouple_props.bl_linear_var = thermocouple_bl_temp_to_dist_var;

%% estimate the position of the validation data

% [bottommiddle_t,bottommiddle_ir_lsr,bottommiddle_ir_lsl,bottommiddle_ir_tsr,bottommiddle_ir_tsl, ...
%     bottommiddle_tc_tr,bottommiddle_tc_br,bottommiddle_tc_bl,bottommiddle_tc_tl] = load_data("training_data/train_bm_2_ss.mat");
% bottommiddle_pos = [datum_x_from_rng(40.3) datum_y_from_rng(22.3)]';
% bottommiddle_dist_from_tcs = vecnorm(tc_locs-bottommiddle_pos);

x = linspace(0,10.8,40);
y = linspace(0,10.8,40);
[XX,YY] = meshgrid(x,y);
X = [XX(:) YY(:)];

actual_loc_z = 1;
actual_loc_size = 2;

% validation 1

[valid1_t,valid1_ir_lsr,valid1_ir_lsl,valid1_ir_tsr,valid1_ir_tsl, ...
    valid1_tc_tr,valid1_tc_br,valid1_tc_bl,valid1_tc_tl] = load_data("validation_data/test_random1_ss.mat");
valid1_pos = [datum_x_from_rng(42.8) datum_y_from_rng(18.2)]';

valid1_tc_tl_ss = compute_stats_last_in_last_percent(valid1_tc_tl,last_percent);
valid1_tc_tl_ss = valid1_tc_tl_ss(1);
valid1_tc_tr_ss = compute_stats_last_in_last_percent(valid1_tc_tr,last_percent);
valid1_tc_tr_ss = valid1_tc_tr_ss(1);
valid1_tc_br_ss = compute_stats_last_in_last_percent(valid1_tc_br,last_percent);
valid1_tc_br_ss = valid1_tc_br_ss(1);
valid1_tc_bl_ss = compute_stats_last_in_last_percent(valid1_tc_bl,last_percent);
valid1_tc_bl_ss = valid1_tc_bl_ss(1);

[est_valid1_mu,est_valid1_sigma] = thermocouple_estimate(thermocouple_props,valid1_tc_tl_ss,valid1_tc_tr_ss,valid1_tc_br_ss,valid1_tc_bl_ss);

z1 = mvnpdf(X,est_valid1_mu',est_valid1_sigma);
z1 = reshape(z1,length(x),length(y));

figure
surf(x,y,z1)
hold on
plot3([valid1_pos(1) valid1_pos(1)], [valid1_pos(2) valid1_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 1")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'Actual Location', 'Location', 'best')

% validation 2

[valid2_t,valid2_ir_lsr,valid2_ir_lsl,valid2_ir_tsr,valid2_ir_tsl, ...
    valid2_tc_tr,valid2_tc_br,valid2_tc_bl,valid2_tc_tl] = load_data("validation_data/test_random2_ss.mat");
valid2_pos = [datum_x_from_rng(41.4) datum_y_from_rng(21.3)]';

valid2_tc_tl_ss = compute_stats_last_in_last_percent(valid2_tc_tl,last_percent);
valid2_tc_tl_ss = valid2_tc_tl_ss(1);
valid2_tc_tr_ss = compute_stats_last_in_last_percent(valid2_tc_tr,last_percent);
valid2_tc_tr_ss = valid2_tc_tr_ss(1);
valid2_tc_br_ss = compute_stats_last_in_last_percent(valid2_tc_br,last_percent);
valid2_tc_br_ss = valid2_tc_br_ss(1);
valid2_tc_bl_ss = compute_stats_last_in_last_percent(valid2_tc_bl,last_percent);
valid2_tc_bl_ss = valid2_tc_bl_ss(1);

[est_valid2_mu,est_valid2_sigma] = thermocouple_estimate(thermocouple_props,valid2_tc_tl_ss,valid2_tc_tr_ss,valid2_tc_br_ss,valid2_tc_bl_ss);

z2 = mvnpdf(X,est_valid2_mu',est_valid2_sigma);
z2 = reshape(z2,length(x),length(y));

figure
surf(x,y,z2)
hold on
plot3([valid2_pos(1) valid2_pos(1)], [valid2_pos(2) valid2_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 2")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'Actual Location', 'Location', 'best')

% validation 3

[valid3_t,valid3_ir_lsr,valid3_ir_lsl,valid3_ir_tsr,valid3_ir_tsl, ...
    valid3_tc_tr,valid3_tc_br,valid3_tc_bl,valid3_tc_tl] = load_data("validation_data/test_random3_ss.mat");
valid3_pos = [datum_x_from_rng(36.6) datum_y_from_rng(19.7)]';

valid3_tc_tl_ss = compute_stats_last_in_last_percent(valid3_tc_tl,last_percent);
valid3_tc_tl_ss = valid3_tc_tl_ss(1);
valid3_tc_tr_ss = compute_stats_last_in_last_percent(valid3_tc_tr,last_percent);
valid3_tc_tr_ss = valid3_tc_tr_ss(1);
valid3_tc_br_ss = compute_stats_last_in_last_percent(valid3_tc_br,last_percent);
valid3_tc_br_ss = valid3_tc_br_ss(1);
valid3_tc_bl_ss = compute_stats_last_in_last_percent(valid3_tc_bl,last_percent);
valid3_tc_bl_ss = valid3_tc_bl_ss(1);

[est_valid3_mu,est_valid3_sigma] = thermocouple_estimate(thermocouple_props,valid3_tc_tl_ss,valid3_tc_tr_ss,valid3_tc_br_ss,valid3_tc_bl_ss);

z3 = mvnpdf(X,est_valid3_mu',est_valid3_sigma);
z3 = reshape(z3,length(x),length(y));

figure
surf(x,y,z3)
hold on
plot3([valid3_pos(1) valid3_pos(1)], [valid3_pos(2) valid3_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 3")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'Actual Location', 'Location', 'best')


%% helper functions
function [last_stats] = compute_stats_last_in_last_percent(data,percent)
% takes the last percentage of the data
n = length(data);
idxs = round(n*(1-percent/100)):n;

last_data = data(idxs);
[last_var, last_mu] = var(last_data);

last_stats = [last_mu last_var];
end
