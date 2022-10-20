function [d] =  compute_distance(x_1, x_2, type)
%COMPUTE_DISTANCE Computes the distance between two datapoints (as column vectors)
%   depending on the choosen distance type={'L1','L2','LInf'}
%
%   input -----------------------------------------------------------------
%   
%       o x_1   : (N x 1),  N-dimensional datapoint
%       o x_2   : (N x 1),  N-dimensional datapoint
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : distance between x_1 and x_2 depending on distance
%                  type {'L1','L2','LInf'}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(type,'L1') == 1
    norm = abs(x_1 - x_2);
    d = sum(norm,1);
elseif strcmp(type,'L2') == 1
    norm = abs(x_1 - x_2).^2;
    d = sqrt(sum(norm));
elseif strcmp(type,'LInf') == 1
    d = max(abs(x_1 - x_2));
end


end