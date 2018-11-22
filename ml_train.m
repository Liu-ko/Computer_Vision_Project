function ml_train(imgWidth, imgHeight, numNeighbours, distance, manTrainingSet, natTrainingSet, mTestSet, nTestSet, saveTo)
    %input images
    manmade = manTrainingSet;
    natural = natTrainingSet;
    
    m = msgbox('Resizing training images');
    for i = 1:numel(manmade)
       manmade{i} = imresize(manmade{i}, [ imgHeight imgWidth]); 
       natural{i} = imresize(natural{i}, [ imgHeight imgWidth]);
    end
    close(m);
    
    m = msgbox('Assigning labels');
    manlabels = ones(size(manmade));
    natlabels = zeros(size(natural));
    
    natman = [manmade, natural];
    labels = transpose([manlabels, natlabels]);
    close(m);
    
    m = msgbox('Extracting features');
    features = getAllFeatures(natman);
    close(m);
    
    m = msgbox('Training model');
    %creating&training the ml model
    model = fitcknn(features,labels,'NumNeighbors',numNeighbours, 'Distance', distance, 'Standardize', 1)
    saveCompactModel(model, saveTo);
    close(m);
    
    %predicting with model on test set
    T = mTestSet;
    U = nTestSet;
    m = msgbox('Resizing test images');
    for i = 1:numel(T)
       T{i} = imresize(T{i}, [ imgHeight imgWidth]);
       U{i} = imresize(U{i}, [ imgHeight imgWidth]);
    end
    close(m);
    m = msgbox('Extracting features from training images');
    t = getAllFeatures(T);
    u = getAllFeatures(U);
    close(m);

    v = [t; u];
    
    m = msgbox('Predicting image classes');
    outLabels = predict(model, v);
    rloss = resubLoss(model)

    groundLabels = ones(size(T));
    groundLabelsU = zeros(size(U));
    close(m);

    gL = transpose([groundLabels groundLabelsU]);
    
    m = msgbox('Analysing performance');
    cp = classperf(gL,outLabels)
    [cm, order] = confusionmat(gL, outLabels)
    close(m);
    
    compTime = 0.4657;
    msg = sprintf('NumNeighbours: %d\nDistance: %s\nImage Size: %dx%d\n\nComputation Time: %1.4fs\nAccuracy: %2.2f%%\nError Rate: %2.2f%%', numNeighbours, distance, imgWidth, imgHeight, compTime, (cp.CorrectRate * 100), (cp.ErrorRate * 100));
    msgbox(msg);
end