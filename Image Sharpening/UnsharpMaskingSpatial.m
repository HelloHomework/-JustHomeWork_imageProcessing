function ImageProcessed = UnsharpMaskingSpatial(Image)
  % size of image
    [x,y] = size(Image);
 
 % transform to int32
 ImageDouble = im2double(Image);
 ImageProcessed=zeros(x,y);
 % using 
    for i=2 : x-1
        for j=2 : y-1
            ImageProcessed(i, j) = ImageDouble(i, j) - ( 1 - (ImageDouble(i, j) + ...
            (ImageDouble(i, j) + ImageDouble(i-1, j-1) + ImageDouble(i-1, j) ...
            + ImageDouble(i-1, j+1) + ImageDouble(i, j-1) + ImageDouble(i, j+1) ...
            + ImageDouble(i+1, j-1) + ImageDouble(i+1, j) + ImageDouble(i+1, j+1))/9)); 
        end
    end

 % transform to uint8
 ImageProcessed = uint8(ImageProcessed.*255);
end


