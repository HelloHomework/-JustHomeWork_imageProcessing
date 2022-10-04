clc;clear all;close all;

images = ["Jetplane.bmp","Lake.bmp","Peppers.bmp"];

for i = 1 : length(images)
        [OriginalImage, ProcessedImage] = sharpening(images(i));
        subplot(length(images),2,2 * (i - 1) + 1);
        imshow(OriginalImage);
        title(images(i));
        % processed image
        subplot(length(images),2,2 * (i - 1) + 2);
        imshow(ProcessedImage);
        title(images(i) + ' Processed');
end


function [ImageInt, ImageProcessed] = sharpening(filename)
  % transform image to gray level bitmap
    [indexedImage, customColorMap] = imread(filename);
    Image = ind2rgb(indexedImage, customColorMap);
    Image = rgb2gray(Image);
    [x,y] = size(Image);
    n = x * y; % n is the total number of pixels in the image
 % transform bitmap form double to int ( range:1-256 )
    for i = 1 : x
        for j = 1 : y
            ImageInt(i, j) = uint32(Image(i, j) * 255);
        end
    end
    ImageProcessed=zeros(i,j);
 % using filter [0,1,0;1,-4,1;0,1,0]
    for i=2 : x-1
        for j=2 : y-1
            ImageProcessed(i, j) = uint32(5 * ImageInt(i, j) - ImageInt(i-1, j) - ImageInt(i, j-1) - ImageInt(i+1, j) - ImageInt(i+1, j) ); 
        end
    end

    ImageInt = uint8(ImageInt);
    ImageProcessed = uint8(ImageProcessed);
end



