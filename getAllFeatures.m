%function which iterates through on an array of images and gets all of
%their features
function fmatrix = getAllFeatures(array)      
    fmatrix = [];
    for idx = 1:numel(array)
            matr = getFeatures(array{idx});
            C = [fmatrix; matr];
            fmatrix = C;
    end
end

            
            