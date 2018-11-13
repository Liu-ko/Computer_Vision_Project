img = imread("D:\comp_vision\Computer_Vision_Project-master\images\sun_aabwvttncoffagty.jpg");

%set variables for cropping
a = 10;
b = 10;
c = 50;
d = 50;

cropped_img = imcrop(img,[ a, b, c, d]);
subplot(1,2,1)
imshow(img)
title("original")
subplot(1, 2, 2)
imshow(cropped_img)
title("cropped image")
