function [] = plot_scatter_matrix(X, labels, title_str)
%PLOT_SCATTER_MATRIX Summary of this function goes here
%   Detailed explanation goes here
[~,AX,BigAx] = plotmatrix(X');
for i=1:length(labels)
    AX(i,1).YLabel.String = labels(i);
end
for i=1:length(labels)
    AX(length(labels),i).XLabel.String = labels(i);
end
title(BigAx,title_str)
end

