function h = RGB_bins(I)
    [rows, cols, z] = size(I);
    h = zeros(1,16^3+16^2+16);
    for row = 1:rows
        for col = 1:cols
            red = uint64(I(row, col, 1)/16);
            green = uint64(I(row, col, 2)/16); 
            blue = uint64(I(row, col, 3)/16);
            bin = red*16*16 + green*16 + blue;
            if bin < 1
                bin = 1;
            end
            h(bin) = h(bin) + 1;
        end
    end
    for bin = 1:16^3+16^2+16
        h(bin) = h(bin) / rows / cols;
    end
end