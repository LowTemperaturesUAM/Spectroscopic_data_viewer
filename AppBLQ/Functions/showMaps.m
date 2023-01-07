function [Struct] = showMaps(App, Struct, k)

% Energia                      = Struct.Energia;
DistanciaColumnas            = Struct.DistanciaColumnas;
DistanciaFilas               = Struct.DistanciaFilas;
DistanciaFourierFilas        = Struct.DistanciaFourierFilas;
DistanciaFourierColumnas     = Struct.DistanciaFourierColumnas;
% TamanhoRealFilas             = Struct.TamanhoRealFilas;
% TamanhoRealColumnas          = Struct.TamanhoRealColumnas;
% ParametroRedColumnas         = Struct.ParametroRedColumnas;
% ParametroRedFilas            = Struct.ParametroRedFilas;
% Voltaje                      = Struct.Voltaje;
% MatrizNormalizada            = Struct.MatrizNormalizada;
Filas                        = Struct.Filas;
Columnas                     = Struct.Columnas;
% MaxCorteReal        = Struct.MaxCorteConductancia;
% MinCorteReal         = Struct.MinCorteConductancia;
% SaveFolder                   = Struct.SaveFolder;
% MatrizCorriente              = Struct.MatrizCorriente;
MapasConductancia            = Struct.MapasConductancia;
Transformadas                = Struct.Transformadas;
% PuntosDerivada               = Struct.PuntosDerivada;

%Iniciacion de la figura en el espacio real
cla (App.RealAxes); %Clear axes
    
ImagenReal = imagesc(App.RealAxes,DistanciaColumnas,DistanciaFilas,MapasConductancia{k});
App.RealAxes.YDir = 'normal';
ImagenReal.HitTest = 'Off';
axis(App.RealAxes,'square');
App.RealAxes.Box = 'On';
App.RealAxes.XLim = [min(DistanciaColumnas) max(DistanciaColumnas)];
App.RealAxes.YLim = [min(DistanciaFilas) max(DistanciaFilas)];
App.RealAxes.Colormap = feval(App.RealColormapDropDown.Value);

Ratio = (App.RealAxes.XLim(2) - App.RealAxes.XLim(1))/...
(App.RealAxes.YLim(2) - App.RealAxes.YLim(1));
App.RealAxes.DataAspectRatio = [100,100*Ratio,1];


if ~App.RealLockContrastCheckBox.Value
    App.RealMinSlider.Value = min(MapasConductancia{k},[],'all');
    App.RealMaxSlider.Value = max(MapasConductancia{k},[],'all');
end

App.RealAxes.CLim = [App.RealMinSlider.Value App.RealMaxSlider.Value];
App.RealMaxEdit.Value = App.RealMaxSlider.Value;
App.RealMinEdit.Value = App.RealMinSlider.Value;

%Iniciacion de la figura en espacio reciproco
cla(App.FFTAxes); %Clear axes

ImagenFourier = imagesc(App.FFTAxes, DistanciaFourierColumnas,DistanciaFourierFilas,Transformadas{k});
App.FFTAxes.YDir = 'normal';
ImagenFourier.HitTest = 'Off';
App.FFTAxes.Box = 'on';
axis(App.FFTAxes,'square');
App.FFTAxes.XLim = [min(DistanciaFourierColumnas) max(DistanciaFourierColumnas)];
App.FFTAxes.YLim = [min(DistanciaFourierFilas) max(DistanciaFourierFilas)];
App.FFTAxes.Colormap = feval(App.FFTColormapDropDown.Value);

Ratio = (App.FFTAxes.XLim(2) - App.FFTAxes.XLim(1))/...
(App.FFTAxes.YLim(2) - App.FFTAxes.YLim(1));
App.FFTAxes.DataAspectRatio = [100,100*Ratio,1];

% Quito el punto central para calcular el máximo de las transformadas
TransformadasAUX = Transformadas{k};
TransformadasAUX(floor(Filas)/2+1, floor(Columnas)/2+1) = 0;

if ~App.FFTLockContrastCheckBox.Value
    App.FFTMinSlider.Value = min(Transformadas{k},[],'all');
    App.FFTMaxSlider.Value = max(TransformadasAUX,[],'all');
end

App.FFTAxes.CLim = [App.FFTMinSlider.Value App.FFTMaxSlider.Value];
App.FFTMaxEdit.Value = App.FFTMaxSlider.Value;
App.FFTMinEdit.Value = App.FFTMinSlider.Value;
clear TransformadasAUX

end