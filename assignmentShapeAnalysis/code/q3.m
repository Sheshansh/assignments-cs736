clear;
mat = load('../data/bone3D.mat');
pointSets = mat.shapesTotal;
triIndices = mat.TriangleIndex;
mean_diff_threshold = 1e-31;
tic;
%% Plotting the initial pointsets

figure;
plotPointsets(pointSets);
title('Initial pointsets')

%% Aligning the centroid of all pointsets to origin

centroids = sum(pointSets,2);
centroids = repmat(centroids,1,size(pointSets,2),1);
centroids = centroids./size(centroids,2);
pointSets = pointSets - centroids;

%% Doing the alternate minimisation of Procrustes distance wrt scale and rotation until there is no significant change

meanShape = findMeanShape(pointSets);
oldmeanShape = zeros(size(meanShape));

numiterations = 0;

while sum(sum((oldmeanShape-meanShape).^2)) > mean_diff_threshold

    for i = 1:size(pointSets,3)
        [temp,pointSets(:,:,i)] = align(meanShape,pointSets(:,:,i));
    end

    oldmeanShape = meanShape;
    meanShape = findMeanShape(pointSets);
    
    numiterations = numiterations + 1;
end

figure;

%% Plotting the pointsets along with the computed mean shape

trimesh(triIndices,meanShape(1,:),meanShape(2,:),meanShape(3,:));hold on;
plotPointsets(pointSets);
title('Aligned pointsets and mean shape')

%% Finding the principal modes of variation and plotting the variances along modes of variation, note that only a very.few modes are significant enough.

flatpointSet = reshape(pointSets,size(pointSets(),1)*size(pointSets(),2),size(pointSets(),3));
[V,D] = eig(cov(flatpointSet'));
figure;
plot(diag(D));
title('variances along modes of variation sorted in increasing order')
ylabel('eigenvalue')
xlabel('modes')

%% Plotting the mean shape, aligned pointsets along with principal modes of variation (+- 2 sigma)
tweak = meanShape+2*sqrt(D(end,end))*reshape(V(:,end),size(pointSets,1),size(pointSets,2));
[~,tweak] = align(meanShape, tweak);
figure;

trimesh(triIndices,tweak(1,:),tweak(2,:),tweak(3,:),'EdgeColor' , [1 0 0]);hold on;
trimesh(triIndices,meanShape(1,:),meanShape(2,:),meanShape(3,:),'EdgeColor' , [0 1 0]);hold on;
tweak = meanShape-2*sqrt(D(end,end))*reshape(V(:,end),size(pointSets,1),size(pointSets,2));
[~,tweak] = align(meanShape, tweak);
trimesh(triIndices,tweak(1,:),tweak(2,:),tweak(3,:),'EdgeColor' , [0 0 1]);hold on;
plotPointsets(pointSets);
title('Aligned pointsets, mean shape and principal mode of variation')
legend('mean+2*SD','mean','mean-2*SD')

toc;