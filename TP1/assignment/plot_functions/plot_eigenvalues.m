function [] = plot_eigenvalues(EigenValues)
%PLOT_EIGENVALUES Summary of this function goes here
%   Detailed explanation goes here
plot(EigenValues, '--b', 'LineWidth', 2)
title('Eigenvalues')
ylabel('Eigenvalues')
xlabel('Eigenvector index')

set(gca,'xtick',1:length(EigenValues));
set(gca,'xlim',[1,length(EigenValues)]);
grid on
end

