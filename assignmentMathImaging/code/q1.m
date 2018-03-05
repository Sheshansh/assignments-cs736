%% Question 1

image = phantom(128);

%%
% <html><h3>Justification of choices of Interpolation scheme and step
% size</h3></html>
%%
% <html>
% <b>Interpolation scheme</b> : Bilinear interpolation. (The default in interp2)
% This is because nearest neighbour though fastest would be very bad scheme
% for approximation of line integrals. Bilinear interpolation is fast as
% well as serves a good way to approximate line integrals.
% <br>
% <b>Step size</b> : 1 pixel distance. For <1 pixel step size, the improvement is
% not much whereas for >1, the smoothness of the radon transform image is
% lost.
% </html>

%% Comparision of Radon transforms
rt_half = myRadonTrans(image,0.5);
rt_one = myRadonTrans(image,1.0);
rt_three = myRadonTrans(image,3.0);
hold on;
h1 = plot((1:1:37)',rt_half(:,1),'r','linewidth',3);
h2 = plot((1:1:37)',rt_one(:,1),'g','linewidth',2);
h3 = plot((1:1:37)',rt_three(:,1),'b','linewidth',2);
title('1D function plot for theta = 0 degrees');
legend([h1;h2;h3],['step=0.5';'step=1.0';'step=3.0']);
figure;hold on;
h1 = plot((1:1:37)',rt_half(:,19),'r','linewidth',3);
h2 = plot((1:1:37)',rt_one(:,19),'g','linewidth',2);
h3 = plot((1:1:37)',rt_three(:,19),'b','linewidth',2);
title('1D function plot for theta = 90 degrees');
legend([h1;h2;h3],['step=0.5';'step=1.0';'step=3.0']);

%% 