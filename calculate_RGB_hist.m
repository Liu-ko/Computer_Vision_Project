function h = calculate_RGB_hist(pic)
    [rows, cols, z] = size(pic);
    h = zeros(1, 256, 3);
    for row = 1:rows
        for col = 1:cols
            red = pic(row, col, 1);
            green = pic(row, col, 2); 
            blue = pic(row, col, 3);
            h(1, red+1, 1) = h(1, red+1, 1)+1;
            h(1, green+1, 2) = h(1, green+1, 2)+1;
            h(1, blue+1, 3) = h(1, blue+1, 3)+1;
        end
    end
    for number = 1:256
        h(1, number, 1) = h(1, number, 1) / rows / cols;
        h(1, number, 2) = h(1, number, 2) / rows / cols;
        h(1, number, 3) = h(1, number, 3) / rows / cols;
    end
end