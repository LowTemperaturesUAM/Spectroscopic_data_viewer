% Fase de la transformada de Fourier 2D en RADIANES [-pi,pi]
% Nota para mejor comprensión: RSI = Real Space Image

function PHASE = fft2dphase(RSI)% La entrada es una matriz con la imagen en el espacio real

    PHASE = fft2(RSI);        % Esta orden hace la transformada para una imagen 2D rutina de matlab
    PHASE = fftshift(PHASE);    % Pone la componente de frecuencia cero en el centro del espectro
    PHASE=angle(PHASE);
%     REAL=real(PHASE);
%     IMAG=imag(PHASE);
%     PHASE=atan(IMAG./REAL);
end
