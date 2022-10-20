addpath(genpath("functions/part1"))
addpath(genpath("functions/part2"))
addpath(genpath("evaluation_functions"))
addpath(genpath("evaluation_functions/part2"))
addpath(genpath("plot_functions"))

clear; 
close all; 
clc;

warning('off', 'all');

rng(42);
seed = rng;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              1) Load Digits Testing Dataset                %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
true_K = 4;
[X, labels] = ml_load_digits_64('data/digits.csv', 0:true_K-1);
X = X';
labels = labels';

% Plot 64 random samples of the dataset as images
plot_images(X);

% Plot the first 8 dimensions of the image as data points
plot_dimensions(X, labels, [1,2,3,4,5,6,7,8]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 6 Metrics computation                          %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evaluate_metric_computations(X);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 7 Kmeans evaluation                            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% K-means Evaluation Parameters
K_range=1:10;
type='L2';
repeats = 10;
init = 'sample';
MaxIter = 100;

% Evaluate K-means to find the optimal K
[RSS_curve, AIC_curve, BIC_curve] = kmeans_eval(X, K_range, repeats, init, type, MaxIter);

% Plot Metric Curves
plot_eval_curves(RSS_curve, AIC_curve, BIC_curve);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 8 F1 measure                                   %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evaluate_f1measure(X, labels);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        Task 9 F1 measure evaluation                        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, labels);

plot_f1measure_curve(F1_curve);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     3) Project data to 4D using PCA and Run K-means EVAL   %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Perform PCA on the digits dataset
[Mu, ~, Vsorted, ~] = solution_compute_pca(X);

% Project Digits Dataset to its first 3 principal components
p = 4;
[Yproj, Ap] = solution_project_pca(X, Mu, Vsorted, p);

% plot the projection
plot_projection(Yproj, labels)

%% K-means Evaluation Parameters
K_range=1:10;
type='L2';
repeats = 10;
init = 'sample';
MaxIter = 100;

% Evaluate K-means to find the optimal K
[RSS_curve, AIC_curve, BIC_curve] = kmeans_eval(Yproj, K_range, repeats, init, type, MaxIter);

plot_eval_curves(RSS_curve, AIC_curve, BIC_curve);

[F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, labels);

plot_f1measure_curve(F1_curve);
