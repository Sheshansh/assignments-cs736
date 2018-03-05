function rt = myRadonTrans(image,step)
    rt = zeros(37,36);
    for i = 1:37
        for j = 1:36
            rt(i,j) = myIntegration(image,i*5-95,j*5-5,step);
        end
    end
end