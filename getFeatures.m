function matr = getFeatures(img) 

%get colormap
[i, map] =rgb2ind(img, 256);

%get HOG
hog = normalize(extractHOGFeatures(img));

%fourier transform
%f = fft(img);

%local entropy of image (grayscale)
%i = rgb2gray(img);
%entr = entropyfilt(i);


%edge detection
i = rgb2gray(img);
edgy = edge(i, 'canny');

sum = 0;
%for i = 1:numel(edgy)
%  
% 
    redChannel = img(:, :, 1);
    greenChannel = img(:, :, 2);
    blueChannel = img(:, :, 3);
    red = mean2(redChannel());
    green = mean2(greenChannel());
    blue = mean2(blueChannel());

bins= normalize(RGB_bins(img));
%matr = [hog bins red green blue];

e = transpose(edgy(:));

matr = [e hog red green blue bins];
end