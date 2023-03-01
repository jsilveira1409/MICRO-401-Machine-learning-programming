function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D = size(Mu, 1);
N = size(X, 1);
K = size(Mu, 2);
M = size(X, 2);
P = size(out, 2);

y_est = zeros(P, M);
var_est = zeros(P, P, M);

sigma_xx = Sigma(1:N, 1:N, :);
sigma_xy = Sigma(1:N, N+1:D, :);
sigma_yy = Sigma(N+1:D, N+1:D, :);
sigma_yx = Sigma(N+1:D, 1:N, :);

mean_x = Mu(1:N, :);
mean_y = Mu(N+1:D , :);

prob = zeros(1, M);

for i = 1:M
    s = zeros(1);
    for j = 1:K
        prob(i) = prob(i) + (Priors(j) * gaussPDF(X(:,i), mean_x(:,j), sigma_xx(:,:,j)));
    end

    for j = 1:K
        variance = sigma_yy(:,:, j) - sigma_yx(:,:,j) / sigma_xx(:,:,j) * sigma_xy(:,:,j);

        beta = Priors(j) * gaussPDF (X(:,i), mean_x(:,j), sigma_xx(:,:,j));
        sig = mean_y(:,j) + sigma_yx(:,:,j) / sigma_xx(:,:,j) * (X(:,i) - mean_x(:,j) );
        
        y_est(:,i) = y_est(:,i) + (beta * sig /prob(i));
        s = s + (beta*(sig.^2 + variance) / prob(i));
    end
    var_est(:,:,i) = s - (y_est(:,i).^2);
end

end

