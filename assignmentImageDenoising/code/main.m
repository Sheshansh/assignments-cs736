%% Inputting data and setting parameters
load('../data/assignmentImageDenoisingPhantom.mat')
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];
x = imageNoisy;
tau = 0.01;

% %% Quadratic loss
% alpha = 0.61;
% gamma = 0; % dummy
% 
% % Optimisation
% objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic,gamma);
% while tau > 1e-8
%     delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic_gradient,gamma);
%     x = x - tau*delta;
%     objective_function_value_old = objective_function_value;
%     objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@quadratic,gamma);
%     if objective_function_value > objective_function_value_old
%         tau = 0.5*tau;
%     else
%         tau = 1.1*tau;
%     end
% end
% 
% subplot(1,2,1), imshow(real(x));
% subplot(1,2,2), imshow(real(imageNoisy));
% temp = (abs(x-imageNoiseless));
% sum(temp(:))
% 
% %% Huber loss
% alpha = 0.93;
% gamma = 0.008;
% 
% % Optimisation
% objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma);
% while tau > 1e-8
%     delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@huber_gradient,gamma);
%     x = x - tau*delta;
%     objective_function_value_old = objective_function_value;
%     objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma);
%     if objective_function_value > objective_function_value_old
%         tau = 0.5*tau;
%     else
%         tau = 1.1*tau;
%     end
% end
% 
% subplot(1,2,1), imshow(real(x));
% subplot(1,2,2), imshow(real(imageNoisy));
% temp = (abs(x-imageNoiseless));
% sum(temp(:))

%% Adaptive loss
alpha = 0.93;
gamma = 0.008;

% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive,gamma);
while tau > 1e-8
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive_gradient,gamma);
    x = x - tau*delta;
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive,gamma);
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    else
        tau = 1.1*tau;
    end
end

subplot(1,2,1), imshow(real(x));
subplot(1,2,2), imshow(real(imageNoisy));
temp = (abs(x-imageNoiseless));
sum(temp(:))
