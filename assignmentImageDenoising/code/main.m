%% Inputting data and setting parameters
load('../data/assignmentImageDenoisingPhantom.mat')
alpha = 0.95;
gamma = 0.1;
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];
x = imageNoisy;
tau = 0.01;

%% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma);
while tau > 1e-8
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@huber_gradient,gamma);
    x = x - tau*delta;
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic,gamma);
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    else
        tau = 1.1*tau;
    end
end


imshow(abs(x));
temp = (abs(x-imageNoiseless));
sum(temp(:))
    