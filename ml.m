% features  = matrix containing all features
% labels = array of labels
function m = ml(labels)
    %input images
    manmade = filesRead(".\Images\out_manmade_1k\");
    natural = filesRead(".\Images\out_natural_1k\");
    
    for i = 1:numel(manmade)
       manmade{i} = imresize(manmade{i}, [ 50 50]); 
       natural{i} = imresize(natural{i}, [ 50 50]);
    end    
    
    manlabels = ones(size(manmade));
    natlabels = zeros(size(natural));
    mFeatures = getAllFeatures(manmade);
    nFeatures = getAllFeatures(natural);
    
    natman = [manmade, natural];
    labels = [manlabels, natlabels];
    
    features = getAllFeatures(natman);
%     sizem = size(map);
%     sizee = size(edgy);
%     if sizee > sizem
%         e = edgy;
%         m = NaN(size(edgy));
%         
%         for idx = 1:numel(map)
%             el = m(idx);
%         end    
%     elseif sizem > sizee
%         e = NaN(size(map));
%         m = map;
%         
%         for idx = 1:numel(edgy)
%             el = e(idx);
%         end
%     end
   disp("ml start")
    %creating&training the ml model
    model = fitcknn(features,transpose(labels),'NumNeighbors',5,'Standardize',1, 'CrossVal', 'on')
    
end