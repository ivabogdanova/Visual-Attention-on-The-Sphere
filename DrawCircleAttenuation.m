function [AC12,fC12]=DrawCircleAttenuation(Radius,thetaM,phiM);
% function for drawing a circle  centered at (thetaM, phiM) on the sphere
% radius of the circle depends on the angle theta which is fixed here to be
% pi/18.
%
% INPUT PARAMETERS: Radius- radius of the circle on the sphere, defined in
% gradus, (pi/18=10 Gradus)
% (thetaM,phiM) center of the circle, i.e. of the attenuation region
%
% OUTPUT PARAMETERS:
%           AC12- attenuated region (circle) to be used later on
%           fC12 - the border to be drawn
%
%
% Iva Bogdanova
% November 2007
%
% last modified: December'07

%Radius = pi/18;
N = 1024;
[phi,theta] = sphgrid(N);
f = zeros(N,N);
f((theta>=Radius -0.02)&(theta<=Radius+0.02))=1;
A = zeros(N,N); %%
A(theta<=Radius)= 1; % all the interior of the circle to be attenuated %%
%yashow(f,'spheric','cmap',gray, 'fig',1);

%----------
%cartesian coordinates of the circle
XC = sin(theta).*cos(phi);
YC = sin(theta).*sin(phi);
ZC = cos(theta);

% rotated grid by thetaM degrees
cos1 = cos(thetaM*(pi/180));
sin1 = sin(thetaM*(pi/180));

% rotated grid by phiM degrees
cos2 = cos(-(phiM+90)*(pi/180));
sin2 = sin(-(phiM+90)*(pi/180));


% rotation in 3d space
Rot_thetaM = [1 0 0; 0 cos1 sin1; 0 -sin1 cos1];
Rot_phiM = [cos2 -sin2 0; sin2 cos2 0; 0 0 1];
Rot= Rot_thetaM*Rot_phiM;

XC12 = Rot(1,1)*XC + Rot(1,2)*YC + Rot(1,3)*ZC;
YC12 = Rot(2,1)*XC + Rot(2,2)*YC + Rot(2,3)*ZC;
ZC12 = Rot(3,1)*XC + Rot(3,2)*YC + Rot(3,3)*ZC;

phiC12 = atan2(YC12,XC12);      % calculate rotated phi angle
thetaC12 = acos(ZC12);          % calculate rotated theta angle
fC12=zeros(N);
fC12((thetaC12>=Radius -0.02)&(thetaC12<=Radius+0.02))=1; % disk in the rotated grid by (thetaM,phiM) degrees
%yashow(fC12,'spheric', 'fig',2); title('rotated circle');
%yashow(fC12,'fig',1); title('unfolded rotated circle');

AC12 = zeros(N);
AC12(thetaC12 <=Radius)=1;
%yashow(AC12,'spheric','fig',3);
