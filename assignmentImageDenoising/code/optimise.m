function [values,x] = optimise(alpha,gamma,x,imageNoisy,shiftedmatrices,prior,prior_gradient)
    tau = 0.000001;
    sigma = 1;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,prior,gamma,sigma);
    values = [];
    diff = 100;
    iterations = 0;
    while iterations < 300
        shiftedmatrices = [circshift(x,1,2),circshift(x,-1,2),circshift(x,1,1),circshift(x,-1,1)];
        delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,prior_gradient,gamma,sigma);
        objective_function_value_old = objective_function_value;
        objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,prior,gamma,sigma);
        diff = abs(objective_function_value_old - objective_function_value)/objective_function_value_old;
        if objective_function_value > objective_function_value_old
            tau = 0.5*tau;
        elseif objective_function_value < objective_function_value_old
            tau = 1.1*tau;
        end
        x = x - tau*delta;
        values  = [values log(objective_function_value)];
        iterations = iterations + 1;
    end
end