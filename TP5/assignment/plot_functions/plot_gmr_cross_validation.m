function [] = plot_gmr_cross_validation(metrics, k_range)
%PLOT_GMR_CROSS_VALIDATION Summary of this function goes here
%   Detailed explanation goes here
%% Plot GMM Model Selection Metrics for F-fold cross-validation with std
figure;

subplot(1,2,1)
errorbar(k_range',metrics.mean_AIC', metrics.std_AIC','--or','LineWidth',2); hold on;
errorbar(k_range',metrics.mean_BIC', metrics.std_BIC','--ob','LineWidth',2);
grid on
xlabel('Number of K components'); ylabel('AIC/BIC Score')
legend('AIC', 'BIC')
title('GMM Model Selection Metrics')

%% Plot Regression Metrics for F-fold cross-validation with std
subplot(1,2,2)
[ax,hline1,hline2]=plotyy(k_range',metrics.mean_MSE',[k_range' k_range'],[metrics.mean_NMSE' metrics.mean_R2']);
delete(hline1);
delete(hline2);
hold(ax(1),'on');
errorbar(ax(1),k_range', metrics.mean_MSE', metrics.std_MSE','--o','LineWidth',2,'Color', [0 0.447 0.741]);
hold(ax(2),'on');
errorbar(ax(2),k_range',metrics.mean_NMSE', metrics.std_NMSE','--or','LineWidth',2);
errorbar(ax(2),k_range',metrics.mean_R2', metrics.std_R2','--og','LineWidth',2);
xlabel('Number of K components'); ylabel('Measures')
legend('MSE', 'NMSE', 'Rsquared')
grid on
title('Regression Metrics')
end

