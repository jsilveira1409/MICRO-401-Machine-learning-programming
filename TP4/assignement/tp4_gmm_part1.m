addpath("./evaluation_functions")
addpath("./plot_functions")
addpath("./utils")
addpath("./functions/part1")

clear; 
close all; 
clc;

dataset_path = './data';

%% SEED: Remove this is you want to add randomness
seed = rng(42);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) Load 2D GMM-EM Function Testing Dataset          %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% choose a dataset
dataset_list = {'1a', '1b', '1c'};
dataset = dataset_list{3}; % CHANGE HERE TO SWITCH DATASET

switch dataset
    %% (1a) Load 2D data for testing Gausspdf and Covariance Matrices
    case '1a'
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        load(strcat(dataset_path,'/2D-Gaussian.mat'));
        % Visualize Dataset
        options.class_names = {};
        options.title       = '2D Gaussian Dataset';
        if exist('h0','var') && isvalid(h0), delete(h0);end
        h0 = ml_plot_data(X',options);hold on;
        
     %% (1b) Load 2D dataset for testing GMM-EM & Likelihood
    case '1b'
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        load(strcat(dataset_path,'/2D-GMM.mat'));
        % Visualize Dataset
        options.labels      = labels;
        options.class_names = {};
        options.title       = '2D GMM Dataset';
        if exist('h0','var') && isvalid(h0), delete(h0);end
        h0 = ml_plot_data(X',options);hold on;
        colors     = hsv(4);
        ml_plot_centroid(gmm.Mu',colors);hold on; 
        plot_gmm_contour(gca,gmm.Priors,gmm.Mu,gmm.Sigma,colors,0.5);
        grid on; box on;

    %% 1c) Draw Data with ML_toolbox GUI
    case '1c'
        close all; clc;
        if exist('X'); clear X; end
        if exist('labels'); clear labels;end
        [X, labels] = ml_draw_data();
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              2) gaussPDF.m function                        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch dataset
    case '1a' % Real Mu and Sigma used for 1a
        Mu = [1;1];
        Sigma = [1, 0.5; 0.5, 1];
        evaluate_gaussPDF(X, Mu, Sigma);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             3) gmmloglik.m function                        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch dataset
    case '1a' % Real Mu and Sigma used for 1a
        Mu = [1;1];
        Sigma = [1, 0.5; 0.5, 1];
        Priors = [1];
        evaluate_gmmLogLik( X, Priors, Mu, Sigma);
        
    case '1b' % Load gmm parameters with real values        
        Priors = gmm.Priors;
        Mu     = gmm.Mu;    
        Sigma  = gmm.Sigma;
        evaluate_gmmLogLik( X, Priors, Mu, Sigma);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            4) compute_covariance.m function                %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 evaluate_covariance(X);

%%%%% Visualize different covariance matrices %%%%
[Sigma_full, Sigma_diag, Sigma_iso] = visualize_covariances(X);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          5) gmmInit.m function                 %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set GMM Hyper-parameters
params.cov_type = 'full';
params.k = 4;
params.max_iter_init = 100;
params.d_type = 'L2';
params.init = 'plus';

% Run GMM-INIT function, estimates and visualizes initial parameters for EM algorithm
[ Priors0, Mu0, Sigma0, labels0 ] = gmmInit(X, params);

evaluate_gmmInit(X);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           6) gmmEM.m function                  %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SEED: Remove this is you want to add randomness
rng(seed)

% Set GMM Hyper-parameters
params.cov_type = 'full';
params.k = 4;
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';

%%%%%% Visualize Initial Estimates %%%%%%
plot_gmm(X, Priors0, Mu0, Sigma0, params, 'Initial Estimates for EM-GMM');

%%%% Run MY GMM-EM function, estimates the paramaters by maximizing loglik
[Priors, Mu, Sigma, iter] = gmmEM(X, params);

%%%%%% Visualize Final Estimates %%%%%%
plot_gmm(X, Priors, Mu, Sigma, params, 'Final Estimates for EM-GMM');

%% Visualize GMM pdf from learnt parameters
ml_plot_gmm_pdf(X, Priors, Mu, Sigma)

evaluate_gmmEM(X);
