%Objetivo: Elegir los distintos valores iniciales para comenzar los
%          calculos del analisis.
%Input   : Ninguno
%         -datosIniciales: Estructura que contiene las siguientes
%                          categorias:
%                                     o corteInferior
%                                     o corteSuperior
%                                     o puntosDerivada
%                                     o offset
%                                     o normSup
%                                     o normInf

function [datosIniciales] = customCurvesv4(SaveFolder, FileName, Struct)
% f = figure;
f = uifigure;
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
    remember = readmatrix([SaveFolder,filesep,FileName(1:length(FileName)-4),'.in'],FileType='text');
else
    existeIni = false;
end

  
%Botones por pares de cada una de las categorias. Siempre hay un tex
%indicando a que corresponde el boton edit para rellenar:

%%%%%%%%%% Corte Inferior %%%%%%%%%%%%%%%%%

editCorteInferior = uieditfield(f,'numeric','Position',[160 320 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 315 120 30],...
    'Text', 'Corte inferior inicial conductancia:');
    %Si existe coge el valor del archivo
if existeIni
    editCorteInferior.Value = ( remember(1));
end
%%%%%%%%% Corte Superior %%%%%%%%%%%%%    

editCorteSuperior = uieditfield(f,'numeric','Position',[160 270 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 265 120 30],...
    'Text', 'Corte superior inicial conductancia:');
    %Si existe coge el valor del archivo
if existeIni
    editCorteSuperior.Value = ( remember(2));
end
    
%%%%%%%%% Energía mínima %%%%%%%%%%%%
    
editEnergiaMin = uieditfield(f,'numeric','Position',[160 220 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 220 120 20],'Text', 'Mapas desde:');
    %Si existe coge el valor del archivo
if existeIni
    editEnergiaMin.Value = ( remember(3));
end
       
%%%%%%%% Energía máxima %%%%%%%%%%%%%%%
editEnergiaMax = uieditfield(f,'numeric','Position',[160 170 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 170 120 20],...
    'Text', 'hasta:');
    %Si existe coge el valor del archivo
if existeIni
    editEnergiaMax.Value = ( remember(4));
end
          
%%%%%%%% Paso mapas %%%%%%%%%%%%    
editPasoMapas = uieditfield(f,'numeric','Position',[160 120 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 120 120 20],...
    'Text', 'en pasos de:');
    %Si existe coge el valor del archivo
if existeIni
    editPasoMapas.Value = ( remember(6));
end    
%%%%%%%%% Delta energía %%%%%%%%%%%%%
editDeltaEnergia = uieditfield(f,'numeric','Position',[160 70 120 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 70 120 20],...
    'Text', 'ΔE:');
%Si existe coge el valor del archivo
if existeIni
    editDeltaEnergia.Value = (remember(5));
end    


%Boton para continuar
uibutton(f,'Position',[80 25 200 20],'Text','Continue',...
    'ButtonPushedFcn','uiresume(gcbf)',BackgroundColor=[0.78,0.96,0.55]);
uiwait(f);


datosIniciales.corteInferior	= editCorteInferior.Value;
datosIniciales.corteSuperior    = editCorteSuperior.Value;
datosIniciales.EnergiaMin       = editEnergiaMin.Value;
datosIniciales.EnergiaMax       = editEnergiaMax.Value;
datosIniciales.DeltaEnergia     = editDeltaEnergia.Value;
datosIniciales.PasoMapas        = editPasoMapas.Value;

%Actualizo los nuevos valores metidos por
%el usuario

writematrix([editCorteInferior.Value; editCorteSuperior.Value;...
    editEnergiaMin.Value; editEnergiaMax.Value;...
    editDeltaEnergia.Value; editPasoMapas.Value;...
    Struct.NumeroCurvas; Struct.NPuntosDerivada;...
    Struct.OffsetVoltaje; Struct.VoltajeNormalizacionInferior;...
    Struct.VoltajeNormalizacionSuperior],...
    [SaveFolder,filesep,FileName(1:length(FileName)-4),'.in'],FileType='text')

 FileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'.txt'], 'a');
        fprintf(FileID, 'Corte Inf Conduc      : %g uS\r\n',editCorteInferior.Value);
        fprintf(FileID, 'Corte Sup Conduc      : %g uS\r\n',editCorteSuperior.Value);
        fprintf(FileID, 'Dibuja de             : %g mV\r\n',editEnergiaMin.Value);
        fprintf(FileID, ' a                    : %g mV\r\n',editEnergiaMax.Value);
        fprintf(FileID, 'con pasos de          : %g mV\r\n',editPasoMapas.Value);
        fprintf(FileID, 'Delta de Energia      : %g mV\r\n',editDeltaEnergia.Value );
        %fprintf(FileID, '\r\n');
        %fprintf(FileID, '\r\n');
 fclose(FileID);
 close(f);
clear fileIni    

    

