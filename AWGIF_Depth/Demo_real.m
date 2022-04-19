%--- Demo Real ---%
clear;
close all;

addpath(genpath('Dataset'));
addpath(genpath('Functions'));
addpath(genpath('AWGIF'));

load Balls.mat;  % load clean image sequence
img=Balls;
% load BallsGP003; % load noisy image sequence
% img=BallsGP003;

[d,g]=computeInitDandG(img); % compute the initial depth map and the guidance map
C = CalculateWeightingFactor_PixBased(g); 
h = fspecial('gaussian',  [16,16], 1); 
C = imfilter( C,  h,  'same');

[q,phi] = Adaptive_Weighted_Guided_Image_Filtering(g, d, 11, 400, C);
d3 = phi.*(d - q) + q; 
ofst = 5;
depth = d3(ofst+1:end-ofst,ofst+1:end-ofst);
figure;imshow(depth,[]);
