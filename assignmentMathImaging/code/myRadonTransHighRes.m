function rt = myRadonTransHighRes(image,step)
    rt = zeros(181,180);
    for i = 1:181
        for j = 1:180
            rt(i,j) = myIntegration(image,i-91,j-1,step);
        end
    end
end