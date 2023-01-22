function [RSI] = ifft2d(MODULE,PHASE)
% Returns the inverse FFT of an image, given its module and phase information
% This function assumes the real space data is not complex, and enforces
% the symmetry when doing the calculation
   FullFFT = MODULE.*exp(1j*PHASE);
   %reverse the applied shift and calculate the ifft
   RSI = ifft2(ifftshift(FullFFT),"symmetric");
end