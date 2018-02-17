%% Inputting data and setting parameters
load('../data/assignmentImageDenoisingPhantom.mat')
shiftedmatrices = [circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)];

% %% Quadratic loss
% x = imageNoisy;
% tau = 0.01;
% alpha = 0.38;
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
% % subplot(1,2,1), imshow(real(x));
% % subplot(1,2,2), imshow(real(imageNoisy));
% absdiff = (abs(imageNoiseless)-abs(x)).^2;
% noiselesssq = (abs(imageNoiseless)).^2;
% RRMSE = sum(absdiff(:))/sum(noiselesssq(:))

%% Huber loss
x = imageNoisy;
tau = 0.01;
alpha = 0.9981;
gamma = 0.010;

% Optimisation
objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma);
while tau > 1e-8
    delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@huber_gradient,gamma);
    x = x - tau*delta;
    objective_function_value_old = objective_function_value;
    objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@huber,gamma);
    if objective_function_value > objective_function_value_old
        tau = 0.5*tau;
    else
        tau = 1.1*tau;
    end
end

subplot(1,2,1), imshow(real(x));
subplot(1,2,2), imshow(real(imageNoisy));
absdiff = (abs(imageNoiseless)-abs(x)).^2;
noiselesssq = (abs(imageNoiseless)).^2;
RRMSE = sum(absdiff(:))/sum(noiselesssq(:))

% %% Adaptive loss
% x = imageNoisy;
% tau = 0.01;
% alpha = 0.9989;
% gamma = 0.008;
% 
% % Optimisation
% objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive,gamma);
% while tau > 1e-8
%     delta = delta_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive_gradient,gamma);
%     x = x - tau*delta;
%     objective_function_value_old = objective_function_value;
%     objective_function_value = objective_function(imageNoisy,x,shiftedmatrices,alpha,@adaptive,gamma);
%     if objective_function_value > objective_function_value_old
%         tau = 0.5*tau;
%     else
%         tau = 1.1*tau;
%     end
% end
% 
% subplot(1,2,1), imshow(real(x));
% subplot(1,2,2), imshow(real(imageNoisy));
% absdiff = (abs(imageNoiseless)-abs(x)).^2;
% noiselesssq = (abs(imageNoiseless)).^2;
% RRMSE = sum(absdiff(:))%/sum(noiselesssq(:))
