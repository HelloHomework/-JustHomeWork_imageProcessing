function [RgbImage] =  MyLab2Rgb(Image,Loffset)

ImageL = Image(:,:,1); % L
ImageA = Image(:,:,2); % A
ImageB = Image(:,:,3); % B

% LAB offset
ImageL = ImageL + Loffset;

[m,n] = size(ImageL);

% init XYZ
X=zeros(size(ImageL));  
Y=zeros(size(ImageA));  
Z=zeros(size(ImageB));  

% param for Lab2Xyz
En = 0.008856;
Xn = 0.950456;
Yn = 1.0;
Zn = 1.088754;

% LAB to XYZ
for i = 1:m
    for j = 1:n
        % prepare fx,fy,fz
        fy = (ImageL(i,j) + 16.0)/116.0;
        fz = fy - ImageB(i,j)/200.0;
        fx = ImageA(i,j)/500 + fy;
        % Y transformation
        if(fy ^3.0 > En)
            Y(i,j) = (fy^3);
        else
            Y(i,j) = (fy - (16.0/116.0))/7.787;
        end
        Y(i,j) = Y(i,j) * Yn;
        % X transformation
        if(fx ^ 3 > En)
            X(i,j) = fx^3.0;
        else
            X(i,j) = (fx - (16.0/116.0))/7.787;
        end
        X(i,j) = X(i,j) * Xn;
        % Z transformation
        if(fz ^ 3 > En)
            Z(i,j) = fz^3.0;
        else
            Z(i,j) = (fz - (16.0/116.0))/7.787;
        end
        Z(i,j) = Z(i,j) * Zn;
    end
end

% xyz2rgb(sRGB,D65)
R =  3.2404542 * X - 1.5371385 * Y - 0.4985314 * Z; 
G = -0.9692660 * X + 1.8760108 * Y + 0.0415560 * Z; 
B =  0.0556434 * X - 0.2040259 * Y + 1.0572252 * Z; 



% R,G,B matrix to image
RgbImage=zeros(size(Image));
RgbImage(:,:,1)=R;
RgbImage(:,:,2)=G;
RgbImage(:,:,3)=B;

RgbImage = uint8(RgbImage * 255.0);

end