function [ logl ] = gmmLogLik(X, Priors, Mu, Sigma)
%MY_GMMLOGLIK Compute the likelihood of a set of parameters for a GMM
%given a $dataset X
%
%   input------------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Priors : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu     : (N x K), an NxK matrix corresponding to the centroids mu = {mu^1,...mu^K}
%       o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                    Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%
%   output ----------------------------------------------------------------
%
%      o logl       : (1 x 1) , loglikelihood
%%
M = size(X,2);
K = size(Mu,2);

loglikelihood = 0;
inner_loglike = 0;

for i = 1:M
    for k = 1:K
        inner_loglike = Priors(k) * mvnpdf(X(:,i)', Mu(:,k)', Sigma(:,:,k)) + inner_loglike;
    end
    loglikelihood = loglikelihood + log(inner_loglike);
    inner_loglike = 0;
end

logl = loglikelihood;


end

