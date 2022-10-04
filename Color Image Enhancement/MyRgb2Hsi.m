function [HsiImage] =  MyRgb2Hsi(Image)

Image = double(Image)/255;

R = Image(:,:,1); % Red
G = Image(:,:,2); % Green
B = Image(:,:,3); % Blue

% preprocess
a=1/2*((R-G)+(R-B));
b=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero
H=acosd(a./(b+0.0000001));

%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);

%Normalize to the range [0 1]
H=H/360;
S=1- (3./(sum(Image,3)+0.0000001)).*min(Image,[],3);
I=sum(Image,3)./3;

%HSI
HSI=zeros(size(Image));
HSI(:,:,1)=H;
HSI(:,:,2)=S;
HSI(:,:,3)=I;

%HsiImage to range [0 255]
HsiImage = uint8(HSI * 255);

end