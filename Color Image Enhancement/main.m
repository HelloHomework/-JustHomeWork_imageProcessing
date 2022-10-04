clc;clear all;close all;

file1="kitchen.jpg"; % hsi : -0.1 lab : -7
file2="house.jpg"; % hsi : -0.1 lab : -7
file3="church.jpg"; % hsi : 0.1 lab : 7
file4="aloe.jpg"; % hsi : 0.1 lab : 7

Image1 = imread(file1);
Image2 = imread(file2);
Image3 = imread(file3);
Image4 = imread(file4);

OriginImage = Image4;

subplot(1,3,1)
imshow(OriginImage);
title('OriginImage');

HSIImage = MyRgb2Hsi(OriginImage);
HSIImage = MyHsi2Rgb(HSIImage,0.05);
subplot(1,3,2);
imshow(HSIImage);
title('HSI Image');

LabImage = MyRgb2Lab(OriginImage);
LabImage = MyLab2Rgb(LabImage,7);
subplot(1,3,3);
imshow(LabImage);
title('LAB Image');
