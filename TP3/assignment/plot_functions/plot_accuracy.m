function [] = plot_accuracy(k_range,acc_curve)

% Plot Accuracy Curve
figure;hold on;
plot(k_range,acc_curve,'--o', 'LineWidth', 1, 'Color', [1 0 0]); hold on;
xlabel('k'); ylabel('Acc')
title('Classification Evaluation for KNN')
grid on
pause(1);
end

