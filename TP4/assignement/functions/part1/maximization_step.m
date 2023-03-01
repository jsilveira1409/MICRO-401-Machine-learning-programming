function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%
M = size(X, 2);
N = size(X, 1);
K = params.k;
epsilon = 1E-5;

Priors = zeros(1,K);
Mu = zeros(N,K);
Sigma = zeros(N,N,K);
type = params.cov_type;

for i = 1:K

    Priors(1,i) = (1/M) * sum( Pk_x(i,:) );
    den = sum(Pk_x(i,:));
    Mu(:,i)=(X * Pk_x(i,:)') /den;
    
    if strcmp(type,'full')
        for j=1:M
            Sigma(:,:,i) = Sigma(:,:,i) + Pk_x(i,j) * (X(:,j) - Mu(:,i)) * (X(:,j) - Mu(:,i))' / sum(Pk_x(i,:));
        end
    elseif strcmp(type,'diag')
        for j=1:M
            Sigma(:,:,i) = Sigma(:,:,i) + Pk_x(i,j) * (X(:,j) - Mu(:,i)) * (X(:,j) - Mu(:,i))' / sum(Pk_x(i,:));
        end
        Sigma(:,:,i) = diag(diag(Sigma(:,:,i)));  
    elseif strcmp(type,'iso')
        for j=1:M
            Sigma(:,:,i) = Sigma(:,:,i) + Pk_x(i,j) * norm((X(:,j) - Mu(:,i)))^2 / (size(X,1) * sum(Pk_x(i,:)));
        end
        Sigma(:,:,i) = diag(diag(Sigma(:,:,i))); 
    end
end

Sigma = Sigma .* (1 + epsilon);

end

