function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix


% center the data
Mu = mean(X,2);
X = X - Mu;

% compute the covariance matrix
C = (1/(size(X,2)-1))*(X*X');

% eigenvalue decomposition
[V,L] = eig(C);

% sort eigenvectors by descending eigenvalues
[EigenValues, ind] = sort(diag(L),'descend');
EigenVectors = V(:,ind);
end

