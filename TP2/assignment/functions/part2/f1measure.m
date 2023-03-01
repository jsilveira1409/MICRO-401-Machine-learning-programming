function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = length(class_labels);                        
K_true = unique(class_labels);
K_found = unique (cluster_labels);  
nb_classes = length(K_true); 
nb_clusters = length (K_found);
pts_in_cluster = zeros(1, nb_clusters);
pts_in_class = zeros(1, nb_classes);

P = zeros(nb_clusters, nb_classes);
R = zeros(nb_clusters, nb_classes);
F1 = zeros(nb_clusters, nb_classes);
F1_overall = 0;

for i = 1:M
    pts_in_cluster(K_found(cluster_labels(i))) = 1 + pts_in_cluster(K_found(cluster_labels(i)));
    pts_in_class(K_true(class_labels(i))) = 1 + pts_in_class(K_true(class_labels(i)));
end

for i = 1:nb_classes
    for j = 1:M
        if class_labels(j) == i
            P(cluster_labels(j),i) = P(K_found(cluster_labels(j)),i) + 1;
            R(cluster_labels(j),i) = R(K_found(cluster_labels(j)),i) + 1;
        end
    end
end

P = P ./ pts_in_cluster';
R = R ./ pts_in_class;

F1 = (2* (R.*P))./(R + P);
F1(isnan(F1)) = 0;

for i = 1:nb_classes
    F1_overall = F1_overall + (pts_in_class(i)/M) * max(F1(:,i));
end




end
