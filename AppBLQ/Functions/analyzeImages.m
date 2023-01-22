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

[datosIniciales,scandir, maptype] = customCurvesv4(Struct.SaveFolder, Struct.FileName, Struct);
if isequal(datosIniciales,0)
    Struct = 0;
    return
else
Struct.datosIniciales  = datosIniciales;
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

	CorteInferiorInicial    = Struct.datosIniciales.corteInferior;
	CorteSuperiorInicial    = Struct.datosIniciales.corteSuperior;
        
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
    %dividimos y multiplicamos por el parametro de red?
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
tic
switch Struct.NormalizationFlag
    case 'mirror window'
        [MatrizNormalizada] = normalizacionPA(VoltajeNormalizacionSuperior,...
            VoltajeNormalizacionInferior,...
            Voltaje,...
            MatrizConductancia,...
            Filas,Columnas);
        ConductanciaTunel = 1;
    case 'none'

        MatrizNormalizada = MatrizConductancia; % units: uS
        ConductanciaTunel = mean(max(MatrizCorriente))/max(Voltaje);

    case 'Feenstra'
        Ismooth = zeros(size(MatrizCorriente));
        switch Struct.Fmethod
            case 'rloess' %it takes siginificantly longer
                parfor i=1:size(MatrizCorriente,2)
                    Ismooth(:,i) = smooth(Struct.MatrizCorriente(:,i),Struct.Fspan,Struct.Fmethod);
                end
            otherwise
                for i=1:size(MatrizCorriente,2)
                    Ismooth(:,i) = smooth(Struct.MatrizCorriente(:,i),Struct.Fspan,Struct.Fmethod);
                end
        end
        Imin = interp1(Voltaje,Ismooth,0);

        G = (Ismooth-Imin)./Voltaje;
        if any( Voltaje == 0 )
            center = find(Voltaje == 0 );
            G(center,:) = 0.5*(G(center+1,:)+ G(center-1,:));
        end
        if Struct.F2check
            [~,center] = min(Voltaje,[],1,ComparisonMethod="abs");
            midspan = floor(0.1*length(Voltaje));
            for i=1:length(Imin)
                G(center-midspan:center+midspan,i) =...
                    smooth(G(center-midspan:center+midspan,i),Struct.Fspan2,Struct.Fmethod2);
            end
        end
        MatrizNormalizada = MatrizConductancia./G;
end
toc
% ------------------------------------------------------------------------
% Removing bad data points with the first cut
% ------------------------------------------------------------------------
%     MatrizNormalizadaCortada = MatrizNormalizada;
%     MatrizNormalizadaCortada(MatrizNormalizadaCortada < CorteInferiorInicialConductancia) = CorteInferiorInicialConductancia;
%     MatrizNormalizadaCortada(MatrizNormalizadaCortada > CorteSuperiorInicialConductancia) = CorteSuperiorInicialConductancia;
% ------------------------------------------------------------------------   
% Considering conductance curves at each point creates conductance maps
% averaging points around a certain DeltaEnergia and its 2D-FFT map
% ------------------------------------------------------------------------
% fileID = Struct.fileID;
% % creo que estamos sobreescribiendo lo anterior!!!
% fprintf(fileID, 'Valores de Energia: de %g mV a %g mV en pasos de %g mV\r\n',...
%                 Energia(1), Energia(length(Energia)),PasoMapas);
% fprintf(fileID, 'Delta de Energia  : %g mv\r\n', DeltaEnergia);
% fprintf(fileID, '-------------------------------\r\n');
% fprintf(fileID, '\r\n\r\n');
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
    
    
    FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'],'a');
    fprintf(FileID, 'Map type              : %s\r\n',maptype);
    fprintf(FileID, 'Sweep direction       : %s \r\n',scandir);
    fprintf(FileID, '-------------------------------\r\n');
    fclose(FileID);
    
    %Si la imagen se ha tomado en Y, reordenamos las curvas del blq antes
    %de obtener los mapas correspondientes
    if strcmp(scandir,'Y')
        ordeny=zeros(1,Filas*Columnas);
        for i=1:Columnas
            ordeny((i-1)*Filas+1:(i-1)*Filas+Columnas) = i:Filas:(Filas-1)*Columnas+i; 
        end
        MatrizNormalizada = MatrizNormalizada(:,ordeny);
        MatrizCorriente = MatrizCorriente(:,ordeny);
    end
    if strcmp(maptype,'Conductance')
        MatrizCorrienteCortada = MatrizCorriente;
        MatrizNormalizadaCortada = MatrizNormalizada;
        MatrizNormalizadaCortada(MatrizNormalizadaCortada < CorteInferiorInicial) = CorteInferiorInicial;
        MatrizNormalizadaCortada(MatrizNormalizadaCortada > CorteSuperiorInicial) = CorteSuperiorInicial;

        Indices =cellfun(@(E) find(E- DeltaEnergia < Voltaje & ...
            E+ DeltaEnergia > Voltaje),num2cell(Energia)', 'UniformOutput',false);
        MapasConductanciaAUX =cellfun(@(x) mean(MatrizNormalizadaCortada(x,:),1), Indices,'UniformOutput',false);
        MapasConductancia =cellfun(@(x) reshape(x,[Columnas,Filas]).',MapasConductanciaAUX, 'UniformOutput',false);
        [Transformadas,Fase] = cellfun(@fft2d, MapasConductancia, 'UniformOutput',false);
%         Fase = cellfun(@fft2dphase, MapasConductancia, 'UniformOutput',false);

    else
        MatrizCorrienteCortada = MatrizCorriente;
        MatrizCorrienteCortada(MatrizCorrienteCortada < CorteInferiorInicial) = CorteInferiorInicial;
        MatrizCorrienteCortada(MatrizCorrienteCortada > CorteSuperiorInicial) = CorteSuperiorInicial;
        MatrizNormalizadaCortada = MatrizNormalizada;

        Indices =cellfun(@(E) find(E- DeltaEnergia < Voltaje & ...
            E+ DeltaEnergia > Voltaje),num2cell(Energia)', 'UniformOutput',false);
        MapasConductanciaAUX =cellfun(@(x) mean(MatrizCorrienteCortada(x,:),1), Indices,'UniformOutput',false);
        MapasConductancia =cellfun(@(x) reshape(x,[Columnas,Filas]).',MapasConductanciaAUX, 'UniformOutput',false);
        [Transformadas,Fase] = cellfun(@fft2d, MapasConductancia, 'UniformOutput',false);
%         Fase = cellfun(@fft2dphase, MapasConductancia, 'UniformOutput',false);
        
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
    Struct.Type = maptype;
    Struct.Direction = scandir;
% ------------------------------------------------------------------------
end
end