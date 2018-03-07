function [ rrmse ] = RRMSE( s,r )
%Compute RRMSE
    rrmse = (s-r).^2;
    rrmse= sqrt(sum(rrmse(:)));
    rrmse = rrmse/sqrt(sum(s(:).^2));
end

