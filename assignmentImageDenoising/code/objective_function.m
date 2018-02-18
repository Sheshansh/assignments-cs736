function objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,prior,gamma,sigma)
    objective_function_value = (1-alpha) *((abs(imageNoisy-x)).^2);
    for i = 1:4
        objective_function_value = objective_function_value + alpha*prior(x,shiftedmatrices(:,256*i-255:256*i),gamma);
    end
    objective_function_value = sum(objective_function_value(:));
end