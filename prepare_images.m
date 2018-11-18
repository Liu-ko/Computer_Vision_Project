function y = prepare_images(imgs, tileX, tileY)
    % Make copy of image set
    y = imgs;
    f = waitbar(0, "Preparing images");
    for k = 1:length(y)
        % Resampling
        y{k} = resample(y{k});
        % Crop images
        y{k} = crop_img(y{k}, 0, 0, tileX, tileY);
        waitbar(k/length(y), f, "Preparing images");
    end
    close(f);
end