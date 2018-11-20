function fmatrix = getAllFeatures(array)      
    fmatrix = [];
    for idx = 1:numel(array)
            matr = getFeatures(array{idx});
            C = [fmatrix; matr];
            fmatrix = C;
    end
end

            
            