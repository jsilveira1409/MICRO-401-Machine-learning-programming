function [] = plot_cross_validation(avgTP, avgFP, stdTP, stdFP, params)
% Plot ROC curve for F-fold cross-validation with standard deviation
figure;hold on;
yneg = stdTP; 
ypos = yneg;
xneg = stdFP; 
xpos = xneg;
plot(avgFP, avgTP, '--o', 'LineWidth', 2, 'Color', [1 0 0]); hold on;
errorbar(avgFP,avgTP,yneg,ypos,xneg,xpos,'ko')
for i = 1:length(params.k_range)
    current_k = params.k_range(i);
    text(avgFP(i)+0.0005,avgTP(i)-0.0015,['k = ' num2str(current_k)])
end
xlabel('False Positive rate'); ylabel('True Positive rate = 1 - False Negative Rate')
title('ROC curve for KNN')
grid on
hold off
end

