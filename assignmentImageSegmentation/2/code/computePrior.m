function [prior] = computePrior( X, x, i, j, imageMask)
    prior = 0;
    if imageMask(i - 1, j) == 1
        prior = prior + (X(i - 1, j) ~= x);
    end;
    if imageMask(i + 1, j) == 1
        prior = prior + (X(i + 1, j) ~= x);
    end;
    if imageMask(i, j - 1) == 1
        prior = prior + (X(i, j - 1) ~= x);
    end;
    if imageMask(i, j + 1) == 1
        prior = prior + (X(i, j + 1) ~= x);
    end;
end
