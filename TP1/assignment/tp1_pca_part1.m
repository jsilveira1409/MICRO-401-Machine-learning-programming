clear;
clc;
close all;

% PATH
addpath("functions/part1")
addpath("evaluation_functions")
addpath("evaluation_functions/part1")
addpath("plot_functions")

% DATA LOADING DO NOT MODIFY
load fisheriris;
X = meas';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 1: Test your compute_pca.m function            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Mu, Covariance, EigenVectors, EigenValues] = compute_pca(X);

% EVALUATION DO NOT MODIFY
evaluate_pca(Mu, Covariance, EigenVectors, EigenValues, X);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 2: Test your project_pca.m function            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = 2;
[Yproj, Ap] = project_pca(X, Mu, EigenVectors, p);

% EVALUATION DO NOT MODIFY
evaluate_projection(Yproj, Ap, X, Mu, EigenVectors, p);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 3: Test your reconstruct_pca.m function        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Xhat = reconstruct_pca(Yproj, Ap, Mu);

% EVALUATION DO NOT MODIFY
evaluate_reconstruction(Xhat, Yproj, Ap, Mu);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 4: Test your reconstruction_error.m function   %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[err] = reconstruction_error(X, Xhat);

% EVALUATION DO NOT MODIFY
evaluate_error(err, X, Xhat);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 5: Test your explained_variance.m function     %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var_threshold = 0.95;
[ExpVar, CumVar, p_opt] = explained_variance(EigenValues, var_threshold);

% EVALUATION DO NOT MODIFY
evaluate_explained_variance(ExpVar, CumVar, p_opt, EigenValues, var_threshold);

%% VISUALIZATION
figure;
subplot(1,2,1)
plot_scatter_matrix(X, {'sepal length','sepal width','petal length','petal width'}, "Original dataset");
subplot(1,2,2)
plot_scatter_matrix(Xhat, {'sepal length','sepal width','petal length','petal width'}, "Reconstructed dataset");
figure;
plot_scatter_matrix(Yproj, [], "Projection on eigenvectors with p=" + string(p));
figure;
plot_eigenvalues(EigenValues);
figure;
plot_explained_variance(ExpVar, CumVar, p_opt);

