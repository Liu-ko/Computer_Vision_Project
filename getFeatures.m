function [map, edgy] = getFeatures()
img = imread("D:\comp_vision\Images\mosaic_target1.jpg");
%get colormap
[i, map] =rgb2ind(img, 256);

%get HOG
hog = extractHOGFeatures(img);

%fourier transform
f = fft(img);

%local entropy of image (grayscale)
i = rgb2gray(img);
entr = entropyfilt(i);


%edge detection
i = rgb2gray(img);
edgy = edge(i, 'canny');
end