function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error
E = 0;
P = size(Y,1);
M = size(Y,2);

if strcmp(type, 'LogLoss')
    tmp1 = Yd .* log(Y);
    tmp2 = (1-Yd) .* log(1 - Y);
    E = (-1/M) * sum((tmp1 + tmp2), 2);
elseif strcmp(type, 'CrossEntropy')
    sum_inner = sum(Yd .* log(Y), 1);
    E = -(1/M) * sum(sum_inner,2);
end


end