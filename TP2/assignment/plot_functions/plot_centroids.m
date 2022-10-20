function [] = plot_centroids(X, Mu, init)
%PLOT_CENTROIDS Summary of this function goes here
%   Detailed explanation goes here
options.title       = sprintf('Centroid Initialization: %s', init);
ml_plot_data(X',options); hold on;
colors     = hsv(length(Mu));
ml_plot_centroids(Mu',colors);
end

