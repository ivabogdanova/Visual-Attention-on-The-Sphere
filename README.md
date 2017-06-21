# Visual-Attention-on-The-Sphere

README

This repository contains the MATLAB source code for performing a visual attention (VA) algorithm on spherical images obtained with ladybug camera.

Uses YAWTB and the Spharmonikit interface

The main program is 
compute_SPHsaliency.m

which calls the following programs:
IntFeature.m
RGFeature.m
BYFeature.m
compute_conspicuicy_on_sphere_3_level.m
pp_norm_image.m
exponential_norm.m
SLpU.m
SpotsAttenuation.m


The attenuation region is defined in spherical coordinates and it can be changed in the main program.

REF: Bogdanova I. et al., Visual Attention on the Sphere, IEEE Transactions on Image Processing, vol. 17, Issue 11, pp. 2000-2014, 2008
