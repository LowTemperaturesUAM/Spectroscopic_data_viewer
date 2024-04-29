function [MODULE,PHASE] = fft2d(RSI,opt)% La entrada es una matriz con la imagen en el espacio real
arguments
    RSI
    opt.Size (1,2) double = 0 % fixed size of the output fft
    opt.ResizeFactor {mustBeScalarOrEmpty,mustBePositive} = 1 % rescale the output fft by a fixed factor in both axis
    opt.Normalize = false % normalize the FFT amplitude by the number of points
end
% Módulo de la transformada de Fourier 2D
% Nota para mejor comprensión: RSI = Real Space Image
% Para obtener las unidades "verdaderas" del modulo de la FFT, poner normalize en true,
% lo que divide por el numero de puntos de la RSI.

ImgSize = size(RSI);
if opt.Size ~= 0 %Size was provided
    if any(opt.Size < ImgSize)
        warning('The dimensions provided for the FFT are smaller than the real image')
    end
    NewSize = opt.Size;
else
    NewSize = ImgSize*opt.ResizeFactor;
end

% Realizar transformada para imagen 2D, funcion de Matlab
FFT = fft2(RSI,NewSize(1),NewSize(2));

if opt.Normalize % Dividir por numero puntos de la imagen real
    % FFT = FFT./(NewSize(1).*NewSize(2));
    FFT = FFT./prod(ImgSize);
end

FFT = fftshift(FFT);
MODULE = abs(FFT); % Valor absoluto para evitar problemas con la parte imaginaria

if nargout==2
    PHASE = angle(FFT); % Opcionalmente, devuelve la fase al mismo tiempo
end
 
end