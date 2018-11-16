function rez = pic_built(T, A)
    [aa, num] = size(A);
    %block sizes
    x = 25;
    y = 25;  
    for i = 1:40
        for j = 1:60
            that_piece = T((i-1)*x+1:i*x, (j-1)*y+1:j*y, :);
            aaa = similarity_check(that_piece, A);
            
            [val, index] = min(aaa);
            rez((i-1)*x+1:i*x, (j-1)*y+1:j*y, :) = A{index};
        end
    end
end