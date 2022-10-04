function [processedImage] = UnsharpMaskingFrequency(image)

% ############ Preprocess ############

% convert to 0~1 double type value and get size
imageDouble = im2double(image);
[m,n] = size(imageDouble);

% preparing padded image variable
% size 2x of max(m,n) => make sure it wont undersampling
len = 2*max(m,n);
preProcessImage = zeros(len,len);

% Multiplying with (-1)^(x+y) and padding
for i = 1:len
    for j = 1:len
        if i <= m && j<= n
            preProcessImage(i,j) = imageDouble(i,j).*(-1).^(i + j);
        else
            preProcessImage(i,j) = 0;
        end
    end
end

% ############ FFT and filtering ############

% perform DFT to transform image to frequency domain
ImageFreq = fft2(preProcessImage);

% generate Frequency spacing for frequency response
[x,y] = freqspace(len,'meshgrid');

% distance martix
dist = zeros(len,len);
for i = 1:len
    for j = 1:len
        dist(i,j) = sqrt(x(i,j).^2 + y(i,j).^2);
    end
end

% constructing High-pass filter function
H = zeros(len,len);
for i = 1:len
    for j = 1:len
        if dist(i,j) >= 0.5  % here 0.5 is the cut-off frequency
            H(i,j) = 1;
        else
            H(i,j) = 0;
        end
    end
end

% filtering & inverse DFT
ifftImg = ifft2(ImageFreq.*H);

% ############ Postprocess ############

% Multiplying with (-1)^(x+y)
postProcessImage = zeros(len,len);
for i = 1:len
    for j = 1:len
        postProcessImageImage(i,j) = ifftImg(i,j).*((-1).^(i+j));
    end
end

% remove padding and (Image - blured Image)
processedImage = zeros(m,n);
for i = 1:m
    for j = 1:n
        processedImage(i,j) = imageDouble(i,j) - postProcessImage(i,j);
    end
end

% convert to gray level(range: 0-255)
processedImage = uint8(processedImage.*255);

end
