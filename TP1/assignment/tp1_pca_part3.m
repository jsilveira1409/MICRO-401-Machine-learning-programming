clear;
clc;
close all;

% PATH
addpath("functions/part1")
addpath("functions/part3")
addpath("evaluation_functions/part1")
addpath("plot_functions")

% data loading
table = readtable("data/cryptocurrencies_prices.csv");
data = table2array(table)';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 9: Test your normalize.m function              %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

normalization = "minmax";
[X, param1, param2] = normalize(data, normalization);

%% PCA (DO NOT MODIFY)
% PCA computation
[Mu, Covariance, EigenVectors, EigenValues] = solution_compute_pca(X);
var_threshold = 0.95;
[ExpVar, CumVar, p_opt] = solution_explained_variance(EigenValues, var_threshold);

% PCA projection
p = 1;
[Yproj, Ap] = solution_project_pca(X, Mu, EigenVectors, p);
XHat = solution_reconstruct_pca(Yproj, Ap, Mu);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 10: Test your denormalize.m function           %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XHatDenormalized = denormalize(XHat, param1, param2, normalization);

%% VISUALIZATION
figure;
plot_eigenvalues(EigenValues);
figure;
plot_explained_variance(ExpVar, CumVar, p_opt);
figure;
plot_bitcoin_comparison(data, XHatDenormalized, 'reconstruction with ' + string(p) + ' eigenvectors')
figure;
plot_bitcoin_comparison(X, Yproj, 'projection on e1 after ' + normalization + ' normalization')
