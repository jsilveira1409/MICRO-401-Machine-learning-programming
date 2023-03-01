function [] = plot_dataset(X, y, X_test, y_est, valid_ratio, params)

% Visualize Split Dataset
options.labels      = y;
options.class_names = [];
options.title       = sprintf('kNN, valid-ratio = %1.2f, k= %d',valid_ratio, params.k);
ml_plot_data(X',options); hold on;
scatter(X_test(1,y_est == 1),X_test(2,y_est == 1),150,'o','MarkerEdgeColor', [1 0 0]);hold on;
scatter(X_test(1,y_est == 2),X_test(2,y_est == 2),150,'o','MarkerEdgeColor', [0 0 1]);
legend({'$y=1$','$y = 2$','$\hat{y} = 1$','$\hat{y} = 2$'},'Interpreter','latex')
axis equal
end

