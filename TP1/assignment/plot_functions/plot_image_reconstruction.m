function [] = plot_image_reconstruction(img)
%PLOT_IMAGE_RECONSTRUCTION Summary of this function goes here
%   Detailed explanation goes here

% plot the original image and the compressed one side by side
figure('Name', 'Original and compressed images')
subplot(2,2,1)
imshow(img)
title('Original image')

p = [5, 50, 100];
for i=1:3
    [cimg, ApList, muList] = compress_image(img,p(i));
    rimg = reconstruct_image(cimg, ApList, muList);
    [cr] = compression_rate(img, cimg, ApList, muList);

    subplot(2,2,i+1)
    imshow(rimg)
    title(join(['p = ' num2str(p(i)) ', compression rate = ' num2str(cr)]))
end
end

