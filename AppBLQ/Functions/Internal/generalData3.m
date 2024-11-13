function [Campo, Temperatura, TamanhoRealFilas,TamanhoRealColumnas, ...
    ParametroRedFilas,ParametroRedColumnas, Filas, Columnas,eleccionMatrices,LeerColumna] = generalData3(TopoLineas,Struct)
f = uifigure;
f.Name = 'Image parameters and import settings';
% f.Position = [172,466,631,345];
f.Position(3:4) = [630,400];

FileName = Struct.FileName;
SaveFolder = Struct.SaveFolder;
%Comprobamos si ya existe un archivo previo de analisis
remember = exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'file');
if remember
    data1 = readmatrix([SaveFolder, filesep, ...
        FileName(1:length(FileName)-4), 'sample.ini'],FileType="text");
end

%Botones para elegir Datos generales de las medidas:
topRow = f.Position(4)-50;
hRow = 50;
%Seleccion de curvas del blq
txtEleccion = uilabel(f,Position=[40, 350,150,20],...
    Text='Direction Topo + IV:',HorizontalAlignment='right');
chkII = uicheckbox(f,Position=[200 topRow,100,20],Text='Forth + Forth',Value=1);
chkIV = uicheckbox(f,Position=[300 topRow,100,20],Text='Forth + Back',Value=0);
chkVI = uicheckbox(f,Position=[400 topRow,100,20],Text='Back + Forth',Value=0);
chkVV = uicheckbox(f,Position=[500 topRow,100,20],Text='Back + Back',Value=0);

% Filas: Por defecto escribe el valor que obtiene del tamaño de la topo.
% Solo si es número redondo
txtFilas= uilabel(f,'Position',[40 topRow-hRow 150 20],...
        'Text', 'Filas:','HorizontalAlignment','right');
      
editFilas = uieditfield(f,'numeric','Position',[200 topRow-hRow 100 20],...
    HorizontalAlignment='center');
    if remember 
        editFilas.Value = data1(1);
    elseif round(TopoLineas) == TopoLineas
        editFilas.Value = TopoLineas;
    end
% Columnas:Por defecto escribe el valor que obtiene del tamaño de la topo.
% Solo si es número redondo
txtColumnas= uilabel(f,'Position',[300 topRow-hRow 180 20],...
        'Text', 'Columnas:','HorizontalAlignment','right');
    
editColumnas = uieditfield(f,'numeric','Position',[490 topRow-hRow 100 20],HorizontalAlignment='center');
    if remember 
        editColumnas.Value = data1(2); 
    elseif round(TopoLineas) == TopoLineas
        editColumnas.Value = TopoLineas;
    end
%Campo:
txtCampo= uilabel(f,'Position',[40 topRow-2*hRow 150 20],...
        'Text', 'Campo:','HorizontalAlignment','right');

editCampo = uieditfield(f,'numeric','Position',[200 topRow-2*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g T'); 
    if remember;11; editCampo.Value = data1(4) ;end  

%temperatura:
txtTemperatura = uilabel(f,'Position',[300 topRow-2*hRow 180 20],...
    'Text', 'Temperatura:','HorizontalAlignment','right');

editTemperatura = uieditfield(f,'numeric','Position',[490 topRow-2*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g K');
     if remember;11; editTemperatura.Value = data1(3) ;end
% Tamaño Filas:
txtTamanhoRealFilas = uilabel(f,'Position',[40 topRow-3*hRow 150 20],...
        'Text', 'Tamaño real Filas:','HorizontalAlignment','right');

editTamanhoRealFilas = uieditfield(f,'numeric','Position',[200 topRow-3*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g nm');
    %comprobamos si hay archivo ini y si no tomamos lo de la imagen
    if remember
        editTamanhoRealFilas.Value = data1(5);
    elseif isfield(Struct,'TamanhoRealFilas')
        editTamanhoRealFilas.Value = Struct.TamanhoRealFilas;
    end
        
% Tamaño Columnas
txtTamanhoRealColumnas = uilabel(f,'Position',[300 topRow-3*hRow 180 20],...
    'Text', 'Tamaño real Columnas:','HorizontalAlignment','right');

editTamanhoRealColumnas = uieditfield(f,'numeric','Position',[490 topRow-3*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g nm');
    %comprobamos si hay archivo ini y si no tomamos lo de la imagen
    if remember
        editTamanhoRealColumnas.Value = data1(5);
    elseif isfield(Struct,'TamanhoRealFilas')
        editTamanhoRealColumnas.Value = Struct.TamanhoRealColumnas;
    end

% Parámetro de red Filas:   
txtParametroRedFilas = uilabel(f,'Position',[40 topRow-4*hRow 150 20],...
        'Text', 'Parámetro de red Filas:','HorizontalAlignment','right');

editParametroRedFilas = uieditfield(f,'numeric','Position',[200 topRow-4*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g nm');
    if remember;11; editParametroRedFilas.Value = data1(7) ;end  
editParametroRedFilas.Limits = [0 Inf];
editParametroRedFilas.LowerLimitInclusive = 'off';
% Parámetro de red Columnas:  
txtParametroRedColumnas = uilabel(f,'Position',[300 topRow-4*hRow 180 20],...
        'Text', 'Parámetro de red Columnas:','HorizontalAlignment','right');

editParametroRedColumnas = uieditfield(f,'numeric','Position',[490 topRow-4*hRow 100 20],...
    HorizontalAlignment='center',ValueDisplayFormat='%11.4g nm');
    if remember;11; editParametroRedColumnas.Value = data1(8) ;end 
editParametroRedColumnas.Limits = [0 Inf];
editParametroRedColumnas.LowerLimitInclusive = 'off';

% Eleccion de columna
txtblqCol = uilabel(f,Position=[40 topRow-5*hRow 150 20],Text='blq Column',...
    HorizontalAlignment='right');
spinblqCol = uispinner(f,Position=[200 topRow-5*hRow 100 20],Limits=[2 4],Value=2);

%Boton para continuar
uibutton(f,'Position',[215 35 200 40],'Text','Continue',...
    'ButtonPushedFcn','uiresume(gcbf)',BackgroundColor=[0.78,0.96,0.55]);



uiwait(f); 


Filas                   = editFilas.Value;
Columnas                = editColumnas.Value;
Temperatura             = editTemperatura.Value;
Campo                   = editCampo.Value;
TamanhoRealFilas        = editTamanhoRealFilas.Value;
TamanhoRealColumnas     = editTamanhoRealColumnas.Value;
ParametroRedFilas       = editParametroRedFilas.Value;
ParametroRedColumnas    = editParametroRedColumnas.Value;
eleccionMatrices        = [chkII.Value chkIV.Value chkVI.Value chkVV.Value];
LeerColumna             = spinblqCol.Value;

data = [Filas Columnas Temperatura Campo TamanhoRealFilas TamanhoRealColumnas ...
    ParametroRedFilas ParametroRedColumnas];

%Save the updated parameters to the file
writematrix(data,[[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'FileType','text', 'WriteMode','overwrite')




close(f);
end