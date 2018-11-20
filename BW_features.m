function featureVec = BW_features(I)
%https://www.researchgate.net/post/How_can_a_histogram_be_used_for_feature_extraction
    glcm = graycomatrix(rgb2gray(I));
    temp = graycoprops(glcm);
    featureVec(1) = temp.Contrast;
    featureVec(2) = temp.Correlation;
    featureVec(3) = temp.Energy;
    featureVec(4) = temp.Homogeneity;
end