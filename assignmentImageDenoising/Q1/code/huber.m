function priorloss = huber(a,b,gamma)
    absdiff = abs(a-b);
    priorloss = zeros(size(a));
    priorloss(absdiff>gamma) = gamma*absdiff(absdiff>gamma) - 0.5*(gamma^2);
    priorloss(absdiff<=gamma) = 0.5*((absdiff(absdiff<=gamma)).^2);
end