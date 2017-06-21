function I_f = IntFeature(I)

I = double(I);

%create the intensity feature from the input image
F1 = 0.3*I(:,:,1) + 0.59*I(:,:,2) + 0.11*I(:,:,3);
I_f = F1;

