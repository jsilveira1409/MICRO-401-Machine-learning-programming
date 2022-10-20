function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nb_dim = size(X, 1);
if strcmp (init, 'sample') == 1
        Mu = datasample(X, k,2);
elseif strcmp (init, 'range') == 1
    minimum = min(X,[], 2);
    maximum = max(X,[], 2);    
    for i = 1:nb_dim
        Mu(i,:) = (maximum(i) - minimum(i)).*rand(k,1) + minimum(i);
    end
end


end