function result =  MySobol(OriginalImage)

[x,y] = size(OriginalImage);

%pading image
Image = zeros(x+2,y+2,"uint16");
for i = 1:x
    for j=1:y
        Image(i+1,j+1) = OriginalImage(i,j);
    end
end

gx = zeros(x,y,"uint16");
gy = zeros(x,y,"uint16");
gxy = zeros(x,y,"uint16");
gyx = zeros(x,y,"uint16");
result = zeros(x,y,"uint16");

for i = 2:(x+1)
    for j= 2:(y+1)
        gx(i-1,j-1) = (Image(i+1,j-1) + 2*Image(i+1,j) + Image(i+1,j+1)) - ...
            (Image(i-1,j-1) + 2*Image(i-1,j) + Image(i+1,j-1));
        gy(i-1,j-1) = (Image(i-1,j+1) + 2*Image(i,j+1) + Image(i+1,j+1)) - ...
            (Image(i+1,j-1) + 2*Image(i,j-1) + Image(i+1,j-1));
        gxy(i-1,j-1) = (Image(i-1,j) + 2*Image(i-1,j+1) + Image(i+1,j)) - ...
            (Image(i,j-1) + 2*Image(i+1,j-1) + Image(i+1,j));
        gyx(i-1,j-1) = (Image(i-1,j) + 2*Image(i-1,j-1) + Image(i,j-1)) - ...
            (Image(i+1,j) + 2*Image(i+1,j+1) + Image(i,j+1));
        result(i-1,j-1) = gx(i-1,j-1) + gy(i-1,j-1) + gxy(i-1,j-1) + gyx(i-1,j-1);
    end
end

result = uint8(result/4);

end
