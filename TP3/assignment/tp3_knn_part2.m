addpath("functions/part1")
addpath("functions/part2")
addpath("evaluation_functions")
addpath("plot_functions")
addpath("utils")

clear; 
close all; 
clc;

dataset_path = 'data/';
rng(42);
seed = rng;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           1) Load 9D KNN Function Testing Dataset          %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load Wisconsin Breast Cancer Dataset
[X, y, class_names] = ml_load_data(strcat(dataset_path,'breast-cancer-wisconsin.csv'),'csv','last');


% Breast-Cancer-Wisconsin Dataset
% https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29
% Nine real-valued features are computed for each cell nucleus:
%   Feature                          Range
%   1. Clump Thickness               1 - 10
%   2. Uniformity of Cell Size       1 - 10
%   3. Uniformity of Cell Shape      1 - 10
%   4. Marginal Adhesion             1 - 10
%   5. Single Epithelial Cell Size   1 - 10
%   6. Bare Nuclei                   1 - 10
%   7. Bland Chromatin               1 - 10
%   8. Normal Nucleoli               1 - 10
%   9. Mitoses                       1 - 10

% Transpose matrices to have datapoints as columns and dimensions as rows
X = X';
y = y';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     2) Data Handling for Classification (split_data.m)        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select Training/Testing Ratio
valid_ratio = 0.8;

% Split data into a training dataset that kNN can use to make predictions
% and a test dataset that we can use to evaluate the accuracy of the model.
[X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         3) Choosing K by visualizing knn_eval.m            %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select Range of K to test accuracy
M_train = length(X_train);
params.k_range = [1:5:ceil(M_train)];
params.d_type = 'L2';
acc_curve = knn_eval(X_train, y_train, X_test, y_test, params); 

plot_accuracy(params.k_range,acc_curve)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      4) Test Confusion Matrix (confusion_matrix.m)         %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Select k
params.k = 5;
params.d_type = 'L2';

% kNN classification of test set
y_est =  knn(X_train, y_train, X_test, params);

% Confusion matrix computation for the classified data
C = confusion_matrix(y_test, y_est);

plotConfMat(C);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                5) Plot ROC curve (knn_ROC.m)               %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Split data randomly between train and test
valid_ratio = 0.9;
[X_train, y_train, X_test, y_test] = split_data( X, y, valid_ratio);

% Compute ROC curve
params.k_range = [1:8:ceil(length(y)*(1-valid_ratio))];
[TP_rate, FP_rate] = knn_ROC( X_train, y_train, X_test, y_test, params );

plot_roc(FP_rate, TP_rate, params)
axis([0 1 0.95 1])
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          6) Cross validation (cross_validation.m)          %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
valid_ratio = 0.9;
params.k_range = [1:8:ceil(length(y)*(1-valid_ratio))];
F_fold = 10;

% Compute F-fold cross-validation
[avgTP, avgFP, stdTP, stdFP] =  cross_validation(X, y, F_fold, valid_ratio, params);

plot_cross_validation(avgTP, avgFP, stdTP, stdFP, params)
axis([0 1.05 0.971 1])
