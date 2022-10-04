clc;clear all;close all;

filename = "image1.jpg";
%filename = "image2.jpg";
%filename = "image3.jpg";
Image = imread(filename);

subplot(1,3,1);
imshow(Image);
title("Origin");
subplot(1,3,2);
imshow(MySobol(Image));
title("Sobol");
subplot(1,3,3);
imshow(MyLoG(Image));
title("LoG");


