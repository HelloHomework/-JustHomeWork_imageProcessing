function result =  MyLoG(OriginalImage)

[x,y] = size(OriginalImage);

%pading image
Image = zeros(x+2*2,y+2*2,"uint16");
for i = 1:x
    for j=1:y
        Image(i+2,j+2) = OriginalImage(i,j);
    end
end

result = zeros(x,y,"uint16");

for i = 3:(x)
    for j= 3:(y)
        result(i-2,j-2) = 16 * Image(i,j) ...
            - 2 * (Image(i+1,j) + Image(i-1,j) + Image(i,j-1) + Image(i,j+1)) ...
            - (Image(i+1,j+1) + Image(i+1,j-1) + Image(i-1,j+1) + Image(i-1,j-1)) ...
            - (Image(i+2,j) + Image(i-2,j) + Image(i,j+2) + Image(i,j-2));
    end
end
result = uint8(result);

end
