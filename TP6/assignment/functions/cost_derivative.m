function [dZ] = cost_derivative(Y, Yd, typeCost, typeLayer)
%COST_DERIVATIVE compute the derivative of the cost function w.r.t to the Z
%value of the last layer
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Yd
%       o Yd (PxM) Ground truth
%       o typeCost (string) type of the cost evaluation function
%       o typeLayer (string) type of the last layer
%   outputs:
%       o dZ (PxM) The derivative dE/dZL
M = size(Y,2);
dZ = 0;

if strcmp(typeCost, 'LogLoss')
    %dZ = cost_function(Y, Yd, typeCost) ./ backward_activation(Y, typeLayer);
    % Formula taken from Applied Machine Learning
    % (slide 19)
    if strcmp(typeLayer, 'sigmoid')
        dZ = Y - Yd;
    end
elseif strcmp(typeCost, 'CrossEntropy')
    if strcmp(typeLayer, 'softmax')
        dZ = Y - Yd;
    end
end
end