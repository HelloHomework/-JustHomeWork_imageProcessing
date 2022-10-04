function [LabImage] =  MyRgb2Lab(Image)

Image = double(Image)/255.0;

ImageR = Image(:,:,1); % Red
ImageG = Image(:,:,2); % Green
ImageB = Image(:,:,3); % Blue

% getLen
[m,n] = size(ImageR);

% rgb2xyz(sRGB,D65)
X = 0.4124564 * ImageR + 0.3575761 * ImageG + 0.1804375 * ImageB;
Y = 0.2126729 * ImageR + 0.7151522 * ImageG + 0.0721750 * ImageB;
Z = 0.0193339 * ImageR + 0.1191920 * ImageG + 0.9503041 * ImageB;

% param for Xyz2Lab
Xn = 0.950456;
Yn = 1.0;
Zn = 1.088754;

% init L,A,B
L=zeros(size(ImageR));  
A=zeros(size(ImageG));  
B=zeros(size(ImageB));  

% Xyz2Lab
for i = 1:m
    for j = 1:n
        % preProcess
        X(i,j) = X(i,j)/Xn;
        Y(i,j) = Y(i,j)/Yn;
        Z(i,j) = Z(i,j)/Zn;
        L(i,j) = 116.0 * HFunction(Y(i,j)) - 16;
        A(i,j) = 500.0 * ( HFunction( X(i,j) ) - HFunction( Y(i,j) ) );
        B(i,j) = 200.0 * ( HFunction( Y(i,j) ) - HFunction( Z(i,j) ) );
    end
end


%Lab Image
LabImage=zeros(size(Image));
LabImage(:,:,1)=L;
LabImage(:,:,2)=A;
LabImage(:,:,3)=B;

end