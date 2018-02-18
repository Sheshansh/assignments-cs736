function gradient = adaptive_gradient(a,b,gamma)
    absdiff = abs(a-b);
    gradient = gamma*(a-b)/absdiff - gamma*((a-b)./absdiff)./(1+absdiff/gamma);
end