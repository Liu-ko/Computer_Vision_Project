
%creating function with input image and parameters for cropping
function y = crop_img(img, a, b, c, d)
    cropped_img = imcrop(img,[ a, b, c, d]);
   
    y = cropped_img;
end

