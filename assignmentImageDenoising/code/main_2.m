%% Inputting data and setting parameters
clear;
clc;
load('../data/assignmentImageDenoisingBrainNoisy.mat')

sample = abs(imageNoisy(1:50,1:50));
sigma = std(sample(:));
fprintf('The noise level in the image is %.4f\n',sigma);
%% Quadratic Prior
x = imageNoisy;
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];
tau = 0.000001;
alpha = 0.3;
gamma = 0; % dummy
iterations = 0;
% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic,gamma,sigma);
diff = 100;
values = [];
while diff > 1e-90 || iterations < 300
    shiftedmatrices = [circshift(x,1,2),circshift(x,-1,2),circshift(x,1,1),circshift(x,-1,1)];
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic_gradient,gamma,sigma);
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic,gamma,sigma);
    diff = abs(objective_function_value_old - objective_function_value)/objective_function_value_old;
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    elseif objective_function_value < objective_function_value_old
        tau = 1.1*tau;
    end
    x = x - tau*delta;
    values  = [values objective_function_value];
    iterations = iterations + 1;
end
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_quad.mat','x');

%% Huber Prior
x = imageNoisy;
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];
tau = 0.000001;
alpha = 0.95;
gamma = 0.006;
iterations = 0;
% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma,sigma);
diff = 100;
values = [];
while diff > 1e-90 || iterations < 300
    shiftedmatrices = [circshift(x,1,2),circshift(x,-1,2),circshift(x,1,1),circshift(x,-1,1)];
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@huber_gradient,gamma,sigma);
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma,sigma);
    diff = abs(objective_function_value_old - objective_function_value)/objective_function_value_old;
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    elseif objective_function_value < objective_function_value_old
        tau = 1.1*tau;
    end
    x = x - tau*delta;
    values  = [values objective_function_value];
    iterations = iterations + 1;
end
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_huber.mat','x');
%% Discontinuity Adaptive Prior
x = imageNoisy;
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];
tau = 0.000001;
alpha = 0.99;
gamma = 0.0015;
iterations = 0;
% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma,sigma);
diff = 100;
values = [];
while diff > 1e-90 || iterations < 300
    shiftedmatrices = [circshift(x,1,2),circshift(x,-1,2),circshift(x,1,1),circshift(x,-1,1)];
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@huber_gradient,gamma,sigma);
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma,sigma);
    diff = abs(objective_function_value_old - objective_function_value)/objective_function_value_old;
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    elseif objective_function_value < objective_function_value_old
        tau = 1.1*tau;
    end
    x = x - tau*delta;
    values  = [values objective_function_value];
    iterations = iterations + 1;
end
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_adaptive.mat','x');
