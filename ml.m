% features  = matrix containing all features
% labels = array of labels
function m = ml(labels)
    [map, edgy] = getFeatures();
    sizem = size(map);
    sizee = size(edgy);
    if sizee > sizem
        e = edgy;
        m = zeros(size(edgy));
        
        for idx = 1:numel(map)
            el = m(idx);
        end    
    elseif sizem > sizee
        e = zeros(size(map));
        m = map;
        
        for idx = 1:numel(edgy)
            el = e(idx);
        end
   
    %creating&training the ml model
    model = fitcknn([m, e],labels,'NumNeighbors',5,'Standardize',1, 'CrossVal', 'on');
    
end