function mapsClickAnalyze(app, Info)

Transformadas                   = Info.Transformadas;
Energia                         = Info.Energia;
DistanciaFourierFilas           = Info.DistanciaFourierFilas;
DistanciaFourierColumnas        = Info.DistanciaFourierColumnas;
DistanciaColumnas               = Info.DistanciaColumnas;
DistanciaFilas                  = Info.DistanciaFilas;
Voltaje                         = Info.Voltaje;
MatrizNormalizada               = Info.MatrizNormalizada;
MatrizCorriente                 = Info.MatrizCorriente;
if isfield(Info,'MatrizSecondDeriv')
    MatrizSecondDeriv = Info.MatrizSecondDeriv;
    SecondDeriv = true;
else
    SecondDeriv = false;
end

[ax, btn, Movimiento] = Up_v2(app.UIFigure);
%Calculamos las dimensiones en cada caso por separado por si fueran distintas
if strcmp(btn, 'alt') && Movimiento && strcmp(ax.Tag,'RealAxes')
    Filas = numel(DistanciaFilas);
    Columnas = numel(DistanciaColumnas);
    Rectangle = ax.UserData.Rectangle;
    CondFig = MeanIVFunction_v4(ax,Rectangle, MatrizNormalizada, Voltaje, DistanciaFilas, DistanciaColumnas, 'Conductance'); %Conductancia vs V
    CurrentFig = MeanIVFunction_v4(ax,Rectangle, MatrizCorriente, Voltaje, DistanciaFilas, DistanciaColumnas, 'Current'); %Corriente vs V
    if SecondDeriv
        SecondFig = MeanIVFunction_v4(ax,Rectangle, MatrizSecondDeriv, Voltaje, DistanciaFilas, DistanciaColumnas, 'Second'); %Corriente vs V
        linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes,SecondFig.CurrentAxes],'x')
    else
        linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes],'x')
    end

elseif strcmp(btn, 'normal') && ~Movimiento
   
    if strcmp(ax.Tag,'RealAxes') 
        Filas = numel(DistanciaFilas);
        Columnas = numel(DistanciaColumnas);
        punteroT = app.Axes.CurrentPoint;
        
        if exist('Info.Puntero','var')
            Info.Puntero = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.Puntero = [punteroT(1,1), punteroT(1,2)];
        end

        CondFig = curvaUnicaPA_v4(app.Axes, Info.Puntero, Voltaje,MatrizNormalizada, DistanciaColumnas,DistanciaFilas, true, 'Conductance');  %Conductancia vs V
        CurrentFig = curvaUnicaPA_v4(app.Axes, Info.Puntero, Voltaje,MatrizCorriente, DistanciaColumnas,DistanciaFilas, true, 'Current'); %Corriente vs V
        if SecondDeriv
            SecondFig = curvaUnicaPA_v4(app.Axes, Info.Puntero, Voltaje,MatrizSecondDeriv, DistanciaColumnas,DistanciaFilas, true, 'Second'); %Segunda derivada vs V
            linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes,SecondFig.CurrentAxes],'x')
        else
            linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes],'x')
        end

    elseif strcmp(ax.Tag,'FFTAxes')
        Filas = numel(DistanciaFourierFilas);
        Columnas = numel(DistanciaFourierColumnas);
        punteroT = app.Axes.CurrentPoint;

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
   
        curvaUnicaPA_v4(app.Axes,Info.PunteroFFT, Energia', TransformadasEqualizadosfAUX, DistanciaFourierColumnas,DistanciaFourierFilas, false,'Conductance'); %Intensidad FFT vs E
    end

elseif strcmp(btn, 'extend') && ~Movimiento
    app.EnergySpinner.Value = min(abs(Energia));  % Vuelve al mapa a 0 bias

end

figure(app.UIFigure)
end