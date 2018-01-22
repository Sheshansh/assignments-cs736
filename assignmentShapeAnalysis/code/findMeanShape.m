function meanShape = findMeanShape(pointSets)
    meanShape = mean(pointSets,3);
    meanShape = meanShape./sum(sum(meanShape.^2,2),1)
end