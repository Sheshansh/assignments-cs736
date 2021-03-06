function gradient = huber_gradient(a,b,gamma)
    absdiff = abs(a-b);    
    h = zeros(size(a));
    h(absdiff>gamma) = gamma./(2*absdiff(absdiff>gamma));
    h(absdiff<=gamma) = 0.5;
    gradient = 2.*(a-b).*h;
end