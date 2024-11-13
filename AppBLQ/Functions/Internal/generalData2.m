%Objetivo: Poder escribir de forma itneractiva valores generales del
%experimento: Campo, Temperatura y Corriente Tunel


function [Campo, Temperatura, TamanhoRealFilas,TamanhoRealColumnas, ParametroRedFilas,ParametroRedColumnas, Filas, Columnas] = generalData2(TopoLineas,Struct)
f = figure;
f.Position = [172,466,631,345];
%Botones para elegir Datos generales de las medidas:
FileName = Struct.FileName;
SaveFolder = Struct.SaveFolder;
remember = exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'file');
%remember
if remember; data1 = dlmread([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini']);end
% Filas: Por defecto escribe el valor que obtiene del tamaño de la topo.
% Solo si es número redondo
txtFilas= uicontrol('Style','text',...
        'Position',[40 300 150 20],...
        'String', 'Filas:','HorizontalAlignment','right');
      
editFilas = uicontrol('Style','edit',...
        'Position',[200 300 100 20]);
    if remember 
        editFilas.String = data1(1);
    elseif round(TopoLineas) == TopoLineas
        editFilas.String = num2str(TopoLineas);
    end
% Columnas:Por defecto escribe el valor que obtiene del tamaño de la topo.
% Solo si es número redondo
txtColumnas= uicontrol('Style','text',...
        'Position',[305 300 83 20],...
        'String', 'Columnas:','HorizontalAlignment','right');
    
editColumnas = uicontrol('Style','edit',...
        'Position',[400 300 100 20]);
    if remember 
        editColumnas.String = data1(2); 
    elseif round(TopoLineas) == TopoLineas
        editColumnas.String = num2str(TopoLineas);
    end
%Campo:
txtCampo= uicontrol('Style','text',...
        'Position',[40 250 150 20],...
        'String', 'Campo (T):','HorizontalAlignment','right');

editCampo = uicontrol('Style','edit',...
        'Position',[200 250 100 20]); 
    if remember;11; editCampo.String = data1(4) ;end  
%temperatura:
txtTemperatura = uicontrol('Style','text',...
        'Position',[40 200 150 20],...
        'String', 'Temperatura (K):','HorizontalAlignment','right');

editTemperatura = uicontrol('Style','edit',...
        'Position',[200 200 100 20]);
     if remember;11; editTemperatura.String = data1(3) ;end  
% Tamaño Filas:
txtTamanhoRealFilas = uicontrol('Style','text',...
        'Position',[40 150 150 20],...
        'String', 'Tamaño real Filas (nm):','HorizontalAlignment','right');

editTamanhoRealFilas = uicontrol('Style','edit',...
        'Position',[200 150 100 20]);
    %comprobamos si hay archivo ini y si no tomamos lo de la imagen
    if remember
        editTamanhoRealFilas.String = data1(5);
    elseif isfield(Struct,'TamanhoRealFilas')
        editTamanhoRealFilas.String = num2str(Struct.TamanhoRealFilas);
    end
        
% Tamaño Columnas
txtTamanhoRealColumnas = uicontrol('Style','text',...
        'Position',[300 150 180 20],...
        'String', 'Tamaño real Columnas (nm):','HorizontalAlignment','right');
    
editTamanhoRealColumnas = uicontrol('Style','edit',...
        'Position',[490 150 100 20]);
    %comprobamos si hay archivo ini y si no tomamos lo de la imagen
    if remember
        editTamanhoRealColumnas.String = data1(5);
    elseif isfield(Struct,'TamanhoRealFilas')
        editTamanhoRealColumnas.String = num2str(Struct.TamanhoRealColumnas);
    end

% Parámetro de red Filas:
txtParametroRedFilas = uicontrol('Style','text',...
        'Position',[40 100 150 20],...
        'String', 'Parámetro de red Filas (nm):','HorizontalAlignment','right');
    

editParametroRedFilas = uicontrol('Style','edit',...
        'Position',[200 100 100 20]);
    if remember;11; editParametroRedFilas.String = data1(7) ;end  
% Parámetro de red Columnas:
txtParametroRedColumnas = uicontrol('Style','text',...
        'Position',[300 100 180 20],...
        'String', 'Parámetro de red Columnas (nm):','HorizontalAlignment','right');
    
editParametroRedColumnas = uicontrol('Style','edit',...
        'Position',[490 100 100 20]);
    if remember;11; editParametroRedColumnas.String = data1(8) ;end 
%Boton para continuar
 uicontrol('Position',[102 35 200 40],'String','Continue',...
              'Callback','uiresume(gcbf)');    
uiwait(gcf); 

Filas                   = str2double(editFilas.String);
Columnas                = str2double(editColumnas.String);
Temperatura             = str2double(editTemperatura.String);
Campo                   = str2double(editCampo.String);
TamanhoRealFilas        = str2double(editTamanhoRealFilas.String);
TamanhoRealColumnas     = str2double(editTamanhoRealColumnas.String);
ParametroRedFilas       = str2double(editParametroRedFilas.String);
ParametroRedColumnas    = str2double(editParametroRedColumnas.String);

data = [Filas Columnas Temperatura Campo TamanhoRealFilas TamanhoRealColumnas ...
    ParametroRedFilas ParametroRedColumnas];

%It is not necessary to open the file first to use dlmwrite, but if you do,
%make sure to close it again
%fileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'w');
%dlmwrite([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],data)
%fclose(fileID)

%We replace it by writematrix because is the recomended way
writematrix(data,[[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'FileType','text', 'WriteMode','overwrite')




close(f);
end