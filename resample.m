function r = resample()
i = imread("D:\comp_vision\Computer_Vision_Project-master\images\out_manmade_1k\out_natural_1k\sun_adttjkmojmfrsozw.jpg");

    img = imgaussfilt(i);
    interpolant = griddedInterpolant(double(img))
    [sx, sy, sz] = size(img)
    nx = (0:5/3:sx)';
    ny = (0:5/3:sy)';
    nz = (1:sz)';
    nimg = uint8(interpolant({nx, ny, nz}));
   
    %nimg = imadjust(nimg,[0.6, 0.7], [0.7, .95]);
    
    %nimg = crop_img(nimg,0, 10, 200, 190);
    %figure
    %subplot(1, 2, 1);
    %imshow(img);
    %subplot(1, 2, 2);
    %imshow(nimg);
    
    totpxi = numel(i);
    totpximg = numel( nimg );
    disp('input:');
    disp(totpxi);
    disp('output');
    disp(totpximg);
    r = nimg;
end