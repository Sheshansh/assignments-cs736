function plotPointsets(pointSets)
    for i = 1:size(pointSets,3)
        if size(pointSets,1)==2
            scatter(pointSets(1,:,i),pointSets(2,:,i),1);
        else
            scatter3(pointSets(1,:,i),pointSets(2,:,i),pointSets(3,:,i),1);
        end
        hold on;
    end
end