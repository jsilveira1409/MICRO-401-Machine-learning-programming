function [] = plot_roc(FP_rate, TP_rate, params)
% Plot ROC Curve

figure;hold on;
plot(FP_rate, TP_rate, '--o', 'LineWidth', 1, 'Color', [1 0 0]); hold on;
xlabel('False Positive rate'); ylabel('True Positive rate = 1 - False Negative Rate')
title('ROC curve for KNN')
grid on
for i = 1:length(params.k_range)
    current_k = params.k_range(i);
    text(FP_rate(i)+0.001,TP_rate(i)-0.001+0.001*mod(i,3),['k = ' num2str(current_k)])
end
end

