function S1 = OmniParToSphere_colour(I);
% function that maps an parabolic RGB omnidirectional image onto the unit
% sphere through inverse stereographic projection
%
% Iva Bogdanova,
% November 2007
%

%I = imread('image1_1024x1024.bmp');

Ir = I(:,:,1);  % separate Red-channel
Ig = I(:,:,2);  % separate Green-channel
Ib = I(:,:,3);  % separate Blue-channel

%----RED------
% find image center (in one of the channels)
[Iy, Ix] = size(Ir);
% define the radus of the disk image (should depend on the sensor calibration)
R = 2;  % a particular case :1- the unit disk

%clean the exterior of the disk image via a mask
mask = ones(Ix,Iy);
[Xd,Yd] = meshgrid(-R:2*R/(Ix-1):R,-R:2*R/(Iy-1):R); % generates the cartesian range
mask(Xd.^2 + Yd.^2 >= R^2) = 0.0; % everything outside of the disk of radius R is equal to 0
mask = uint8(mask);
data_r = Ir.*mask;
%figure(2); imagesc(data); title('MASKED intensity image'); colormap('gray'); colorbar; axis image;

% generate spherical grid
[phi, theta] = sphgrid(Ix,Iy); % uses Yawtb 

% find the correspondance on the sphere through inverse stereographic
% projection
xij = 2*tan(theta/2).*cos(phi);
yij = 2*tan(theta/2).*sin(phi);

% matrix to be filled in
S_Ir = zeros(size(theta));
% interpolation
S_Ir = interp2(Xd,Yd,data_r,xij,yij,'cubic'); % trough cubic interpolation as defined in MATLAB
% visualize the sphere
% transform NaN value to zero value
S_Ir(isnan(S_Ir)) = 0;
% clear the interior disk
S_Ir(1:100,:)=0;

% UPDATE
% clear value out of the circle 
% <=> under 0 Deg of latitude
S_Ir((Ix/2)+1:Ix,:)=0.0;

%--------GREEN-------
data_g = Ig.*mask;
% matrix to be filled in
S_Ig = zeros(size(theta));
% interpolation
S_Ig = interp2(Xd,Yd,data_g,xij,yij,'cubic'); % trough cubic interpolation as defined in MATLAB
S_Ig(isnan(S_Ig)) = 0;
S_Ig(1:100,:)=0;%clear the interior disk
S_Ig((Ix/2)+1:Ix,:)=0.0;

%--------Blue-------
data_b = Ib.*mask;
% matrix to be filled in
S_Ib = zeros(size(theta));
% interpolation
S_Ib = interp2(Xd,Yd,data_b,xij,yij,'cubic'); % trough cubic interpolation as defined in MATLAB
S_Ib(isnan(S_Ib)) = 0;
S_Ib(1:100,:)=0;    %clear the interior disk
S_Ib((Ix/2)+1:Ix,:)=0.0;


% sum the r g b channels
S1(:,:,1) = uint8(S_Ir);
S1(:,:,2) = uint8(S_Ig);
S1(:,:,3) = uint8(S_Ib);


yashow(S1, 'spheric','fig',1); title('parabolic image mapped on the sphere'); % uses Yawtb
yashow(S1,'fig',2); title('unfolded omnidirectional image on the sphere'); %Yawtb

