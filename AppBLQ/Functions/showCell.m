function [Info] = showCell(App, Cell, Info, k, isReal) %flag: true if Real, false if FFT
previousColormap = App.Axes.Colormap;
% Analize Real
if isReal
    
    DistanciaColumnas            = Info.DistanciaColumnas;
    DistanciaFilas               = Info.DistanciaFilas;
    
    if ~isfield(Info, 'XLimReal')
        Info.XLimReal = [min(DistanciaColumnas) max(DistanciaColumnas)];
    end

    if ~isfield(Info, 'YLimReal')
        Info.YLimReal = [min(DistanciaFilas) max(DistanciaFilas)];
    end
    
    cla (App.Axes); %Clear axes
%     App.Axes.DataAspectRatioMode = 'manual';

    ImagenReal = imagesc(App.Axes,DistanciaColumnas,DistanciaFilas,Cell{k});
    App.Axes.YDir = 'normal';
    ImagenReal.HitTest = 'Off';
    axis(App.Axes,'square');
    App.Axes.Box = 'On';
    App.Axes.XLim = Info.XLimReal;
    App.Axes.YLim = Info.YLimReal;  
    
    if App.Interpolation
        App.Axes.Children.Interpolation = 'bilinear';
    end
    App.Axes.Colormap = previousColormap;
% 
%     Ratio = (App.Axes.XLim(2) - App.Axes.XLim(1))/...
%     (App.Axes.YLim(2) - App.Axes.YLim(1));
%     App.Axes.DataAspectRatio = [1,Ratio,1];
    App.Axes.DataAspectRatio = [1,1,1];
%     App.Axes.DataAspectRatioMode = 'auto';

%     if ~App.RealLockContrastCheckBox.Value
%         App.RealMinSlider.Limits = [min(min(MapasConductancia{k})) max(max(MapasConductancia{k}))];
%         App.RealMaxSlider.Limits = [min(min(MapasConductancia{k})) max(max(MapasConductancia{k}))];
%     %     App.RealMinSlider.Value = App.RealMinSlider.Limits(1);
%     %     App.RealMaxSlider.Value = App.RealMaxSlider.Limits(2);
%     end
    
    %I make sure to choose Values inside the defined Limits or the limits themselves.
    
    values = chooseContrast(Info.ContrastReal(:,k),...
        App.MinSlider.Limits(1), App.MaxSlider.Limits(2));

    App.MinSlider.Value = values(1); 
    App.MinEditField.Value = App.MinSlider.Value;
    App.MaxSlider.Value = values(2);
    App.MaxEditField.Value = App.MaxSlider.Value;
    App.Axes.CLim = [App.MinSlider.Value; App.MaxSlider.Value];
    
else % Analize FFT
    
    DistanciaFourierFilas        = Info.DistanciaFourierFilas;
    DistanciaFourierColumnas     = Info.DistanciaFourierColumnas;
%     Filas                        = Info.Filas;
%     Columnas                     = Info.Columnas;

    if ~isfield(Info, 'XLimFFT')
        Info.XLimFFT = [min(DistanciaFourierColumnas) max(DistanciaFourierColumnas)];
    end

    if ~isfield(Info, 'YLimFFT')
        Info.YLimFFT = [min(DistanciaFourierFilas) max(DistanciaFourierFilas)];
    end
    
    cla(App.Axes); %Clear axes

    ImagenFourier = imagesc(App.Axes, DistanciaFourierColumnas,DistanciaFourierFilas,Cell{k});
    App.Axes.YDir = 'normal';
    ImagenFourier.HitTest = 'Off';
    App.Axes.Box = 'on';
    axis(App.Axes,'square');
    App.Axes.XLim = Info.XLimFFT;
    App.Axes.YLim = Info.YLimFFT;
    
    if App.Interpolation
        App.Axes.Children.Interpolation = 'bilinear';
    end
        
    App.Axes.Colormap = previousColormap;

%     Ratio = (App.Axes.XLim(2) - App.Axes.XLim(1))/...
%     (App.Axes.YLim(2) - App.Axes.YLim(1));
%     App.Axes.DataAspectRatio = [100,100*Ratio,1];
    App.Axes.DataAspectRatio = [1,1,1];

%     % Quito el punto central para calcular el máximo de las transformadas
%     TransformadasAUX = Cell{k};
%     TransformadasAUX(Filas/2+1, Columnas/2+1) = 0;
% 
%     if ~App.RealLockContrastCheckBox.Value
%         App.FFTMinSlider.Limits = [min(min(Transformadas{k})) max(max(TransformadasAUX))];
%         App.FFTMaxSlider.Limits = [min(min(Transformadas{k})) max(max(TransformadasAUX))];
%     %     App.FFTMinSlider.Value = App.FFTMinSlider.Limits(1);
%     %     App.FFTMaxSlider.Value = App.FFTMaxSlider.Limits(2);
%     end
    
%I make sure to choose Values inside the defined Limits or the limits themselves.
    values = chooseContrast(Info.ContrastFFT(:,k),...
        App.MinSlider.Limits(1), App.MaxSlider.Limits(2));

    App.MinSlider.Value = values(1);
    App.MinEditField.Value = App.MinSlider.Value;
    App.MaxSlider.Value = values(2);
    App.MaxEditField.Value = App.MaxSlider.Value;
    App.Axes.CLim = [App.MinSlider.Value, App.MaxSlider.Value];
%     clear TransformadasAUX


end
    if App.ColorbarCheckBox.Value
        set(App.Colorbar, 'Limits', values, 'YTick', values,'TickLength', 0)
    end
end