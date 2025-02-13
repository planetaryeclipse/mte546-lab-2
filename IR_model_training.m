clc
clear
close all

plate_datum_offset_x = 36.65;
plate_datum_offset_y = 26.55;
block_half_width = 3.3/2;

means_vars = dictionary();  % Create an empty dictionary

% convenience functions for converting a range into datum coords
datum_x_from_rng = @(x) x - plate_datum_offset_x + block_half_width;
datum_y_from_rng = @(y) plate_datum_offset_y - y - block_half_width;


% bottom left case

[bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
    bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = V2_load_data("training_data/train_bl_2_ss.mat");
[v_bottomleft_t,v_bottomleft_ir_lsr,v_bottomleft_ir_lsl,v_bottomleft_ir_tsr,v_bottomleft_ir_tsl, ...
    v_bottomleft_tc_tr,v_bottomleft_tc_br,v_bottomleft_tc_bl,v_bottomleft_tc_tl] = Vol_load_data("training_data/train_bl_2_ss.mat");

bottomleft_block_x = 37.7;
bottomleft_block_y = 22.4;
bottomleft_pos = [datum_x_from_rng(bottomleft_block_x) datum_y_from_rng(bottomleft_block_y)]';

means_vars("bottomleft_mean_lsl_x") = mean(bottomleft_ir_lsl) + block_half_width - plate_datum_offset_x;
means_vars("bottomleft_mean_tsl_y") = plate_datum_offset_y - (mean(bottomleft_ir_tsl) + block_half_width);
means_vars("bottomleft_var_lsl_x") = var_carry(v_bottomleft_ir_lsl, "LR");
means_vars("bottomleft_var_tsl_y") = var_carry(v_bottomleft_ir_tsl, "SR");

% bottom middle case

[bottommiddle_t,bottommiddle_ir_lsr,bottommiddle_ir_lsl,bottommiddle_ir_tsr,bottommiddle_ir_tsl, ...
    bottommiddle_tc_tr,bottommiddle_tc_br,bottommiddle_tc_bl,bottommiddle_tc_tl] = V2_load_data("training_data/train_bm_2_ss.mat");
[v_bottommiddle_t,v_bottommiddle_ir_lsr,v_bottommiddle_ir_lsl,v_bottommiddle_ir_tsr,v_bottommiddle_ir_tsl, ...
    v_bottommiddle_tc_tr,v_bottommiddle_tc_br,v_bottommiddle_tc_bl,v_bottommiddle_tc_tl] = Vol_load_data("training_data/train_bm_2_ss.mat");
bottommiddle_block_x = 40;
bottommiddle_block_y = 22.4;
bottommiddle_pos = [datum_x_from_rng(bottommiddle_block_x) datum_y_from_rng(bottommiddle_block_y)]';

means_vars("bottommiddle_mean_lsl_x") = mean(bottommiddle_ir_lsl) + block_half_width - plate_datum_offset_x;
means_vars("bottommiddle_mean_tsr_y") = plate_datum_offset_y - (mean(bottommiddle_ir_tsr) + block_half_width);
means_vars("bottommiddle_var_lsl_x") = var_carry(v_bottommiddle_ir_lsl, "LR");
means_vars("bottommiddle_var_tsr_y") = var_carry(v_bottommiddle_ir_tsr, "MR");

% bottom right case

[bottomright_t,bottomright_ir_lsr,bottomright_ir_lsl,bottomright_ir_tsr,bottomright_ir_tsl, ...
    bottomright_tc_tr,bottomright_tc_br,bottomright_tc_bl,bottomright_tc_tl] = V2_load_data("training_data/train_br_ss.mat");
[v_bottomright_t,v_bottomright_ir_lsr,v_bottomright_ir_lsl,v_bottomright_ir_tsr,v_bottomright_ir_tsl, ...
    v_bottomright_tc_tr,v_bottomright_tc_br,v_bottomright_tc_bl,v_bottomright_tc_tl] = Vol_load_data("training_data/train_br_ss.mat");
bottomright_block_x = 43.5;
bottomright_block_y = 22;
bottomright_pos = [datum_x_from_rng(bottomright_block_x) datum_y_from_rng(bottomright_block_y)]';

bottomright_mean = mean(bottomright_ir_lsl);
bottomright_var = var_carry(v_bottomright_ir_lsl, "LR");

% center left case

[centerleft_t,centerleft_ir_lsr,centerleft_ir_lsl,centerleft_ir_tsr,centerleft_ir_tsl, ...
    centerleft_tc_tr,centerleft_tc_br,centerleft_tc_bl,centerleft_tc_tl] = V2_load_data("training_data/train_cl_ss.mat");
[v_centerleft_t,v_centerleft_ir_lsr,v_centerleft_ir_lsl,v_centerleft_ir_tsr,v_centerleft_ir_tsl, ...
    v_centerleft_tc_tr,v_centerleft_tc_br,v_centerleft_tc_bl,v_centerleft_tc_tl] = Vol_load_data("training_data/train_cl_ss.mat");
centerleft_block_x = 43.5;
centerleft_block_y = 22;
centerleft_pos = [datum_x_from_rng(centerleft_block_x) datum_y_from_rng(centerleft_block_y)]';

centerleft_mean = mean(centerleft_ir_lsl);
centerleft_var = var_carry(v_centerleft_ir_lsl, "LR");

% center center case

[centercenter_t,centercenter_ir_lsr,centercenter_ir_lsl,centercenter_ir_tsr,centercenter_ir_tsl, ...
    centercenter_tc_tr,centercenter_tc_br,centercenter_tc_bl,centercenter_tc_tl] = V2_load_data("training_data/train_cc_ss.mat");
[v_centercenter_t,v_centercenter_ir_lsr,v_centercenter_ir_lsl,v_centercenter_ir_tsr,v_centercenter_ir_tsl, ...
    v_centercenter_tc_tr,v_centercenter_tc_br,v_centercenter_tc_bl,v_centercenter_tc_tl] = Vol_load_data("training_data/train_cc_ss.mat");
centercenter_block_x = 43.5;
centercenter_block_y = 22;
centercenter_pos = [datum_x_from_rng(centercenter_block_x) datum_y_from_rng(centercenter_block_y)]';

centercenter_mean = mean(centercenter_ir_lsl);
centercenter_var = var_carry(v_centercenter_ir_lsl, "LR");

% center right case

[centerright_t,centerright_ir_lsr,centerright_ir_lsl,centerright_ir_tsr,centerright_ir_tsl, ...
    centerright_tc_tr,centerright_tc_br,centerright_tc_bl,centerright_tc_tl] = V2_load_data("training_data/train_cr_ss.mat");
centerright_block_x = 43.5;
centerright_block_y = 22;
centerright_pos = [datum_x_from_rng(centerright_block_x) datum_y_from_rng(centerright_block_y)]';

centerright_mean = mean(centerright_ir_lsl);
centerright_var = var(centerright_ir_lsl);

% top left case

[topleft_t,topleft_ir_lsr,topleft_ir_lsl,topleft_ir_tsr,topleft_ir_tsl, ...
    topleft_tc_tr,topleft_tc_br,topleft_tc_bl,topleft_tc_tl] = V2_load_data("training_data/train_tl_ss.mat");
topleft_block_x = 43.5;
topleft_block_y = 22;
topleft_pos = [datum_x_from_rng(topleft_block_x) datum_y_from_rng(topleft_block_y)]';

topleft_mean = mean(topleft_ir_lsl);
topleft_var = var(topleft_ir_lsl);

% top right case

[topright_t,topright_ir_lsr,topright_ir_lsl,topright_ir_tsr,topright_ir_tsl, ...
    topright_tc_tr,topright_tc_br,topright_tc_bl,topright_tc_tl] = V2_load_data("training_data/train_tc_ss.mat");
topright_block_x = 43.5;
topright_block_y = 22;
topright_pos = [datum_x_from_rng(topright_block_x) datum_y_from_rng(topright_block_y)]';

topright_mean = mean(topright_ir_lsl);
topright_var = var(topright_ir_lsl);



%% Plotting the Gaussian likelihood probability function in 3D

% Set visible range for x and y axes (adjust these values as needed)
visible_x_min = 0;    % Example: minimum x value
visible_x_max = 100;  % Example: maximum x value
visible_y_min = 0;    % Example: minimum y value
visible_y_max = 100;   % Example: maximum y value

% Create grid for the plot
numPointsX = 200;
numPointsY = 100;
x_values = linspace(visible_x_min, visible_x_max, numPointsX);
y_values = linspace(visible_y_min, visible_y_max, numPointsY);
[X, Y] = meshgrid(x_values, y_values);

% Compute Gaussian likelihood (pdf) along x (same for all y)
% Gaussian PDF: f(x) = (1/sqrt(2*pi*var))*exp(-((x-mean).^2)/(2*var))
Z = (1/sqrt(2*pi*bottomleft_var)) * exp( -((X - bottomleft_mean).^2) / (2*bottomleft_var) );

% Create 3D surface plot
figure;
surf(X, Y, Z)
xlabel('X (space)')
ylabel('Y (space)')
zlabel('Likelihood')
title('Gaussian Likelihood Function based on Bottom Left Data')
shading interp    % Smooths the color transitions
colormap jet      % Changes the color map
colorbar          % Displays a color scale

% Optionally, set the axis limits (only x and y are user–controlled here)
axis([visible_x_min visible_x_max visible_y_min visible_y_max min(Z(:)) max(Z(:))])