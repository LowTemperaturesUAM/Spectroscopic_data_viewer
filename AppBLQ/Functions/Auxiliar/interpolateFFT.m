function InfoStruct = interpolateFFT(InfoStruct,ratio)
Maps = InfoStruct.Transformadas;
Phase = InfoStruct.Fase;

NewMaps = cellfun(@(R,A) interp2(R.*exp(1j*A),ratio,'nearest'),...
    Maps,Phase,UniformOutput=false);
[Row,Col] = size(NewMaps{1});
NewRow = linspace(InfoStruct.DistanciaFourierFilas(1),...
    InfoStruct.DistanciaFourierFilas(end),Row);
NewCol = linspace(InfoStruct.DistanciaFourierColumnas(1),...
    InfoStruct.DistanciaFourierColumnas(end),Col);
InfoStruct.Transformadas = cellfun(@(F) abs(F),NewMaps,UniformOutput=false);
InfoStruct.Fase = cellfun(@(F) angle(F),NewMaps,UniformOutput=false);
InfoStruct.DistanciaFourierFilas = NewRow;
InfoStruct.DistanciaFourierColumnas = NewCol;
end