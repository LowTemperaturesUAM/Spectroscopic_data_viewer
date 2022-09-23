function mapsClickVortexSym(app,Info)

Energia                         = Info.Energia;
DistanciaColumnas               = Info.DistanciaColumnas;
DistanciaFilas                  = Info.DistanciaFilas;
Filas                           = size(DistanciaFilas,2);
Columnas                        = size(DistanciaColumnas,2);
Voltaje                         = Info.Voltaje;
MatrizNormalizada               = Info.MatrizNormalizada;
% MapasConductancia               = Info.MapasConductancia;
MatrizCorriente                 = Info.MatrizCorriente;

[ax, btn, Movimiento] = Up_v2(app.EnergySymmetryUIFigure);

if strcmp(btn, 'normal') && ~Movimiento

    if strcmp(ax.Tag,'RealAxes')
        punteroT = app.Axes.CurrentPoint;

        if exist('Info.Puntero','var')
            Info.Puntero = [struct.Puntero; punteroT(1,1), punteroT(1,2)];
        else
            Info.Puntero = [punteroT(1,1), punteroT(1,2)];
        end

    end
end

if strcmp(btn, 'extend') && ~Movimiento
    app.EnergySpinner.Value = min(abs(Energia));    % Vuelve al mapa a 0 bias
end

% SEguir MIRANDO
end

