addpath("functions/part1")
addpath("evaluation_functions")
addpath("evaluation_functions/part1")
addpath("plot_functions")
addpath("utils")

clear; 
close all; 
clc;

dataset_path = 'data/';
rng(42);
seed = rng;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           1) Load 2D KNN Function Testing Dataset          %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load Concentric Circle Data
% Load Dataset
load(strcat(dataset_path,'/2d-concentric-circles.mat'))
[~, M] = size(X);
rand_idx = randperm(M);
X = X(:,rand_idx);
y = y(rand_idx);
y = y + 1;

% Visualize Dataset
options.labels      = y;
options.class_names = {'y = 1','y = 2'};
options.title       = '2D Concentric Circles Dataset';

h0 = ml_plot_data(X',options);
axis equal

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     2) Data Handling for Classification (split_data.m)        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select Training/Testing Ratio
valid_ratio = 0.8;

% Split data into a training dataset that kNN can use to make predictions 
% and a test dataset that we can use to evaluate the accuracy of the model.
[X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    3) Test kNN implementation (my_knn) and Visualize Results  %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select k
params.k = 5;
params.d_type = 'L2';

% Compute y_estimate from k-NN
y_est =  knn(X_train, y_train, X_test, params);

plot_dataset(X, y, X_test, y_est, valid_ratio, params);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
evaluate_knn(X_train, y_train, X_test);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             4) Test my_accuracy.m function                 %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select k
params.k = 7;
params.d_type = 'L2';

% Compute y_estimate from k-NN
y_est =  knn(X_train, y_train, X_test, params);
acc = accuracy(y_test,y_est);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           5) Visualize kNN Results and Accuracy            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select k
params.k = 20; 
params.d_type = 'L2';

% Compute y_estimate from k-NN
y_est =  knn(X_train, y_train, X_test, params);

% Compute Accuracy
acc =  accuracy(y_test, y_est);

plot_dataset(X, y, X_test, y_est, valid_ratio, params)
plot_boundaries(X, y, X_train, y_train, valid_ratio, params)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         6) Choosing K by visualizing knn_eval.m            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select Range of K to test accuracy
M_train = length(X_train);
params.k_range = [1:2:ceil(M_train/2)];
acc_curve = knn_eval(X_train, y_train, X_test, y_test, params); 

plot_accuracy(params.k_range,acc_curve)
