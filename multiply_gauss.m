function [mu,sigma] = multiply_gauss(mu_1,sigma_1,mu_2,sigma_2)
%MULTIPLY_GAUSS Multiply Gaussian distributions
sigma = (sigma_1^-1 + sigma_2^-1)^-1;
mu = sigma*sigma_1^-1*mu_1 + sigma*sigma_2^-1*mu_2;
end

