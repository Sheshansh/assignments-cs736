function rrmse = RRMSE(noiseless,noisy)
    absnoiseless = abs(noiseless);
    absnoisy = abs(noisy);
    absdiffsq = (absnoiseless-absnoisy).^2;
    absnoiselesssq = absnoiseless.^2;
    rrmse = sqrt(sum(absdiffsq(:)))/sqrt(sum(absnoiselesssq(:)));
end