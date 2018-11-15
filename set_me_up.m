function [A, hist, target, tar_hist] = set_me_up()
    %load the pictures
    A = filesRead("./Images/manmade_training/out_manmade_1k/");
    target = imread("./Images/mosaic_target1.jpg");
    
    %get all the histograms
    [x, num] = size(A);
    hist = cell(1, num);
    for i = 1:num
        hist{i} = calculate_RGB_hist(A{i});
    end
    tar_hist = calculate_RGB_hist(target);
    
    clc
end