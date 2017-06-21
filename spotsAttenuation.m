function M = spots_on_the_sphere(Radius,saliency_resized);
% this function detects 10 spots of attention and mark them on the input
% image
% Radius -radius (size) of the attenuated spherical region
%
% external programs: 
%           DrawCircle.m
%           FindMax_sph(X)
% uses YAWtb
% 
% evaluation of maximums:
%     1 - red
%     2 - green
%     3- blue
%     4- yellow
%     5- magenda
%     6- cyan
%     7- dark red
%     8- gray
%     9- white
%     10- black
%     
%
% Iva Bogdanova
% November 2007
%


%read the input image
%J = imread('d1.jpg');
I =imread('/Users/ivabogdanova/Omni_images/work/omni_VA/SPHEREomni/VA_ladybug/LADYBUGimages/input/large_box_center_no_light.bmp');
I = imresize(I, [1024 1024]);
imwrite(I,'/Users/ivabogdanova/Omni_images/work/omni_VA/SPHEREomni/VA_ladybug/LADYBUGimages/input_1024x1024/large_box_center_no_light.tif');

%map the image on the sphere
%S1 = OmniParToSphere(double(rgb2gray(F1)));
S1 = I;

%[x,y] = size(S1); %for nxn matrix
[x,y,p] = size(S1); % for nxnx3 matrix (color)

%%%% read the map // replace by the code to compute the map 
%%%% the input matrix and the map must be of the same size!
%%%% X = imread('saliency_15.tif');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 max in red
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%for n= 0:2


%find first maximum in the map (Y)
[r1,c1]= FindMax_sph(saliency_resized)


%yashow(saliency_resized,'cmap',gray, 'fig',17);

% find degree resolution
 thetaM = r1(1)*(180/y)
 phiM = c1(1)*(360/x)
    
%saliency_resized(r1(1)-Radius:r1(1)+Radius,c1(1)-Radius:c1(1)+Radius) = 0;

% show the unfolded image
%yashow(S1,'cmap',gray, 'fig',12); title('unfolded input omnidirectional image on the sphere'); %Yawtb
%yashow(X,'cmap',gray, 'fig',1); title('unfolded saliency map on the sphere'); %Yawtb
%hold on

%
% draw circle at center (thetaM,phiM) and attenuate the region
[AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);

%yashow(fC12,'spheric', 'fig',13); % draw only the circle centered at max
% locate all position of the circle and replace them in the inpit image
% equal to 0

S1_r = squeeze(S1(:,:,1));
S1_g = squeeze(S1(:,:,2));
S1_b = squeeze(S1(:,:,3));
S1_r(fC12 == 1) = 255;
S1_g(fC12 == 1) = 0;
S1_b(fC12 == 1) = 0;
S1(:,:,1) = S1_r;
S1(:,:,2) = S1_g;
S1(:,:,3) = S1_b;

% attenuate the region inside the circle
saliency_resized(AC12==1) = 0;


%----2 max in Green---
[r1,c1]= FindMax_sph(saliency_resized)

% find degree resolution
 thetaM = r1(1)*(180/y)
 phiM = c1(1)*(360/x)

[AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);

S1_r = squeeze(S1(:,:,1));
S1_g = squeeze(S1(:,:,2));
S1_b = squeeze(S1(:,:,3));
S1_r(fC12 == 1) = 0;
S1_g(fC12 == 1) = 255;
S1_b(fC12 == 1) = 0;
S1(:,:,1) = S1_r;
S1(:,:,2) = S1_g;
S1(:,:,3) = S1_b;

saliency_resized(AC12==1) = 0;

% -------------3 max in Blue-------------------------------------------------
[r1,c1]= FindMax_sph(saliency_resized)

% find degree resolution
 thetaM = r1(1)*(180/y)
 phiM = c1(1)*(360/x)

[AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM); % draw circle at the required max

S1_r = squeeze(S1(:,:,1));
S1_g = squeeze(S1(:,:,2));
S1_b = squeeze(S1(:,:,3));
S1_r(fC12 == 1) = 0;
S1_g(fC12 == 1) = 0;
S1_b(fC12 == 1) = 255;
S1(:,:,1) = S1_r;
S1(:,:,2) = S1_g;
S1(:,:,3) = S1_b;

saliency_resized(AC12==1) = 0;

% --4 max in  YELLOW--------------
[r1,c1]= FindMax_sph(saliency_resized)

% find degree resolution
 thetaM = r1(1)*(180/y)
 phiM = c1(1)*(360/x)
 
[AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM); % draw circle at the required max

S1_r = squeeze(S1(:,:,1));
S1_g = squeeze(S1(:,:,2));
S1_b = squeeze(S1(:,:,3));
S1_r(fC12 == 1) = 255;
S1_g(fC12 == 1) = 255;
S1_b(fC12 == 1) = 0;
S1(:,:,1) = S1_r;
S1(:,:,2) = S1_g;
S1(:,:,3) = S1_b;

saliency_resized(AC12==1) = 0;

% --5 max-- MAGENDA---------
[r1,c1]= FindMax_sph(saliency_resized)

% find degree resolution
 thetaM = r1(1)*(180/y)
 phiM = c1(1)*(360/x)

[AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);% draw circle at the required max

S1_r = squeeze(S1(:,:,1));
S1_g = squeeze(S1(:,:,2));
S1_b = squeeze(S1(:,:,3));
S1_r(fC12 == 1) = 255;
S1_g(fC12 == 1) = 0;
S1_b(fC12 == 1) = 255;
S1(:,:,1) = S1_r;
S1(:,:,2) = S1_g;
S1(:,:,3) = S1_b;


saliency_resized(AC12==1) = 0;

% % % % --6 max--CYAN----
% % % [r1,c1]= FindMax_sph(saliency_resized)
% % % 
% % % % find degree resolution
% % %  thetaM = r1(1)*(180/y)
% % %  phiM = c1(1)*(360/x)
% % % 
% % % [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);% draw circle at the required max
% % % 
% % % S1_r = squeeze(S1(:,:,1));
% % % S1_g = squeeze(S1(:,:,2));
% % % S1_b = squeeze(S1(:,:,3));
% % % S1_r(fC12 == 1) = 0;
% % % S1_g(fC12 == 1) = 255;
% % % S1_b(fC12 == 1) = 255;
% % % S1(:,:,1) = S1_r;
% % % S1(:,:,2) = S1_g;
% % % S1(:,:,3) = S1_b;
% % % 
% % % saliency_resized(AC12==1) = 0;
% % % 
% % % % --7 max--DARK RED--------------
% % % [r1,c1]= FindMax_sph(saliency_resized)
% % % 
% % % % find degree resolution
% % %  thetaM = r1(1)*(180/y)
% % %  phiM = c1(1)*(360/x)
% % %  
% % % 
% % % [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM); % draw circle at the required max
% % % 
% % % S1_r = squeeze(S1(:,:,1));
% % % S1_g = squeeze(S1(:,:,2));
% % % S1_b = squeeze(S1(:,:,3));
% % % S1_r(fC12 == 1) = 128;
% % % S1_g(fC12 == 1) = 0;
% % % S1_b(fC12 == 1) = 0;
% % % S1(:,:,1) = S1_r;
% % % S1(:,:,2) = S1_g;
% % % S1(:,:,3) = S1_b;
% % % 
% % % saliency_resized(AC12==1) = 0;
% % % 
% % % % --8 max--GRAY--------------
% % % [r1,c1]= FindMax_sph(saliency_resized)
% % % 
% % % % find degree resolution
% % %  thetaM = r1(1)*(180/y)
% % %  phiM = c1(1)*(360/x)
% % %  
% % %  
% % % [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM); % draw circle at the required max
% % % 
% % % S1_r = squeeze(S1(:,:,1));
% % % S1_g = squeeze(S1(:,:,2));
% % % S1_b = squeeze(S1(:,:,3));
% % % S1_r(fC12 == 1) = 128;
% % % S1_g(fC12 == 1) = 128;
% % % S1_b(fC12 == 1) = 128;
% % % S1(:,:,1) = S1_r;
% % % S1(:,:,2) = S1_g;
% % % S1(:,:,3) = S1_b;
% % % 
% % % saliency_resized(AC12==1) = 0;
% % % 
% % % % --9 max--WHITE--------------
% % % [r1,c1]= FindMax_sph(saliency_resized)
% % % 
% % % % find degree resolution
% % %  thetaM = r1(1)*(180/y)
% % %  phiM = c1(1)*(360/x)
% % % 
% % % [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM); % draw circle at the required max
% % % 
% % % S1_r = squeeze(S1(:,:,1));
% % % S1_g = squeeze(S1(:,:,2));
% % % S1_b = squeeze(S1(:,:,3));
% % % S1_r(fC12 == 1) = 255;
% % % S1_g(fC12 == 1) = 255;
% % % S1_b(fC12 == 1) = 255;
% % % S1(:,:,1) = S1_r;
% % % S1(:,:,2) = S1_g;
% % % S1(:,:,3) = S1_b;
% % % 
% % % saliency_resized(AC12==1) = 0;
% % % 
% % % % --10 max--BLACK-------------
% % % [r1,c1]= FindMax_sph(saliency_resized)
% % % 
% % % % find degree resolution
% % %  thetaM = r1(1)*(180/y)
% % %  phiM = c1(1)*(360/x)
% % % 
% % % [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);% draw circle at the required max
% % % 
% % % S1_r = squeeze(S1(:,:,1));
% % % S1_g = squeeze(S1(:,:,2));
% % % S1_b = squeeze(S1(:,:,3));
% % % S1_r(fC12 == 1) = 0;
% % % S1_g(fC12 == 1) = 0;
% % % S1_b(fC12 == 1) = 0;
% % % S1(:,:,1) = S1_r;
% % % S1(:,:,2) = S1_g;
% % % S1(:,:,3) = S1_b;
% % % 
% % % saliency_resized(AC12==1) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yashow(S1,'cmap',gray, 'fig',3);% YAWTB
yashow(S1,'spheric', 'fig',4);  %YAWtb
%----
imwrite(S1,'/Users/ivabogdanova/Omni_images/work/omni_VA/SPHEREomni/VA_ladybug/LADYBUGimages/spots/large_box_center_no_light_spots.tif');
