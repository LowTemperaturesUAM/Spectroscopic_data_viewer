function [Struct] = analyzeImages(Struct)

Date       = datetime;
SaveFolder = Struct.SaveFolder;
FileName   = Struct.FileName;
    
FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'a');
        fprintf(FileID, '\r\n');
        fprintf(FileID, '\r\n');
        fprintf(FileID, 'Fecha análisis: %s \r\n',char(Date));
        fprintf(FileID, '-------------------------------\r\n');
        fprintf(FileID, 'Number of curves      : %g \r\n', Struct.NumeroCurvas );
        fprintf(FileID, 'Deriv points          : %g \r\n', Struct.NPuntosDerivada ); 
        fprintf(FileID, 'Offset                : %g mV\r\n', Struct.OffsetVoltaje);
        fprintf(FileID, 'Normalize min         : %g mV\r\n', Struct.VoltajeNormalizacionInferior);
        fprintf(FileID, 'Normalize max         : %g mV\r\n', Struct.VoltajeNormalizacionSuperior); 
        fclose(FileID);

Struct.datosIniciales = customCurvesv3(Struct.SaveFolder, Struct.FileName, Struct);

%------------------------------------------------------------------------
% CONSTANTS:
% -----------------------------------------------------------------------
    Pi = 3.141592653589793;
% -----------------------------------------------------------------------
	FileName                            = Struct.FileName;
	FilePath                            = Struct.FilePath;
    
	IV                                  = Struct.IV;
	MatrizCorriente                     = Struct.MatrizCorriente;
        
	PuntosDerivada                      = Struct.NPuntosDerivada;
	Voltaje                             = Struct.Voltaje;
	VoltajeNormalizacionInferior        = Struct.VoltajeNormalizacionInferior;
	VoltajeNormalizacionSuperior        = Struct.VoltajeNormalizacionSuperior;

	CorteInferiorInicialConductancia    = Struct.datosIniciales.corteInferior;
	CorteSuperiorInicialConductancia    = Struct.datosIniciales.corteSuperior;
        
    DeltaEnergia                        = Struct.datosIniciales.DeltaEnergia;
    PasoMapas                           = Struct.datosIniciales.PasoMapas;
    Energia                             = (Struct.datosIniciales.EnergiaMin:PasoMapas:Struct.datosIniciales.EnergiaMax);
 
    Filas                               = Struct.Filas;
    Columnas                            = Struct.Columnas;
    TamanhoRealFilas                    = Struct.TamanhoRealFilas;
    TamanhoRealColumnas                 = Struct.TamanhoRealColumnas;
    ParametroRedFilas                   = Struct.ParametroRedFilas;
    ParametroRedColumnas                = Struct.ParametroRedColumnas;
    TamanhoPixelFilas                   = TamanhoRealFilas/Filas;
    TamanhoPixelColumnas                = TamanhoRealColumnas/Columnas;
% ------------------------------------------------------------------------
% Defining units in direct and reciprocal space
% ------------------------------------------------------------------------
	DistanciaColumnas = TamanhoPixelColumnas*(1:1:Columnas);
    DistanciaFilas = TamanhoPixelFilas*(1:1:Filas);
    
    DistanciaFourierColumnas = (1/TamanhoRealColumnas)*(1:1:Columnas);
    DistanciaFourierFilas = (1/TamanhoRealFilas)*(1:1:Filas);
% ------------------------------------------------------------------------
% Centering reciprocal space units
% ------------------------------------------------------------------------
	DistanciaFourierColumnas = DistanciaFourierColumnas - DistanciaFourierColumnas(floor(Columnas/2)+1); 
    DistanciaFourierFilas = DistanciaFourierFilas - DistanciaFourierFilas(floor(Filas/2)+1);
% ------------------------------------------------------------------------        
% Changing reciprocal space units to 2\pi/a  
% ------------------------------------------------------------------------
	DistanciaFourierColumnas = DistanciaFourierColumnas*(Struct.ParametroRedColumnas);
    DistanciaFourierFilas = DistanciaFourierFilas*(Struct.ParametroRedFilas);
% ------------------------------------------------------------------------
% Absolute units    
% ------------------------------------------------------------------------
    DistanciaFourierColumnas = DistanciaFourierColumnas/(Struct.ParametroRedColumnas);
    DistanciaFourierFilas = DistanciaFourierFilas/(Struct.ParametroRedFilas);
% ------------------------------------------------------------------------    
% Derivating the tunneling matrix
% ------------------------------------------------------------------------
    [MatrizConductancia] = derivadorLeastSquaresPA(PuntosDerivada,...
                                                   MatrizCorriente,...
                                                   Voltaje,...
                                                   Filas,Columnas);
% ------------------------------------------------------------------------
% Normalizing (or not) the data
% ------------------------------------------------------------------------
	if Struct.NormalizationFlag                           
        [MatrizNormalizada] = normalizacionPA(VoltajeNormalizacionSuperior,...
                                              VoltajeNormalizacionInferior,...
                                              Voltaje,...
                                              MatrizConductancia,...
                                              Filas,Columnas);
        ConductanciaTunel = 1;
    else
        MatrizNormalizada = MatrizConductancia; % units: uS
        ConductanciaTunel = mean(max(MatrizCorriente))/max(Voltaje);
	end
% ------------------------------------------------------------------------
% Removing bad data points with the first cut
% ------------------------------------------------------------------------
    MatrizNormalizadaCortada = MatrizNormalizada;
    MatrizNormalizadaCortada(MatrizNormalizadaCortada < CorteInferiorInicialConductancia) = CorteInferiorInicialConductancia;
    MatrizNormalizadaCortada(MatrizNormalizadaCortada > CorteSuperiorInicialConductancia) = CorteSuperiorInicialConductancia;
% ------------------------------------------------------------------------   
% Considering conductance curves at each point creates conductance maps
% averaging points around a certain DeltaEnergia and its 2D-FFT map
% ------------------------------------------------------------------------
fileID = Struct.fileID;
% creo que estamos sobreescribiendo lo anterior!!!
fprintf(fileID, 'Valores de Energia: de %g mV a %g mV en pasos de %g mV\r\n',...
                Energia(1), Energia(length(Energia)),PasoMapas);
fprintf(fileID, 'Delta de Energia  : %g mv\r\n', DeltaEnergia);
fprintf(fileID, '-------------------------------\r\n');
fprintf(fileID, '\r\n\r\n');
% ------------------------------------------------------------------------
% Warning for empty matrices
% ------------------------------------------------------------------------
if abs(Voltaje(2) - Voltaje(1)) > 2*DeltaEnergia
    fprintf('AVISO: El paso de voltaje es MAYOR que el intervalo seleccionado. Es posible que aparezcan MATRICES en BLANCO.\n');
elseif abs(Voltaje(2) - Voltaje(1)) < 2*DeltaEnergia
    fprintf('El paso de voltaje es menor que el intervalo seleccionado.\n');
else
    fprintf('El paso de voltaje es justamente el intervalo seleccionado.\n');
end
% ------------------------------------------------------------------------
% Arrays to use in this part
% ------------------------------------------------------------------------
%   Indices:            IV index to average in each map.
%
%   MapasConductancia:  conductance map for each energy value in the
%                       corresponding conductance units.
%
%   Transformadas:      2D-FFT of the corresponding conductance map in the
%                       corresponding conductance units.
% ------------------------------------------------------------------------
    Indices = cell(length(Energia),1);
    MapasConductancia = cell(1,length(Energia));
    MapasConductanciaAUX = cell(1,length(Energia));
    Transformadas = cell(1,length(Energia));
    
    choice_1 = questdlg('Conductance maps or current maps?','Confirmation','Conductance','Current','X');
    choice_2 = questdlg('Sweep direction?','Confirmation','X','Y','X');   
    
    if strcmp(choice_1,'Conductance')                
        for k = 1:length(Energia)
            Indices{k} = find(Energia(k)- DeltaEnergia < Voltaje & Energia(k)+ DeltaEnergia > Voltaje);
            MapasConductanciaAUX{k} = mean(MatrizNormalizadaCortada(Indices{k},:),1);
            MapasConductancia{k} = reshape(MapasConductanciaAUX{k},[Columnas,Filas]);
            MapasConductancia{k} = MapasConductancia{k}';
            if strcmp(choice_2,'Y')
                MapasConductancia{k} = imrotate(MapasConductancia{k},-90);
                MapasConductancia{k} = fliplr(MapasConductancia{k} );
            end
            Transformadas{k} = fft2d(MapasConductancia{k});
    %         Transformadas{k} = Transformadas{k}/(TamanhoRealFilas*TamanhoRealColumnas); % Lo comento porque no entiendo nada
        end
    else
        for k = 1:length(Energia)
            Indices{k} = find(Energia(k)- DeltaEnergia < Voltaje & Energia(k)+ DeltaEnergia > Voltaje);
            MapasConductanciaAUX{k} = mean(MatrizCorriente(Indices{k},:),1);
            MapasConductancia{k} = reshape(MapasConductanciaAUX{k},[Columnas,Filas]);
            MapasConductancia{k} = MapasConductancia{k}';
            if strcmp(choice_2,'Y')
                MapasConductancia{k} = imrotate(MapasConductancia{k},-90);
                MapasConductancia{k} = fliplr(MapasConductancia{k} );
            end
            Transformadas{k} = fft2d(MapasConductancia{k});
    %         Transformadas{k} = Transformadas{k}/(TamanhoRealFilas*TamanhoRealColumnas); % Lo comento porque no entiendo nada
        end
    end
clear k Indices DeltaEnergia MapasConductanciaAUX;
% ------------------------------------------------------------------------
% Creating structures to pass to GUI analysis
% ------------------------------------------------------------------------
k = ceil(length(Energia)/2);

    Struct.Energia                      = Energia;
    Struct.DistanciaColumnas            = DistanciaColumnas;
    Struct.DistanciaFilas               = DistanciaFilas;
    Struct.MatrizCorriente              = MatrizCorriente;
    Struct.MatrizNormalizada            = MatrizNormalizadaCortada;
    Struct.Voltaje                      = Voltaje;
    Struct.TamanhoRealFilas             = TamanhoRealFilas;
    Struct.TamanhoRealColumnas          = TamanhoRealColumnas;
    Struct.DistanciaFourierColumnas     = DistanciaFourierColumnas;
    Struct.DistanciaFourierFilas        = DistanciaFourierFilas;
    Struct.Filas                        = Filas;
    Struct.Columnas                     = Columnas;
    Struct.MaxCorteConductancia         = CorteSuperiorInicialConductancia;
    Struct.MinCorteConductancia         = CorteInferiorInicialConductancia;
    Struct.Transformadas                = Transformadas;
    Struct.MapasConductancia            = MapasConductancia;
    Struct.PuntosDerivada               = PuntosDerivada;
    Struct.kInicial                     = k;
    if strcmp(choice_1,'Conductance')
       Struct.MaxCorteConductancia         = 100;
       Struct.MinCorteConductancia         = -100;
    end
% ------------------------------------------------------------------------

end