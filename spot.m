function f = spot(R);
% this function detects the spots of attention and mark them on the input
% image
% R-radius of the attenuated region
% 
% Iva Bogdanova
% November 2007
%


%read the input image
F1 = imread('image1_1024x1024.bmp');

%map the image on the sphere
S1 = OmniParToSphere(double(rgb2gray(F1)));

% read the map // replace by the code to compute the map 
% the input matrix and the map must be of the same size!
X = imread('saliency.tif');

% define a working variable Y on which will be applied the attenuation
Y = X;
%find first maximum in the map (Y)
[r1,c1]= FindMax_sph(Y);
% put all pixels equal to 0 in the (squared) region of radius R 
Y(r1-R:r1+R,c1-R:c1+R) = 0;

% second MAX, search on the whole matrix exept the previously attenuated region
[r2,c2]= FindMax_sph(Y);
Y(r2-R:r2+R,c2-R:c2+R) = 0;

% third max
[r3,c3]= FindMax_sph(Y);
Y(r3-R:r3+R,c3-R:c3+R) = 0;

% show the unfolded image
%yashow(S1,'cmap',gray, 'fig',1); title('unfolded omnidirectional image on the sphere'); %Yawtb
yashow(X,'cmap',gray, 'fig',1); title('unfolded omnidirectional image on the sphere'); %Yawtb
hold on

% spot the maximum on the unfolded image
plot(c1,r1,'r*',c2,r2,'b*',c3,r3,'g*');

