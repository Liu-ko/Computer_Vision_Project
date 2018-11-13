%img = imread("D:\comp_vision\Computer_Vision_Project-master\images\sun_aabwvttncoffagty.jpg");

%creating function with input image and parameters
function crop_img(img, a, b, c, d)
    cropped_img = imcrop(img,[ a, b, c, d]);
    subplot(1,2,1)
    imshow(img)
    title("original")
    subplot(1, 2, 2)
    imshow(cropped_img)
    title("cropped image")
end

