function [A, hist, target, tar_hist] = set_me_up()
    %load the pictures
    A = filesRead("./Images/manmade_training/out_manmade_1k/");
    target = imread("./Images/mosaic_target1.jpg");
    
    % sizes
    pixX = 1000;
    pixY = 1500;
    blockX = 40;
    blockY = 60;
    
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
    
    A = a
    %get all the histograms
    [x, num] = size(A);
    hist = cell(1, num);
    for i = 1:num
        hist{i} = calculate_RGB_hist(A{i});
    end
    tar_hist = calculate_RGB_hist(target);
    
    clc;
    
end