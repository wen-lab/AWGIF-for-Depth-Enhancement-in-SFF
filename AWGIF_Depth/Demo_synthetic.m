%--- Demo Synthetic ---%
clear;
close all;

addpath(genpath('Dataset'));
addpath(genpath('Functions'));
addpath(genpath('AWGIF'));

% load Simc.mat;  % load clean image sequence (Cone object)
% img=Simc;
load SimcGP02.mat;  % load noisy image sequence
img=SimcGP02;
load SimcD; % load ground truth depth map
gt=SimcD;

[d,g]=computeInitDandG(img); % compute the initial depth map and the guidance map
C = CalculateWeightingFactor_PixBased(g); 
h = fspecial('gaussian',  [16,16], 1); 
C = imfilter( C,  h,  'same');

[q,phi] = Adaptive_Weighted_Guided_Image_Filtering(g, d, 5, 3000, C);
d3 = phi.*(d - q) + q; 
ofst = 5;
depth = d3(ofst+1:end-ofst,ofst+1:end-ofst);
mesh(depth);
colormap jet;
grid off; axis off;
