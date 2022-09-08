function [Struct] = calculateblq(App, Struct, Voltaje, MatrizCorriente)

Columnas = Struct.Columnas;
Filas = Struct.Filas;
OffsetVoltajeValue = App.OffsetvoltageEditField.Value;
VoltajeEscala = App.VoltageScaleFactor.Value;
NumeroCurvasValue = App.CurvestoshowEditField.Value;
NPuntosDerivadaValue = App.DerivativepointsEditField.Value;
VoltajeNormalizacionSuperior = App.toEditField.Value;
VoltajeNormalizacionInferior = App.fromEditField.Value;

SaveFolder = Struct.SaveFolder;
FileName = Struct.FileName;

VoltajeOffset = Voltaje*VoltajeEscala + OffsetVoltajeValue;

% i = 1+round(rand(NumeroCurvasValue,1)*(Columnas-1)); % Random index for curve selection
% j = 1+round(rand(NumeroCurvasValue,1)*(Filas-1));    % Random index for curve selection
% 
% MatrizCorrienteTest = zeros(length(Voltaje),NumeroCurvasValue);
%         
% for count = 1:NumeroCurvasValue
%     MatrizCorrienteTest(:,count) = MatrizCorriente(:,(Filas*(j(count)-1)+ i(count)));
% end
% clear i j;

IV = length(Voltaje);
[MatrizConductanciaTest] = derivadorLeastSquaresPA(NPuntosDerivadaValue,Struct.MatrizCorrienteTest,Voltaje,1,NumeroCurvasValue);

NormalizationFlag = 0;
if App.NormalizedButton.Value
    NormalizationFlag = 1;
    [MatrizNormalizadaTest] = normalizacionPA(VoltajeNormalizacionSuperior,...
                                          VoltajeNormalizacionInferior,...
                                          VoltajeOffset,...
                                          MatrizConductanciaTest,...
                                          1,NumeroCurvasValue);
    ConductanciaTunel = 1;
else
    MatrizNormalizadaTest = MatrizConductanciaTest; % units: uS
        ConductanciaTunel = mean(max(Struct.MatrizCorrienteTest))/max(Voltaje);
end

% Plot current
cla(App.CurrentAxes);
% axes(App.CurrentAxes);

hold(App.CurrentAxes,'on');
for ContadorCurvas = 1:NumeroCurvasValue
    plot(VoltajeOffset,Struct.MatrizCorrienteTest(:,ContadorCurvas),'-','Parent',App.CurrentAxes);
end
hold(App.CurrentAxes,'off');
App.CurrentAxes.MinorGridLineStyle = ':';

App.CurrentAxes.XLim = [min(VoltajeOffset), max(VoltajeOffset)];
App.CurrentAxes.YLim = [mean(min(Struct.MatrizCorrienteTest)) mean(max(Struct.MatrizCorrienteTest))];
App.CurrentAxes.XGrid = 'on';
App.CurrentAxes.YGrid = 'on';
App.CurrentAxes.Box = 'on';

%Plot conductance
cla(App.ConductanceAxes);
% axes(App.ConductanceAxes);

hold(App.ConductanceAxes,'on');
for ContadorCurvas = 1:NumeroCurvasValue
    plot(VoltajeOffset,MatrizNormalizadaTest(:,ContadorCurvas),'-','Parent',App.ConductanceAxes);
end

App.ConductanceAxes.MinorGridLineStyle = ':';
App.ConductanceAxes.MinorGridColor = 'k';

App.ConductanceAxes.XLim = [min(VoltajeOffset) max(VoltajeOffset)];
App.ConductanceAxes.XGrid = 'on';
App.ConductanceAxes.YGrid = 'on';
App.ConductanceAxes.Box = 'on';

if App.NormalizedButton.Value

    plot([VoltajeNormalizacionInferior,   VoltajeNormalizacionInferior], [0, 2*ConductanciaTunel],'b-',...
        'Parent',App.ConductanceAxes);
    plot([-VoltajeNormalizacionInferior, -VoltajeNormalizacionInferior], [0, 2*ConductanciaTunel],'b-',...
        'Parent',App.ConductanceAxes);
    plot([VoltajeNormalizacionSuperior,   VoltajeNormalizacionSuperior], [0, 2*ConductanciaTunel],'r-',...
        'Parent',App.ConductanceAxes);
    plot([-VoltajeNormalizacionSuperior, -VoltajeNormalizacionSuperior], [0, 2*ConductanciaTunel],'r-',...
        'Parent',App.ConductanceAxes);

    ylabel(App.ConductanceAxes,'Normalized conductance (a.u.)');
        App.ConductanceAxes.YLim = [0, 2*ConductanciaTunel];
else
    ylabel(App.ConductanceAxes,'Conductance (\muS)');
%         App.ConductanceAxes.YLim = [0, 2*ConductanciaTunel];
App.ConductanceAxes.YLim = [0,1.1*max(MatrizNormalizadaTest,[],'all') ];
end

hold(App.ConductanceAxes,'off');

% Save txt

if ~exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'file')
    %
% Saving data from the experiment in a text file
% ------------------------------------------------------------------------
    fileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'w');
    fprintf(fileID, 'Archivo analizado:\r\n');
    fprintf(fileID, '-------------------------------\r\n');
    fprintf(fileID, 'File Name : %s \r\n',FileName(1:length(FileName)-4));
    %fprintf(fileID, 'SaveFolder : %s \r\n',FilePath);
    fprintf(fileID, 'Date : %s \r\n',char(date));
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
%         Struct.MatrizCorrienteTest          = MatrizCorrienteTest;
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