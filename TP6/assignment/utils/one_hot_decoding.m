function [vec] = one_hot_decoding(mat)
%ONE_HOT_DECODING Transform a one-hot encoded matrix back to a vector of
%class labels
    [~, M] = size(mat);
    vec = zeros(1, M);
    
    for i = 1:M
        [~,I] = max(mat(:, i));
        vec(1, i) = I;
    end
end

