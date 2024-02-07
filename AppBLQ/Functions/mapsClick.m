function mapsClick(app, Info)

Transformadas                   = Info.Transformadas;
Energia                         = Info.Energia;
DistanciaFourierFilas           = Info.DistanciaFourierFilas;
DistanciaFourierColumnas        = Info.DistanciaFourierColumnas;
DistanciaColumnas               = Info.DistanciaColumnas;
DistanciaFilas                  = Info.DistanciaFilas;
Voltaje                         = Info.Voltaje;
MatrizNormalizada               = Info.MatrizNormalizada;
MatrizCorriente                 = Info.MatrizCorriente;

[ax, btn, Movimiento] = Up_v2(app.mapsPreviewFigure);
%Calculamos las dimensiones en cada caso por separado por si fueran distintas
if strcmp(btn, 'alt') && Movimiento && strcmp(ax.Tag,'RealAxes')
    Filas = numel(DistanciaFilas);
    Columnas = numel(DistanciaColumnas);
    Rectangle = ax.UserData.Rectangle;
    MeanIVFunction_v3(ax,Rectangle, MatrizNormalizada, Voltaje, DistanciaFilas, DistanciaColumnas,0) %Conductancia
    MeanIVFunction_v3(ax,Rectangle, MatrizCorriente, Voltaje, DistanciaFilas, DistanciaColumnas,1) %Corriente

elseif strcmp(btn, 'normal') && ~Movimiento

    if strcmp(ax.Tag,'RealAxes')
        Filas = numel(DistanciaFilas);
        Columnas = numel(DistanciaColumnas);
        punteroT = app.RealAxes.CurrentPoint;

        if exist('Info.Puntero','var')
            Info.Puntero = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.Puntero = [punteroT(1,1), punteroT(1,2)];
        end

        curvaUnicaPA_v3(app.RealAxes, Info.Puntero, Voltaje,MatrizNormalizada, DistanciaColumnas,DistanciaFilas, true,0) %Conductancia vs V
        curvaUnicaPA_v3(app.RealAxes, Info.Puntero, Voltaje,MatrizCorriente, DistanciaColumnas,DistanciaFilas, true,1) %Corriente vs V

    elseif strcmp(ax.Tag,'FFTAxes')
        Filas = numel(DistanciaFourierFilas);
        Columnas = numel(DistanciaFourierColumnas);
        punteroT = app.FFTAxes.CurrentPoint;

        TransformadasEqualizadosf = zeros(Filas,Columnas,length(Energia));

        if exist('Info.Puntero','var')
            Info.PunteroFFT = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.PunteroFFT = [punteroT(1,1), punteroT(1,2)];
        end

        for i = 1:length(Energia)
            TransformadasEqualizadosf(:,:,i) = Transformadas{i};
        end
        % Con esta vuelta de tuerca podemos usar las mismas funciones. Pasamos
        % los mapas de las FFT como ristras [length(Energia)xFilasxColumnas]
        TransformadasEqualizadosfAUX = permute(TransformadasEqualizadosf,[3 2 1]);
        TransformadasEqualizadosfAUX = reshape(TransformadasEqualizadosfAUX,[length(Energia),Filas*Columnas]);

        curvaUnicaPA_v3(app.FFTAxes,Info.PunteroFFT, Energia', TransformadasEqualizadosfAUX, DistanciaFourierColumnas,DistanciaFourierFilas, false,0); %Intensidad FFT vs E
    end

elseif strcmp(btn, 'extend') && ~Movimiento
    app.EnergySpinner.Value = min(abs(Energia));  % Vuelve al mapa a 0 bias

end