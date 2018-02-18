function delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,prior_gradient,gamma,sigma)
    delta = 2.0*(1-alpha)*(x-imageNoisy);
    for i=1:4
        delta = delta + alpha*prior_gradient(x,shiftedmatrices(:,256*i-255:256*i),gamma);
    end
end