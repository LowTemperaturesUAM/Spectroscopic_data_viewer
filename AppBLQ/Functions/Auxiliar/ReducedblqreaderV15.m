%BLQREADER para blqs corruptas cuadradas o rectangulares

function  [Voltaje, IdaIda, IdaVuelta, VueltaIda, VueltaVuelta] = ReducedblqreaderV15( FileName, Filas, Columnas, Eleccion, initialPoint)

FileID = fopen (FileName,'r'); % FileID es el nombre que le damos a todo lo que Matlab lea desde el BLQ
fprintf('ABRIENDO BLQ ...');
% ------------------------------------------
% Las matrices de salida son:
%     Voltaje      = zeros(PuntosIV,1);
%     IdaIda       = zeros(PuntosIV,Filas*Columnas);
%     IdaVuelta    = zeros(PuntosIV,Filas*Columnas);
%     VueltaIda    = zeros(PuntosIV,Filas*Columnas);
%     VueltaVuelta = zeros(PuntosIV,Filas*Columnas);

ColIda = 0;
ColIV = 0;
ColVI = 0;
ColVV = 0;

IdaIda       = 0;
IdaVuelta    = 0;
VueltaIda    = 0;
VueltaVuelta = 0;

finalPoint = 4*Filas*Columnas;

IICeros = [];
IVCeros = [];
VICeros = [];
VVCeros = [];
for NumeroCurva = 1 : 1 : finalPoint + initialPoint-1
% -------------------------------------------------------------------------
    % Cabecera general de 400 bytes - Solo leo lo absolutamente necesario.
    %No sabemos que es, podemos saltarlo
    %fread (FileID, 4, 'uint16'); % No se sabe qué es pero hay que leerlo
    fseek(FileID,8,'cof');
    Control = fread (FileID, 32,'uchar'); % Contiene el nombre del fichero, cuando no está, está vacío
    if isempty(Control) % Cuando los 32 bits de Control están vacíos (no hay más datos) deja de leer.
        break; 
    end
    TamanoDatos = fread (FileID, 2, 'int32'); 
        PuntosIV    = TamanoDatos(2); % Número de puntos de las IV
        ColumnasBLQ = TamanoDatos(1); % Ristras guardadas en cada IV: En principio sólo hay V e I pero puede haber más casillas marcadas en el Liner.exe
    %Como no sabemos lo que es podemos saltarlo
    %fread(FileID,352,'uchar'); % Otra cosa que no se sabe lo que es pero hay que leer.
    fseek(FileID,352,'cof');
    
% -------------------------------------------------------------------------
    % Ahora queremos definir el vector Voltaje.
    
    if NumeroCurva == initialPoint % Diferenciamos el caso de la primera curva para cargar su voltaje: las demás será el mismo
       bstart=ftell(FileID); %bytes antes de leer el voltaje
       [Data] = readSet(FileID,PuntosIV); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la función readSet
       bend=ftell(FileID); %bytes despues de leer el voltaje
       bskip=bend-bstart;
       Voltaje      = zeros(PuntosIV,1); % Defino el vector vacío voltaje
            if Eleccion(1)
                IdaIda       = zeros(PuntosIV,Filas*Columnas);
            end
            if Eleccion(2)
                IdaVuelta    = zeros(PuntosIV,Filas*Columnas);
            end
            if Eleccion(3)
                VueltaIda    = zeros(PuntosIV,Filas*Columnas);
            end
            if Eleccion(4)
            VueltaVuelta = zeros(PuntosIV,Filas*Columnas);
            end
            disp(['  Puntos en las IV: ',num2str(PuntosIV),'    Nº total de curvas: ',num2str(finalPoint)]);
            Voltaje(:,1) = Data; % Relleno el vector voltaje
% ------------------------------------------------------------------------- 
    % Como ya hemos leído el voltaje de la primera curva, si no queremos
    % perder la información de la corriente de esa curva tenemos que
    % guardarla ahora para no pasarnos de largo en el archivo binario,
    % y en todo caso utilizarla luego.
        if Eleccion(1)
            for c = 2:ColumnasBLQ % En caso de que haya más cosas guardadas por ristra
                [Data, readFlag] = readSet(FileID,  PuntosIV); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la función readSet
                if readFlag
                    ColIda = ColIda+1;
                    IdaIda(:,ColIda) = Data;
                end
            end
        else
            for c = 2:ColumnasBLQ % En caso de que haya más cosas guardadas por ristra
                readSet(FileID,  PuntosIV); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la función readSet
            end
        end
% -------------------------------------------------------------------------
    % Ahora leemos el resto de curvas, saltando convenientemente las que no
    % nos interesen al inicio del BLQ.
    elseif NumeroCurva < initialPoint % Las primeras curvas que no valen
        for c = 1:ColumnasBLQ    
            readSet(FileID,  PuntosIV);  % Hay que leerlas pero pasamos de ellas y no las guardamos 
        end
        %despues de leer la primera curva, podemos ver en que byte nos
        %encontramos con ftell(FileID) y directamente saltamos hasta la
        %curva que hayamos puesto como initial point
         
% -------------------------------------------------------------------------
    % Y finalmente leemos el resto de curvas que sí nos interesan y las
    % guardamos en las matrices de salida.
    else
        for c = 2:ColumnasBLQ % Notar que ahora empezamos de 1 porque también hay que leer el voltaje en cada curva aunque no lo guardemos      
           %[~, ~] = readSet(FileID, PuntosIV); % Dr Pepe: Esto lee el voltaje y sudamos de el.
           %Como ya sabemos el numero de bytes(lo podemos calcular en la primera curva), podemos utilizar fseek para saltarlo
           %nos lleva un tercio del tiempo leer estos datos para desecharlos cada vez
           fseek(FileID,bskip,'cof');
           %-------------------------------------------------------------------------------------------
%            [~, ~] = readSet(FileID, PuntosIV); % Dr Fran: Esto lee la segunda columna y sudamos de ella.
           %-------------------------------------------------------------------------------------------
           [Data, readFlag] = readSet(FileID, PuntosIV); % Esto lee la corriente y guardamos
            NumeroCurvaG = NumeroCurva - initialPoint+1; % Este es el contador que determina si toca guardar esa ristra o no
       
            % [~, ~] = readSet(FileID, PuntosIV); Si hay mas de dos
            % columnas, hay que meter tantos readSet como columnas haya
            % demas. Hay que tener cuidado donde se guarda la corriente. Por
            % ejemplo, si el blq guarda: Voltaje, Corriente, Z, al final de
            % este for, hay que poner un readSet. Si fuese Voltaje, Z y
            % Corriente, habrá que poner el readSet antes de que guarde los
            % datos de corriente.
            

            if mod(floor((NumeroCurvaG +1)/(2*Columnas)),2) == 0
                if mod(NumeroCurvaG +1,2) == 0 && Eleccion(1) == 1    
                    ColIda = ColIda + 1;
                    if ~readFlag IICeros = [IICeros ColIda]; end
                    IdaIda(:,ColIda) = Data;
                elseif mod(NumeroCurvaG+1,2) ~= 0 && Eleccion(2) == 1
                    ColIV = ColIV + 1;
                    if ~readFlag IVCeros = [IVCeros ColIV]; end
                    IdaVuelta(:,ColIV) = Data;
                end
            else
                if mod(NumeroCurvaG+1,2) == 0 && Eleccion(3) == 1
                    ColVI = ColVI + 1;
                    if ~readFlag VICeros = [VICeros ColVI]; end
                    VueltaIda(:,ColVI) = Data;
                elseif mod(NumeroCurvaG+1,2) ~= 0 && Eleccion(4) == 1
                    ColVV = ColVV + 1;
                    if ~readFlag VVCeros = [VVCeros ColVV]; end
                    VueltaVuelta(:,ColVV) = Data;
                end
            end


            %Sabiendo que la estructura ida/vuelta se repite, podriamos
            %evitarnos estos calculos y directamente saltar las curvas que
            %no queramos. 
            %-------------------------------------------------------------------------------------------
%            [~, ~] = readSet(FileID, PuntosIV); % Dr Fran: Esto lee la tercera columna y sudamos de ella.
            %-------------------------------------------------------------------------------------------
        end
    end
end
%disp(['Numeros = ', num2str([ColIda,ColIV,ColVI,ColVV])]);

%Interpolamos las curvas adyacentes para aquellas que nos hayan dado
%ceros al principio

IdaIda(:,IICeros)=(IdaIda(:,IICeros+1)+IdaIda(:,IICeros-1))/2;
IdaVuelta(:,IVCeros)=(IdaVuelta(:,IVCeros+1)+IdaVuelta(:,IVCeros-1))/2;
VueltaIda(:,VICeros)=(VueltaIda(:,VICeros+1)+VueltaIda(:,VICeros-1))/2;
VueltaVuelta(:,VVCeros)=(VueltaVuelta(:,VVCeros+1)+VueltaVuelta(:,VVCeros-1))/2;

% -------------------------------------------------------------------------
    % Ahora toca reordenar las matrices de salida para que todas 'empiecen'
    % y 'acaben' en los mismos valores de voltaje y posición
if Eleccion(3) == 1 && Eleccion(4) == 1
    VueltaIdaAUX = VueltaIda;
    VueltaVueltaAUX = VueltaVuelta;
    for i = 1:Columnas
        VueltaIdaAUX(:,i:Columnas:end-(Columnas-i)) = VueltaIda(:,Columnas-(i-1):Columnas:end-(i-1));
        VueltaVueltaAUX(:,i:Columnas:end-(Columnas-i)) = VueltaVuelta(:,Columnas-(i-1):Columnas:end-(i-1));
    end
        VueltaIda = VueltaIdaAUX;
        clear VueltaIdaAUX;
        VueltaVuelta = VueltaVueltaAUX;
        clear VueltaVueltaAUX;
else
    if Eleccion(4) == 1
        VueltaVueltaAUX = VueltaVuelta;
        for i = 1:Columnas
            VueltaVueltaAUX(:,i:Columnas:end-(Columnas-i)) = VueltaVuelta(:,Columnas-(i-1):Columnas:end-(i-1));
        end
        VueltaVuelta = VueltaVueltaAUX;
        clear VueltaVueltaAUX;
    elseif Eleccion(3) == 1
         VueltaIdaAUX = VueltaIda;
         for i = 1:Columnas
            VueltaIdaAUX(:,i:Columnas:end-(Columnas-i)) = VueltaIda(:,Columnas-(i-1):Columnas:end-(i-1));
         end
         VueltaIda = VueltaIdaAUX;
        clear VueltaIdaAUX;
    end
end
    if Eleccion(2) ==1    
        IdaVuelta = flipud(IdaVuelta);
    end
    if Eleccion(4) ==1
        VueltaVuelta = flipud(VueltaVuelta);
    end
fclose(FileID);