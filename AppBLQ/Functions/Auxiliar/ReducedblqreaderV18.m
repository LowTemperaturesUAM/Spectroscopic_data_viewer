function  [Voltage, FF, FB, BF, BB,counts] = ReducedblqreaderV18( FileName, Row, Col, Choice, startPoint,opt)
arguments
    FileName (1,1) string
    Row (1,1) double
    Col (1,1) double
    Choice (1,4) logical
    startPoint (1,1) double {mustBePositive,mustBeFinite} = 1
    opt.BlqColumn = 2;
    opt.Format {mustBeMember(opt.Format,{'normal','forth','back'})} = 'normal'
%     opt.IVpts (1,1) double {mustBePositive,mustBeFinite}
end

%This function reads blq files generated from spectroscopic images (CITS)
%The function will load and split curves into forward and backward scanning
%directions, as well as the forward and backward voltage sweep


FileID = fopen (FileName,'r'); % FileID es el nombre que le damos a todo lo que Matlab lea desde el BLQ
fprintf('ABRIENDO BLQ ...');
fprintf(' Leyendo columna %i\n',opt.BlqColumn)

ColII = 0;
ColIV = 0;
ColVI = 0;
ColVV = 0;
FF = 0;
FB = 0;
BF = 0;
BB = 0;
% if isfield(opt,'IVpts') %prealocate
%     Voltage = zeros(opt.IVpts,1);
%     FF = zeros(opt.IVpts,Row*Col);
%     FB = zeros(opt.IVpts,Row*Col);
%     BF = zeros(opt.IVpts,Row*Col);
%     BB = zeros(opt.IVpts,Row*Col);
% else
%     FF = 0;
%     FB = 0;
%     BF = 0;
%     BB = 0;
% end


switch opt.Format
    case 'normal'
        finalPoint = 4*Row*Col;
    case {'forth','back'}
        finalPoint = 2*Row*Col;
end
%Curvas previas a la espectroscopia
for curIndex = 1 : startPoint-1
    % Cabecera general de 400 bytes - Solo leo lo absolutamente necesario.
    %No sabemos que es, podemos saltarlo
    %fread (FileID, 4, 'uint16'); % No se sabe qué es pero hay que leerlo
    fseek(FileID,8,'cof');
    Control = fread (FileID, 32,'uchar'); % Contiene el nombre del fichero, cuando no está, está vacío
    if isempty(Control) % Cuando los 32 bits de Control están vacíos (no hay más datos) deja de leer.
        fprintf('Last curve available: %i\n',curIndex)
        break;
    end
    blqSize = fread (FileID, 2, 'int32');
%         IVpts    = blqSize(2); % Número de puntos de las IV
%         blqColumns = blqSize(1); % Ristras guardadas en cada IV: En principio sólo hay V e I pero puede haber más casillas marcadas en el Liner.exe
    %Saltamos el resto de la cabecera porque no nos interesa
    fseek(FileID,352,'cof');

    % Ahora leemos el resto de curvas, saltando convenientemente las que no
    % nos interesen al inicio del BLQ.
    for c = 1:blqSize(1)
%             readSet(FileID,  IVpts);  % Hay que leerlas pero pasamos de ellas y no las guardamos
        readSet(FileID,  blqSize(2));  % Hay que leerlas pero pasamos de ellas y no las guardamos
    end
end

%Primera curva de la espectroscopía. Obtenemmos los los parametros para
%siguientes iteraciones
curIndex = startPoint;
% Cabecera general de 400 bytes - Solo leo lo absolutamente necesario.
%No sabemos que es, podemos saltarlo
%fread (FileID, 4, 'uint16'); % No se sabe qué es pero hay que leerlo
fseek(FileID,8,'cof');
Control = fread (FileID, 32,'uchar'); % Contiene el nombre del fichero, cuando no está, está vacío
if isempty(Control) % Cuando los 32 bits de Control están vacíos (no hay más datos) deja de leer.
    fprintf('Last curve available: %i\n',curIndex)
    return;
end
blqSize = fread (FileID, 2, 'int32');
IVpts    = blqSize(2); % Número de puntos de las IV
blqColumns = blqSize(1); % Ristras guardadas en cada IV: En principio sólo hay V e I pero puede haber más casillas marcadas en el Liner.exe
%Saltamos el resto de la cabecera porque no nos interesa
fseek(FileID,352,'cof');

% Ahora queremos definir el vector Voltaje.
bstart=ftell(FileID); %bytes antes de leer el voltaje
[Data] = readSet(FileID,IVpts); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la función readSet
bend=ftell(FileID); %bytes despues de leer el voltaje
bskip(1)=bend-bstart;
Voltage = zeros(IVpts,1); % Defino el vector vacío voltaje
Voltage(:,1) = Data; % Relleno el vector voltaje
if Choice(1)
    FF = zeros(IVpts,Row*Col);
end
if Choice(2)
    FB = zeros(IVpts,Row*Col);
end
if Choice(3)
    BF = zeros(IVpts,Row*Col);
end
if Choice(4)
    BB = zeros(IVpts,Row*Col);
end

disp(['  Puntos en las IV: ',num2str(IVpts),'    Nº total de curvas: ',num2str(finalPoint)]);
%Comprobamos que existe la columna que queremos leer
if opt.BlqColumn > blqColumns
    fprintf('The desired column cannot be read. The file cointains only %i columns\n',blqColumns)
    return
end

% Como ya hemos leído el voltaje de la primera curva, si no queremos
% perder la información de la corriente de esa curva tenemos que
% guardarla ahora para no pasarnos de largo en el archivo binario,
% y en todo caso utilizarla luego.
for c = 2:blqColumns % En caso de que haya más cosas guardadas por ristra
    bstart2=ftell(FileID);
    if c==opt.BlqColumn
        [Data, readFlag,DataFormat,Factor] = readSet(FileID,  IVpts); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la función readSet
    else
        readSet(FileID,  IVpts);
    end
    bend2=ftell(FileID);
    %el tamaño en bytes del eje y no tiene por qué ser el mismo
    %que el de voltaje.
    % Obtenemos este valor para cada columna
    bskip(c)=bend2-bstart2;
end
switch opt.Format
    case {'normal','forth'}
        if Choice(1) && readFlag
            ColII = ColII+1;
            FF(:,ColII) = Data;
        end
    case 'back'
        if Choice(3) && readFlag
            ColVI = ColVI+1;
            BF(:,ColVI) = Data;
        end
end


%El resto de curvas del archivo
for curIndex = startPoint+1 : finalPoint
    % Cabecera general de 400 bytes - Solo leo lo absolutamente necesario.
    %No sabemos que es, podemos saltarlo
    %fread (FileID, 4, 'uint16'); % No se sabe qué es pero hay que leerlo
    fseek(FileID,8,'cof');
    Control = fread (FileID, 32,'uchar'); % Contiene el nombre del fichero, cuando no está, está vacío
    if isempty(Control) % Cuando los 32 bits de Control están vacíos (no hay más datos) deja de leer.
        fprintf('Last curve available: %i\n',curIndex)
        break;
    end
    blqSize = fread (FileID, 2, 'int32');
    IVpts    = blqSize(2); % Número de puntos de las IV
    blqColumns = blqSize(1); % Ristras guardadas en cada IV: En principio sólo hay V e I pero puede haber más casillas marcadas en el Liner.exe
    %Saltamos el resto de la cabecera porque no nos interesa
    fseek(FileID,352,'cof');

    %Como ya sabemos el numero de bytes(lo podemos calcular en la primera curva), podemos utilizar fseek para saltarlo
    fseek(FileID,bskip(1),'cof');

    newIndex = curIndex-startPoint+1; % Este es el contador que determina si toca guardar esa ristra o no
    for c=2:opt.BlqColumn-1
        fseek(FileID,bskip(c),'cof');
    end
    switch opt.Format
        case 'normal'
            if mod(floor((newIndex-1)/(2*Col)),2) == 0
                if mod(newIndex-1,2) == 0 && Choice(1)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColII = ColII + 1;
                    FF(:,ColII) = Data;
                elseif mod(newIndex-1,2) ~= 0 && Choice(2)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColIV = ColIV + 1;
                    FB(:,ColIV) = Data;
                else
                    fseek(FileID,bskip(opt.BlqColumn),'cof');
                end
            else
                if mod(newIndex-1,2) == 0 && Choice(3)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColVI = ColVI + 1;
                    BF(:,ColVI) = Data;
                elseif mod(newIndex-1,2) ~= 0 && Choice(4)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColVV = ColVV + 1;
                    BB(:,ColVV) = Data;
                else
                    fseek(FileID,bskip(opt.BlqColumn),'cof');
                end
            end
        case 'forth'
                if mod(newIndex-1,2) == 0 && Choice(1)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColII = ColII + 1;
                    FF(:,ColII) = Data;
                elseif mod(newIndex-1,2) ~= 0 && Choice(2)
                    [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                    ColIV = ColIV + 1;
                    FB(:,ColIV) = Data;
                else
                    fseek(FileID,bskip(opt.BlqColumn),'cof');
                end
        case 'back'
            if mod(newIndex-1,2) == 0 && Choice(3)
                [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                ColVI = ColVI + 1;
                BF(:,ColVI) = Data;
            elseif mod(newIndex-1,2) ~= 0 && Choice(4)
                [Data, readFlag] = readSetFast(FileID, IVpts,DataFormat,Factor); % Esto lee la corriente y guardamos.
                ColVV = ColVV + 1;
                BB(:,ColVV) = Data;
            else
                fseek(FileID,bskip(opt.BlqColumn),'cof');
            end

    end
    for c=opt.BlqColumn+1:blqColumns
        fseek(FileID,bskip(c),'cof');
    end


end

%Sacamos el indice de la ultima curva para controlar si nos queda
%incompleto
% fprintf('Last index for each direction: \n II: %i \n IV: %i \n VI: %i \n VV: %i \n',ColII,ColIV,ColVI,ColVV);


% Ahora toca reordenar las matrices de salida para que todas 'empiecen'
% y 'acaben' en los mismos valores de voltaje y posición

if Choice(4)
    BBAux = BB;
    for i = 1:Col
        BBAux(:,i:Col:end-(Col-i)) = BB(:,Col-(i-1):Col:end-(i-1));
    end
    BB = flipud(BBAux); % Flip the values so that they are sorted the same as forth sweep
    clear BBAux;
end
if Choice(3)
    BFAux = BF;
    for i = 1:Col
        BFAux(:,i:Col:end-(Col-i)) = BF(:,Col-(i-1):Col:end-(i-1));
    end
    BF = BFAux;
    clear BFAux;
end
if Choice(2)
    FB = flipud(FB); % Flip the values so that they are sorted the same as forth sweep
end
fclose(FileID);
counts = [ColII, ColIV, ColVI, ColVV]; % contains the count of each of the requested curves
end