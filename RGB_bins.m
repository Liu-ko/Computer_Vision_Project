function h = RGB_bins(I)
    [rows, cols, z] = size(I);
    h = zeros(1,32^3+32^2+32);
    for row = 1:rows
        for col = 1:cols
            red = uint64(I(row, col, 1)/8);
            green = uint64(I(row, col, 2)/8); 
            blue = uint64(I(row, col, 3)/8);
            bin = red*32*32 + green*32 + blue;
            if bin < 1
                bin = 1;
            end
            h(bin) = h(bin) + 1;
        end
    end
    for bin = 1:32^3+32^2+32
        h(bin) = h(bin) / rows / cols;
    end
end