function out = SphLow(in,varargin)
%
% Spherical Low Pass filtering
%
% Pierre Vandergheynst, 2004
% uses YAWTB and the Spharmonikit interface
% WARNING: some parameters are fixed by spharmonikit


% spherical Fourier transform of data
Fin = fst(double(in));
L   = size(Fin,1);
L2  = 2*L;
l   = 0:L-1;

% deal with arguments

if length(varargin) == 0
    %sigma = sqrt(24)./L
    sigma = sqrt(2)./L
elseif length(varargin) == 1
    sigma = varargin{1};
else
    warning('wrong number of arguments');
    warning('using default Sigma');
end

% create spherical low pass filter
G = exp(-(sigma*l).^2);
    % replicate l-coeffs + magic constant
    %mask = ilmshape(repmat(G(1,:)*(4*pi)^.5./(2*l+1).^.5,L2-1,1)); 
    mask = ilmshape(repmat(G(1,:),L2-1,1));
out = ifst(Fin .* mask);

% yashow(out,'spheric','fig',1,'relief','mode','real','cmap','jet'); colorbar