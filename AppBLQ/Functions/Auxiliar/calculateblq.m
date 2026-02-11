function [Struct] = calculateblq(App, Struct, Voltaje, MatrizCorriente)

Columnas = Struct.Columnas;
Filas = Struct.Filas;
OffsetVoltajeValue = App.OffsetvoltageEditField.Value;
VoltajeEscala = App.VoltageScaleFactor.Value;
NumeroCurvasValue = App.CurvestoshowEditField.Value;
NPuntosDerivadaValue = App.DerivativepointsSpinner.Value;
VoltajeNormalizacionSuperior = App.toEditField.Value;
VoltajeNormalizacionInferior = App.fromEditField.Value;
AutoAxis = App.AutoAxisBtn.Value;

SaveFolder = Struct.SaveFolder;
FileName = Struct.FileName;

VoltajeOffset = Voltaje*VoltajeEscala + OffsetVoltajeValue;

Struct.MatrizCorriente;
IV = length(Voltaje);
[MatrizConductanciaTest] = derivadorLeastSquaresArray(NPuntosDerivadaValue,Struct.MatrizCorrienteTest,Voltaje);

% Get the conductance curve accordingly, depending of the method selected
if App.NormalizeMirrorButton.Value
    NormalizationFlag = 'mirror window';
    [MatrizNormalizadaTest] = NormalizeRange(VoltajeNormalizacionSuperior,...
        VoltajeNormalizacionInferior,VoltajeOffset,MatrizConductanciaTest,Range = "both");
    ConductanciaTunel = 1;
elseif App.NormalizeSingleButton.Value
    NormalizationFlag = 'single side';
    [MatrizNormalizadaTest] = NormalizeRange(VoltajeNormalizacionSuperior,...
        VoltajeNormalizacionInferior,VoltajeOffset,MatrizConductanciaTest,Range = "single");
    ConductanciaTunel = 1;

elseif App.FeenstraNormButton.Value
    NormalizationFlag = 'Feenstra'; %for now, but it has to change for the analysis
    Ismooth = zeros(size(Struct.MatrizCorrienteTest));
    for i=1:NumeroCurvasValue
        Ismooth(:,i) = smooth(Struct.MatrizCorrienteTest(:,i),Struct.Fspan,Struct.Fmethod);
    end
    Imin = interp1(VoltajeOffset,Ismooth,0);

    GTest = (Ismooth-Imin)./VoltajeOffset;
    if any( VoltajeOffset == 0 )
        center = find(VoltajeOffset == 0 );
        GTest(center,:) = 0.5*(GTest(center+1,:)+ GTest(center-1,:));
    end
    
    if Struct.F2check
        [~,center] = min(VoltajeOffset,[],1,ComparisonMethod="abs");
        midspan = floor(0.1*length(VoltajeOffset));
        for i=1:NumeroCurvasValue
            GTest(center-midspan:center+midspan,i) =...
                smooth(GTest(center-midspan:center+midspan,i),Struct.Fspan2,Struct.Fmethod2);
        end
    end

    MatrizNormalizadaTest = MatrizConductanciaTest./GTest;
    ConductanciaTunel = 1;
elseif App.LogButton.Value
    NormalizationFlag = 'log';
    [MatrizNormalizadaTest] = NormalizeRange(VoltajeNormalizacionSuperior,...
        VoltajeNormalizacionInferior,VoltajeOffset,MatrizConductanciaTest,Range = "single");
    ConductanciaTunel = 1;
else
    MatrizNormalizadaTest = MatrizConductanciaTest; % units: uS
    % This is not technically correct if the set point is negative
    ConductanciaTunel = mean(max(Struct.MatrizCorrienteTest))/max(Voltaje);
    NormalizationFlag = 'none';
end

% Plot current
cla(App.CurrentAxes)
% axes(App.CurrentAxes);
% Clear normalization and offset lines
curve = findall(App.CurrentAxes,'Type','ConstantLine'); 
delete(curve)
% hold(App.CurrentAxes,'on');
% for ContadorCurvas = 1:NumeroCurvasValue
%     plot(VoltajeOffset,Struct.MatrizCorrienteTest(:,ContadorCurvas),'-','Parent',App.CurrentAxes);
% end
% hold(App.CurrentAxes,'off');
plot(VoltajeOffset,Struct.MatrizCorrienteTest,'-','Parent',App.CurrentAxes);
App.CurrentAxes.MinorGridLineStyle = ':';

App.CurrentAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
if ~all(Struct.MatrizCorrienteTest==0,'all') && AutoAxis %Check for empty curves
    Imin = min(Struct.MatrizCorrienteTest,[],'all');
    Imax = max(Struct.MatrizCorrienteTest,[],'all');
    App.CurrentAxes.YLim = [-1,1]*abs(max(Imin,Imax,ComparisonMethod = 'abs'));
    % App.CurrentAxes.YLim = [min(Struct.MatrizCorrienteTest,[],'all') max(Struct.MatrizCorrienteTest,[],'all')];
end
App.CurrentAxes.XGrid = 'on';
App.CurrentAxes.YGrid = 'on';
App.CurrentAxes.Box = 'on';
App.CurrentAxes.Interactions = [zoomInteraction regionZoomInteraction rulerPanInteraction];

%Plot conductance
cla(App.ConductanceAxes)
% axes(App.ConductanceAxes);
% Clear normalization and offset lines
curve = findall(App.ConductanceAxes,'Type','ConstantLine'); 
delete(curve)
% hold(App.ConductanceAxes,'on');
% for ContadorCurvas = 1:NumeroCurvasValue
%     plot(VoltajeOffset,MatrizNormalizadaTest(:,ContadorCurvas),'-','Parent',App.ConductanceAxes);
% end
plot(VoltajeOffset,MatrizNormalizadaTest,'-','Parent',App.ConductanceAxes);

App.ConductanceAxes.MinorGridLineStyle = ':';
App.ConductanceAxes.MinorGridColor = 'k';

App.ConductanceAxes.XLim = [min(VoltajeOffset) max(VoltajeOffset)];
App.ConductanceAxes.XGrid = 'on';
App.ConductanceAxes.YGrid = 'on';
App.ConductanceAxes.Box = 'on';

if App.NormalizeMirrorButton.Value
    xline(App.ConductanceAxes,VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,-VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    xline(App.ConductanceAxes,-VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
    % App.ConductanceAxes.YLim = [0,max( 1.1*max(MatrizNormalizadaTest,[],'all'), 2*ConductanciaTunel) ];
elseif App.NormalizeSingleButton.Value
    xline(App.ConductanceAxes,VoltajeNormalizacionInferior,'b-',HandleVisibility='off')
    xline(App.ConductanceAxes,VoltajeNormalizacionSuperior,'r-',HandleVisibility='off')
    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
    % App.ConductanceAxes.YLim = [0,max( 1.1*max(MatrizNormalizadaTest,[],'all'), 2*ConductanciaTunel) ];
elseif App.FeenstraNormButton.Value
    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
    % App.ConductanceAxes.YLim = [0,max( 1.1*max(MatrizNormalizadaTest,[],'all'), 2*ConductanciaTunel) ];
else
    ylabel(App.ConductanceAxes,'Conductance (\muS)');
%         App.ConductanceAxes.YLim = [0, 2*ConductanciaTunel];
    % App.ConductanceAxes.YLim = [0,1.1*max(MatrizNormalizadaTest,[],'all') ];
    % App.ConductanceAxes.YLimMode= 'auto';
end

if AutoAxis
    App.ConductanceAxes.YLimMode = 'auto';
else
    % App.ConductanceAxes.YLim = [0,max( 1.1*max(MatrizNormalizadaTest,[],'all'), 2*ConductanciaTunel) ];
end

% hold(App.ConductanceAxes,'off');

% Save txt

if ~exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'file')
    %
% Saving data from the experiment in a text file
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
else
    fileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'r');
    fclose(fileID);
end
% Displaying info    
% ------------------------------------------------------------------------

    fprintf('-------------------------\n');
    fprintf('Análisis de %s\n',     FileName);
    fprintf('-------------------------\n');
    

% Saving into Structure to pass to analysis
% ------------------------------------------------------------------------
Struct.fileID                       = fileID;

% Fix data (raw data)
% ---------------------------------------------
Struct.Voltaje                      = VoltajeOffset;
Struct.IV                           = IV;
Struct.MatrizNormalizadaTest        = MatrizNormalizadaTest;
%Struct.MatrizCorrienteTest          = MatrizCorrienteTest;
Struct.MatrizCorriente              = MatrizCorriente;
Struct.NPuntosImagen                = Filas*Columnas;
Struct.Filas                        = Filas;
Struct.Columnas                     = Columnas;

% Variable data (curve analysis)
% ---------------------------------------------
Struct.NumeroCurvas                 = NumeroCurvasValue;
Struct.NPuntosDerivada              = NPuntosDerivadaValue;
Struct.VoltajeNormalizacionInferior	= VoltajeNormalizacionInferior;
Struct.VoltajeNormalizacionSuperior	= VoltajeNormalizacionSuperior;
Struct.OffsetVoltaje                = OffsetVoltajeValue;
Struct.NormalizationFlag            = NormalizationFlag;



end