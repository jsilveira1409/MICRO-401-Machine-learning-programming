addpath(genpath("./utils"))
addpath(genpath("./plot_functions"))
addpath(genpath("../solution/functions/part1"))
addpath(genpath("../solution/functions/part2"))

clear; 
close all; 
clc;

dataset_path = './data/';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Task 4: Sampling from single GMM
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataset_type = "corners";
[data, Xtrain, ~, ~, ~, params] = initialize_parameters(dataset_type);

params.k = 25; % try to change here

[Priors, Mu, Sigma] = gmmEM(Xtrain, params);

nbPoints = 1000;
gmm.Priors = Priors;
gmm.Mu = Mu;
gmm.Sigma = Sigma;

% sample from the GMM 
XNew = sample_from_gmm(gmm, nbPoints);

% plot both the original data and the sampled ones
figure('Name', 'Original dataset')
dotsize = 12;
ax1 = subplot(1,2,1);
scatter(Xtrain(1,:), Xtrain(2,:), dotsize);
title('Original Data')
ax2 = subplot(1,2,2);
scatter(XNew(1,:), XNew(2,:), dotsize);
title('Sampled Data')
linkaxes([ax1,ax2],'xy')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         2) Sampling from high-dimensional data
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

train_data = csvread(strcat(dataset_path,'mnist_train.csv'), 1, 0);  
nbSubSamples = 2000;
idx = randperm(size(train_data, 1), nbSubSamples);
train_data = train_data(idx,:);

% extract the data
Xtrain = train_data(:,2:end)';
Ytrain = train_data(:,1)';

plot_digits(Xtrain)

p = 20;
params.cov_type = 'full';
params.k = 200;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';
% Apply PCA on the dataset
[MuPCA, C, EigenVectors, EigenValues] = compute_pca(Xtrain);
[Xtrain, A_p] = project_pca(Xtrain, MuPCA, EigenVectors, p);

% fit a GMM on the PCA data
[Priors, Mu, Sigma] = gmmEM(Xtrain, params);
gmm.Priors = Priors;
gmm.Mu = Mu;
gmm.Sigma = Sigma;

% sample from the GMM 
X = sample_from_gmm(gmm, 100);

% reconstruct the images from the PCA
XHat = reconstruct_pca(X, A_p, MuPCA);

% plot the reconstructed
plot_digits(XHat)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Task 5: Sampling from a GMM models
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we can also train different models of GMM for each class of digits
params.cov_type = 'full';
params.k = 100;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';
models = gmm_models(Xtrain, Ytrain, params);

% sample from the trained GMM model
X = sample_from_gmmModels(models, 50);

% reconstruct the images from the PCA
XHat = reconstruct_pca(X, A_p, MuPCA);

% plot the reconstructed
plot_digits(XHat)

% sample only class 4
X = sample_from_gmmModels(models, 50, 4);

% reconstruct the images from the PCA
XHat = reconstruct_pca(X, A_p, MuPCA);

% plot the reconstructed
plot_digits(XHat)




