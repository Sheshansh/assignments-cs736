function priorloss = quadratic(a,b,~)
    priorloss = abs(a-b).^2;
end