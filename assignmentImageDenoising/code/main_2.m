%% Inputting data and setting parameters
clear;
clc;
load('../data/assignmentImageDenoisingBrainNoisy.mat')

sample = abs(imageNoisy(1:50,1:50));
sigma = std(sample(:));
fprintf('The noise level in the image is %.4f\n',sigma);
%% Quadratic Prior
x = imageNoisy;
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
alpha = 0.3;
gamma = 0; % dummy
% Optimisation
[values,x] = optimise(alpha,gamma,x,imageNoisy,shiftedmatrices,@quadratic,@quadratic_gradient);
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_quad.mat','x');

% %% Huber Prior
x = imageNoisy;
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
tau = 0.000001;
alpha = 0.95;
gamma = 0.006;
% Optimisation
[values,x] = optimise(alpha,gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);

figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_huber.mat','x');

%% Discontinuity Adaptive Prior
x = imageNoisy;
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
alpha = 0.99;
gamma = 0.0015;
% Optimisation
[values,x] = optimise(alpha,gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_adaptive.mat','x');
