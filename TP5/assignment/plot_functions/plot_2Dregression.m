function [] = plot_2Dregression(X, y, ftruth, f)
%PLOT_2DREGRESSION Summary of this function goes here
%   Detailed explanation goes here
%% Plotting Ground Truth
% Plot True Function
figure('Name', '2D Dataset')
subplot(1,2,1)
options           = [];
options.title = 'Training Data';
options.surf_type = 'surf';
options.bFigure = false;
ml_plot_value_func(X,ftruth,[1 2],options);hold on

% Plot Noisy Data from Function
options = [];
options.plot_figure = true;
options.points_size = 10;
options.labels = zeros(size(X,2),1);
options.plot_labels = {'x1','x2','y'};
ml_plot_data([X y],options);
title('Original data')
        
%% Plotting Options for Regressive Function
subplot(1,2,2)
options           = [];
options.title     = 'Estimated y=f(x) from Gaussian Mixture Regression';
options.regr_type = 'GMR';
options.surf_type = 'surf';
options.bFigure = false;
ml_plot_value_func(X,f,[1 2],options);hold on

% Plot Training Data
options = [];
options.plot_figure = true;
options.points_size = 12;
options.labels = zeros(size(X,2),1);
options.plot_labels = {'x1','x2','y'};
ml_plot_data([X y],options);
title('Estimated regression')
end

