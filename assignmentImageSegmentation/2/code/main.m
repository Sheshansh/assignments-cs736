%% Initializing Parameters
clear
clc
load('../data/assignmentSegmentBrainGmmEmMrf.mat');
numClasses = 3;
% Initialize labels uniformly
[X,means,vars] = initLabels(imageData,imageMask,numClasses);

%% Labels for beta = 0.4
beta = 0.4;
[X,memberships,means,vars] = EMOptimize(X,imageData,imageMask,means,vars,beta,numClasses);
save('../results/optimbetaResult.mat','X');
m1 = memberships(:,:,1);save('../results/optimbetaMemberships1.mat','m1');
m2 = memberships(:,:,2);save('../results/optimbetaMemberships2.mat','m2');
m3 = memberships(:,:,3);save('../results/optimbetaMemberships3.mat','m3');
figure;imagesc(imageData);colormap 'gray';title('Original image');colorbar;
figure;imagesc(X);colormap 'gray';title('Segmented Image with beta = 0.4');colorbar;
figure;imagesc(memberships(:,:,1));colormap 'gray';title('Memberships for Label 1, beta = 0.4');colorbar;
figure;imagesc(memberships(:,:,2));colormap 'gray';title('Memberships for Label 2, beta = 0.4');colorbar;
figure;imagesc(memberships(:,:,3));colormap 'gray';title('Memberships for Label 3, beta = 0.4');colorbar;
fprintf('The optimal estimates for class means are %.4f, %.4f. %.4f\n', means(1),means(2),means(3));
%% Labels for beta = 0
beta = 0;
[X,memberships,means,vars] = EMOptimize(X,imageData,imageMask,means,vars,beta,numClasses);
save('../results/betaZeroResult.mat','X');
m1 = memberships(:,:,1);save('../results/betaZeroMemberships1.mat','m1');
m2 = memberships(:,:,2);save('../results/betaZeroMemberships2.mat','m2');
m3 = memberships(:,:,3);save('../results/betaZeroMemberships3.mat','m3');
figure;imagesc(X);colormap 'gray';title('Segmented Image with beta = 0');colorbar;
figure;imagesc(memberships(:,:,1));colormap 'gray';title('Memberships for Label 1, beta = 0');colorbar;
figure;imagesc(memberships(:,:,2));colormap 'gray';title('Memberships for Label 2, beta = 0');colorbar;
figure;imagesc(memberships(:,:,3));colormap 'gray';title('Memberships for Label 3, beta = 0');colorbar;
fprintf('The optimal estimates for class means are %.4f, %.4f. %.4f\n', means(1),means(2),means(3));
%%
% <html>Answers: </html>
%%
% (a)The optimal value of beta is 0.4
% (b) To initialize the label image: We divided the intensity range into k classes. The pixels which belong to each class have been assigned that class. This is a reasonable initialization because it is expected that different segments in the brain will fall in different intensity ranges.
% (c) We initialized the means and variances for each class to be the sample mean and sample variance for each
% class given the initialized the label image. The motivation for this is
% that this corresponds to the MAP estimate of the means and variance.