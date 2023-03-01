function [mat] = one_hot_encoding(vec)
%ONE_HOT_ENCODING Compute the one-hot encoding matrix of a vector of class
%labels
    classes = unique(vec);
    mat = zeros(length(classes), length(vec));
    for i=1:length(vec)
        mat(classes == vec(i), i) = 1;
    end
end

