function ImageProcessed = LaplacianSpatial(Image)
  % transform image to gray level bitmap
    [x,y] = size(Image);
    n = x * y; % n is the total number of pixels in the image
 % transform bitmap form double to int ( range:1-256 )
    for i = 1 : x
        for j = 1 : y
            ImageInt(i, j) = uint32(Image(i, j));
        end
    end
    ImageProcessed=zeros(i,j);
 % using filter [0,1,0;1,-4,1;0,1,0]
    for i=2 : x-1
        for j=2 : y-1
            ImageProcessed(i, j) = uint32(5 * ImageInt(i, j) - ImageInt(i-1, j) - ImageInt(i, j-1) - ImageInt(i+1, j) - ImageInt(i+1, j) ); 
        end
    end

    ImageInt = uint8(ImageInt);
    ImageProcessed = uint8(ImageProcessed);
end


