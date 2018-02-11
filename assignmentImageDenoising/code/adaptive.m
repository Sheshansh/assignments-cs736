function priorloss = adaptive(a,b,gamma)
    absdiff = abs(a-b);
    priorloss = gamma*absdiff - (gamma^2)*log(1+absdiff/gamma);
end