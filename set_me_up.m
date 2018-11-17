function [A, hist, target, tar_hist, manmade] = set_me_up()
    %load the pictures
    %A = filesRead("./Images/manmade_training/out_manmade_1k/");
    A = filesRead("D:/comp_vision/Computer_Vision_Project-master/images/out_manmade_1k/out_natural_1k/");
    %target = imread("./Images/mosaic_target1.jpg");
    target = imread("D:/comp_vision/Computer_Vision_Project-master/images/out_manmade_1k/sun_aabwvttncoffagty.jpg");
    
    %here we create an array of labels
    %we use 0 for "manmade" and 1 for "natural"
    manmade = zeros(size(A));
    %natural = ones(size(B));
   
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