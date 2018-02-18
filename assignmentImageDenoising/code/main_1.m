%% Inputting data and setting parameters
clear;
% clc;
tic;
load('../data/assignmentImageDenoisingPhantom.mat')

sample = abs(imageNoisy(1:50,1:50));
rrmse_noisy_noiseless = RRMSE(imageNoiseless,imageNoisy);
fprintf('RRMSE between the noisy and noiseless images is %.4f\n',rrmse_noisy_noiseless);
%% Quadratic Prior
opt_alpha = 0.22;
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
% Optimisation
x = imageNoisy;
[~,x] = optimise(opt_alpha*1.2,0,x,imageNoisy,shiftedmatrices,@quadratic,@quadratic_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At 1.2*(optimum alpha), RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(opt_alpha*0.8,0,x,imageNoisy,shiftedmatrices,@quadratic,@quadratic_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At 0.8*(optimum alpha), RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[values,x] = optimise(opt_alpha,0,x,imageNoisy,shiftedmatrices,@quadratic,@quadratic_gradient);
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_quad.mat','x');
rrmse = RRMSE(imageNoiseless,x);
fprintf('RRMSE using quadratic prior is %.4f\n',rrmse);

%% Huber Prior
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
opt_alpha = 0.95;
opt_gamma = 0.006;
x = imageNoisy;
[~,x] = optimise(0.8*opt_alpha,opt_gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At 0.8*(optimum alpha) gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(1,opt_gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At alpha=1 gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(opt_alpha,0.8*opt_gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At (optimum alpha) 0.8*gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(opt_alpha,1.2*opt_gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At (optimum alpha) 1.2*gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[values,x] = optimise(opt_alpha,opt_gamma,x,imageNoisy,shiftedmatrices,@huber,@huber_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('RRMSE using huber prior is %.4f\n',rrmse);figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_huber.mat','x');

%% Discontinuity Adaptive Prior
shiftedmatrices = {circshift(imageNoisy,1,2),circshift(imageNoisy,-1,2),circshift(imageNoisy,1,1),circshift(imageNoisy,-1,1)};
opt_alpha = 0.99;
opt_gamma = 0.0012;

x = imageNoisy;
[~,x] = optimise(0.8*opt_alpha,opt_gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At 0.8*(optimum alpha) gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(1,opt_gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At alpha=1 gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(opt_alpha,0.8*opt_gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At (optimum alpha) 0.8*gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[~,x] = optimise(opt_alpha,1.2*opt_gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
rrmse = RRMSE(imageNoiseless,x);
fprintf('At (optimum alpha) 1.2*gamma, RRMSE= %.4f\n',rrmse);
x = imageNoisy;
[values,x] = optimise(opt_alpha,opt_gamma,x,imageNoisy,shiftedmatrices,@adaptive,@adaptive_gradient);
figure;
subplot(2,2,1), imshow(abs(x));
subplot(2,2,2), imshow(abs(imageNoisy));
subplot(2,2,3), plot(values);
save('../results/denoised_adaptive.mat','x');
rrmse = RRMSE(imageNoiseless,x);
fprintf('RRMSE using discontinuity adaptive prior is %.4f\n',rrmse);
% 
toc;
