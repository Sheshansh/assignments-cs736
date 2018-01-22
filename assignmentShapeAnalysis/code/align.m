function [ im1,im2 ] = align( raw_im1, raw_im2 )
%Given raw_im1 and raw_im2 it aligns the second image with the first one.
%This function assumes that their centroids are at (0,0)
%  raw_im1, raw_im2 are 2*32
%     c1 = sum(raw_im1,2)/size(raw_im1,2);
%     c2 = sum(raw_im2,2)/size(raw_im2,2);
%     c1 = repmat(c1, [1,size(raw_im1,2)]);
%     c2 = repmat(c2, [1,size(raw_im2,2)]);
%     im1 = raw_im1 - c1;
%     im2 = raw_im2 - c2;
    norm1 = sqrt(sum(sum(raw_im1.^2,2),1));
    norm2 = sqrt(sum(sum(raw_im2.^2,2),1));
    im1 = raw_im1./norm1;
    im2 = raw_im2./norm2;
    
    temp = im2*im1';
    [U,~,V] = svd(temp);
    R = V*U';
    if det(R) ~= 1
        I  = eye(size(R));
        I(end,end) = -1;
        R = V*I*U';
    end
    im2 = R*im2;
end