%% postlab_thermocouple_training.m
% author: Samuel Street
% date: 2025-02-12
% completed: 2025-02-13

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

%% load the ir sensor models
% ideally should wrap this in a function at some point

global long_coeffs;
global med_coeffs;
global short_coeffs;

load("sensor_models/long_coeffs.mat","coeffs")
long_coeffs = coeffs;
load("sensor_models/med_coeffs.mat","coeffs")
med_coeffs = coeffs;
load("sensor_models/short_coeffs.mat","coeffs")
short_coeffs = coeffs;

global long_volt_noise_var;
global med_volt_noise_var;
global short_volt_noise_var;

load("sensor_models/long_noise.mat","noise_var")
long_volt_noise_var = noise_var;
load("sensor_models/medium_noise.mat","noise_var")
med_volt_noise_var = noise_var;
load("sensor_models/short_noise.mat","noise_var")
short_volt_noise_var = noise_var;

%% load the data

% NOTE: all coordinates below are provided with the origin at the
% bottom-left hand corner of the plate as viewed from the top

% the following are the redone trials

% ----

% [bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
%     bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = load_data("training_data/train_bl_2_ss.mat");
% bottomleft_pos = [datum_x_from_rng(37.5) datum_y_from_rng(22.5)]';
% bottomleft_dist_from_tcs = vecnorm(tc_locs-bottomleft_pos);

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

% [topleft_t,topleft_ir_lsr,topleft_ir_lsl,topleft_ir_tsr,topleft_ir_tsl, ...
%     topleft_tc_tr,topleft_tc_br,topleft_tc_bl,topleft_tc_tl] = load_data("training_data/train_tl_ss.mat");
% topleft_pos = [datum_x_from_rng(37.2) datum_y_from_rng(16.7)]';
% topleft_dist_from_tcs = vecnorm(tc_locs-topleft_pos);

% ----

[topcenter_t,topcenter_ir_lsr,topcenter_ir_lsl,topcenter_ir_tsr,topcenter_ir_tsl, ...
    topcenter_tc_tr,topcenter_tc_br,topcenter_tc_bl,topcenter_tc_tl] = load_data("training_data/train_tc_ss.mat");
topcenter_pos = [datum_x_from_rng(40.3) datum_y_from_rng(16.3)]';
topcenter_dist_from_tcs = vecnorm(tc_locs-topcenter_pos);

% ----

% [topright_t,topright_ir_lsr,topright_ir_lsl,topright_ir_tsr,topright_ir_tsl, ...
%     topright_tc_tr,topright_tc_br,topright_tc_bl,topright_tc_tl] = load_data("training_data/train_tr_ss.mat");
% topright_pos = [datum_x_from_rng(43.5) datum_y_from_rng(16.3)]';
% topright_dist_from_tcs = vecnorm(tc_locs-topright_pos);

% ----

% figure;
% plot(topright_ir_tsr);
% hold on
% grid on
% plot(centerright_ir_tsr);
% plot(bottomright_ir_tsr);

% figure;
% plot(topright_ir_tsr/10)
% hold on
% grid on
% plot(datum_y_from_rng(topright_ir_tsr/10))
% yline(topright_pos(2))

% figure;
% plot(topright_t,topright_tc_tr);
% hold on
% grid on
% plot(topright_t,topright_tc_tl);
% plot(topright_t,topright_tc_br);
% plot(topright_t,topright_tc_bl);
% xlabel('Time (s)')
% ylabel('Temperature (°C)')
% legend("Top-Right TC", "Top-Left TC", "Bottom-Left TC", "Bottom-Right TC")

%% calibration to match IR with expected plate positions
ir_top_right_calibration_means = [
    % mean(topright_ir_tsr) 
    mean(centerright_ir_tsr) 
    % mean(bottomright_ir_tsr)
];
ir_top_right_expected = [
    % topright_pos(2)
    centerright_pos(2)
    % bottomright_pos(2)
];

ir_top_left_calibration_means = [
    % mean(topleft_ir_tsl)
    mean(centerleft_ir_tsl)
    % mean(bottomleft_ir_tsl)
    ];
ir_top_left_expected = [
    % topleft_pos(2)
    centerleft_pos(2)
    % bottomleft_pos(2)
    ];

ir_left_bottom_calibration_means = [
    % mean(bottomleft_ir_lsl)
    mean(bottommiddle_ir_lsl)
    % mean(bottomright_ir_lsl)
    ];
ir_left_bottom_expected = [
    % bottomleft_pos(1)
    bottommiddle_pos(1)
    % bottomright_pos(1)
    ];

ir_left_top_calibration_means = [
    % mean(topleft_ir_lsr)
    mean(topcenter_ir_lsr)
    % mean(topright_ir_lsr)
    ];
ir_left_top_expected = [
    % topleft_pos(1)
    topcenter_pos(1)
    % topright_pos(1)
    ];

% computes the calibration fits to map the ranges to the datum
% ir_top_right_calibrate_fit = polyfit(ir_top_right_calibration_means,ir_top_right_expected,1);
% ir_top_left_calibrate_fit = polyfit(ir_top_left_calibration_means,ir_top_left_expected,1);
% ir_left_bottom_calibrate_fit = polyfit(ir_left_bottom_calibration_means,ir_left_bottom_expected,1);
% ir_left_top_calibrate_fit = polyfit(ir_left_top_calibration_means,ir_left_top_expected,1);
ir_top_right_calibrate_fit = [-1 (centerright_pos(2)+mean(centerright_ir_tsr))];
ir_top_left_calibrate_fit = [-1 (centerleft_pos(2)+mean(centerleft_ir_tsl))];
ir_left_bottom_calibrate_fit = [1 (bottommiddle_pos(1)-mean(bottommiddle_ir_lsl))];
ir_left_top_calibrate_fit = [1 (topcenter_pos(1)-mean(topcenter_ir_lsr))];

% plot these calibration curves
tiledlayout(2,2)

nexttile
scatter(ir_top_right_calibration_means,ir_top_right_expected)
hold on
grid on
x = linspace(0,20,100); %ir_top_right_calibration_means;
plot(x, polyval(ir_top_right_calibrate_fit,x))
xlabel('Sample Mean of Ranges (cm)')
ylabel('Datum Location (cm)')
title('Top-Right IR Sensor')

nexttile
scatter(ir_top_left_calibration_means,ir_top_left_expected)
hold on
grid on
% x = ir_top_left_calibration_means;
plot(x, polyval(ir_top_left_calibrate_fit,x))
xlabel('Sample Mean of Ranges (cm)')
ylabel('Datum Location (cm)')
title('Top-Left IR Sensor')

nexttile
scatter(ir_left_bottom_calibration_means,ir_left_bottom_expected)
hold on
grid on
x = linspace(0,40,100);
% x = ir_left_bottom_calibration_means;
plot(x, polyval(ir_left_bottom_calibrate_fit,x))
xlabel('Sample Mean of Ranges (cm)')
ylabel('Datum Location (cm)')
title('Left-Bottom IR Sensor')

nexttile
scatter(ir_left_top_calibration_means,ir_left_top_expected)
hold on
grid on
% x = ir_left_top_calibration_means;
plot(x, polyval(ir_left_top_calibrate_fit,x))
xlabel('Sample Mean of Ranges (cm)')
ylabel('Datum Location (cm)')
title('Left-Top IR Sensor')

% flips to put in the same form as the thermocouple fits (and for report)
ir_top_right_calibrate_linear = flip(ir_top_right_calibrate_fit);
ir_top_left_calibrate_linear = flip(ir_top_left_calibrate_fit);
ir_left_bottom_calibrate_linear = flip(ir_left_bottom_calibrate_fit);
ir_left_top_calibrate_linear = flip(ir_left_top_calibrate_fit);

%% setup the ir sensor estimate properties

ir_props = struct;
ir_props.top_right_dist_model_coeffs = med_coeffs;
ir_props.top_left_dist_model_coeffs = short_coeffs;
ir_props.left_bottom_dist_model_coeffs = long_coeffs;
ir_props.left_top_dist_model_coeffs = long_coeffs;

ir_props.top_right_volt_var = med_volt_noise_var;
ir_props.top_left_volt_var = short_volt_noise_var;
ir_props.left_bottom_volt_var = long_volt_noise_var;
ir_props.left_top_volt_var = long_volt_noise_var;

ir_props.top_right_calibrate_linear = ir_top_right_calibrate_linear;
ir_props.top_left_calibrate_linear = ir_top_left_calibrate_linear;
ir_props.left_bottom_calibrate_linear = ir_left_bottom_calibrate_linear;
ir_props.left_top_calibrate_linear = ir_left_top_calibrate_linear;

%% load the validation data

x = linspace(0,10.8,40);
y = linspace(0,10.8,40);
[XX,YY] = meshgrid(x,y);
X = [XX(:) YY(:)];

actual_loc_z = 1;
actual_loc_size = 2;

%%

% validation 1

[valid1_t,valid1_ir_lsr,valid1_ir_lsl,valid1_ir_tsr,valid1_ir_tsl, ...
    valid1_tc_tr,valid1_tc_br,valid1_tc_bl,valid1_tc_tl, ...
    valid1_ir_left_top_volt,valid1_ir_left_bottom_volt, ...
    valid1_ir_top_left_volt,valid1_ir_top_right_volt] = load_data("training_data/train_tr_ss.mat");
valid1_pos = [datum_x_from_rng(43.5) datum_y_from_rng(16.3)]';

[ir_est_valid1_mu,ir_est_valid1_sigma] = ir_estimate(ir_props, ...
    mean(valid1_ir_top_left_volt),mean(valid1_ir_top_right_volt),mean(valid1_ir_left_bottom_volt),mean(valid1_ir_left_top_volt));

z1 = mvnpdf(X,ir_est_valid1_mu',ir_est_valid1_sigma);
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

%%

% validation 2

[valid2_t,valid2_ir_lsr,valid2_ir_lsl,valid2_ir_tsr,valid2_ir_tsl, ...
    valid2_tc_tr,valid2_tc_br,valid2_tc_bl,valid2_tc_tl, ...
    valid2_ir_left_top_volt,valid2_ir_left_bottom_volt, ...
    valid2_ir_top_left_volt,valid2_ir_top_right_volt] = load_data("training_data/train_tl_ss.mat");
valid2_pos = [datum_x_from_rng(37.2) datum_y_from_rng(16.7)]';

[ir_est_valid2_mu,ir_est_valid2_sigma] = ir_estimate(ir_props, ...
    mean(valid2_ir_top_left_volt),mean(valid2_ir_top_right_volt),mean(valid2_ir_left_bottom_volt),mean(valid2_ir_left_top_volt));

z2 = mvnpdf(X,ir_est_valid2_mu',ir_est_valid2_sigma);
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

%%

% validation 3

[valid3_t,valid3_ir_lsr,valid3_ir_lsl,valid3_ir_tsr,valid3_ir_tsl, ...
    valid3_tc_tr,valid3_tc_br,valid3_tc_bl,valid3_tc_tl, ...
    valid3_ir_left_top_volt,valid3_ir_left_bottom_volt, ...
    valid3_ir_top_left_volt,valid3_ir_top_right_volt] = load_data("training_data/train_bl_2_ss.mat");
valid3_pos = [datum_x_from_rng(37.5) datum_y_from_rng(22.5)]';

[ir_est_valid3_mu,ir_est_valid3_sigma] = ir_estimate(ir_props, ...
    mean(valid3_ir_top_left_volt),mean(valid3_ir_top_right_volt),mean(valid3_ir_left_bottom_volt),mean(valid3_ir_left_top_volt));

z3 = mvnpdf(X,ir_est_valid3_mu',ir_est_valid3_sigma);
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

%% save the estimated validation distributions separately

save("ir_est_data","ir_est_valid1_mu","ir_est_valid1_sigma",...
    "ir_est_valid2_mu","ir_est_valid2_sigma","ir_est_valid3_mu","ir_est_valid3_sigma",...
    "valid1_pos","valid2_pos","valid3_pos")
