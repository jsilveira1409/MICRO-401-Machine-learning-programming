function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function
syms z;

if strcmp(Sigma, "sigmoid")
    %dZ = arrayfun(@(z) exp(-z)/(exp(-z) + 1)^2, Z);
    dZ = exp(-Z)./(1 + exp(-Z)).^2;
elseif strcmp(Sigma, "tanh")
    %dZ = arrayfun(@(z) 1 - (exp(-z) - exp(z))^2/(exp(-z) + exp(z))^2, Z);
    dZ = 1-tanh(Z).^2; 
elseif strcmp(Sigma, "leakyrelu")
    %tmp = diff(max(0.01*z, z));
    %dZ = arrayfun(@(z) tmp, Z);
    dZ = (Z >= 0) + 0.01*(Z < 0);

elseif strcmp(Sigma, "relu")    
    %tmp = diff(max(0, z));
    %dZ = arrayfun(@(z) tmp, Z);
    dZ = (Z >= 0);

end


end