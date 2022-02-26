%Objetivo: Elegir los distintos valores iniciales para comenzar los
%          calculos del analisis.
%Input   : Ninguno
%Output  :-eleccionMatrices: Vector de 1x4 con 1 y 0 segun si se ha
%                            clickado a cada opcion. Despues multiplico
%                            este vector por cada una de las matrices
%                            y divido entre el numero de 1s en el vector.
%         -datosIniciales: Estructura que contiene las siguientes
%                          categorias:
%                                     o corteInferior
%                                     o corteSuperior
%                                     o puntosDerivada
%                                     o offset
%                                     o normSup
%                                     o normInf

function [datosIniciales] = customCurvesv3(SaveFolder, FileName, Struct)
f = figure;
f.Position(3:4)=[350 365];
%Si ya existe, abro el archivo de iniciacion y segun si existe o no, creo
%una variable existeIni que sera true si existe y false si no. Si existe
%guardará los valores introducidos por el usuario en orden de esta forma:
% 1.- Corte Inferior
% 2.- Corte Superior
% 3.- Energía inicial
% 4.- Energía final
% 5.- Paso energía
% 6.- Delta energía

if exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in'], 'file') == 2
    [[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in'];
    existeIni = true;
    fileIni   = fopen( [[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in']);
    remember  = fscanf(fileIni, '%20f');
else
    existeIni = false;
end

  
%Botones por pares de cada una de las categorias. Siempre hay un tex
%indicando a que corresponde el boton edit para rellenar:

%%%%%%%%%% Corte Inferior %%%%%%%%%%%%%%%%%
editCorteInferior = uicontrol('Style','edit',...
    'Position',[160 320 120 20]);
                    uicontrol('Style','text',...
    'Position',[40 315 120 30],...
    'String', 'Corte inferior inicial conductancia:');
    %Si existe coge el valor del archivo
if existeIni
    editCorteInferior.String = ( remember(1));
end
%%%%%%%%% Corte Superior %%%%%%%%%%%%%    
editCorteSuperior = uicontrol('Style','edit',...
    'Position',[160 270 120 20]);
                    uicontrol('Style','text',...
    'Position',[40 265 120 30],...
    'String', 'Corte superior inicial conductancia:');
    %Si existe coge el valor del archivo
if existeIni
    editCorteSuperior.String = ( remember(2));
end
    
%%%%%%%%% Energía mínima %%%%%%%%%%%%
    
editEnergiaMin = uicontrol('Style','edit',...
    'Position',[160 220 120 20]);
                 uicontrol('Style','text',...
    'Position',[40 220 120 20],...
    'String', 'Mapas desde:');
    %Si existe coge el valor del archivo
if existeIni
    editEnergiaMin.String = ( remember(3));
end
       
%%%%%%%% Energía máxima %%%%%%%%%%%%%%%
editEnergiaMax = uicontrol('Style','edit',...
    'Position',[160 170 120 20]);
                 uicontrol('Style','text',...
    'Position',[40 170 120 20],...
    'String', 'hasta:');
    %Si existe coge el valor del archivo
if existeIni
    editEnergiaMax.String = ( remember(4));
end
          
%%%%%%%% Paso mapas %%%%%%%%%%%%    
editPasoMapas = uicontrol('Style','edit',...
    'Position',[160 120 120 20]);
                uicontrol('Style','text',...
    'Position',[40 120 120 20],...
    'String', 'en pasos de:');
    %Si existe coge el valor del archivo
if existeIni
    editPasoMapas.String = ( remember(6));
end    
%%%%%%%%% Delta energía %%%%%%%%%%%%%
editDeltaEnergia = uicontrol('Style','edit',...
    'Position',[160 70 120 20]);
                   uicontrol('Style','text',...
    'Position',[40 70 120 20],...
    'String', 'ΔE:');
%Si existe coge el valor del archivo
if existeIni
    editDeltaEnergia.String = (remember(5));
end    


%Boton para continuar
uicontrol('Position',[80 25 200 20],'String','Continue',...
          'Callback','uiresume(gcbf)');    
uiwait(gcf);

datosIniciales.corteInferior	= str2double(editCorteInferior.String);
datosIniciales.corteSuperior    = str2double(editCorteSuperior.String);
datosIniciales.EnergiaMin       = str2double(editEnergiaMin.String);
datosIniciales.EnergiaMax       = str2double(editEnergiaMax.String);
datosIniciales.DeltaEnergia     = str2double(editDeltaEnergia.String);
datosIniciales.PasoMapas        = str2double(editPasoMapas.String);

%Abro el archivo de iniciacion y actualizo los nuevos valores metidos por
%el usuario
fileIni = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.in'], 'w');
fprintf(fileIni, ['\n' editCorteInferior.String ]) ;
fprintf(fileIni, ['\n' editCorteSuperior.String] ); 
fprintf(fileIni, ['\n' editEnergiaMin.String ]) ;
fprintf(fileIni, ['\n' editEnergiaMax.String ] ) ;
fprintf(fileIni, ['\n' editDeltaEnergia.String] ) ;
fprintf(fileIni, ['\n' editPasoMapas.String ]   );  
fprintf(fileIni, ['\n' num2str(Struct.NumeroCurvas)] );
fprintf(fileIni, ['\n' num2str(Struct.NPuntosDerivada)]); 
fprintf(fileIni, ['\n' num2str(Struct.OffsetVoltaje)] );
fprintf(fileIni, ['\n' num2str(Struct.VoltajeNormalizacionInferior)]) ;
fprintf(fileIni, ['\n' num2str(Struct.VoltajeNormalizacionSuperior)] );

fprintf(fileIni, '\r\n');

fclose(fileIni);

 FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'], 'a');
        fprintf(FileID, 'Corte Inf Conduc         : %s uS\r\n',editCorteInferior.String);
        fprintf(FileID, 'Corte Sup Conduc         : %s uS\r\n',editCorteSuperior.String);
        fprintf(FileID, 'Dibuja de                : %s mV\r\n',editEnergiaMin.String);
        fprintf(FileID, ' a                       : %s mV\r\n',editEnergiaMax.String);
        fprintf(FileID, 'con pasos de             : %s mV\r\n',editPasoMapas.String);
        fprintf(FileID, 'delta de Energia          : %s mV\r\n',editDeltaEnergia.String );
        fprintf(FileID, '-------------------------------\r\n');
        fprintf(FileID, '\r\n');
        fprintf(FileID, '\r\n');
 fclose(FileID);
 close(f);
clear fileIni    

    

