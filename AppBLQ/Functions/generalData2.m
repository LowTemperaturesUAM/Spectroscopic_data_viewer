%Objetivo: Poder escribir de forma itneractiva valores generales del
%experimento: Campo, Temperatura y Corriente Tunel


function [Campo, Temperatura, TamanhoRealFilas,TamanhoRealColumnas, ParametroRedFilas,ParametroRedColumnas, Filas, Columnas] = generalData2(TopoLineas,Struct)
f = figure;
f.Position = [172,466,631,345];
%Botones para elegir Datos generales de las medidas:
FileName = Struct.FileName;
SaveFolder = Struct.SaveFolder;
remember = exist([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'file');
remember
if remember; data1 = dlmread([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini']);end
% Filas: Por defecto escribe el valor que obtiene del tama�o de la topo.
% Solo si es n�mero redondo
txtFilas= uicontrol('Style','text',...
        'Position',[40 300 150 20],...
        'String', 'Filas:','HorizontalAlignment','right');
      
editFilas = uicontrol('Style','edit',...
        'Position',[200 300 100 20]);
    if round(TopoLineas) == TopoLineas
        editFilas.String = num2str(TopoLineas);
    end
% Columnas:Por defecto escribe el valor que obtiene del tama�o de la topo.
% Solo si es n�mero redondo
txtColumnas= uicontrol('Style','text',...
        'Position',[305 300 83 20],...
        'String', 'Columnas:','HorizontalAlignment','right');
    
editColumnas = uicontrol('Style','edit',...
        'Position',[400 300 100 20]);
    
    if round(TopoLineas) == TopoLineas
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
% Tama�o Filas:
txtTamanhoRealFilas = uicontrol('Style','text',...
        'Position',[40 150 150 20],...
        'String', 'Tama�o real Filas (nm):','HorizontalAlignment','right');

editTamanhoRealFilas = uicontrol('Style','edit',...
        'Position',[200 150 100 20]);
    if remember;11; editTamanhoRealFilas.String = data1(5) ;end  
% Tama�o Columnas
txtTamanhoRealColumnas = uicontrol('Style','text',...
        'Position',[300 150 180 20],...
        'String', 'Tama�o real Columnas (nm):','HorizontalAlignment','right');
    
editTamanhoRealColumnas = uicontrol('Style','edit',...
        'Position',[490 150 100 20]);
        if remember;11; editTamanhoRealColumnas.String = data1(6) ;end  

% Par�metro de red Filas:
txtParametroRedFilas = uicontrol('Style','text',...
        'Position',[40 100 150 20],...
        'String', 'Par�metro de red Filas (nm):','HorizontalAlignment','right');
    

editParametroRedFilas = uicontrol('Style','edit',...
        'Position',[200 100 100 20]);
    if remember;11; editParametroRedFilas.String = data1(7) ;end  
% Par�metro de red Columnas:
txtParametroRedColumnas = uicontrol('Style','text',...
        'Position',[300 100 180 20],...
        'String', 'Par�metro de red Columnas (nm):','HorizontalAlignment','right');
    
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

fileID = fopen([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],'w');
dlmwrite([[SaveFolder,filesep],FileName(1:length(FileName)-4),'sample.ini'],data)




close(f);
end