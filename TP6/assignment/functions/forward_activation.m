function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function
N = size(Z,1);
M = size(Z,2);
A = zeros(N,M);
if strcmp(Sigma, "sigmoid")
    A = 1 ./ (1 + exp(-Z));
    
elseif strcmp(Sigma, 'relu')
    A = max(0,Z);

elseif strcmp(Sigma, 'tanh')
    A = tanh(Z); 

elseif strcmp(Sigma, 'leakyrelu')
    A = max(0.01*Z,Z);

elseif strcmp(Sigma, 'softmax')
     delta = max(Z,[],1);
     A = exp(Z-delta) ./ sum(exp(Z-delta),1);
end

end

