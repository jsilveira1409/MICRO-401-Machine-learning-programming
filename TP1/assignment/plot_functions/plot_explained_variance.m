function [] = plot_explained_variance(ExplainedVar, CumVar,p_opt)
%PLOT_EXPLAINED_VARIANCE Summary of this function goes here
%   Detailed explanation goes here
plot(CumVar, '--r', 'LineWidth', 2) ; hold on;
plot(p_opt,CumVar(p_opt),'or'); hold on;
bar(ExplainedVar, 0.2, 'b');
title('Explained Variance from EigenValues')
ylabel('% Cumulative Variance Explained')
xlabel('Eigenvector index')

set(gca,'xtick',1:length(ExplainedVar));
set(gca,'xlim',[0.5,length(ExplainedVar)]);
set(gca,'ylim',[0,1]);
grid on
end

