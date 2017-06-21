function S1 = OmniParToSphere(F1)
% function that maps an parabolic omnidirectional image onto the unit
% sphere through inverse stereographic projection
%
% Iva Bogdanova,
% March 2007
%
%   UPDATE:
% Alex Bur
% 


% find image center
[Iy, Ix] = size(F1);
% define the radus of the disk image (should depend on the sensor calibration)
R = 2;  % a particular case :1- the unit disk

%clean the exterior of the disk image via a mask
mask = ones(Ix,Iy);
[Xd,Yd] = meshgrid(-R:2*R/(Ix-1):R,-R:2*R/(Iy-1):R); % generates the cartesian range
mask(Xd.^2 + Yd.^2 >= R^2) = 0.0; % everything outside of the disk of radius R is equal to 0
data = F1.*mask;
%figure(2); imagesc(data); title('MASKED intensity image'); colormap('gray'); colorbar; axis image;

% generate spherical grid
[phi, theta] = sphgrid(Ix,Iy); % uses Yawtb 

% find the correspondance on the sphere through inverse stereographic
% projection
xij = 2*tan(theta/2).*cos(phi);
yij = 2*tan(theta/2).*sin(phi);

% matrix to be filled in
S1 = zeros(size(theta));
% interpolation
S1 = interp2(Xd,Yd,data,xij,yij,'cubic'); % trough cubic interpolation as defined in MATLAB
% visualize the sphere

% UPDATE
% clear value out of the circle 
% <=> under 0 Deg of latitude
S1((Ix/2)+1:Ix,:)=0.0;

yashow(S1, 'spheric','cmap', gray,'fig',3); title('parabolic image mapped on the sphere'); % uses Yawtb
yashow(S1,'cmap',gray, 'fig',4); title('unfolded omnidirectional image on the sphere'); %Yawtb


% transform NaN value to zero value
S1(isnan(S1)) = 0;
