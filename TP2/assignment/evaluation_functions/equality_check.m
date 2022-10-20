function [bool] = equality_check(m1,m2)
%EQUALITY_CHECK Summary of this function goes here
%   Detailed explanation goes here
bool = (size(m1,1) ==  size(m2,1)) && (size(m1,2) ==  size(m2,2)) && (norm(m1 - m2) < 1e-4);
end