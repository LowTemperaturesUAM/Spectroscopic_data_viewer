% Módulo de la transformada de Fourier 2D
% Nota para mejor comprensión: RSI = Real Space Image
% Para obtener las unidades "verdaderas" del modulo de la FFT es necesario
% dividir por el numero de puntos de la RSI.

function [MODULE,PHASE] = fft2d(RSI)% La entrada es una matriz con la imagen en el espacio real

    FFT = fft2(RSI);        % Esta orden hace la transformada para una imagen 2D rutina de matlab
    FFT = fftshift(FFT);    % Pone la componente de frecuencia cero en el centro del espectro
    MODULE = abs(FFT);      % Valor absoluto para evitar problemas con la parte imaginaria
    %      FFT = log((FFT+1)+1);   % Logaritmo para que la escalca quede mejor
    if nargout==2
        PHASE = angle(FFT); % Opcionalmente, devuelve la fase al mismo tiempo
    end
    
end

