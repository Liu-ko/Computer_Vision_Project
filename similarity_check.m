function rez = similarity_check(T, S, means, bins, hog)
%target then sources
    [something, num] = size(S);
  
    rez = zeros(1, num);
        
    Img_mean = mean_calculation(T);  
    Img_bins = RGB_bins(T);
    Img_hog = extractHOGFeatures(T);
    %Img_texture = feature_box(T);
    
    aaa = euclid(Img_mean, means);
    bbb = euclid(Img_bins, bins);
    ccc = euclid(Img_hog, hog);
    %ddd = euclid(Img_texture, texture);
    
    rez = (aaa + bbb + ccc);

    %find the most similar mean
    %for z = 1:num
    %    the_mean = means{z};
        %the_hist = hist{z};
    %    rez(z) = sqrt(sum((Img_mean - the_mean).^ 2));
    %end    
end