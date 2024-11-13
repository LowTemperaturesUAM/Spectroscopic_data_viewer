%Suma todos los pixels de la FFT dentro de XLim e YLim
function averageScattering(Info)
    Filas = length(Info.DistanciaFourierFilas);
    curvaFFT = zeros(length(Info.Energia),1);
    
    XLim = Info.XLimFFT;
    YLim = Info.YLimFFT;
    
    [~,XInicio] = min(abs(Info.DistanciaFourierColumnas - (XLim(1))));
    [~,XFinal] = min(abs(Info.DistanciaFourierColumnas - (XLim(2))));
    
    [~,YInicio] = min(abs(Info.DistanciaFourierFilas - (YLim(1))));
    [~,YFinal] = min(abs(Info.DistanciaFourierFilas - (YLim(2))));
    
    ColumnasRecorte = XFinal - XInicio + 1;
    FilasRecorte = YFinal - YInicio + 1;
    
    for i=1:length(Info.Energia)
        
        MatrizFFT = Info.Transformadas{i};
%         rem(Filas,2)
        if rem(Filas,2)%Si se ha ajustado el (0,0)
            sum_except = sum(sum(MatrizFFT(YInicio:YFinal,XInicio:XFinal)))/((Filas)*(Filas))...
                - sum(sum(MatrizFFT(floor(Filas/2):floor(Filas/2)+2,floor(Filas/2):floor(Filas/2)+2)))/(Filas*Filas);
            curvaFFT(i) = sum_except./(ColumnasRecorte*FilasRecorte-9);
        else %Si no se ha ajustado el (0,0)
            sum_except = sum(sum(MatrizFFT(YInicio:YFinal,XInicio:XFinal)))/(Filas*Filas)...
                - MatrizFFT(Filas/2+1,Filas/2+1)/(Filas*Filas);
        %     curvaFFT(i) = mean(mean(InfoStruct.Transformadas{i}));
            curvaFFT(i) = sum_except./(ColumnasRecorte*FilasRecorte-1);
    %         curvaFFT(i) = Transformadas{i}(257,257);
        %     curvaFFT (i) = sum(sum(InfoStruct.MapasConductancia{i}));
        end
    end
    
%     curvaFFT = curvaFFT*1e3;%Unidades en nS
    
%     figure(6979)
%     imagesc(Info.Transformadas{18}(YInicio:YFinal,XInicio:XFinal))
    
    figure (57385)
%     plot(Info.Voltaje(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada)...
%     ,curvaFFT(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada))
    plot(Info.Energia,curvaFFT)
    
    b=gca;
    % a.XLim = [-95 95];
    b.Children.LineWidth = 2;
    b.Children.Color = [0 0 0];
    b.FontWeight = 'bold';
    b.LineWidth = 2;
    b.XColor = [0 0 0];
    b.YColor = [0 0 0];
    b.XLabel.String = 'Energy (meV)';
%     b.YLabel.String = 'Conductance (nS)';
    b.YLabel.String = 'Normalized Conductance';

    assignin('base','averageScattering',curvaFFT);
end