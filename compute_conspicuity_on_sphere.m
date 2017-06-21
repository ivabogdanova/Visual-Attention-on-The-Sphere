function c_map = compute_conspicuity_on_sphere(Feature_theta_phi)
%
% function for calculating the conspicuity map of a feature image
% through VA algorithm based on center surround mechanism 
% uses: SphLow, SLpU as external functions
% YAWTB, SpharmonicKit
%
% input image must be NxN (powers of 2) 
% AND must is in the THETA PHI domain
%
% Iva Bogdanova & Alex Bur
% June 2007
%


n = size(Feature_theta_phi);

%-----------------------------------------%
% create  the levels of Laplacian Pyramid %
%-----------------------------------------%
    
%level 1compute_conspicuity_on_sphere.m
f1 = SphLow(Feature_theta_phi);
f1_down = f1(1:2:n(1), 1:2:n(2)); 


%level 2
f2 = SphLow(f1_down);
f2_down = f2(1:2:n(1)/2, 1:2:n(2)/2);

%level 3
f3 = SphLow(f2_down);
f3_down = f3(1:2:round(n(1)/4), 1:2:round(n(2)/4));

%level 4
f4 = SphLow(f3_down);
f4_down = f4(1:2:n(1)/8, 1:2:n(2)/8);

%level 5
f5 = SphLow(f4_down);
f5_down = f5(1:2:n(1)/16, 1:2:n(2)/16);

%level 6
f6 = SphLow(f5_down);
f6_down = f6(1:2:n(1)/32, 1:2:n(2)/32);

%level 7
f7 = SphLow(f6_down);
f7_down = f7(1:2:n(1)/64, 1:2:n(2)/64);

%level 8
f8 = SphLow(f7_down);
f8_down = f8(1:2:n(1)/128, 1:2:n(2)/128);

% visualization on the sphere of both fi and fi_down
%yashow(f8, 'spheric','fig',14); title('8 level Gassian sphere'); colormap gray; view(-113,50);
%yashow(f8_down, 'spheric','fig',15); title('8 level down sampled sphere'); colormap gray; view(-113,50);


%----------------------------------------%
% compute the center surround difference %
% 5 multiscale level : cmap14,cmap25,    %
%               cmap36,cmap47,cmap58     %
%----------------------------------------%

%--------- L1-L4 at scale 1--------------%

% upsample level 4 to level 1
L4_u1 = SLpU(SLpU(SLpU(f4_down)));

% center surround difference
M1 = f1_down - L4_u1;

% cmap14 visualization
%yashow(M1, 'cmap', gray, 'fig',1);title('unfolded MAP1 = L1-L4 at level 1');

%imwrite(M1,'map14.tif');

%TAKE THE ABSOLUTE VALUE
abs_M1 = abs(M1);                                                       

%compute the weighting coeff
map14 = weight_w_norm(abs_M1);


%--------- L2-L5 at scale 2------------

% upsample level 5 to level 2
L5_u2 = SLpU(SLpU(SLpU(f5_down)));

% center surround difference
M2 = f2_down - L5_u2;

% cmap14 visualization
%yashow(M2, 'cmap', gray, 'fig',2);title('unfolded MAP2 = L2-L5 at level 2');

%imwrite(M2,'map25.tif');

% Upsample cmap25 to level 1 ----> (1 level up)
M2_u = SLpU(M2);

%TAKE THE ABSOLUTE VALUE
abs_M2_u = abs(M2_u);                                                       

%compute the weighting coeff
map25 = weight_w_norm(abs_M2_u);



%--------- L3-L6 at scale 3------------

% upsample level 6 to level 3
L6_u3 = SLpU(SLpU(SLpU(f6_down)));

% center surround difference
M3 = f3_down - L6_u3;

% cmap14 visualization
%yashow(M3, 'cmap', gray, 'fig',3);title('unfolded MAP3 = L3-L6 at level 3');

%imwrite(M3,'map36.tif');

% Upsample cmap63 to level 1  ----> (2 levels up)
M3_uu = SLpU(SLpU(M3));      

%TAKE THE ABSOLUTE VALUE
abs_M3_uu = abs(M3_uu);                                                       

%compute the weighting coeff
map36 = weight_w_norm(abs_M3_uu);



%--------- L4-L7 at scale 4------------

% upsample level 7 to level 4
L7_u4 = SLpU(SLpU(SLpU(f7_down)));

% center surround difference
M4 = f4_down - L7_u4;

% cmap14 visualization
%yashow(M4, 'cmap', gray, 'fig',4);title('unfolded MAP4 = L4-L7 at level 4');

%imwrite(M4,'map47.tif');

% Upsample cmap74 to level 1  ----> (3 levels up)
M4_uuu = SLpU(SLpU(SLpU(M4)));      

%TAKE THE ABSOLUTE VALUE
abs_M4_uuu = abs(M4_uuu);                                                      

%compute the weighting coeff
map47 = weight_w_norm(abs_M4_uuu);



%--------- L5-L8 at scale 5------------

% upsample level 8 to level 5
L8_u5 = SLpU(SLpU(SLpU(f8_down)));

% center surround difference
M5 = f5_down - L8_u5;

% cmap14 visualization
%yashow(M5, 'cmap', gray, 'fig',5);title('unfolded MAP5 = L5-L8 at level 5');

%imwrite(M5,'map58.tif');

% Upsample cmap74 to level 1  ----> (4 levels up)
M5_uuuu = SLpU(SLpU(SLpU(SLpU(M5))));          

%TAKE THE ABSOLUTE VALUE
abs_M5_uuuu = abs(M5_uuuu);                                                       

%compute the weighting coeff
map58 = weight_w_norm(abs_M5_uuuu);


%---------------------------------------------------------------%
%MAP COMBINATION: at level 1                                   %
%                                                              %
%C = N(cmap14) + N(cmap25) + N(cmap36) + N(cmap47) +N(cmap58)  %                                    
%                                                              %
%---------------------------------------------------------------%

%---sum the maps at scale 1----
map = map14 + map25 + map36 + map47 + map58;



% cmap14 visualization
%figure(6); imagesc(map); axis image; colormap gray; title('unfolded Intensity map at level 1');

%yashow(map,'spheric', 'cmap', gray, 'fig',7);title('intensity map on the sphere');
%imwrite(map,'mapS.tif');

c_map = map;



