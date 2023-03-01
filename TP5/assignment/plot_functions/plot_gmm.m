function [] = plot_gmm(X, Priors, Mu, Sigma, params, title)
%PLOT_CONTOUR Summary of this function goes here
%   Detailed explanation goes here
options.labels      = [];
options.class_names = [];
options.title       = title;
ml_plot_data(X',options);hold on;
colors     = hsv(params.k);
ml_plot_centroid(Mu',colors);hold on;
plot_gmm_contour(gca,Priors,Mu,Sigma,colors);
grid on; box on;
end

