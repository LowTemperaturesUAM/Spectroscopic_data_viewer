function [Struct] = calculateblqV2(App, Struct, Voltaje, MatrizCorriente)

Columnas = Struct.Columnas;
Filas = Struct.Filas;
OffsetVoltajeValue = App.OffsetvoltageEditField.Value;
VoltajeEscala = App.VoltageScaleFactor.Value;
NumeroCurvasValue = App.CurvestoshowEditField.Value;
derivPts = App.DerivativepointsSpinner.Value;
VoltajeNormalizacionSuperior = App.toEditField.Value;
VoltajeNormalizacionInferior = App.fromEditField.Value;
AutoAxis = App.AutoAxisBtn.Value;
Centered = App.CenterCurrentBtn.Value;

SaveFolder = Struct.SaveFolder;
FileName = Struct.FileName;

VoltajeOffset = Voltaje*VoltajeEscala + OffsetVoltajeValue;


IV = length(Voltaje);


% Get the conductance curve accordingly, depending of the method selected
if App.NormalizeMirrorButton.Value
    NormalizationFlag = 'mirror window';
    MatrizNormalizadaTest = getDerivative(Struct.MatrizCorrienteTest,...
        Voltaje,derivPts,LowerValue=VoltajeNormalizacionInferior,...
        UpperValue=VoltajeNormalizacionSuperior,Method="mirrorNorm");
elseif App.NormalizeSingleButton.Value
    NormalizationFlag = 'single side';
    MatrizNormalizadaTest = getDerivative(Struct.MatrizCorrienteTest,...
        Voltaje,derivPts,LowerValue=VoltajeNormalizacionInferior,...
        UpperValue=VoltajeNormalizacionSuperior,Method="singleNorm");
elseif App.FeenstraNormButton.Value
    NormalizationFlag = 'Feenstra'; 
    MatrizNormalizadaTest = getDerivative(Struct.MatrizCorrienteTest,...
        Voltaje,derivPts,Method="FeenstraNorm");
elseif App.LogButton.Value
    NormalizationFlag = 'log';
    MatrizNormalizadaTest = getDerivative(Struct.MatrizCorrienteTest,...
        Voltaje,derivPts,Method="Log");
else
    NormalizationFlag = 'none';
    MatrizNormalizadaTest = getDerivative(Struct.MatrizCorrienteTest,...
        Voltaje,derivPts,Method="none"); % units: uS
end

% Plot current
cla(App.CurrentAxes)
plot(App.CurrentAxes,VoltajeOffset,Struct.MatrizCorrienteTest,'-');

App.CurrentAxes.XGrid = 'on';
App.CurrentAxes.YGrid = 'on';
App.CurrentAxes.Box = 'on';
App.CurrentAxes.Interactions = [zoomInteraction regionZoomInteraction rulerPanInteraction];

%Plot conductance
cla(App.ConductanceAxes)
% Clear normalization and offset lines
curve = findall(App.ConductanceAxes,'Type','ConstantLine'); 
delete(curve)

plot(VoltajeOffset,MatrizNormalizadaTest,'-','Parent',App.ConductanceAxes);

App.ConductanceAxes.MinorGridLineStyle = ':';
App.ConductanceAxes.MinorGridColor = 'k';



if App.NormalizeMirrorButton.Value
    xline(App.ConductanceAxes,VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,-VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    xline(App.ConductanceAxes,-VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
elseif App.NormalizeSingleButton.Value
    xline(App.ConductanceAxes,VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
elseif App.FeenstraNormButton.Value
    ylabel(App.ConductanceAxes,'Normalized conductance dI/dV/(I/V) (a.u.)');
elseif App.LogButton.Value
    ylabel(App.ConductanceAxes,'Logarithmic conductance dlog(I)/dV (a.u.)');
else
    ylabel(App.ConductanceAxes,'Conductance (\muS)');
end


%now that we only use actual curves beforehand, we don't have to check every
%time
if AutoAxis && Centered
    % make sure current is centered at zero, and the axis are adjusted to the curves being plotted
    App.CurrentAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
    Imin = min(Struct.MatrizCorrienteTest,[],'all');
    Imax = max(Struct.MatrizCorrienteTest,[],'all');
    App.CurrentAxes.YLim = [-1,1]*abs(max(Imin,Imax,ComparisonMethod = 'abs'));
    App.ConductanceAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
    App.ConductanceAxes.YLimMode = 'auto';
    App.ConductanceAxes.YLimitMethod = 'tight';
elseif AutoAxis && ~Centered
    %Autoranging without centering. We leave matlab do it on its own
    App.CurrentAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
    App.CurrentAxes.YLimMode = 'auto';
    App.CurrentAxes.YLimitMethod = 'tight';
    App.ConductanceAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
    App.ConductanceAxes.YLimMode = 'auto';
    App.ConductanceAxes.YLimitMethod = 'tight';
else
    App.CurrentAxes.YLimMode = 'manual';
    App.ConductanceAxes.YLimMode = 'manual';
end

% Save txt

if ~exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'file')
    %
% Saving data to the header of the text file
% ------------------------------------------------------------------------
    fileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'W');
    fprintf(fileID, 'Archivo analizado:\r\n');
    fprintf(fileID, '-------------------------------\r\n');
    fprintf(fileID, 'File Name : %s \r\n',FileName(1:length(FileName)-4));
    %fprintf(fileID, 'SaveFolder : %s \r\n',FilePath);
    fprintf(fileID, 'Date : %s \r\n',char(datetime('today')));
    fprintf(fileID, '-------------------------------\r\n');
    fprintf(fileID, '\r\n');
    fprintf(fileID, 'Datos del Experimento\r\n');
    fprintf(fileID, '-------------------------------\r\n');
    fprintf(fileID, 'Campo                   : %g T\r\n', Struct.Campo);
    fprintf(fileID, 'Temperatura             : %g K\r\n', Struct.Temperatura) ;
    fprintf(fileID, 'Corriente Tunel         : %g nA\r\n',mean(max(MatrizCorriente)));
    fprintf(fileID, 'Tamaño Filas            : %g nm\r\n',Struct.TamanhoRealFilas);
    fprintf(fileID, 'Tamaño Columnas         : %g nm\r\n',Struct.TamanhoRealColumnas);
    fprintf(fileID, 'Parametro red Columnas  : %g nm\r\n',Struct.ParametroRedColumnas);
    fprintf(fileID, 'Parametro red Filas     : %g nm\r\n',Struct.ParametroRedFilas);
    fprintf(fileID, '-------------------------------\r\n');
    fclose(fileID);
end  

% Saving into Structure to pass to analysis
% ------------------------------------------------------------------------
Struct.fileID                       = fileID;

% Fix data (raw data)
% ---------------------------------------------
Struct.Voltaje                      = VoltajeOffset;
Struct.IV                           = IV;
Struct.MatrizNormalizadaTest        = MatrizNormalizadaTest;
%Struct.MatrizCorrienteTest          = MatrizCorrienteTest;
% Struct.MatrizCorriente              = MatrizCorriente; %its already there, WHy?
Struct.NPuntosImagen                = Filas*Columnas;
Struct.Filas                        = Filas;
Struct.Columnas                     = Columnas;

% Variable data (curve analysis)
% ---------------------------------------------
Struct.NumeroCurvas                 = NumeroCurvasValue;
Struct.NPuntosDerivada              = derivPts;
Struct.VoltajeNormalizacionInferior	= VoltajeNormalizacionInferior;
Struct.VoltajeNormalizacionSuperior	= VoltajeNormalizacionSuperior;
Struct.OffsetVoltaje                = OffsetVoltajeValue;
Struct.NormalizationFlag            = NormalizationFlag;



end