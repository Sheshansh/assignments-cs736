function [X,means,vars ] = initLabels(imageData,imageMask,numClasses )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
X = zeros(size(imageData));
pos = imageMask == 1;
minI = min(imageData(pos));
maxI = max(imageData(pos));
h  = (maxI - minI)/numClasses;
a = minI;
X(imageData == a) = 1;
for i =1 :numClasses
     pos = and(imageData > a,imageData <= a+h);
     pos = and(pos, imageMask == 1);
     X(pos) = i;
     a = a+h;
end
means = zeros(1,numClasses);
vars = zeros(1,numClasses);
for i=1:numClasses
    means(i) = mean(imageData(X == i));
    vars(i) = var(imageData(X==i));
end

end

