function I_out = pp_norm_image(I,mini,maxi)

%------------------------------------------------------------%
%pp_norm_image(): normalize the input image I from 0.0 to 1.0%
%------------------------------------------------------------%

min_val = min(I(:));

max_val = max(I(:));

I_out = (I - min_val + mini) ./ max_val .*maxi;
