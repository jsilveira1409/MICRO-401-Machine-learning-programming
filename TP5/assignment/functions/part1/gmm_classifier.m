function [Yest] = gmm_classifier(Xtest, models, labels)
%GMM_CLASSIFIER Classifies datapoints of X_test using ML Discriminant Rule
%   input------------------------------------------------------------------
%
%       o Xtest    : (N x M_test), a data set with M_test samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o models    : (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels    : (1 x N_classes) unique labels of X_test.
%   output ----------------------------------------------------------------
%       o Yest  :  (1 x M_test), a vector with estimated labels y \in {0,...,N_classes}
%                   corresponding to X_test.
%%
N = size(Xtest,1);

M_test = size(Xtest, 2);
N_classes = size(labels,2);
Yest = zeros(1,M_test);
prob = zeros(N_classes,M_test);

% TODO: check if possible to directly use gmmLogLik

for class = 1:N_classes
    K = size(models(1,class).Priors, 2);  
    for i = 1:K
        prob(class,:) = prob(class,:) + models(1,class).Priors(1,i) * ... 
                        gaussPDF(Xtest, models(1,class).Mu(:,i), ...
                        models(1,class).Sigma(:,:,i));
    end
end

prob = log(prob);
[~, indexes] = max(prob, [], 1);
Yest = labels(indexes);
end