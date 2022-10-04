clc;clear all;close all;

c = 1;
images = ["Jetplane.bmp","Lake.bmp","Peppers.bmp"];
gammas = [0.1, 0.4, 1, 2.5, 10];

for i = 1 : length(images)
    for j = 1 : length(gammas)
        subplot(3,5,(i-1)*length(gammas)+j);
        imshow(powerLaw(images(i),1,gammas(j)));
        title(images(i) + ' gamma ' + gammas(j) );
    end
end

function Image = powerLaw(filename,c,gamma)
    % transform image to gray level bitmap
    [indexedImage, customColorMap] = imread(filename);
    Image = ind2rgb(indexedImage, customColorMap);
    Image = rgb2gray(Image);
    [x,y] = size(Image);
    % As shown in Fig. 3.6, power-law transformations have the basic form:
    % where c and gamma are positive constants.
    % s = c * ( r ^ gamma)
    for i = 1 : x
        for j = 1 : y
            Image(i, j) = c * (Image(i, j)^ gamma);
        end
    end
end