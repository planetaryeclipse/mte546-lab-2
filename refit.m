clc
close all
clear

%% first refit
% bottom left case

[bottomleft_t,bottomleft_ir_lsr,bottomleft_ir_lsl,bottomleft_ir_tsr,bottomleft_ir_tsl, ...
    bottomleft_tc_tr,bottomleft_tc_br,bottomleft_tc_bl,bottomleft_tc_tl] = Vol_load_data("training_data/train_bl_2_ss.mat");
bottomleft_block_x = 37.7;
bottomleft_block_y = 22.4;
%bottomleft_pos = [datum_x_from_rng(bottomleft_block_x) datum_y_from_rng(bottomleft_block_y)]';

bottomleft_mean = mean(bottomleft_ir_lsl);
bottomleft_var = var(bottomleft_ir_lsl);

% bottom middle case

[bottommiddle_t,bottommiddle_ir_lsr,bottommiddle_ir_lsl,bottommiddle_ir_tsr,bottommiddle_ir_tsl, ...
    bottommiddle_tc_tr,bottommiddle_tc_br,bottommiddle_tc_bl,bottommiddle_tc_tl] = Vol_load_data("training_data/train_bm_2_ss.mat");
bottommiddle_block_x = 40;
bottommiddle_block_y = 22.4;
%bottommiddle_pos = [datum_x_from_rng(bottommiddle_block_x) datum_y_from_rng(bottommiddle_block_y)]';

bottommiddle_mean = mean(bottommiddle_ir_lsl);
bottommiddle_var = var(bottommiddle_ir_lsl);

%bottom right case

[bottomright_t,bottomright_ir_lsr,bottomright_ir_lsl,bottomright_ir_tsr,bottomright_ir_tsl, ...
    bottomright_tc_tr,bottomright_tc_br,bottomright_tc_bl,bottomright_tc_tl] = Vol_load_data("training_data/train_br_ss.mat");
bottomright_block_x = 43.5;
bottomright_block_y = 22;
%bottomright_pos = [datum_x_from_rng(bottomright_block_x) datum_y_from_rng(bottomright_block_y)]';

bottomright_mean = mean(bottomright_ir_lsl);
bottomright_var = var(bottomright_ir_lsl);


x = [377; 400; 435];
y = [bottomleft_mean; bottommiddle_mean; bottomright_mean];

rational_fit = fittype('(a)/(b*x + c)', 'independent', 'x');

[fitted_model, gof1,output] = fit(x, y, rational_fit,'StartPoint', [1, 1,1]);

%% Plot raw data and fitted model

% Create a figure and hold on to add multiple plots
figure; hold on;

% Plot raw data points
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);

% Generate a range of x values for the fitted curve
x_fit = linspace(min(x), max(x), 100);
y_fit = fitted_model(x_fit); % Evaluate the fitted model at these x values

% Plot the fitted model curve
plot(x_fit, y_fit, 'b-', 'LineWidth', 2);

% Add labels, title, and legend
xlabel('Block X Position');
ylabel('Mean IR LSL Value');
title('Raw Data and Fitted Rational Model');
legend('Raw Data', 'Fitted Model', 'Location', 'Best');

grid on;
hold off;

