function features = feature_box(I)
   a = rgb2gray(I);
   features = extractLBPFeatures(a,'Upright',false);
end