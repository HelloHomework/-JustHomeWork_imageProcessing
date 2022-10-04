clc;clear all;close all;

file1="skeleton_orig.bmp";
file2="blurry_moon.tif";

Image1 = imread(file1);
Image1 = rgb2gray(Image1);
Image2 = imread(file2);

Image = Image1;

subplot(3,3,1);
imshow(Image);
title("Origin");

subplot(3,3,2);
imshow(Image);
title("Origin");

subplot(3,3,3);
imshow(Image);
title("Origin");
%imwrite(Image,'Origin.tif');

subplot(3,3,4);
imshow(LaplacianSpatial(Image));
title("LaplacianSpatial");
%imwrite(LaplacianSpatial(Image),'LaplacianSpatial.tif');

subplot(3,3,7);
imshow(LaplacianFrequency(Image));
title("LaplacianFrequency");
%imwrite(LaplacianFrequency(Image),'LaplacianFrequency.tif');

subplot(3,3,5);
imshow(UnsharpMaskingSpatial(Image));
title("UnsharpMaskingSpatial");
%imwrite(UnsharpMaskingSpatial(Image),'UnsharpMaskingSpatial.tif');

subplot(3,3,8);
imshow(UnsharpMaskingFrequency(Image));
title("UnsharpMaskingFrequency");
%imwrite(UnsharpMaskingFrequency(Image),'UnsharpMaskingFrequency.tif');

subplot(3,3,6);
imshow(HighBoostSpatial(Image,3));
title("HighBoostSpatial");
%imwrite(HighBoostSpatial(Image,3),'HighBoostSpatial.tif');

subplot(3,3,9);
imshow(HighBoostFrequency(Image,3));
title("HighBoostFrequency");
%imwrite(HighBoostFrequency(Image,3),'HighBoostFrequency.tif');
