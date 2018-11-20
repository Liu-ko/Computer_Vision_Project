function r = euclid(Th, Sh)
%target histogram, Source histograms
    [z, num] = size(Sh);
    r = zeros(1, num); 
    for i = 1:num
       r(i) = sqrt(sum((Th - Sh{i}).^ 2)); 
    end    
end