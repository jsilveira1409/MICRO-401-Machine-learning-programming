function [] = plot_curves(AIC_curve,BIC_curve,params)
%PLOT_CURVES Summary of this function goes here
%   Detailed explanation goes here
figure('Color',[1 1 1]);
plot(AIC_curve,'--o', 'LineWidth', 1); hold on;
plot(BIC_curve,'--o', 'LineWidth', 1); hold on;
xlabel('K')
legend('AIC', 'BIC')
title(sprintf('GMM (%s) Model Fitting Evaluation metrics',params.cov_type))
grid on
end

