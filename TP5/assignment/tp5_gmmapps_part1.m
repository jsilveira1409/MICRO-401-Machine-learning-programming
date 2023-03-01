addpath(genpath("./utils"))
addpath(genpath("./plot_functions"))
addpath(genpath("../solution/functions/part1"))

clear; 
close all; 
clc;

dataset_path = './data/';
rng(42)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Task 1: Parameter initialization
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_type = "halfkernel";
[data, Xtrain, Ytrain, Xtest, Ytest, params] = initialize_parameters(dataset_type);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Task 2: Training
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

models = gmm_models(Xtrain, Ytrain, params);

plot_fitted_dataset(Xtrain, Ytrain, models)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Task 3: Prediction
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Yest] = gmm_classifier(Xtest, models, unique(Ytrain));

% Compute Accuracy
acc =  accuracy(Ytest, Yest);

% visualize it
figure('Name', 'Classification with GMM')
ax1 = subplot(1,2,1);
dotsize = 12;
scatter(data(:,1), data(:,2), dotsize, data(:,3)); axis equal;
title('Original Data');

% Plot decision boundary
ax2 = subplot(1,2,2);
plot_boundaries(Xtrain, Ytrain, Xtest, Ytest, Yest,  models);
linkaxes([ax1,ax2],'xy')
