function [Struct,TopoLineas,Matrix] = ReadTopoV2(Name,Path,Struct)
% INPUT:
% Name: string cointaining the name of the file
% Path: string cointaining the rest of the file file path besides the name
% Struct: struct variable containing the data of the current analysis
% OUTPUT:
% Struct: input struct variable containing the real dimensions data
% TopoLineas: size of the topo matrix, in pixels
% Matrix (optional): topographic image data in nm
%
% If the input image is not found, or not properly formatted, the function
% will not return any real space dimensions, and default to a matrix size
% of 128 pixels

if nargout == 3 %Return the topography image as a matrix
    readall=true;
else
    readall=false;
end


if isequal(Name,0)
    disp('No image was loaded');
    %No tenemos imagen y hay que introducirlo manualmente
    TopoLineas=128; %Valor de puntos por defecto en este caso
    Matrix = [];
else
    Ext = Name(end-2:end); %extension del archivo de imagen
    if strcmp(Ext,'img') %Solo sacamos el numero de puntos
        disp('Img file loaded')
        Struct.FileNameTopo = Name;
        Struct.FilePathTopo = Path;
        TopoProperties      = dir([Path Name]);
        TopoLineas          = sqrt((TopoProperties.bytes - 1032)/4);
        Matrix = [];
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
%                 case '[General Info]'
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
                            TopoLineas=double(Value{1});
                            %solo tomamos la resolucion esta
                            %seccion, podemos salir del bluque
                            %break
                        case 'Image Data Type'
                            %Las imagenes antiguas vienen etiquetadas como
                            %single, y contienen la informacion directa del
                            % DAC Z como int16
                            switch C{2}{:}
                                case 'single' %Imagenes antiguas
                                    type = 'int16';
                                    isNew = false;
                                case 'double' %Imagenes nuevas
                                    type = 'double';
                                    isNew = true;
                                otherwise %Si no sabemos, no leemos el output
                                    readall = false;
                            end
                        case 'Z Amplitude'
                            %Obtenermos la escala de amplitud de la imagen,
                            %para convertir a escala real en nm
                            Value=textscan(char(C{2}), '%f %s');
                            Number=Value{1};
                            Units=char(Value{2});
                            switch Units
                                case 'nm'
                                    Factor = 1;
                                case 'Å'
                                    Factor = 1e-1;
                                case 'pm'
                                    Factor = 1e-3;
                                otherwise
                                    fprintf('This unit cannot be read!!')
                                    Factor = 1;
                            end
                            Zscale = Number * Factor;
                    end

                    tline=fgetl(FileSTP);
                end
            end
            tline=fgetl(FileSTP);
        end
%         TopoLineas = cast(TopoLineas, 'double')
        % Now we read the data matrix
        if readall
            if isNew
                % For new images from MyScanner, the format is indeed double, as
                % the header says. We just need to offset the lowest point
                Matrix = fread(FileSTP,[TopoLineas, TopoLineas],type);
                Matrix = Matrix - min(Matrix,[],"all");
            else
                % For old images exported in STP from viewIMG, the format is the
                % raw 16bit DAC information, despite the header saying is single
                Matrix = fread(FileSTP,[TopoLineas, TopoLineas],type);
                Matrix = Matrix - min(Matrix,[],"all");
                Matrix = Matrix / max(Matrix,[],"all");
            end
            %This part is the same for both cases
            Matrix = Matrix * Zscale;
            Matrix = rot90(Matrix,-1);
        else
            %If we don't want the whole image, or we don't now the proper
            %format, we return an empty matrix
            Matrix = [];
        end
    else
        disp('This image has the wrong format. No data was read');
        TopoLineas=128;
        Matrix = [];
    end
end

end
