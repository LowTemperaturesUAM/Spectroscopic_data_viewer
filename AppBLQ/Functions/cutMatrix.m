function InfoCut = cutMatrix(Info)
    InfoCut = Info;
    XLim = Info.XLimFFT;%(:,1);
    YLim = Info.YLimFFT;%(:,1);
    
    [~,XInicio] = min(abs(Info.DistanciaFourierColumnas - (XLim(1))));
    [~,XFinal] = min(abs(Info.DistanciaFourierColumnas - (XLim(2))));
    
    [~,YInicio] = min(abs(Info.DistanciaFourierFilas - (YLim(1))));
    [~,YFinal] = min(abs(Info.DistanciaFourierFilas - (YLim(2))));
    
%     ColumnasRecorte = XFinal - XInicio + 1;
%     FilasRecorte = YFinal - YInicio + 1;
    
    for i=1:length(Info.Energia)
        InfoCut.Transformadas{i} = Info.Transformadas{i}(YInicio:YFinal, XInicio:XFinal);
    end
    
    InfoCut.DistanciaFourierColumnas = Info.DistanciaFourierColumnas(XInicio:XFinal);
    InfoCut.DistanciaFourierFilas = Info.DistanciaFourierFilas(YInicio:YFinal);

end