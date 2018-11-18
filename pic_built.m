function rez = pic_built(T, A, tileResX, tileResY, tileY, tileX)
    [aa, num] = size(A);
    %block sizes
    x = tileResX;
    y = tileResY;
    f = waitbar(0, "Generating mosaic");    
    for i = 1:tileX
        for j = 1:tileY
            disp("" + i + " " + j);
            that_piece = T((i-1)*x+1:i*x, (j-1)*y+1:j*y, :);
            aaa = similarity_check(that_piece, A);
            
            [val, index] = min(aaa);
            rez((i-1)*x+1:i*x, (j-1)*y+1:j*y, :) = A{index};
            waitbar((i*tileY+j)/(tileY * tileX), f, "Generating mosaic");
        end
    end
    close(f);
end