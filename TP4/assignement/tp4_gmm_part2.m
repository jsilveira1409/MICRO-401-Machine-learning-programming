addpath("./evaluation_functions")
addpath("./plot_functions")
addpath("./utils")
addpath("./functions/part1")
addpath("./functions/part2")

clear; 
close all; 
clc;

dataset_path = './data';

%% SEED: Remove this is you want to add randomness
seed = rng(42);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) Load 2D GMM Fit Function Testing Dataset        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose a dataset
dataset_list = {'1a', '1b', '1c'};
dataset = dataset_list{1};

switch dataset
    %% 1a) Load 2d GMM Dataset
    case '1a'
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        load(strcat(dataset_path,'/2D-GMM.mat'))
        
    %% 1b) Load 2d Circle Dataset
    case '1b'
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        load(strcat(dataset_path,'/2d-concentric-circles.mat'))

    %% 1c) Draw Data with ML_toolbox GUI
    case '1c'
        close all; clc;
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        [X, labels] = ml_draw_data();
end

%% K-means Evaluation Parameters
K_range = 1:10; 
repeats = 10;
%% Set GMM Hyper-parameters
params.cov_type = 'full';
params.k = 4;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

% Evaluate gmm-em to find the optimal k
[AIC_curve, BIC_curve] = gmm_eval(X, K_range, repeats, params);

% Plot Metric Curves
plot_curves(AIC_curve, BIC_curve, params)

%% Pick best K from Plot and Visualize result
% SEED: Remove this is you want to add randomness
rng(seed)

% Set GMM Hyper-parameters
params.cov_type = 'full';
params.k = 3;
%%%% Run MY GMM-EM function, estimates the paramaters by maximizing loglik
[Priors, Mu, Sigma, iter] = gmmEM(X, params);

%%%%%% Visualize Final Estimates %%%%%%
plot_gmm(X,Priors,Mu,Sigma,params,strcat(['Final Estimates ',params.cov_type,' covariance, k=',int2str(params.k)]));

% Visualize GMM pdf from learnt parameters
ml_plot_gmm_pdf(X, Priors, Mu, Sigma)
