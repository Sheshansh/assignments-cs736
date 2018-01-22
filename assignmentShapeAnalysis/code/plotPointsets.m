function plotPointsets(pointSets,meanShape)
    for i = 1:size(pointSets,3)
        scatter(pointSets(1,:,i),pointSets(2,:,i),1);
        if i ~= size(pointSets,3)
            hold on;
        end
    end
    plot(meanShape(1,:),meanShape(2,:));
end