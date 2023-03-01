function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_val = zeros(repeats,1);
a_val = zeros(repeats,1);
b_val = zeros(repeats,1);
RSS_curve = zeros(size(K_range,2),1);
AIC_curve = zeros(size(K_range,2),1);
BIC_curve = zeros(size(K_range,2),1);


for k = K_range
    for it = 1:repeats
        [labels, Mu, Mu_init, iter] = kmeans(X, k, init, type, MaxIter, 0);
        [r_val(it), a_val(it), b_val(it)] = compute_metrics(X,labels,Mu);
    end
    RSS_curve(k) = mean(r_val);
    AIC_curve(k) = mean(a_val);
    BIC_curve(k) = mean(b_val);
end

RSS_curve = RSS_curve';
AIC_curve = AIC_curve';
BIC_curve = BIC_curve';






end