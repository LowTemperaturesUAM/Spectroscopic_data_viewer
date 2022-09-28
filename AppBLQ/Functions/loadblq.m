function [Struct, MatrizCorriente, Voltaje] = loadblq(App, initialPoint)
    [FileName, FilePath] = uigetfile('*.blq','Load blq');
        Struct.FileName = FileName;
        Struct.FilePath = FilePath;
    
    a = ChooseMatrixApp;    % Usando App
    uiwait(a.UIFigure)
    eleccionMatrices = evalin('base','eleccionMatrices');
    evalin ('base','clear eleccionMatrices')
%     uiwait(ChooseMatrix) %Para poner en pausa el programa % Usando GUIDE
    
    [FileNameTopo, FilePathTopo] = uigetfile({'*.stp;*.img','Image Files (*.stp,*.img)';'*.stp','WSxM Images';'*.img','IMG files';'*.*','All Files'},'Load topography');

    if isequal(FileNameTopo,0)
       disp('No image was loaded');
       %No tenemos imagen y hay que introducirlo manualmente
       TopoLineas=128; %Valor de puntos por defecto en este caso
    else
        Ext = FileNameTopo(end-2:end); %extension del archivo de imagen
        if strcmp(Ext,'img') %Solo sacamos el numero de puntos
            disp('Img file loaded')
            Struct.FileNameTopo = FileNameTopo;
            Struct.FilePathTopo = FilePathTopo;
            TopoProperties      = dir([FilePathTopo FileNameTopo]);
            TopoLineas          = sqrt((TopoProperties.bytes - 1032)/4);
        elseif strcmp(Ext,'stp') %Sacamos numero de puntos y tamaño
            disp('STP file loaded')
            FileSTP=fopen([FilePathTopo FileNameTopo],'r');
            %No podemos usar el tamaño del header porque es incorrecto en
            %algunas versiones de MyScanner
            fgetl(FileSTP);%Nos saltamos las 3 primeras lineas
            fgetl(FileSTP);
            fgetl(FileSTP);
            tline=fgetl(FileSTP);
            while ~strcmp(tline,'[Header end]')
                if strcmp(tline,'[Control]')
                    fgetl(FileSTP); %saltamos la linea vacia
                    tline=fgetl(FileSTP);
                    while ~strcmp(tline,'') %seguimos hasta el final de la seccion
                        %Extraemos la etiqueta y el valor
                        C=textscan(tline,'%s %s','Delimiter', ':');
                        Label=char(C{1});
                        %Separamos el valor y las unidades
                        Value=textscan(char(C{2}), '%f %s');
                        Number=Value{1};
                        Units=char(Value{2});
                        switch Label
                            %Asumimos que la imagen es cuadrada
                            case {'X Amplitude','Y Amplitude'} 
                                %convertimos a nm y lo salvamos
                                switch Units
                                    case 'nm'
                                        Struct.TamanhoRealFilas =Number;
                                        Struct.TamanhoRealColumnas =Number;
                                        %disp('Ya son nm')
                                    case 'Å'
                                        Struct.TamanhoRealFilas =Number*1e-1;
                                        Struct.TamanhoRealColumnas =Number*1e-1;
                                        %fprintf('%.2f nm',TamanhoRealFilas)
                                    case 'pm'
                                        Struct.TamanhoRealFilas =Number*1e3;
                                        Struct.TamanhoRealColumnas =Number*1e3;
                                        %fprintf('%.2f nm',TamanhoRealFilas)
                                    case 'mm'
                                        Struct.TamanhoRealFilas =Number*1e6;
                                        Struct.TamanhoRealColumnas =Number*1e6;
                                        %fprintf('%.2f nm',TamanhoRealFilas)
                                    otherwise
                                        fprintf('This unit cannot be read!!')
                                end
                                %como solo tomamos el tamaño de esta
                                %seccion, podemos salir del bucle
                                break %solo queremos
                        end

                        tline=fgetl(FileSTP); 
                    end

        
                elseif strcmp(tline,'[General Info]')
                    fgetl(FileSTP); %saltamos la linea vacia
                    tline=fgetl(FileSTP);
                    while ~strcmp(tline,'') %seguimos hasta el final de la seccion
                        %Extraemos la etiqueta 
                        C=textscan(tline,'%s %s','Delimiter', ':');
                        Label=char(C{1});
                        switch Label
                            %Asumimos que es cuadrada
                            case {'Number of columns','Number of rows'} 
                                % La resolucion solo es un valor numerico
                                Value=textscan(char(C{2}), '%u');
                                TopoLineas=Value{1};
                                %solo tomamos la resolucion esta
                                %seccion, podemos salir del bluque
                                break                                             
                        end

                        tline=fgetl(FileSTP); 
                    end
                end
                tline=fgetl(FileSTP);
            end
        else
            disp('This image has the wrong format. No data was read');    
            TopoLineas=128;
        end
    end


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
    

    
    choice_1 = questdlg('Number of columns in blq file:','Confirmation','2','3','2');
    if strcmp(choice_1,'2')
        % Loading data from BLQ file into matlab matrices
    % ------------------------------------------------------------------------ 
        tic
        [Voltaje,...
            IdaIda,...
            IdaVuelta,...
            VueltaIda,...
            VueltaVuelta] = ReducedblqreaderV15([FilePath,FileName],Filas,Columnas, eleccionMatrices, initialPoint);
        toc
        Voltaje = Voltaje*1000; % Para ponerlo en mV
        
    elseif strcmp(choice_1,'3')
        choice_2 = questdlg('Column to read:','Confirmation','2','3','2');
        LeerColumna = str2double(choice_2);
        
        % Loading data from BLQ file into matlab matrices
    % ------------------------------------------------------------------------ 
        tic
        [Voltaje,...
            IdaIda,...
            IdaVuelta,...
            VueltaIda,...
            VueltaVuelta] = ReducedblqreaderV15_Dos([FilePath,FileName],Filas,Columnas, eleccionMatrices, initialPoint, LeerColumna);
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
        display(['Cargadas:    ', num2str(eleccionMatrices(1)),...
                       '       ', num2str(eleccionMatrices(2)),...
                     '         ', num2str(eleccionMatrices(3)),...
                    '          ', num2str(eleccionMatrices(4))]);
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
    if exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in'],'file')
        remember = dlmread( [[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in']);
    end  
        
    if length(remember) ==11
        App.CurvestoshowEditField.Value     = remember(7);
        App.DerivativepointsSpinner.Value = remember(8);
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