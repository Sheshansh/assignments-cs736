function [X] = getMapLabels(X,imageData,imageMask,means,vars,numClasses,beta)
%getMapLabels Given parameters of the noise model, get the MAP labels
    [m,n] = size(imageData);
    for iter = 1:5
        newX= zeros(size(X,1),size(X,2));
        for i = 1:m
            for j=1:n
                if imageMask(i,j) == 0
                    continue
                end
                %Choose the best label for this pixel
                bestClass = -1;
                bestP = -1;
                for x = 1:numClasses
                    P =  exp(-1*(1-beta)*((imageData(i, j) - means(x))^2)/(2*vars(x)))*exp(-1*beta*computePrior(X,x,i,j,imageMask));
                    if P > bestP
                        bestP = P;
                        bestClass = x;
                    end
                end
                newX(i,j) = bestClass;
            end
        end
        X = newX;
    end

end

