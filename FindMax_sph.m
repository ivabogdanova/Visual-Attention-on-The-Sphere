function  [r,c]= FindMax_sph(X);
% function which returns the position of the max value in 
% an input matrix I
%
%
% Iva Bogdanova
% November 2007


%% % read the saliency map here instead of creating a synthetic matrix
%% X = imread(I);

% find the  pixel indeces (r,c) of the pixel with max value in the matrix
[r,c] = find(abs(X) == max(max(abs(X))));