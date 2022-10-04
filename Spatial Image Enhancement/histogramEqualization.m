clc;clear all;close all;

images = ["Jetplane.bmp","Lake.bmp","Peppers.bmp"];

for i = 1 : length(images)
        [OriginalImage, ProcessedImage] = histogramEq(images(i))
        subplot(length(images),4,4 * (i - 1) + 1);
        imshow(OriginalImage);
        title(images(i));
        subplot(length(images),4,4 * (i - 1) + 2);
        histogram(OriginalImage,256,BinLimits=[0,255]);
        title(images(i) + ' Histogram');
        % processed image
        subplot(length(images),4,4 * (i - 1) + 3);
        imshow(ProcessedImage);
        title(images(i) + ' Processed');
        
        subplot(length(images),4,4 * (i - 1) + 4);
        histogram(ProcessedImage,256,BinLimits=[0,255]);
        title(images(i)+ ' Processed Histogram');
end

function [ImageIntOrigin, ImageFinal] = histogramEq(filename)
 % transform image to gray level bitmap
    [indexedImage, customColorMap] = imread(filename);
    Image = ind2rgb(indexedImage, customColorMap);
    Image = rgb2gray(Image);
    [x,y] = size(Image);
    n = x * y; % n is the total number of pixels in the image
 % transform bitmap form double to int ( range:1-256 )
    for i = 1 : x
        for j = 1 : y
            ImageIntOrigin(i, j) = uint8(Image(i, j) * 255);
            ImageInt(i, j) = uint8(Image(i, j) * 255) + 1;
        end
    end
 % count all value
    ImageCount = zeros(1,256)
    for i = 1 : x
        for j = 1 : y
            ImageCount((ImageInt(i, j))) = ImageCount((ImageInt(i, j))) + 1;
        end
    end
 % caculate pdf( probability density function ) of image
    for i = 1 : 256
            ImagePdf(i) = double(ImageCount(i)) / (n * 1.0);
    end
 % caculate cdf( cumulative distribution function ) of image
    ImageCdf = ImagePdf;
    for i = 2 : 256
            ImageCdf(i) = ImageCdf(i - 1) + ImagePdf(i);
    end
 % cnf * 255(max)
    for i = 1 : 256
            ImageMap(i) = uint8(ImageCdf(i) * 255);
    end
 % mapping to new picture
    for i = 1 : x
        for j = 1 : y
            ImageFinal(i, j) = ImageMap(ImageInt(i, j));
        end
    end
end


