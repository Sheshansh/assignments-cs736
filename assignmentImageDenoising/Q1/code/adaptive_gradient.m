function gradient = adaptive_gradient(a,b,gamma)
    absdiff = abs(a-b);
    gradient = gamma*sign(a-b) - gamma*sign(a-b)./(1+absdiff/gamma);
end