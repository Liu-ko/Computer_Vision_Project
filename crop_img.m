%img = imread("D:\comp_vision\Computer_Vision_Project-master\images\sun_aabwvttncoffagty.jpg");

%creating function with input image and parameters
function y = crop_img(img, a, b, c, d)
    cropped_img = imcrop(img,[ a, b, c, d]);
   
    y = cropped_img;
end

