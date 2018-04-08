function [ prob ] = computeProb(X,imageData,imageMask,beta,means,vars)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [m,n] = size(imageData);
    P = 0;
    for i =1:m
        for j=1:n
            if imageMask(i,j) == 0
                continue
            end
            x = X(i,j);
            P = P +  exp(-1*(1-beta)*((imageData(i, j) - means(x))^2)/(2*vars(x)))*exp(-1*beta*computePrior(X,x,i,j,imageMask));
        end
    end
    prob = P;
end

