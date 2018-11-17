function y = prepare_images(imgs, tileX, tileY)
    % Make copy of image set
    y = imgs;
    % Gaussian
    % Resampling
    % Crop images
    for k = 1:length(y)
        y{k} = crop_img(y{k}, 0, 0, tileX, tileY);
    end
end