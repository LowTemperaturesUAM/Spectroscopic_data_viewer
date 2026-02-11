function [Struct] = analyzeImages(Struct)

Date       = datetime;
SaveFolder = Struct.SaveFolder;
FileName   = Struct.FileName;
% We should consolidate this to use the same function than in recalculate maps
% Than one currently uses customCurvesWindow
[datosIniciales, scandir, maptype, mapmethod,secondDerivPts] = customCurvesv7(Struct.SaveFolder, Struct.FileName, Struct);


if isequal(datosIniciales,0)
    Struct = 0;
    return
else
    writematrix([datosIniciales.corteInferior; datosIniciales.corteSuperior;...
    datosIniciales.EnergiaMin; datosIniciales.EnergiaMax;...
    datosIniciales.DeltaEnergia; datosIniciales.PasoMapas;...
    Struct.NumeroCurvas; Struct.NPuntosDerivada;...
    Struct.OffsetVoltaje; Struct.VoltajeNormalizacionInferior;...
    Struct.VoltajeNormalizacionSuperior],...
    [SaveFolder,filesep,FileName(1:length(FileName)-4),'.in'],...
    FileType='text',WriteMode='overwrite')

    FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'A');
    fprintf(FileID, '\r\n');
    fprintf(FileID, '\r\n');
    fprintf(FileID, 'Fecha análisis: %s \r\n',char(Date));
    fprintf(FileID, '-------------------------------\r\n');
    fprintf(FileID,'Curves selected       : [%d %d %d %d]\r\n',Struct.CurveSelection);
    fprintf(FileID, 'Deriv points          : %g \r\n', Struct.NPuntosDerivada );
    fprintf(FileID, 'Offset                : %g mV\r\n', Struct.OffsetVoltaje);
    switch Struct.NormalizationFlag
        case {'single side'}
            fprintf(FileID, 'Normalization         : single side\r\n');
            fprintf(FileID, 'Normalize min         : %g mV\r\n', Struct.VoltajeNormalizacionInferior);
            fprintf(FileID, 'Normalize max         : %g mV\r\n', Struct.VoltajeNormalizacionSuperior);
            fprintf(FileID, 'Corte Inf Conduc      : %g\r\n',datosIniciales.corteInferior);
            fprintf(FileID, 'Corte Sup Conduc      : %g\r\n',datosIniciales.corteSuperior);
        case {'mirror window'}
            lowbound = min(Struct.VoltajeNormalizacionInferior,...
                Struct.VoltajeNormalizacionSuperior,ComparisonMethod="abs");
            highbound = max(Struct.VoltajeNormalizacionInferior,...
                Struct.VoltajeNormalizacionSuperior,ComparisonMethod="abs");
            fprintf(FileID, 'Normalization         : symmetrical\r\n');
            fprintf(FileID, 'Normalize min         : ±%g mV\r\n', abs(lowbound));
            fprintf(FileID, 'Normalize max         : ±%g mV\r\n', abs(highbound));
            fprintf(FileID, 'Corte Inf Conduc      : %g\r\n',datosIniciales.corteInferior);
            fprintf(FileID, 'Corte Sup Conduc      : %g\r\n',datosIniciales.corteSuperior);
        case 'none'
            fprintf(FileID, 'Normalization         : none\r\n');
            fprintf(FileID, 'Corte Inf Conduc      : %g uS\r\n',datosIniciales.corteInferior);
            fprintf(FileID, 'Corte Sup Conduc      : %g uS\r\n',datosIniciales.corteSuperior);
        %case 'Feenstra'
    end
    fprintf(FileID, 'Dibuja de             : %g mV\r\n',datosIniciales.EnergiaMin);
    fprintf(FileID, ' a                    : %g mV\r\n',datosIniciales.EnergiaMax);
    switch mapmethod
        case 'mean'
            fprintf(FileID, 'con pasos de          : %g mV\r\n',datosIniciales.PasoMapas);
            fprintf(FileID, 'Delta de Energia      : %g mV\r\n',datosIniciales.DeltaEnergia);
        case 'none'
            fprintf(FileID, 'con pasos de          : %g mV\r\n',...
                abs(max(Struct.Voltaje) - min(Struct.Voltaje))/numel(Struct.Voltaje));
        otherwise
            fprintf(FileID, 'con pasos de          : %g mV\r\n',datosIniciales.PasoMapas);
    end
    fprintf(FileID, 'Metodo de interpolado : %s\r\n',mapmethod);
    fclose(FileID);

    Struct.datosIniciales  = datosIniciales;
% -----------------------------------------------------------------------
	FileName                            = Struct.FileName;
	FilePath                            = Struct.FilePath;
    
	IV                                  = Struct.IV;
	MatrizCorriente                     = Struct.MatrizCorriente;
        
	PuntosDerivada                      = Struct.NPuntosDerivada;
	Voltaje                             = Struct.Voltaje;
	VoltajeNormalizacionInferior        = Struct.VoltajeNormalizacionInferior;
	VoltajeNormalizacionSuperior        = Struct.VoltajeNormalizacionSuperior;

	CorteInferiorInicial    = Struct.datosIniciales.corteInferior;
	CorteSuperiorInicial    = Struct.datosIniciales.corteSuperior;
        
    DeltaEnergia                        = Struct.datosIniciales.DeltaEnergia;
    PasoMapas                           = Struct.datosIniciales.PasoMapas;
    switch mapmethod
        case 'none' %use the raw voltages from the IV
            % we have to make sure the values are sorted from lowest to
            % highest
            [NewVoltaje,indx] = sort(Struct.Voltaje,'ascend');
            energyRange = NewVoltaje < Struct.datosIniciales.EnergiaMax &...
                NewVoltaje > Struct.datosIniciales.EnergiaMin;
            energyValues = indx(energyRange);
            Energia                     = Struct.Voltaje(energyValues);
        otherwise %create an evenly spaced vector with the provided spacing
            Energia                     = (Struct.datosIniciales.EnergiaMin:PasoMapas:Struct.datosIniciales.EnergiaMax);
    end
 
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
    %dividimos y multiplicamos por el parametro de red?

% ------------------------------------------------------------------------
% Normalizing (or not) the data
% ------------------------------------------------------------------------
tic
MatrizNormalizada = zeros([Struct.IV,Struct.Filas*Struct.Columnas]);
switch Struct.NormalizationFlag
    case 'mirror window'
        MatrizNormalizada(:,1:Struct.curveCount) = getDerivative(MatrizCorriente(:,1:Struct.curveCount),...
            Voltaje,PuntosDerivada,LowerValue=VoltajeNormalizacionInferior,...
            UpperValue=VoltajeNormalizacionSuperior,Method="mirrorNorm");
    case 'single side'
        MatrizNormalizada(:,1:Struct.curveCount) = getDerivative(MatrizCorriente(:,1:Struct.curveCount),...
            Voltaje,PuntosDerivada,LowerValue=VoltajeNormalizacionInferior,...
            UpperValue=VoltajeNormalizacionSuperior,Method="singleNorm");
    case 'none'
        MatrizNormalizada(:,1:Struct.curveCount) = getDerivative(MatrizCorriente(:,1:Struct.curveCount),...
            Voltaje,PuntosDerivada,Method="none");
    case 'log'
        MatrizNormalizada(:,1:Struct.curveCount) = getDerivative(MatrizCorriente(:,1:Struct.curveCount),...
            Voltaje,PuntosDerivada,Method="Log");
    case 'Feenstra'
        MatrizNormalizada(:,1:Struct.curveCount) = getDerivative(MatrizCorriente(:,1:Struct.curveCount),...
            Voltaje,PuntosDerivada,Method="FeenstraNorm");
end
toc

% ------------------------------------------------------------------------
% Warning for empty matrices
% ------------------------------------------------------------------------
switch mapmethod
    case 'mean'
        if abs(Voltaje(2) - Voltaje(1)) > 2*DeltaEnergia
            fprintf('AVISO: El paso de voltaje es MAYOR que el intervalo seleccionado. Es posible que aparezcan MATRICES en BLANCO.\n');
        elseif abs(Voltaje(2) - Voltaje(1)) < 2*DeltaEnergia
            fprintf('El paso de voltaje es menor que el intervalo seleccionado.\n');
        else
            fprintf('El paso de voltaje es justamente el intervalo seleccionado.\n');
        end
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
    

FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'A');
fprintf(FileID, 'Map type              : %s\r\n',maptype);
fprintf(FileID, 'Sweep direction       : %s \r\n',scandir);
fprintf(FileID, '-------------------------------\r\n');
fclose(FileID);

%Si la imagen se ha tomado en Y, reordenamos las curvas del blq antes
%de obtener los mapas correspondientes
if strcmp(scandir,'Y')
    ordeny=zeros(1,Filas*Columnas);
    for i=1:Filas
        ordeny(1+(i-1)*Columnas:i*Columnas) = i:Filas:Filas*Columnas;
    end
    MatrizNormalizada = MatrizNormalizada(:,ordeny);
    MatrizCorriente = MatrizCorriente(:,ordeny);
end


switch maptype
    case 'Conductance'
        MatrizCorrienteCortada = MatrizCorriente;
        MatrizNormalizadaCortada = MatrizNormalizada;
        MatrizNormalizadaCortada(MatrizNormalizadaCortada < CorteInferiorInicial) = CorteInferiorInicial;
        MatrizNormalizadaCortada(MatrizNormalizadaCortada > CorteSuperiorInicial) = CorteSuperiorInicial;
        switch mapmethod
            case 'mean'
                MapasConductancia = GetMapsMeanWindow(Voltaje,...
                    MatrizNormalizadaCortada,Energia,DeltaEnergia,Filas,Columnas);
            case {'nearest','linear','makima'}
                MapasConductancia = GetMapsInterpolate(Voltaje,...
                    MatrizNormalizadaCortada,Energia,Filas,Columnas,mapmethod);
            case 'none'
                Info = struct();
                Info.Voltaje = Voltaje;
                Info.DistanciaFilas = DistanciaFilas;
                Info.DistanciaColumnas = DistanciaColumnas;
                MapasConductancia = curves2maps(MatrizNormalizadaCortada,Info);
                MapasConductancia = MapasConductancia(energyValues);
                clear Info
        end
        [Transformadas,Fase] = cellfun(@fft2d, MapasConductancia, 'UniformOutput',false);
    case 'Current'
        MatrizCorrienteCortada = MatrizCorriente;
        CorteSuperiorInicial = max(MatrizCorrienteCortada,[],"all");
        CorteInferiorInicial = min(MatrizCorrienteCortada,[],"all");
        % We decide not to enforce the limits
        % MatrizCorrienteCortada(MatrizCorrienteCortada < CorteInferiorInicial) = CorteInferiorInicial;
        % MatrizCorrienteCortada(MatrizCorrienteCortada > CorteSuperiorInicial) = CorteSuperiorInicial;
        MatrizNormalizadaCortada = MatrizNormalizada;

        switch mapmethod
            case 'mean'
                MapasConductancia = GetMapsMeanWindow(Voltaje,...
                    MatrizCorrienteCortada,Energia,DeltaEnergia,Filas,Columnas);
            case {'nearest','linear','makima'}
                MapasConductancia = GetMapsInterpolate(Voltaje,...
                    MatrizCorrienteCortada,Energia,Filas,Columnas,mapmethod);
            case 'none'
                Info = struct();
                Info.Voltaje = Voltaje;
                Info.DistanciaFilas = DistanciaFilas;
                Info.DistanciaColumnas = DistanciaColumnas;
                MapasConductancia = curves2maps(MatrizCorrienteCortada,Info);
                MapasConductancia = MapasConductancia(energyValues);
                clear Info
        end
        [Transformadas,Fase] = cellfun(@fft2d, MapasConductancia, 'UniformOutput',false);
    case 'd2I/dV2'
        MatrizCorrienteCortada = MatrizCorriente;
        MatrizNormalizadaCortada = MatrizNormalizada;
        MatrizSecondDeriv = derivadorLeastSquaresArray(secondDerivPts,...
            MatrizNormalizadaCortada,Voltaje);
        CorteSuperiorInicial = max(MatrizSecondDeriv,[],"all");
        CorteInferiorInicial = min(MatrizSecondDeriv,[],"all");
        switch mapmethod
            case 'mean'
                MapasConductancia = GetMapsMeanWindow(Voltaje,...
                    MatrizSecondDeriv,Energia,DeltaEnergia,Filas,Columnas);
            case {'nearest','linear','makima'}
                MapasConductancia = GetMapsInterpolate(Voltaje,...
                    MatrizSecondDeriv,Energia,Filas,Columnas,mapmethod);
            case 'none'
                Info = struct();
                Info.Voltaje = Voltaje;
                Info.DistanciaFilas = DistanciaFilas;
                Info.DistanciaColumnas = DistanciaColumnas;
                MapasConductancia = curves2maps(MatrizSecondDeriv,Info);
                MapasConductancia = MapasConductancia(energyValues);
                clear Info
        end
        [Transformadas,Fase] = cellfun(@fft2d, MapasConductancia, 'UniformOutput',false);
end
clear k Indices DeltaEnergia MapasConductanciaAUX;
% ------------------------------------------------------------------------
% Creating structures to pass to GUI analysis
% ------------------------------------------------------------------------
% Find the closest map to zero even for an asymmetric energy range
[~,k] = min(Energia,[],ComparisonMethod="abs");

    Struct.Energia                      = Energia;
    Struct.DistanciaColumnas            = DistanciaColumnas;
    Struct.DistanciaFilas               = DistanciaFilas;
    Struct.MatrizCorriente              = MatrizCorrienteCortada;
    Struct.MatrizNormalizada            = MatrizNormalizadaCortada;
    if strcmp(maptype,'d2I/dV2')
    Struct.MatrizSecondDeriv            = MatrizSecondDeriv;
    end
    Struct.Voltaje                      = Voltaje;
    Struct.TamanhoRealFilas             = TamanhoRealFilas;
    Struct.TamanhoRealColumnas          = TamanhoRealColumnas;
    Struct.DistanciaFourierColumnas     = DistanciaFourierColumnas;
    Struct.DistanciaFourierFilas        = DistanciaFourierFilas;
    Struct.Filas                        = Filas;
    Struct.Columnas                     = Columnas;
    Struct.MaxCorteConductancia         = CorteSuperiorInicial;
    Struct.MinCorteConductancia         = CorteInferiorInicial;
    Struct.Transformadas                = Transformadas;
    Struct.MapasConductancia            = MapasConductancia;
    Struct.PuntosDerivada               = PuntosDerivada;
    Struct.kInicial                     = k;
    Struct.Fase                         = Fase;
    Struct.Type                         = maptype;
    Struct.Direction                    = scandir;

% ------------------------------------------------------------------------
end
end