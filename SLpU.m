function out = SLpU(in)
% Spherical Laplacian Pyramid
% Up-sampling / Prediction channel
%
% Pierre Vandergheynst, 2004

% upsample data
[sx,sy] = size(in);
temp = zeros(2*sx,2*sy);
temp(1:2:2*sx,1:2:2*sy) = in;

% spherical Fourier transform of data
Fin = fst(double(temp));
L   = size(Fin,1);
L2  = 2*L;
l   = 0:L-1;

% choose sigma for full bandwidth
sigma = sqrt(6)./L;


% create spherical low pass filter
G = exp(-(sigma*l).^2);
    % replicate l-coeffs + magic constant
    % mask = ilmshape(repmat(G(1,:)*(4*pi)^.5./(2*l+1).^.5,L2-1,1)); 
    mask = ilmshape(repmat(G(1,:),L2-1,1)); 
out = 4*real(ifst(Fin .* mask));

