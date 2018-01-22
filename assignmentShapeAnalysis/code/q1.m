mat = load('../data/ellipses2D.mat');
pointSets = mat.pointSets;
%% Plotting the pointsets

% plotPointsets(pointSets);
% figure;
%% Aligning the centroid of all pointsets to origin

centroids = sum(pointSets,2);
centroids = repmat(centroids,1,size(pointSets,2),1);
centroids = centroids./size(centroids,2);
pointSets = pointSets - centroids;

%% Now first aligning all pointsets to the first pointset and then finding mean

meanShape = findMeanShape(pointSets);

for i = 1:mat.numOfPointSets
    [meanShape,pointSets(:,:,i)] = align(meanShape,pointSets(:,:,i));
end

plotPointsets(pointSets,meanShape);
figure;

for i = 1:mat.numOfPointSets
    [meanShape,pointSets(:,:,i)] = align(meanShape,pointSets(:,:,i));
end

plotPointsets(pointSets);
figure;

meanShape = findMeanShape(pointSets,meanShape);