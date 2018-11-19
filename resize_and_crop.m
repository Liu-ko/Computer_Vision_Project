function y = resize_and_crop(i, tileX, tileY)
    y = i;
    
    % determine image dimensions
    imgX = size(i, 2);
    imgY = size(i, 1);
    
    IAR = tileX / tileY; % calculate intended aspect ratio of a tile
    SAR = imgX / imgY; % calculate current aspect ratio of the source image
    
    % does the image need to be cropped along the x-axis or y-axis?
    if SAR > IAR
        % x-axis needs cropped
        % resize image so that y-axis fits into the size of a tile
        y = imresize(i, [tileY, (tileY * SAR)]);
    else
        % y-axis needs cropped
        % resize image so that X-axis fits into the size of a tile
        y = imresize(i, [(tileX / SAR), tileX]);
    end
    
    % crop image to size of tile
    y = crop_img(y, 0, 0, tileX, tileY);
end