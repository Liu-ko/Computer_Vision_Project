function h = calculate_BW_hist(pic)
    pic = rgb2gray(pic);
    [rows, cols] = size(pic);
    h = zeros(1,256);
    for row = 1:rows
        for col = 1:cols
            number = pic(row, col);
            h(number+1) = h(number+1)+1;
        end
    end
    for number = 1:256
        h(number) = h(number) / rows / cols;
    end
end