function [integration] = myIntegration(image,t,theta,step)
%     Assuming the image dimensions would be 128*128
    s = -100:step:100;
    x = t*cosd(theta)-s*sind(theta)+64;
    y = t*sind(theta)+s*cosd(theta)+64;
    values = interp2(image,x,y); % Bilinear is fast
    values(isnan(values)) = 0;
    integration = sum(values)*step;
end