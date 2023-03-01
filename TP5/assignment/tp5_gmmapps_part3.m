addpath(genpath("./utils"))
addpath(genpath("./plot_functions"))
addpath(genpath("../solution/functions/part3"))

clear; 
close all; 
clc;

dataset_path = './data/';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               Task 6: Regression 1D dataset
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%  (1a) Generate Data from a noisy line %%%%%%
dataset_type = '1d-sinc';
[ X, y_true, y ] = load_regression_datasets( dataset_type, dataset_path );
Xi = [X  y]';

%% Run MY GMM-EM function, estimates the paramaters by maximizing loglik
% Fit GMM with Chosen parameters
params.cov_type = 'full';
params.k = 7;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

% Run GMM-EM function, estimates the paramaters by maximizing loglik
[Priors, Mu, Sigma] = gmmEM(Xi, params);

%% Test your implementation of Gaussian Mixture Regression
N = size(X,2); 
P = size(y,2);
in  = 1:N;
out = N+1:(N+P);
[y_est, var_est] = gmr(Priors, Mu, Sigma, X', in, out);

plot_regression(X, y, y_true, y_est, var_est, '1D Linear Dataset');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             2)  Regression 2D dataset
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%% (2a) Sin/Cos Dataset %%%%%%
dataset_type = '2d-cossine';
[ X, y_true, y, ftruth ] = load_regression_datasets( dataset_type, dataset_path );
Xi = [X  y]';

% Fit GMM with Chosen parameters
params.cov_type = 'full';
params.k = 4;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

% Run MY GMM-EM function, estimates the paramaters by maximizing loglik
[Priors, Mu, Sigma, ~] = gmmEM(Xi, params);

% Compute Regressive signal and variance
N = size(X,2); P = size(y,2); M = size(X,1);
in  = 1:N;       % input dimensions
out = N+1:(N+P); % output dimensions
[y_est, var_est] = gmr(Priors, Mu, Sigma, X', in, out);

% Function handle for my_gmr.m
f = @(X) gmr(Priors,Mu,Sigma,X, in, out);

plot_2Dregression(X, y, ftruth, f)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Task 7 & 8: Cross validation
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_type = '1d-sine';
[ X, y_true, y, ftruth ] = load_regression_datasets( dataset_type, dataset_path );
Xi = [X  y]';

% GMM parameters
params.cov_type = 'diag';
params.max_iter_init = 50;
params.max_iter = 100;
params.d_type = 'L2';
params.init = 'plus';

% Cross-validation parameters
valid_ratio  = 0.2;    % train/test ratio
k_range   = 1:10;   % range of K to evaluate
F_fold    = 10;     % # of Folds for cv

% Compute F-fold cross-validation
[metrics] = cross_validation_gmr(X', y', F_fold, valid_ratio, k_range, params);

plot_gmr_cross_validation(metrics, k_range)


