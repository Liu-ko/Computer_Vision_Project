% features  = matrix containing all features
% labels = array of labels
function m = ml()
    %input images
    manmade = filesRead('.\Images\manmade_training\out_manmade_1k\');
    natural = filesRead('.\Images\natural_training\out_natural_1k\');

    %setting image size
    %180x180 produced the best results, so:
    s = 180;
    
    %resizing images for training
    for i = 1:numel(manmade)
       manmade{i} = imresize(manmade{i}, [ s s]); 
       natural{i} = imresize(natural{i}, [ s s]);
    end    
    
    %setting labels for classes
    manlabels = ones(size(manmade));
    natlabels = zeros(size(natural));
    
    %mergin manmade image and natural image layer array
    natman = [manmade, natural];
    labels = transpose([manlabels, natlabels]);
    
    %getting features of images
    features = getAllFeatures(natman);
    
    %just so we see when training starts
   disp("ml start")
   
    %creating&training the ml model
    model = fitcknn(features,labels,'NumNeighbors',20, 'Standardize', 1, 'Distance', 'cosine')
    
    %predicting with model on test set
    %setting everything up in the same way as we've done for training
            T = filesRead('.\Images\manmade_test\out_manmade_1k\');
            U = filesRead('.\Images\natural_test\out_natural_1k\');
            for i = 1:numel(T)
                %images for prediction need to be at the same size as the
                %images used for training so use s
               T{i} = imresize(T{i}, [ s s]);
               U{i} = imresize(U{i}, [ s s]);
            end
    %get features of test image sets
            t = getAllFeatures(T);
            u = getAllFeatures(U);
    %then merge them into one
            v = [t; u];
            
    %predicting classes of test images, so we can analyse results
            outLabels = predict(model, v);

    %generating ground truth labels for test folders
            groundLabels = ones(size(T));
            groundLabelsU = zeros(size(U));

    %merging ground truth labels 
            gL = transpose([groundLabels groundLabelsU]);
            
    %get performance of classifier 
            cp = classperf(gL,outLabels)
            
    %get confusion matrix
            [cm, order] = confusionmat(gL, outLabels)
end