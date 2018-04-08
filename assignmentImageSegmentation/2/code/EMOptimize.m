function [ X,memberships,means,vars ] = EMOptimize(X,imageData,imageMask,means,vars,beta,numClasses)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [s,t] = size(imageData);
    memberships = zeros(s,t,numClasses);
    for iter = 1:21
        %E step
        oldProb = computeProb(X,imageData,imageMask,beta,means,vars);
        X = getMapLabels(X,imageData,imageMask,means,vars,numClasses,beta);
        newProb = computeProb(X,imageData,imageMask,beta,means,vars);
        fprintf('Iter %d: Old Prob : %.4f, New Prob :%.4f\n',iter,log(oldProb),log(newProb));
        for i = 1:s
            for j = 1:t
                if imageMask(i,j) == 0
                    continue
                end
                m = zeros(numClasses,1);
                for k = 1:numClasses
                    m(k) = exp(-1*(1-beta)*((imageData(i,j)-means(k))^2)/(2 *vars(k)))* exp(-1*beta*computePrior(X,k,i,j,imageMask));
                end
                m = m./sum(m);
                memberships(i,j,:)= m;
            end
        end
        % M step
        for k=1:numClasses
            m = memberships(:,:,k);
            newMean = m.*imageData;
            newMean = sum(newMean(:));
            newMean = newMean/sum(m(:));
            
            newVar = (imageData - newMean).^2;
            newVar = newVar.*m;
            newVar = sum(newVar(:));
            newVar = newVar/sum(m(:));
            
            vars(k) = newVar;
            means(k) = newMean;
        end
       
    end

end

