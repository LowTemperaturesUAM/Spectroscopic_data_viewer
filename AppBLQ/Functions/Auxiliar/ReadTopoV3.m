function [Struct,Size,Matrix] = ReadTopoV3(Name,Path,Struct)
arguments
    Name char {mustBeNonzeroLengthText}
    Path char
    Struct
end
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
    Size=[128,128]; %Valor de puntos por defecto en este caso
    Matrix = [];
else

    Ext = Name(end-2:end); %extension del archivo de imagen
    if strcmp(Ext,'img') %Solo sacamos el numero de puntos
        disp('Img file loaded')
        Struct.FileNameTopo = Name;
        Struct.FilePathTopo = Path;
        FileIMG=fopen([Path Name],'r');
        % identifier and version
        fread(FileIMG,2,'int32');
        % day, month and year
        fread(FileIMG,3,'uint16');
        % moment and time (seconds of day and final-start)
        fread(FileIMG,2,'double');
        % Xstart, Xend in meters
        RealXLim = fread(FileIMG,2,'double');
        % Ystart, Yend in meters
        RealYLim = fread(FileIMG,2,'double');
        Struct.TamanhoRealColumnas = diff(RealXLim)*1e9;
        Struct.TamanhoRealFilas = diff(RealYLim)*1e9;
        Size = fread(FileIMG,2,'int32=>double');
        % empty space
        fread(FileIMG,450,'char*1');
        % Comment
        fread(FileIMG,512,'char*1');

        if readall
            Matrix = fread(FileIMG,Size.','single')*1e9;
            Matrix = rot90(Matrix,-1);
            %Shift to positive values
            Matrix = Matrix - min(Matrix,[],"all");
        else
            %If we don't want the whole image, or we don't now the proper
            %format, we return an empty matrix
            Matrix = [];
        end

    elseif strcmp(Ext,'stp') %Sacamos numero de puntos y tamaño
        disp('STP file loaded')
        IsCurrent = false;
        Struct.FileNameTopo = Name;
        Struct.FilePathTopo = Path;
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
                                    % fprintf('This unit cannot be read!!')
                                    fprintf('Empty Units\n')
                                    Struct.TamanhoRealFilas =Number;
                                    Struct.TamanhoRealColumnas =Number;
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
                        case 'Number of rows'
                            % La resolucion solo es un valor numerico
                            Value=textscan(char(C{2}), '%u');
                            Size(1)=double(Value{1});
                        case 'Number of columns'
                            % La resolucion solo es un valor numerico
                            Value=textscan(char(C{2}), '%u');
                            Size(2)=double(Value{1});
                        case 'Image Data Type'
                            %Las imagenes antiguas vienen etiquetadas como
                            %single, pero son int16
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
                                case 'nA' %current map
                                    Factor = 1;
                                    IsCurrent = true;
                                otherwise
                                    % fprintf('This unit cannot be read!!')
                                    fprintf('Empty Units\n')
                                    Factor = 1;
                            end
                            if isNew
                                % simply convert to nm and ignore the value
                                Zscale = Factor;
                            else
                                Zscale = Number * Factor;
                            end
                    end

                    tline=fgetl(FileSTP);
                end
            end
            tline=fgetl(FileSTP);
        end
%         TopoLineas = cast(TopoLineas, 'double')
        % Now we read the data matrix
%         ftell(FileSTP)
        if readall
            if isNew
                % For new images from MyScanner, the format is indeed double, as
                % the header says. We just need to offset the lowest point
                Matrix = fread(FileSTP,Size,type);
                if ~IsCurrent
                    Matrix = Matrix - min(Matrix,[],"all");
                end
                Matrix = Matrix * Zscale;
                Matrix = rot90(Matrix,-1);
            else
                % For old images exported in STP from viewIMG, the format 
                % is int16, despite the header saying is single
                % We map the range of the z axis from [zmin,zmax] to
                % [0,Zscale]
                %We are not handling Current maps right now
                Matrix = fread(FileSTP,Size,type);
                Matrix = Matrix - min(Matrix,[],"all");
                Matrix = Matrix * Zscale / max(Matrix,[],"all");
                Matrix = rot90(Matrix,-1);
            end
            %This part is the same for both cases
            %Shift to positive values
%             Matrix = Matrix - min(Matrix,[],"all");
%             Matrix = Matrix * Zscale;
%             Matrix = rot90(Matrix,-1);
        else
            %If we don't want the whole image, or we don't now the proper
            %format, we return an empty matrix
            Matrix = [];
        end
    else
        disp('This image has the wrong format. No data was read');
        Size=128;
        Matrix = [];
    end


end

end
