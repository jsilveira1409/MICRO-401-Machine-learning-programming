function [] = plot_eval_curves(RSS_curve, AIC_curve, BIC_curve)
% Plot Metric Curves
figure('Color',[1 1 1]);hold on;
plot(RSS_curve,'--o', 'LineWidth', 1); hold on;
plot(AIC_curve,'--o', 'LineWidth', 1); hold on;
plot(BIC_curve,'--o', 'LineWidth', 1); hold on;
xlabel('K')
legend('RSS', 'AIC', 'BIC')
title('Clustering Evaluation metrics')
grid on
axis tight
end

