function resample()
i = imread("D:\comp_vision\Computer_Vision_Project-master\images\sun_aabwvttncoffagty.jpg");

    img = imgaussfilt(i);
    interpolant = griddedInterpolant(double(img))
    [sx, sy, sz] = size(img)
    nx = (0:5/6:sx)';
    ny = (0:5/6:sy)';
    nz = (1:sz)';
    nimg = uint8(interpolant({nx, ny, nz}));
    figure
    subplot(1, 2, 1);
    imshow(img);
    subplot(1, 2, 2);
    imshow(nimg);
    
    totpxi = numel(i);
    totpximg = numel( nimg );
    disp('input:')
    disp(totpxi)
    disp('output')
    disp(totpximg)
end