function [] = plot_boundaries(X, y, X_train, y_train, valid_ratio, params)

% Plot K-NN Decision boundary
knn_options.k      = params.k;
knn_options.d_type = params.d_type;
[~, model]= knn_classifier(X_train, y_train, [], knn_options);
f_knn     = @(X_test)knn_classifier(X_test, [], model, []);

% Plot Decision Boundary
c_options         = [];
plot_data_options = [];
c_options.dim_swaped     = true;
c_options.show_misclass  = false;
c_options.title          = sprintf('K(%d)-NN Decision Boundary with valid-ratio: %1.2f',params.k,valid_ratio);

ml_plot_classifier(f_knn,X',y,c_options,plot_data_options);
axis tight

end

