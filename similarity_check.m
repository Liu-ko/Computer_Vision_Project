function rez = similarity_check(I, T)
    [something, num] = size(T);
  
    rez = zeros(1, num);
        
    %get mean values
    means = cell(1, num);
    for z = 1:num
        means{z} = mean_calculation(T{z});
    end  
    I_mean = mean_calculation(I);  
    
    %piece_hist = calculate_RGB_hist(that_piece);
    %find the most similar mean
    for z = 1:num
        the_mean = means{z};
        %the_hist = hist{z};
        rez(z) = sqrt(sum((I_mean - the_mean).^ 2));

        %histogram shait
        %e1 = sum((piece_hist(:,:,1) - the_hist(:,:,1)).^ 2);                
        %e2 = sum((piece_hist(:,:,2) - the_hist(:,:,2)).^ 2);
        %e3 = sum((piece_hist(:,:,3) - the_hist(:,:,3)).^ 2);
        %aaa(z) = sqrt(e1+e2+e3);
    end    
end