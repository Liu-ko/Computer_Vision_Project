function rez = pic_built(T, A, tileResX, tileResY, tileX, tileY)
    [aa, num] = size(A);
    %block sizes
    x = tileResX;
    y = tileResY;
    
    %get values: mean color, rgb historgam via bins, HOG 
    means = cell(1, num);
    bins = cell(1, num);
    hog = cell(1, num);
    for z = 1:num
        means{z} = mean_calculation(A{z});
        bins{z} = RGB_bins(A{z});
        hog{z} = extractHOGFeatures(A{z});
    end  
    
    f = waitbar(0, "Generating composite image");    
    for i = 1:tileX
        for j = 1:tileY
            %disp("" + i + " " + j);
            that_piece = T((i-1)*x+1:i*x, (j-1)*y+1:j*y, :);
            similarity_values = similarity_check(that_piece, A, means, bins, hog);
            
            [val, index] = min(similarity_values);
            rez((i-1)*x+1:i*x, (j-1)*y+1:j*y, :) = A{index};
            %waitbar((i*tileY+j)/(tileY * tileX), f, "Generating mosaic");
        end
        waitbar(i/tileX, f, "Generating composite image");
    end
    close(f);
end