function [] = plot_images(X)

% Generate Variables
[N, M]  = size(X);
sizeIm  = sqrt(N);
idx = randperm(M);

if exist('h0','var') && isvalid(h0), delete(h0);end
h0  = ml_plot_images(X(:,idx(1:64))',[sizeIm sizeIm]);
end

