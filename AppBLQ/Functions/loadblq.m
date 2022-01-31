function [Struct, MatrizCorriente, Voltaje] = loadblq(App, initialPoint)
    [FileName, FilePath] = uigetfile('*.blq','Load blq');
        Struct.FileName = FileName;
        Struct.FilePath = FilePath;
    
    a = ChooseMatrixApp;    % Usando App
    uiwait(a.UIFigure)
    eleccionMatrices = evalin('base','eleccionMatrices');
    evalin ('base','clear eleccionMatrices')
%     uiwait(ChooseMatrix) %Para poner en pausa el programa % Usando GUIDE
    
    [FileNameTopo, FilePathTopo] = uigetfile('*.img','Load topography');
        Struct.FileNameTopo = FileNameTopo;
        Struct.FilePathTopo = FilePathTopo;
        TopoProperties      = dir([FilePathTopo FileNameTopo]);
        TopoLineas          = sqrt((TopoProperties.bytes - 1032)/4);
            
	[SaveFolder] = uigetdir(FilePath,'Save Files of Analysis');
        Struct.SaveFolder = SaveFolder;
        
	[Campo, Temperatura, TamanhoRealFilas, TamanhoRealColumnas, ParametroRedFilas,...
        ParametroRedColumnas, Filas, Columnas] = generalData2(TopoLineas, Struct);

        Struct.Campo                = Campo;
        Struct.Temperatura          = Temperatura;
        Struct.TamanhoRealFilas     = TamanhoRealFilas;
        Struct.TamanhoRealColumnas  = TamanhoRealColumnas;
        Struct.ParametroRedFilas    = ParametroRedFilas;
        Struct.ParametroRedColumnas = ParametroRedColumnas;
        Struct.Filas                = Filas;
        Struct.Columnas             = Columnas;
        
	if Filas ~= Columnas
        msgbox('Numbers of rows and columns are not the same','Be careful...','warn')
    end
    
    Date = datetime;
    
    choice_1 = questdlg('Number of columns in blq file:','Confirmation','2','3','2');
    if strcmp(choice_1,'2')
        % Loading data from BLQ file into matlab matrices
    % ------------------------------------------------------------------------ 
        tic
        [Voltaje,...
            IdaIda,...
            IdaVuelta,...
            VueltaIda,...
            VueltaVuelta] = ReducedblqreaderV14([FilePath,FileName],Filas,Columnas, eleccionMatrices, initialPoint);
        toc
        Voltaje = Voltaje*1000; % Para ponerlo en mV
        
    elseif strcmp(choice_1,'3')
        choice_2 = questdlg('Column to read:','Confirmation','2','3','2');
        LeerColumna = str2num(choice_2);
        
        % Loading data from BLQ file into matlab matrices
    % ------------------------------------------------------------------------ 
        tic
        [Voltaje,...
            IdaIda,...
            IdaVuelta,...
            VueltaIda,...
            VueltaVuelta] = ReducedblqreaderV14_Dos([FilePath,FileName],Filas,Columnas, eleccionMatrices, initialPoint, LeerColumna);
        toc
        Voltaje = Voltaje*1000; % Para ponerlo en mV

    end
    
    % Checking which current matricex exists and putting them in nA for simplcity
% ------------------------------------------------------------------------
        if exist('IdaIda',  'var')
            IdaIda       = IdaIda*1e9;
%             display('Exists IdaIda');
        end
        if exist('IdaVuelta',  'var')
            IdaVuelta    = IdaVuelta*1e9;
        end
        if exist('VueltaIda',  'var')
            VueltaIda    = VueltaIda*1e9;
        end
        if exist('VueltaVuelta',  'var')
            VueltaVuelta = VueltaVuelta*1e9;
        end

        display('Matrices: IdaIda IdaVuelta VueltaIda VueltaVuelta');
        display(['Cargadas:      ', num2str(eleccionMatrices(1)),...
                         '       ', num2str(eleccionMatrices(2)),...
                        '        ', num2str(eleccionMatrices(3)),...
                       '         ', num2str(eleccionMatrices(4))]);
    % ------------------------------------------------------------------------
    %
    % Checking if data matricex exist and initializing them otherwise for
    % program purposes
    % ------------------------------------------------------------------------
        if ~exist('IdaIda',  'var') 
            eleccionMatrices(1) = 0;
            IdaIda = 0;
        end
        if ~exist('IdaVuelta',  'var')
            eleccionMatrices(2) = 0;
            IdaVuelta = 0;
        end
        if ~exist('VueltaIda',  'var')
             eleccionMatrices(3) = 0;
             VueltaIda = 0;
        end
        if  ~exist('VueltaVuelta',  'var')
             eleccionMatrices(4) = 0;
             VueltaVuelta = 0;
        end
        
    % ------------------------------------------------------------------------
    %
    % Creating the tunneling current matrix (MatrizCorriente) adding the
    % different selected matrices and the Voltage array adding the offset
    % (VoltajeOffset)
    % ------------------------------------------------------------------------
        MatrizCorriente = ( eleccionMatrices(1)*IdaIda +...
                            eleccionMatrices(2)*IdaVuelta +...
                            eleccionMatrices(3)*VueltaIda +... 
                            eleccionMatrices(4)*VueltaVuelta)...
                            /length(find (eleccionMatrices ~=0));
        
        %-------------------------------------                
        % Reading data from ini file, if any.
        %-------------------------------------
        remember = 0;
    if exist([[SaveFolder,'\'],FileName(1:length(FileName)-4),'.in'],'file')
        remember = dlmread( [[SaveFolder,'\'],FileName(1:length(FileName)-4),'.in']);
    end  
        
    if length(remember) ==11
        App.CurvestoshowEditField.Value     = remember(7);
        App.DerivativepointsEditField.Value = remember(8);
        App.OffsetvoltageEditField.Value    = remember(9);
        App.fromEditField.Value             = remember(10);
        App.toEditField.Value               = remember(11);        
    else        
        if App.toEditField.Value == 0
            App.toEditField.Value = 0.9*max(Voltaje);
        end

        if App.fromEditField.Value == 0
            App.fromEditField.Value = 0.7*max(Voltaje);
        end
    end
    
    % Para pintar                
    i = 1+round(rand(App.CurvestoshowEditField.Value,1)*(Columnas-1)); % Random index for curve selection
    j = 1+round(rand(App.CurvestoshowEditField.Value,1)*(Filas-1));    % Random index for curve selection

    MatrizCorrienteTest = zeros(length(Voltaje),App.CurvestoshowEditField.Value);

    for count = 1:App.CurvestoshowEditField.Value
        MatrizCorrienteTest(:,count) = MatrizCorriente(:,(Filas*(j(count)-1)+ i(count)));
    end
    clear i j;
    Struct.MatrizCorrienteTest = MatrizCorrienteTest;

    msgbox('blq succesfully loaded.','Congratulations','help')
end