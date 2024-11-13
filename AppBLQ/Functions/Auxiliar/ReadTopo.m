function [Struct,TopoLineas] =ReadTopo(Name,Path,Struct)
if isequal(Name,0)
    disp('No image was loaded');
    %No tenemos imagen y hay que introducirlo manualmente
    TopoLineas=128; %Valor de puntos por defecto en este caso
else
    Ext = Name(end-2:end); %extension del archivo de imagen
    if strcmp(Ext,'img') %Solo sacamos el numero de puntos
        disp('Img file loaded')
        Struct.FileNameTopo = Name;
        Struct.FilePathTopo = Path;
        TopoProperties      = dir([Path Name]);
        TopoLineas          = sqrt((TopoProperties.bytes - 1032)/4);
    elseif strcmp(Ext,'stp') %Sacamos numero de puntos y tamaño
        disp('STP file loaded')
        FileSTP=fopen([Path Name],'r');
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
                                    Struct.TamanhoRealFilas =Number*1e-3;
                                    Struct.TamanhoRealColumnas =Number*1e-3;
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
                            break
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

end
