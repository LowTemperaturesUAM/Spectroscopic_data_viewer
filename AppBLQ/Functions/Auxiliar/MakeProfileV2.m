function MakeProfileV2(Info, angle)
    Momentum = Info.DistanciaFourierColumnas*cosd(angle) + Info.DistanciaFourierFilas*sind(angle);

    a=figure(54535);
    imagesc(Info.DistanciaFourierFilas*2*Info.ParametroRedFilas,Info.Energia,Perfiles);
    %axis([0 1 min(InfoStruct.Energia) max(InfoStruct.Energia)]);
    axis([0 1 -85 85]);
    b=gca;
    b.Colormap = parula;
    b.YDir='normal';
    b.YLabel.String = '\fontsize{15} Energy (meV)';
    b.XLabel.String = '\fontsize{15} q';
    b.LineWidth = 2;
    b.FontWeight = 'bold'
end