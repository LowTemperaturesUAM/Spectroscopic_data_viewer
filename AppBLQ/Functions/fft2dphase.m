% Fase de la transformada de Fourier 2D en RADIANES [-pi,pi]
% Nota para mejor comprensión: RSI = Real Space Image
% Funcion obsoleta. Puede usarse sin problema, pero fft2d.m ofrece lo mismo
% como segundo output.

function PHASE = fft2dphase(RSI)% La entrada es una matriz con la imagen en el espacio real

    PHASE = fft2(RSI);          % Esta orden hace la transformada para una imagen 2D rutina de matlab
    PHASE = fftshift(PHASE);    % Pone la componente de frecuencia cero en el centro del espectro
    PHASE=angle(PHASE);         % Obtiene la fase  
end
