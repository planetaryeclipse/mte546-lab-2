%% fused_ir_and_thermocouple.m
% author: Samuel Street
% date: 2025-02-13

clear
clc
close all

load("ir_est_data.mat")
load("tc_est_data.mat")

%% fuse the ir and thermocopule data

[est_valid1_mu, est_valid1_sigma] = multiply_gauss(...
    ir_est_valid1_mu,ir_est_valid1_sigma,...
    tc_est_valid1_mu,tc_est_valid1_sigma);

[est_valid2_mu, est_valid2_sigma] = multiply_gauss(...
    ir_est_valid2_mu,ir_est_valid2_sigma,...
    tc_est_valid2_mu,tc_est_valid2_sigma);

[est_valid3_mu, est_valid3_sigma] = multiply_gauss(...
    ir_est_valid3_mu,ir_est_valid3_sigma,...
    tc_est_valid3_mu,tc_est_valid3_sigma);

%% plot the distributions for each of the validation points

x = linspace(0,10.8,40);
y = linspace(0,10.8,40);
[XX,YY] = meshgrid(x,y);
X = [XX(:) YY(:)];

actual_loc_z = 1;
actual_loc_size = 2;

%% 

z1 = mvnpdf(X,est_valid1_mu',est_valid1_sigma);
z1 = reshape(z1,length(x),length(y));

z1_ir = mvnpdf(X,ir_est_valid1_mu',ir_est_valid1_sigma);
z1_ir = reshape(z1_ir,length(x),length(y));

z1_tc = mvnpdf(X,tc_est_valid1_mu',tc_est_valid1_sigma);
z1_tc = reshape(z1_tc,length(x),length(y));

figure
surf(x,y,z1)
hold on
surf(x,y,z1_ir,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[2*0.378,0.378,0.378])
surf(x,y,z1_tc,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[0.378,2*0.378,0.378])
plot3([valid1_pos(1) valid1_pos(1)], [valid1_pos(2) valid1_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 1")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'IR Likelihood', 'TC Likelihood', 'Actual Location', 'Location', 'best')

%%

z2 = mvnpdf(X,est_valid2_mu',est_valid2_sigma);
z2 = reshape(z2,length(x),length(y));

z2_ir = mvnpdf(X,ir_est_valid2_mu',ir_est_valid2_sigma);
z2_ir = reshape(z2_ir,length(x),length(y));

z2_tc = mvnpdf(X,tc_est_valid2_mu',tc_est_valid2_sigma);
z2_tc = reshape(z2_tc,length(x),length(y));

figure
surf(x,y,z2)
hold on
surf(x,y,z2_ir,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[2*0.378,0.378,0.378])
surf(x,y,z2_tc,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[0.378,2*0.378,0.378])
plot3([valid2_pos(1) valid2_pos(1)], [valid2_pos(2) valid2_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 2")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'IR Likelihood', 'TC Likelihood', 'Actual Location', 'Location', 'best')

%%

z3 = mvnpdf(X,est_valid3_mu',est_valid3_sigma);
z3 = reshape(z3,length(x),length(y));

z3_ir = mvnpdf(X,ir_est_valid3_mu',ir_est_valid3_sigma);
z3_ir = reshape(z3_ir,length(x),length(y));

z3_tc = mvnpdf(X,tc_est_valid3_mu',tc_est_valid3_sigma);
z3_tc = reshape(z3_tc,length(x),length(y));

figure
surf(x,y,z3)
hold on
surf(x,y,z3_ir,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[2*0.378,0.378,0.378])
surf(x,y,z3_tc,'EdgeColor','none','FaceAlpha',0.5,'FaceColor',[0.378,2*0.378,0.378])
plot3([valid3_pos(1) valid3_pos(1)], [valid3_pos(2) valid3_pos(2)], [0, 1], 'r', 'LineWidth',2)
% scatter3(valid1_pos(1),valid1_pos(2),actual_loc_z,"LineWidth",10);
title("Validation 3")
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
zlabel('$P(\mathbf{\mu}|\mathbf{x})$', 'Interpreter', "latex")
legend('Likelihood', 'IR Likelihood', 'TC Likelihood', 'Actual Location', 'Location', 'best')