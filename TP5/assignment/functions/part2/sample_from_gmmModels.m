function [XNew] = sample_from_gmmModels(models, nbSamplesPerClass, desiredClass)
%SAMPLE_FROM_GMMMODELS Generate new samples from a set of GMM
%   input------------------------------------------------------------------
%       o models : (structure array), Contains the following fields
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o nbSamplesPerClass    : (int) Number of samples per class to generate.
%       o desiredClass : [optional] (int) Desired class to generate samples for
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.
%       nbSamples depends if the optional argument is provided or not. If
%       not nbSamples = nbSamplesPerClass * nbClasses, if yes nbSamples = nbSamplesPerClass
%%
if nargin < 3
    N = size(models(1).Mu, 1);
    K = size(models(1).Priors, 2);
    nb_classes = size(models,2);
    XNew = zeros(N, nbSamplesPerClass*nb_classes);
   
    for i = 1:nb_classes
        XNew (:, 1 + (i - 1) * nbSamplesPerClass : i * nbSamplesPerClass ) = ...
            sample_from_gmm(models(i), nbSamplesPerClass);
    end 

elseif nargin == 3
    XNew = sample_from_gmm(models(desiredClass + 1), nbSamplesPerClass);
end





end
