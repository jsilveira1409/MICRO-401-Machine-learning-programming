function [h] = plot_gmmbayes_class_boundary(X_train, y_train, X_test, y_test, y_est, models, K)
labels = unique(y_test);


% Plot decision boundary
xplot = linspace(min(X_train(1,:)), max(X_train(1,:)), 400)';
yplot = linspace(min(X_train(2,:)), max(X_train(2,:)), 400)';

[Xs, Ys] = meshgrid(xplot,yplot);

%% ADD YOUR FUNCTION HERE
idx = my_gmm_classifier([Xs(:),Ys(:)]', models, labels, K); % to replace by your function
%% END CODE

colors  = hsv(length(unique(idx)));
Z      = reshape(idx,size(Xs));
pcolor(Xs,Ys,Z); shading interp;
colormap(colors);
hold on

scatter(X_test(1,:),X_test(2,:),150, colors(y_est,:),'o', 'filled','MarkerEdgeColor',[0 0 0]); hold on;
scatter(X_train(1,:),X_train(2,:),50, colors(y_train,:),'o','filled','MarkerEdgeColor',[0 0 0]);
scatter(X_test(1,:),X_test(2,:),50, colors(y_test,:),'o','filled','MarkerEdgeColor',[0 0 0]);

end