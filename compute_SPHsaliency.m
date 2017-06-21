function saliency = compute_saliency(omni_image)
% this function computes the saliency on the sphere
% external programs used:  IntFeature.m
%                           RGFeature.m
%                           BYFeature.m
%                           compute_conspicuity_on_sphere_3_level.m
%                           pp_norm_image.m
%                           exponential_norm.m
%                           SLpU.m
%                           SpotsAttenuation.m
%
% Iva Bogdanova & Alex Bur
% June 2007
%



%Define the gamma value
gamma=1.5;


% read omni directional image
I = imread('/Users/ivabogdanova/Omni_images/work/omni_VA/SPHEREomni/VA_ladybug/LADYBUGimages/input/large_box_center_no_light.bmp');
%yashow(I,'cmap',gray, 'fig',1);% YAWTB 
%title('input LADYBUG image');

I = imresize(I,[1024 1024]);
yashow(I,'cmap',gray, 'fig',1);

%---------------------------------------%
% intensity                             %
%---------------------------------------%
 
  
% compute feature intensity in cartesian domain
intensity_xy = IntFeature(I);

% compute feature intensity in phi theta domain
intensity_phi_theta = intensity_xy;


%------------------------%
%UPDATE: Alex 08. 11. 07.%
%------------------------%

%% % compute intensity conspicuity map
 cmap_int = compute_conspicuity_on_sphere(intensity_phi_theta);

% compute intensity conspicuity map
% cmap_int = compute_conspicuity_on_sphere_3_level(intensity_phi_theta, gamma);

%------------------------%

%---------------------------------------%
% Red -green color opponency            %
%---------------------------------------%

% compute feature RG in cartesian domain
RG_xy = RGFeature(I);

% compute feature RG in phi theta domain
RG_phi_theta = RG_xy;

%------------------------%
%UPDATE: Alex 08. 11. 07.%
%------------------------%

%% % compute intensity conspicuity map
%% cmap_RG = compute_conspicuity_on_sphere(RG_phi_theta);

% compute intensity conspicuity map
cmap_RG = compute_conspicuity_on_sphere_3_level(RG_phi_theta, gamma);



%------------------------%

%---------------------------------------%
% Yellow-Blue color opponency           %
%---------------------------------------%

% compute feature RG in cartesian domain
YB_xy = BYFeature(I);

% compute feature RG in phi-theta domain
BY_phi_theta = YB_xy;

%------------------------%
%UPDATE: Alex 08. 11. 07.%
%------------------------%

%% % compute intensity conspicuity map
%% cmap_BY = compute_conspicuity_on_sphere(BY_phi_theta);

% compute intensity conspicuity map
cmap_BY = compute_conspicuity_on_sphere_3_level(BY_phi_theta, gamma);

%------------------------%

%---------------------------------------%
% Compute the final saliency map        %
%---------------------------------------%

% normalize all conspicuity maps from 0 to 1
cmap_int = pp_norm_image(cmap_int,0.0,1.0);
cmap_RG = pp_norm_image(cmap_RG,0.0,1.0);
cmap_BY = pp_norm_image(cmap_BY,0.0,1.0);


%------------------------%
%UPDATE: Alex 08. 11. 07.%
%------------------------%

% % apply weighting scheme to all conspicuity maps
% cmap_int = weight_w_norm(cmap_int);
% cmap_RG = weight_w_norm(cmap_RG);
% cmap_BY = weight_w_norm(cmap_BY);



% apply exponential normalization to all conspicuity maps
cmap_int = exponential_norm(cmap_int,gamma);
cmap_RG = exponential_norm(cmap_RG,gamma);
cmap_BY = exponential_norm(cmap_BY,gamma);

%------------------------%

% sum all conspicuity maps
saliency = (cmap_int + cmap_RG + cmap_BY)/3.0;
saliency(400:512,:) = 0.0;                          % LADYBUG images: attenuate the empty band in (theta,phi)
%saliency(1:50,:) = 0.0; saliency(300:512,:) = 0.0; % hyperbolic mirror
%saliency(1:150,:) = 0.0; saliency(390:512,:) = 0.0;  %KAIDAN

%saliency = cmap_RG;

%normalize the saliency map from 0 to 1.0
saliency = pp_norm_image(saliency,0.0,1.0);

%resized the saliency map to the original size of the image
SaliencyResized = SLpU(saliency);


% conspicuity visualization
cmap_int = pp_norm_image(cmap_int,0.0,1.0);
cmap_RG = pp_norm_image(cmap_RG,0.0,1.0);
cmap_BY = pp_norm_image(cmap_BY,0.0,1.0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%figure(8); imagesc(cmap_int); axis image; colormap gray; title('intensity consp');
% figure(9); imagesc(cmap_RG);  axis image; colormap gray; title('Red Green consp');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%figure(10); imagesc(cmap_BY); axis image; colormap gray; title('Blue Yellow consp');

% saliency visualization
 figure(2); imagesc(saliency); axis image; colormap gray; title('saliency map');



% compute and draw the spots 
 Radius = 2*pi/18; %define the radius of the acircle to be drawn and the attenuation 
 spotsAttenuation(Radius,SaliencyResized);


% store saliency & conspicuity maps

imwrite(saliency,'/Users/ivabogdanova/Omni_images/work/omni_VA/SPHEREomni/VA_ladybug/LADYBUGimages/SaliencyMaps/large_box_center_no_light_saliency.tif');
yashow(saliency,'spheric','cmap', gray,'fig',5);
% % % % % % imwrite(saliency,'saliency.tif');
% % % % % % imwrite(cmap_int,'intensity.tif');
% % % % % % imwrite(cmap_RG,'RG.tif');
% % % % % % imwrite(cmap_BY,'BY.tif');
