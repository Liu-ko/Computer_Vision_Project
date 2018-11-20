function b = find_largest(image_set)
    max_area = 0;
    max_index = 0;
    I = image_set;
    
    for k = 1:length(I)
        x = size(I{k}, 2);
        y = size(I{k}, 1);
        area = x * y;
        if area > max_area
            max_area = area;
            max_index = k;
        end
    end
    
    % make a histogram
    [map, edgy] = getFeatures();
    [N,edges,bin] = histcounts(edgy,'BinMethod','integers');
    
    b = N;
end