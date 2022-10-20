function [] = plot_boundaries(X, Mu, labels, K, type)
% Plot decision boundary
my_kmeans_result.distance    = type;
my_kmeans_result.K           = K;
my_kmeans_result.method_name = 'kmeans';
my_kmeans_result.labels      = labels';
my_kmeans_result.centroids   = Mu';
my_kmeans_result.title       = sprintf('. My K-means result. K = %d, dist = %s',K, type);
if exist('hd','var') && isvalid(hd), delete(hd);end
hd = ml_plot_class_boundary(X',my_kmeans_result);
end

