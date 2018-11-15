function rez = similarity_check(A, T, hist)
    T = imresize(T, [1000, 1500]);
    rez = T;
    
    %block 40x60
    x = 25;
    y = 25;
    
    %resize all the source images
    [aa, num] = size(A);
    a = cell(1, num);
    for i = 1:num
        a{i} = imresize(A{i}, [x, y]);  
        %a{i} = crop_image(A{i})
    end
    
    %get mean values
    means = cell(1, num);
    for z = 1:num
        means{z} = mean_calculation(a{z});
    end    
    
    aaa = zeros(1, num);
    for i = 1:40
        for j = 1:60
            that_piece = T((i-1)*x+1:i*x, (j-1)*y+1:j*y, :);
            piece_mean = mean_calculation(that_piece);  
            piece_hist = calculate_RGB_hist(that_piece);
            %find the most similar mean
            for z = 1:num
                the_mean = means{z};
                the_hist = hist{z};
                aaa(z) = sqrt(sum((piece_mean - the_mean).^ 2));
                %aaa(z) = sqrt(sum((piece_hist - the_hist).^ 2));
            end    
            [val, index] = min(aaa);
            rez((i-1)*x+1:i*x, (j-1)*y+1:j*y, :) = a{index};
        end
    end
end