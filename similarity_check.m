function rez = similarity_check(A, T, hist)
    [aa, num] = size(A);
    %block sizes
    x = 25;
    y = 25;
    %get mean values
    means = cell(1, num);
    for z = 1:num
        means{z} = mean_calculation(A{z});
    end    
    
    aaa = zeros(1, num);
    for i = 1:40
        for j = 1:60
            that_piece = T((i-1)*x+1:i*x, (j-1)*y+1:j*y, :);
            piece_mean = mean_calculation(that_piece);  
            %piece_hist = calculate_RGB_hist(that_piece);
            %find the most similar mean
            for z = 1:num
                the_mean = means{z};
                %the_hist = hist{z};
                aaa(z) = sqrt(sum((piece_mean - the_mean).^ 2));
                
                %histogram shait
                %e1 = sum((piece_hist(:,:,1) - the_hist(:,:,1)).^ 2);                
                %e2 = sum((piece_hist(:,:,2) - the_hist(:,:,2)).^ 2);
                %e3 = sum((piece_hist(:,:,3) - the_hist(:,:,3)).^ 2);
                %aaa(z) = sqrt(e1+e2+e3);
            end    
            [val, index] = min(aaa);
            rez((i-1)*x+1:i*x, (j-1)*y+1:j*y, :) = A{index};
        end
    end
end