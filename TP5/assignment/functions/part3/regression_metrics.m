function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = size(yest, 1);
M = size(yest, 2);

mean_y_est = sum(yest,2) / M;
mean_y = sum(y,2) / M;

tmp1 = 0
tmp2 = 0;
total = 0;
var = 0;
mse = 0;

for i = 1:M
    difference_y = y(:,i) - mean_y;
    difference_yest = yest(:,i) - mean_y_est;

    tmp1 = tmp1 + difference_y^2;
    tmp2 = tmp2 + difference_yest^2;
    total = total + difference_yest * difference_y;

    mse = mse + (yest(:,i) - y(:,i))^2;
    var = var + difference_y^2 /(M - 1);
    
end

MSE = mse/M;
NMSE =  mse/(M * var);
Rsquared = total^2/(tmp1 * tmp2);





end

