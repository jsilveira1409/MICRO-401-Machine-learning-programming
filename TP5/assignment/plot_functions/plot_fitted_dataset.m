function [] = plot_fitted_dataset(Xtrain, Ytrain, models)
%PLOT_FITTED_DATASET Summary of this function goes here
%   Detailed explanation goes here
% visualize the GMM fitting
% Display contours for each class
for c = 1:length(unique(Ytrain))
    ml_plot_gmm_pdf(Xtrain, models(c).Priors, models(c).Mu, models(c).Sigma)
    hold off 
end
end

