function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of min AIC values for K-range
%       o BIC_curve  : (1 X K), vector of min BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = size(K_range,2);
AIC_val = zeros(1,repeats);
BIC_val = zeros(1,repeats);
AIC_curve = zeros(1, K);
BIC_curve = zeros(1, K);
log_likelihood = zeros(1,repeats);


for k = 1:length(K_range)
    
    params.k = K_range(k);

    for i = 1:repeats
        [  Priors, Mu, Sigma, iter ] = gmmEM(X, params);
        log_likelihood(1,i) = gmmLogLik(X, Priors, Mu, Sigma);
        [AIC_val(1,i), BIC_val(1,i)] = gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);
    end
    k
    [val, index] = max(log_likelihood);
    AIC_curve(1,k) = AIC_val(1, index);
    BIC_curve(1,k) = BIC_val(1, index);
end

end
