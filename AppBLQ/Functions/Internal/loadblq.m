function [Struct, MatrizCorriente, Voltaje] = loadblq(App, initialPoint)
    [FileName, FilePath] = uigetfile('*.blq','Load blq');
    if isequal(FileName,0) %Exit if no file is selected
        Struct = 0;
        MatrizCorriente = 0;
        Voltaje = 0;
        return
    else
        Struct.FileName = FileName;
        Struct.FilePath = FilePath;
    
    [FileNameTopo, FilePathTopo] = uigetfile({'*.stp;*.img','Image Files (*.stp,*.img)';'*.stp','WSxM Images';'*.img','IMG files';'*.*','All Files'},'Load topography');

    [Struct,Dimensiones,Topo] = ReadTopoV3(FileNameTopo,FilePathTopo,Struct);
    
	[SaveFolder] = uigetdir(FilePath,'Save Files of Analysis');
        Struct.SaveFolder = SaveFolder;

	[Campo, Temperatura, TamanhoRealFilas, TamanhoRealColumnas, ParametroRedFilas,...
        ParametroRedColumnas, Filas, Columnas,CurveSelection,LeerColumna,formatoCurvas] = generalData5(Dimensiones, Struct);

        Struct.Campo                = Campo;
        Struct.Temperatura          = Temperatura;
        Struct.TamanhoRealFilas     = TamanhoRealFilas;
        Struct.TamanhoRealColumnas  = TamanhoRealColumnas;
        Struct.ParametroRedFilas    = ParametroRedFilas;
        Struct.ParametroRedColumnas = ParametroRedColumnas;
        Struct.Filas                = Filas;
        Struct.Columnas             = Columnas;
        if ~isempty(Topo) %If we loaded the topography, we save it to the struct
            Struct.Topo             = Topo;
        end
        
    if Filas ~= Columnas
        msgbox('Numbers of rows and columns are not the same','Be careful...','warn')
    end
    
    
    % Loading data from BLQ file into matlab matrices
    % ------------------------------------------------------------------------ 
    tic
    [Voltaje,IdaIda,IdaVuelta,VueltaIda,VueltaVuelta,curveCounts] = ...
        ReducedblqreaderV18([FilePath,FileName],Filas,Columnas,...
        CurveSelection, initialPoint,BlqColumn=LeerColumna,Format=formatoCurvas);
    toc
    Voltaje = Voltaje*1000; % Para ponerlo en mV

    
    
    % Checking which current matricex exists and putting them in nA for simplcity
    % ------------------------------------------------------------------------
    % Checking if data matricex exist and initializing them otherwise for
    % program purposes
        if exist('IdaIda',  'var')
            IdaIda       = IdaIda*1e9;
        else
            CurveSelection(1) = 0;
            IdaIda = 0;
        end
        if exist('IdaVuelta',  'var')
            IdaVuelta    = IdaVuelta*1e9;
        else
            CurveSelection(2) = 0;
            IdaVuelta = 0;
        end
        if exist('VueltaIda',  'var')
            VueltaIda    = VueltaIda*1e9;
        else
            CurveSelection(3) = 0;
            VueltaIda = 0;
        end
        if exist('VueltaVuelta',  'var')
            VueltaVuelta = VueltaVuelta*1e9;
        else
            CurveSelection(4) = 0;
            VueltaVuelta = 0;
        end

        disp('Matrices: IdaIda IdaVuelta VueltaIda VueltaVuelta');
        disp(['Cargadas:    ', num2str(CurveSelection(1)),...
                       '       ', num2str(CurveSelection(2)),...
                     '         ', num2str(CurveSelection(3)),...
                    '          ', num2str(CurveSelection(4))]);
        
    % ------------------------------------------------------------------------
    %
    % Creating the tunneling current matrix (MatrizCorriente) adding the
    % different selected matrices and the Voltage array adding the offset
    % (VoltajeOffset)
    % ------------------------------------------------------------------------
    MatrizCorriente = ( CurveSelection(1)*IdaIda +...
        CurveSelection(2)*IdaVuelta +...
        CurveSelection(3)*VueltaIda +...
        CurveSelection(4)*VueltaVuelta)...
        /sum(CurveSelection);

    %-------------------------------------
    % Reading data from in file, if any.
    %-------------------------------------
    remember = 0;
    if exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in'],'file')
        remember = readmatrix([SaveFolder,filesep,FileName(1:length(FileName)-4),'.in'], FileType = 'text');
    end  
        
    if length(remember) >=11
        App.CurvestoshowEditField.Value     = remember(7);
        App.DerivativepointsSpinner.Value   = remember(8);
        App.OffsetvoltageEditField.Value    = remember(9);
        App.fromEditField.Value             = remember(10);
        App.toEditField.Value               = remember(11);        
    else %use some reasonable normalization values if none were given
        if App.toEditField.Value == 0
            App.toEditField.Value = 0.9*max(Voltaje);
        end

        if App.fromEditField.Value == 0
            App.fromEditField.Value = 0.7*max(Voltaje);
        end
    end
    %Paint some sample curves taken at random
    ncurves = App.CurvestoshowEditField.Value;
    %Check how many curves were read, in case some of them were missing
    curveCount = min(curveCounts(CurveSelection));
    if curveCount<Filas*Columnas %if the file is incomplete, we report it
        fprintf('Curves read: %d out of %d total\n',curveCount,Filas*Columnas)
    end
    MatrizCorrienteTest = getRandomCurves(MatrizCorriente,ncurves,curveCount);
    %We should probably save each direction separately so that we can modified
    %later on during the analysis
    Struct.MatrizCorrienteTest = MatrizCorrienteTest;
    Struct.CurveSelection = CurveSelection;
    Struct.curveCount = curveCount; % record this value for the future
    msgbox('blq succesfully loaded.','Congratulations','help')
    end
end