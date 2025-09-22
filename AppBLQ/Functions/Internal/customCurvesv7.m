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

function [datosIniciales,direction,maptype,mapmethod,secondDerivPts] = customCurvesv7(SaveFolder, FileName, Struct)
f = uifigure;
f.Position(3:4)=[350 630];
f.Position(2) = f.Position(2)-80;
f.Name = 'Map analysis settings';
rpos = f.Position(3);
hrow = 50;
toprow = f.Position(4)-hrow;
movegui(f);
%Si ya existe, abro el archivo de iniciacion y segun si existe o no, creo
%una variable existeIni que sera true si existe y false si no. Si existe
%guardará los valores introducidos por el usuario en orden de esta forma:
% 1.- Corte Inferior
% 2.- Corte Superior
% 3.- Energía inicial
% 4.- Energía final
% 5.- Delta energía
% 6.- Paso energía
% 7.- Curvas a mostrar
% 8.- Puntos de derivada
% 9.- Offset
%10.- Min Rango Normalización
%11.- Max Rango Normalización

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
    'Text', 'Lower limit cut:');
%Si existe coge el valor del archivo
if existeIni
    editCorteInferior.Value = remember(1);
end
%%%%%%%%% Corte Superior %%%%%%%%%%%%%    

editCorteSuperior = uieditfield(f,'numeric','Position',[rpos-130 toprow-hrow 90 20],...
    HorizontalAlignment='center');
uilabel(f,'Position',[40 toprow-hrow 120 20],...
    'Text', 'Upper limit cut:');
%Si existe coge el valor del archivo
if existeIni
    editCorteSuperior.Value = remember(2);
end
    
%%%%%%%%% Energía mínima %%%%%%%%%%%%
    
editEnergiaMin = uieditfield(f,'numeric','Position',[rpos-130 toprow-2*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-2*hrow 120 20],'Text', 'Maps from:');
%Si existe coge el valor del archivo
if existeIni
    editEnergiaMin.Value = remember(3);
end
       
%%%%%%%% Energía máxima %%%%%%%%%%%%%%%
editEnergiaMax = uieditfield(f,'numeric','Position',[rpos-130 toprow-3*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-3*hrow 120 20],...
    'Text', 'to:');
%Si existe coge el valor del archivo
if existeIni
    editEnergiaMax.Value = remember(4);
end
          
%%%%%%%% Paso mapas %%%%%%%%%%%%    
editPasoMapas = uieditfield(f,'numeric','Position',[rpos-130 toprow-4*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-4*hrow 120 20],...
    'Text', 'Map spacing:');
%Si existe coge el valor del archivo
if existeIni
    editPasoMapas.Value = remember(6);
else
    editPasoMapas.Value = round(0.5*abs(max(Struct.Voltaje) - min(Struct.Voltaje))...
        /numel(Struct.Voltaje),3);
end    
editPasoMapas.Enable = false;


%%%%%%%%% Delta energía %%%%%%%%%%%%%
editDeltaEnergia = uieditfield(f,'numeric','Position',[rpos-130 toprow-6*hrow 90 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g mV');
uilabel(f,'Position',[40 toprow-6*hrow 120 20],...
    'Text', 'ΔE:');
% Si existe coge el valor del archivo, si no, utiliza la mitad del espaciado
% entre puntos
if existeIni
    editDeltaEnergia.Value = remember(5);
else
    editDeltaEnergia.Value = round(0.5*abs(max(Struct.Voltaje) - min(Struct.Voltaje))...
        /numel(Struct.Voltaje),3);
end
editDeltaEnergia.Enable = false;

% Interpolation Method
MethodTip = sprintf(['Select interpolation method to obtain the maps.\n ',...
    '-Mean Window: Averages all points on the curve in an interval [V-ΔE,V+ΔE]\n',...
    '-Nearest: Takes the closest point in the curve\n', ...
    '-Linear: Obtains the maps by linear interpolation of the curves\n', ...
    '-Makima: Obtains the maps by Modified Akima interpolation method']);
methodsel = uidropdown(f,"Items",{'Mean Window','Nearest','Linear','Makima','None'},...
    "ItemsData",{'mean','nearest','linear','makima','none'},...
    Position = [rpos-150 toprow-5*hrow 110 20],...
    Tooltip=MethodTip,...
    ValueChangedFcn=@(methodsel,event) changeMethod(methodsel,editDeltaEnergia,editPasoMapas));
uilabel(f,Position =[40 toprow-5*hrow 120 20],...
    Text = 'Interpolation Method:');
methodsel.Value='none';

%Boton para elegir x/y
xyswich = uiswitch(f,Items={'X','Y'});
% xyswich.Position(3) = 200;
xyswich.Position(2) = toprow-7*hrow;
xyswich.Position(1) = floor(rpos-85 - xyswich.Position(3)/2); 
xylbl = uilabel(f,"Text",'Sweep direction:');
xylbl.Position(1:2) = [40 xyswich.Position(2)];
xylbl.Position(3:4) = [120, 20];  

maptypesel = uidropdown(f,"Items",{'Conductance','Current','d2I/dV2'},...
    Position=[rpos-150 toprow-8*hrow 110 20]);
typelbl = uilabel(f,"Text",'Map type:',Position=[40, toprow-8*hrow 120, 20]);

secondDselect = uispinner(f,Value = 1,RoundFractionalValues="on",...
    Limits=[1,Inf],Position=[rpos-130 toprow-9*hrow 90 20],...
    ValueDisplayFormat='%d',Enable=false);
uilabel(f,Text='2nd Derivative points:',Position=[40, toprow-9*hrow 120, 20]);

maptypesel.ValueChangedFcn=@(typesel,event) changeMapType(typesel,secondDselect,editCorteInferior,editCorteSuperior);
% se
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
    mapmethod = 0;
    secondDerivPts = 0;
    return
else

datosIniciales.corteInferior	= -Inf;
datosIniciales.corteSuperior    = Inf;
if strcmp(maptypesel.Value,'Conductance')
datosIniciales.corteInferior	= editCorteInferior.Value;
datosIniciales.corteSuperior    = editCorteSuperior.Value;
end
datosIniciales.EnergiaMin       = editEnergiaMin.Value;
datosIniciales.EnergiaMax       = editEnergiaMax.Value;
datosIniciales.DeltaEnergia     = editDeltaEnergia.Value;
datosIniciales.PasoMapas        = editPasoMapas.Value;
direction                       = xyswich.Value;
maptype                         = maptypesel.Value;
mapmethod                       = methodsel.Value;
secondDerivPts                  = 0;
if strcmp(maptypesel.Value,'d2I/dV2')
secondDerivPts                  = secondDselect.Value;
end

close(f);

end
end

function  changeMethod(methodsel,editDeltaEnergia,editPasoMapas)
    method = methodsel.Value;
    switch method
        case 'mean'
            editDeltaEnergia.Enable = true;
            editPasoMapas.Enable = true;
        case 'none'
            editDeltaEnergia.Enable = false;
            editPasoMapas.Enable = false;
        otherwise
            editDeltaEnergia.Enable = false;
            editPasoMapas.Enable = true;
    end
end

function changeMapType(maptypesel,secondDselect,editCorteInferior,editCorteSuperior)
    typesel = maptypesel.Value;
    switch typesel
        case 'Conductance'
            editCorteInferior.Enable = true;
            editCorteSuperior.Enable = true;
            secondDselect.Enable = false;
        case 'Current'
            editCorteInferior.Enable = false;
            editCorteSuperior.Enable = false;
            secondDselect.Enable = false;
        case 'd2I/dV2'
            editCorteInferior.Enable = false;
            editCorteSuperior.Enable = false;
            secondDselect.Enable = true;
        otherwise
            editCorteInferior.Enable = true;
            editCorteSuperior.Enable = true;
            secondDselect.Enable = false;
    end
end