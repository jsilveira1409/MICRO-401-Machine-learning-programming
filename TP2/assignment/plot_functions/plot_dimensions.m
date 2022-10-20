function [] = plot_dimensions(X, labels, dimensions)

% Generate Variables
[N, M]  = size(X);
idx = randperm(M);
nSamples = round(M);

% Plot the first 8 dimensions of the image as data points
plot_options = [];
plot_options.labels = labels(idx(1:nSamples));
plot_options.title = '';
if exist('h1','var') && isvalid(h1), delete(h1);end
h1  = ml_plot_data(X(dimensions, idx(1:nSamples))',plot_options);
axis equal;
end

