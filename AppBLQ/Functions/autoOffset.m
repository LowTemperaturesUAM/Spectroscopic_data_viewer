function [Voffset] = autoOffset(App, Voltaje, MatrizCorriente)
% Calculate the offset, add the voltage value to the offset dialog and 
% place a temporary vertical line on the current plot (and maybe also in
% the conductance)
% Function used in app blqReader.

    VoltajeEscala = App.VoltageScaleFactor.Value;
    OffsetVoltajeValue = App.OffsetvoltageEditField.Value;
    MeanCurrent = mean(MatrizCorriente,2);
    [~,I] = min(MatrizCorriente-MeanCurrent,[],1,ComparisonMethod="abs");
    Counts =  histcounts(I,length(Voltaje));
    [~,Midpoint] = max(Counts);

    Voffset = VoltajeEscala * Voltaje(Midpoint);
    
    %Plot a line in the corresponding position accounting for the current
    %offset applied to the curves
    xline(App.CurrentAxes,Voffset+OffsetVoltajeValue,'k-',HandleVisibility='off')
    xline(App.ConductanceAxes,Voffset+OffsetVoltajeValue,'k-',HandleVisibility='off')

end