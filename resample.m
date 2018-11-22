function r = resample(i)

    %applying simple gaussian filter
    img = imgaussfilt(i);
    
    interpolant = griddedInterpolant(double(img));
    [sx, sy, sz] = size(img);
    nx = (0:5/3:sx)';
    ny = (0:5/3:sy)';
    nz = (1:sz)';
    nimg = uint8(interpolant({nx, ny, nz}));
    
%these were used just for testing,  that's why they are left here
    %figure
    %subplot(1, 2, 1);
    %imshow(img);
    %subplot(1, 2, 2);
    %imshow(nimg);
    
    %totpxi = numel(i);
    %totpximg = numel( nimg );
    %disp('input:');
    %disp(totpxi);
    %disp('output');
    %disp(totpximg);
    r = nimg;
end