function [Xinversed] = denormalize(X, param1, param2, normalization)
%DENORMALIZE Denormalize the data wrt to the normalization technique passed in
%parameter and param1 and param2 calculated during the normalization step
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o X : (N x M), normalized data of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : first parameter of the normalization 
%       o param2 : second parameter of the normalization
%
%   output ----------------------------------------------------------------
%
%       o Xinversed : (N x M), the denormalized data
if nargin == 2
    recalculate = true;
else
    recalculate = false;
end

if strcmp(normalization, 'minmax')
    if recalculate == true
        param1 = min(data, [], 2);
        param2 = max(data, [], 2);
    end
   Xinversed = X*(param2 - param1) + param1;
 elseif strcmp(normalization, 'zscore')
    if recalculate == true
        param1 = mean(data, 2);
        param2 = std(data, 2);
    end
   Xinversed = X*param2 + param1;
elseif strcmp(normalization, 'none')
    Xinversed = X;
else
    Xinversed = X;
end

end

