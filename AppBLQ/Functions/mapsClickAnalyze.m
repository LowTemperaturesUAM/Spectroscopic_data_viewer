function mapsClickAnalyze(App, Info)

Transformadas                   = Info.Transformadas;
Energia                         = Info.Energia;
[Filas, Columnas]               = size(Transformadas{1});
DistanciaFourierFilas           = Info.DistanciaFourierFilas;
DistanciaFourierColumnas        = Info.DistanciaFourierColumnas;
DistanciaColumnas               = Info.DistanciaColumnas;
DistanciaFilas                  = Info.DistanciaFilas;
Voltaje                         = Info.Voltaje;
MatrizNormalizada               = Info.MatrizNormalizada;
% MapasConductancia               = Info.MapasConductancia;
MatrizCorriente                 = Info.MatrizCorriente;

[ax, btn, Movimiento] = Up_v2(App.UIFigure);
%     Ratio = (ax.XLim(2) - ax.XLim(1))/...
%         (ax.YLim(2) - ax.YLim(1));
%    PosicionAx = ax.Position;
%    ax.UserData.Rectangle
%    if Ratio < 1
%         ax.Position = [PosicionAx(1), PosicionAx(2), PosicionAx(3)*Ratio PosicionAx(4)];
%    else
%        ax.Position = [PosicionAx(1), PosicionAx(2), PosicionAx(3) PosicionAx(4)/Ratio];
%    end
if strcmp(btn, 'alt') && Movimiento 
    Rectangle = ax.UserData.Rectangle;
%  MeanIVFunction(Rectangle, MatrizNormalizada, Voltaje, Columnas, Filas, DistanciaColumnas)
        MeanIVFunction_v3(ax,Rectangle, MatrizNormalizada, Voltaje, Columnas, Filas, DistanciaColumnas, 0) %Conductancia vs V
        MeanIVFunction_v3(ax,Rectangle, MatrizCorriente, Voltaje, Columnas, Filas, DistanciaColumnas, 1) %Corriente vs V
end
    
if strcmp(btn, 'normal') && ~Movimiento
   
    if strcmp(ax.Tag,'RealAxes') 
        punteroT = App.Axes.CurrentPoint;
        
%         k = find(Energia == App.EnergySpinner.Value);
        
        if exist('Info.Puntero','var')
            Info.Puntero = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.Puntero = [punteroT(1,1), punteroT(1,2)];
        end
%          size(MatrizCorriente)
%         curvaUnicaPA(Struct.Puntero, MapasConductancia{k}, Voltaje,MatrizNormalizada, DistanciaColumnas,DistanciaFilas,true);
        curvaUnicaPA_v2(App.Axes, Info.Puntero, Voltaje,MatrizNormalizada, DistanciaColumnas,DistanciaFilas, true, 0)  %Conductancia vs V
        curvaUnicaPA_v2(App.Axes, Info.Puntero, Voltaje,MatrizCorriente, DistanciaColumnas,DistanciaFilas, true, 1) %Corriente vs V
        
    elseif strcmp(ax.Tag,'FFTAxes')
        punteroT = App.Axes.CurrentPoint;

%         k = find(Energia == App.EnergySpinner.Value);
        TransformadasEqualizadosf = zeros(Filas,Columnas,length(Energia));
        
        if exist('Info.Puntero','var')
            Info.PunteroFFT = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.PunteroFFT = [punteroT(1,1), punteroT(1,2)];
        end
        
%         size(Struct.PunteroFFT);
       
        for i = 1:length(Energia)
            TransformadasEqualizadosf(:,:,i) = Transformadas{i};
        end
        % Con esta vuelta de tuerca podemos usar las mismas funciones. Pasamos
        % los mapas de las FFT como ristras [length(Energia)xFilasxColumnas]
        TransformadasEqualizadosfAUX = permute(TransformadasEqualizadosf,[3 2 1]);
        TransformadasEqualizadosfAUX = reshape(TransformadasEqualizadosfAUX,[length(Energia),Filas*Columnas]);
   
        curvaUnicaPA_v2(App.Axes,Info.PunteroFFT, Energia', TransformadasEqualizadosfAUX, DistanciaFourierColumnas,DistanciaFourierFilas, false,0); %Intensidad FFT vs E
    end
end

if strcmp(btn, 'extend') && ~Movimiento
    App.EnergySpinner.Value = min(abs(Energia));    % Vuelve al mapa a 0 bias

end