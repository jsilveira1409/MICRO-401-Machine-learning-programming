function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%
%   where positive is encoded by the label 1 and negative is encoded by the label 2.        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_true_positives = sum(y_test == 1);
num_true_negatives = sum(y_test == 2);
TP = sum((y_est == 1 & y_test == 1));
TN = sum((y_est == 2 & y_test == 2));
FN = sum((y_est == 2 & y_test == 1));
FP = sum((y_est == 1 & y_test == 2));

C = [TP FN; FP TN];







end

