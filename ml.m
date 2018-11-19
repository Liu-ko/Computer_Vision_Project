% features  = matrix containing all features
% labels = array of labels
function m = ml(features, labels)
    %creating&training the ml model
    model = fitcknn(features,labels,'NumNeighbors',5,'Standardize',1, 'CrossVal', 'on');
    
end