function means = mean_calculation(Img)
%https://uk.mathworks.com/matlabcentral/answers/346161-finding-the-mean-color-of-image-segment
    % Extract the individual red, green, and blue color channels.
    redChannel = Img(:, :, 1);
    greenChannel = Img(:, :, 2);
    blueChannel = Img(:, :, 3);
    % Get means
    means = zeros(1, 1, 3);
    means(1, 1, 1) = mean2(redChannel());
    means(1, 1, 2) = mean2(greenChannel());
    means(1, 1, 3) = mean2(blueChannel());
end