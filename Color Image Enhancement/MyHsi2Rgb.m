function [HsiImage] =  MyHsi2Rgb(Image,Ioffset)

%Image to double 
Image = double(Image)/255;

%Obtain the Hue, Saturation and Intensity components  
H=Image(:,:,1);  
S=Image(:,:,2);  
I=Image(:,:,3);

%offset I,H
I = I + Ioffset;

%Multiply Hue by 360 to represent in the range [0 360]  
H=H*360;                                               

%Preallocate the R,G and B components  
R=zeros(size(H));  
G=zeros(size(H));  
B=zeros(size(H));  
HsiImage=zeros([size(H),3]);  

%RG Sector(0<=H<120)
B(H<120)=I(H<120).*(1-S(H<120));  
R(H<120)=I(H<120).*(1+((S(H<120).*cosd(H(H<120)))./cosd(60-H(H<120))));  
G(H<120)=3.*I(H<120)-(R(H<120)+B(H<120));  
  
%GB Sector(120<=H<240)
%Subtract 120 from H  
H2=H-120;  

R(H>=120&H<240)=I(H>=120&H<240).*(1-S(H>=120&H<240));  
G(H>=120&H<240)=I(H>=120&H<240).*(1+((S(H>=120&H<240).*cosd(H2(H>=120&H<240)))./cosd(60-H2(H>=120&H<240))));  
B(H>=120&H<240)=3.*I(H>=120&H<240)-(R(H>=120&H<240)+G(H>=120&H<240));  
   
%BR Sector(240<=H<=360)  
%Subtract 240 from H  
H2=H-240;  
    
G(H>=240&H<=360)=I(H>=240&H<=360).*(1-S(H>=240&H<=360));  
B(H>=240&H<=360)=I(H>=240&H<=360).*(1+((S(H>=240&H<=360).*cosd(H2(H>=240&H<=360)))./cosd(60-H2(H>=240&H<=360))));  
R(H>=240&H<=360)=3.*I(H>=240&H<=360)-(G(H>=240&H<=360)+B(H>=240&H<=360));  

%Form RGB Image  
HsiImage(:,:,1)=R;  
HsiImage(:,:,2)=G;  
HsiImage(:,:,3)=B;  
   
%HsiImage to range [0 255]
HsiImage = uint8(HsiImage * 255); 
end