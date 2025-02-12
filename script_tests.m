%% script_tests.m
% author: Samuel Street
% date: 2025-02-12

%% circle intersection

% tested can confirm it works

center_1 = [0 0]';
center_2 = [0 1]';
center_3 = [1 1]';

p = [0.35 0.7]';

dist_1 = norm(p - center_1);
dist_2 = norm(p - center_2);
dist_3 = norm(p - center_3);

p = circle_intersect(center_1,dist_1,center_2,dist_2,center_3,dist_3);

% graphing purposes
ang = linspace(0,2*pi,100);
circ_1 = [dist_1*cos(ang)+center_1(1) ; dist_1*sin(ang)+center_1(2)];
circ_2 = [dist_2*cos(ang)+center_2(1) ; dist_2*sin(ang)+center_2(2)];
circ_3 = [dist_3*cos(ang)+center_3(1) ; dist_3*sin(ang)+center_3(2)];

figure;
plot(circ_1(1,:), circ_1(2,:));
axis equal
hold on
grid on
plot(circ_2(1,:), circ_2(2,:));
plot(circ_3(1,:), circ_3(2,:));
scatter(p(1),p(2))

%% circle position estimate

dist_var_1 = 0;
dist_var_2 = 0.1;
dist_var_3 = 1;

[mu, sigma] = circle_gauss_estimate(center_1,dist_1,dist_var_1, ...
    center_2,dist_2,dist_var_2,center_3,dist_3,dist_var_3);

x = linspace(-0.75,2,30);
y = linspace(-0.75,2,30);
[XX,YY] = meshgrid(x,y);
X = [XX(:) YY(:)];

z = mvnpdf(X,mu',sigma);
z = reshape(z,length(x),length(y));

circ_heights = 0.75*ones(size(ang));

surf(x,y,z)
xlabel('x')
ylabel('y')
zlabel('estimate density')
hold on
axis equal
plot3(circ_1(1,:), circ_1(2,:), circ_heights, 'LineWidth', 1);
plot3(circ_2(1,:), circ_2(2,:), circ_heights, 'LineWidth', 1);
plot3(circ_3(1,:), circ_3(2,:), circ_heights, 'LineWidth', 1);
scatter3(mu(1),mu(2),circ_heights(1),'filled', 'LineWidth', 1.5);

%% product of 2 gaussians

mu_1 = [1 1]';
mu_2 = [2 2]';
sigma_1 = [0.1 0.05 ; 1 0.05];
sigma_2 = [1 0 ; 0 1];

[mu,sigma] = multiply_gauss(mu_1,sigma_1,mu_2,sigma_2);
