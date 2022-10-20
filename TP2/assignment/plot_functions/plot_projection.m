function [] = plot_projection(Yproj, labels)

% Visualize Projected Dataset
plot_options = [];
plot_options.title = 'Digits projected to 4d-subspace';
plot_options.labels = labels;
h2  = ml_plot_data(Yproj',plot_options);
axis tight
legend('1','2','3','4')
end

