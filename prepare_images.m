function y = prepare_images(imgs, tileX, tileY)
    % Make copy of image set
    y = imgs;
    f = waitbar(0, "Preparing images");
    for k = 1:length(y)
        % Resampling
        y{k} = resample(y{k});
        % Resize and crop images
        %y{k} = crop_img(y{k}, 0, 0, tileX, tileY);
        y{k} = resize_and_crop(y{k}, tileX, tileY);
        waitbar(k/length(y), f, "Preparing images");
    end
    close(f);
end