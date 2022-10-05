function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

channels = size(cimg,3);
height = size(ApList,2);
width = size(cimg, 2);

rimg = zeros(height, width, channels);
for i = 1:channels
    rimg(:,:,i) = reconstruct_pca(cimg(:,:,i), ApList(:,:,i), muList(:, i));
end

end

