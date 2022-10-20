function [] = plot_2d_data(X, gmm)
% Visualize Dataset
options.class_names = {};
options.title       = '2D Dataset';

if exist('h0','var') && isvalid(h0), delete(h0);end
h0 = ml_plot_data(X',options);hold on;
colors     = hsv(4);
ml_plot_centroids(gmm.Mu',colors);
ml_plot_sigma (gmm, colors, 10);
end

