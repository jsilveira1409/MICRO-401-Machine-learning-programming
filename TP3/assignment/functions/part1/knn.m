function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(X_train,1);
M_train = size(X_train,2);
M_test = size(X_test,2);
y_est = zeros(1, M_test);
d = zeros(M_train, M_test);

for i = 1:M_train
    for j = 1:M_test
        d(i,j) = compute_distance(X_train(:,i), X_test(:,j), params);
    end
end

for i = 1:M_test
    [~, index] = sort(d(:,i), 'ascend');
    y_train_sorted_labels = y_train(index);
    [C,~,ic] = unique(y_train_sorted_labels(1:params.k));
    counter = accumarray(ic, 1);
    [~,max_cnt_index] = max(counter);
    y_est(i) = C(max_cnt_index);
end











end