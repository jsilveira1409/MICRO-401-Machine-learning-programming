function [] = plot_f1measure_curve(F1_curve)
figure('Color',[1 1 1]);hold on;
plot(F1_curve,'--o', 'LineWidth', 1); 
xlabel('K')
legend('F1-Measure')
title('F1 measure')
axis([1 10 0 1])
grid on
end

