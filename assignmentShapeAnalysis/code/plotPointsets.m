function plotPointsets(pointSets)
    for i = 1:size(pointSets,3)
        scatter(pointSets(1,:,i),pointSets(2,:,i),1);
        hold on;
    end
end