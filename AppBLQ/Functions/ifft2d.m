function [RSI] = ifft2d(MODULE,PHASE,opt)
arguments
    MODULE (:,:) double {mustBeReal,mustBeNonnegative,mustBeFinite}
    PHASE (:,:) double {mustBeReal,mustBeFinite} = 0
    opt.Real logical = false;
end
% Calculates the Inverse Fourier Transform on a given 2D map
% The function assumes that the data is increasingly ordered in momentum
% with the zero frecuency component located in the
% [floor(row)/2+1,floor(column)/2+1] point
% It takes the module and phase components as separate arguments
% If no phase is provided, it is assumed to be zero for all points
% Optionally, the argument Real = true can be passed if the real space data
% is not complex so that the symmetry is enforced on the calculation

FullFFT = MODULE.*exp(1j*PHASE);
%reverse the applied shift and calculate the ifft
if opt.Real %set the flag to true if the real space data is real
    RSI = ifft2(ifftshift(FullFFT),"symmetric");
else
    RSI = ifft2(ifftshift(FullFFT));
end
end