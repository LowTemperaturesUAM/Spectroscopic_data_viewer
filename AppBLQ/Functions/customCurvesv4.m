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

function [datosIniciales,direction,maptype] = customCurvesv4(SaveFolder, FileName, Struct)
f = uifigure;
f.Position(3:4)=[350 500];
f.Position(2) = f.Position(2)-80;
f.Name = 'Map analysis settings';
rpos = f.Position(3);
hrow = 50;
toprow = f.Position(4)-hrow;
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

editCorteInferior = uieditfield(f,'numeric','Position',[rpos-130 toprow 90 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 toprow 120 20],...
    'Text', 'Limite inferior:');
%Si existe coge el valor del archivo
if existeIni
    editCorteInferior.Value = ( remember(1));
end
%%%%%%%%% Corte Superior %%%%%%%%%%%%%    

editCorteSuperior = uieditfield(f,'numeric','Position',[rpos-130 toprow-hrow 90 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 toprow-hrow 120 20],...
    'Text', 'Limite superior:');
%Si existe coge el valor del archivo
if existeIni
    editCorteSuperior.Value = ( remember(2));
end
    
%%%%%%%%% Energía mínima %%%%%%%%%%%%
    
editEnergiaMin = uieditfield(f,'numeric','Position',[rpos-130 toprow-2*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-2*hrow 120 20],'Text', 'Mapas desde:');
%Si existe coge el valor del archivo
if existeIni
    editEnergiaMin.Value = ( remember(3));
end
       
%%%%%%%% Energía máxima %%%%%%%%%%%%%%%
editEnergiaMax = uieditfield(f,'numeric','Position',[rpos-130 toprow-3*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-3*hrow 120 20],...
    'Text', 'hasta:');
%Si existe coge el valor del archivo
if existeIni
    editEnergiaMax.Value = ( remember(4));
end
          
%%%%%%%% Paso mapas %%%%%%%%%%%%    
editPasoMapas = uieditfield(f,'numeric','Position',[rpos-130 toprow-4*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-4*hrow 120 20],...
    'Text', 'en pasos de:');
%Si existe coge el valor del archivo
if existeIni
    editPasoMapas.Value = ( remember(6));
end    
%%%%%%%%% Delta energía %%%%%%%%%%%%%
editDeltaEnergia = uieditfield(f,'numeric','Position',[rpos-130 toprow-5*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-5*hrow 120 20],...
    'Text', 'ΔE:');
%Si existe coge el valor del archivo
if existeIni
    editDeltaEnergia.Value = (remember(5));
end    


%Boton para elegir x/y
xyswich = uiswitch(f,Items={'X','Y'});
% xyswich.Position(3) = 200;
xyswich.Position(2) = toprow-6*hrow;
xyswich.Position(1) = floor(rpos-85 - xyswich.Position(3)/2); 
xylbl = uilabel(f,"Text",'Sweep direction:');
xylbl.Position(1:2) = [40 xyswich.Position(2)];
xylbl.Position(3:4) = [120, 20]; 

maptypesel = uidropdown(f,"Items",{'Conductance','Current'},Position=[rpos-150 toprow-7*hrow 110 20]);
typelbl = uilabel(f,"Text",'Map type:',Position=[40, toprow-7*hrow 120, 20]);


%Boton para continuar
uibutton(f,'Position',[80 25 200 40],'Text','Continue',...
    'ButtonPushedFcn','uiresume(gcbf)',BackgroundColor=[0.78,0.96,0.55],...
    FontWeight='bold',FontSize=14);
uiwait(f);

%Comprobamos si la figura ha sido cerrada para seguir
if ~ishghandle(f)
    datosIniciales = 0;
    direction = 0;
    maptype = 0;
    return
else

datosIniciales.corteInferior	= editCorteInferior.Value;
datosIniciales.corteSuperior    = editCorteSuperior.Value;
datosIniciales.EnergiaMin       = editEnergiaMin.Value;
datosIniciales.EnergiaMax       = editEnergiaMax.Value;
datosIniciales.DeltaEnergia     = editDeltaEnergia.Value;
datosIniciales.PasoMapas        = editPasoMapas.Value;
direction                       = xyswich.Value;
maptype                         = maptypesel.Value;

%Actualizo los nuevos valores metidos por el usuario

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
 fclose(FileID);
 close(f);
clear fileIni    

end

