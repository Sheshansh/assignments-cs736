function rrmse = RRMSE(original_image,reconstructed_image)
    diffsq = (original_image-reconstructed_image).^2;
    origsq = original_image.^2;
    rrmse = sqrt(sum(diffsq(:)))/sqrt(sum(origsq(:)));
end