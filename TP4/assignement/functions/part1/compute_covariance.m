function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%
M = size(X, 2);
N = size(X, 1);
X = X - X_bar;  

if strcmp(type, 'full')
    Sigma = 1/(M - 1) * (X * X');
elseif strcmp(type, 'diag')
    Sigma = 1/(M - 1) * (X * X');
    Sigma = diag(diag(Sigma));
else if strcmp(type, 'iso')
    sig = 1/(N*M) * sum(vecnorm(X,2,1).^2) * ones(N,1);
    Sigma = diag(sig);
end



end

