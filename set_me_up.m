function [A, hist, target, tar_hist, manmade] = set_me_up(target_image, manmade_source_images, natural_source_images, resX, resY, tileX, tileY)
    %load the pictures
    A = manmade_source_images;
    B = natural_source_images;
    target = imread(target_image);
    
    %here we create an array of labels
    %we use 0 for "manmade" and 1 for "natural"
    manmade = zeros(size(A));
    natural = ones(size(B));
   
    % sizes
    pixX = resX;
    pixY = resY;
    blockX = tileX;
    blockY = tileY;
    
    %block sizes
    x = pixX/blockX;
    y = pixY/blockY;
    
    %resize all the images
    target = imresize(target, [pixX, pixY]);
    [aa, num] = size(A);
    a = cell(1, num);
    for i = 1:num
        a{i} = imresize(A{i}, [x, y]); 
    end
    
    A = a;
    %get all the histograms
    [x, num] = size(A);
    hist = cell(1, num);
    for i = 1:num
        hist{i} = calculate_RGB_hist(A{i});
    end
    tar_hist = calculate_RGB_hist(target);
    
    clc;
    
end