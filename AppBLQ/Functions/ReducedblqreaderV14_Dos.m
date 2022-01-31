%BLQREADER para blqs corruptas cuadradas o rectangulares

function  [Voltaje, IdaIda, IdaVuelta, VueltaIda, VueltaVuelta] = ReducedblqreaderV14_Dos(FileName, Filas, Columnas, Eleccion, initialPoint,LeerColumna)

FileID = fopen (FileName,'r'); % FileID es el nombre que le damos a todo lo que Matlab lea desde el BLQ
fprintf('ABRIENDO BLQ ...');
% ------------------------------------------
% Las matrices de salida son:
%     Voltaje      = zeros(PuntosIV,1);
%     IdaIda       = zeros(PuntosIV,Filas*Columnas);
%     IdaVuelta    = zeros(PuntosIV,Filas*Columnas);
%     VueltaIda    = zeros(PuntosIV,Filas*Columnas);
%     VueltaVuelta = zeros(PuntosIV,Filas*Columnas);

disp([' Leyendo columna ', num2str(LeerColumna)]);
% LeerColumna = 2; % 2 � 3

ColIda = 0;
ColIV = 0;
ColVI = 0;
ColVV = 0;

IdaIda       = 0;
IdaVuelta    = 0;
VueltaIda    = 0;
VueltaVuelta = 0;

finalPoint = 4*Filas*Columnas;

for NumeroCurva = 1 : 1 : finalPoint + initialPoint-1
% -------------------------------------------------------------------------
    % Cabecera general de 400 bytes - Solo leo lo absolutamente necesario.
    
    fread (FileID, 4, 'uint16'); % No se sabe qu� es pero hay que leerlo
    Control = fread (FileID, 32,'uchar'); % Contiene el nombre del fichero, cuando no est�, est� vac�o
    if isempty(Control) % Cuando los 32 bits de Control est�n vac�os (no hay m�s datos) deja de leer.
        break; 
    end
    TamanoDatos = fread (FileID, 2, 'int32'); 
        PuntosIV    = TamanoDatos(2); % N�mero de puntos de las IV
        ColumnasBLQ = TamanoDatos(1); % Ristras guardadas en cada IV: En principio s�lo hay V e I pero puede haber m�s casillas marcadas en el Liner.exe
    fread(FileID,352,'uchar'); % Otra cosa que no se sabe lo que es pero hay que leer.
% -------------------------------------------------------------------------
    % Ahora queremos definir el vector Voltaje.
    
    if NumeroCurva == initialPoint % Diferenciamos el caso de la primera curva para cargar su voltaje: las dem�s ser� el mismo
       [Data] = readSet(FileID,PuntosIV); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la funci�n readSet
       Voltaje      = zeros(PuntosIV,1); % Defino el vector vac�o voltaje
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
            disp(['  Puntos en las IV: ',num2str(PuntosIV),'    N� total de curvas: ',num2str(finalPoint)]);
            Voltaje(:,1) = Data; % Relleno el vector voltaje
% ------------------------------------------------------------------------- 
    % Como ya hemos le�do el voltaje de la primera curva, si no queremos
    % perder la informaci�n de la corriente de esa curva tenemos que
    % guardarla ahora para no pasarnos de largo en el archivo binario,
    % y en todo caso utilizarla luego.
        if Eleccion(1)
            for c = 2:ColumnasBLQ-1 % En caso de que haya m�s cosas guardadas por ristra
                if LeerColumna == 2
                    [Data, readFlag] = readSet(FileID,  PuntosIV); % Guardo la 2� columna
                    [~, ~] = readSet(FileID,  PuntosIV); % Salto la 3� columna
                elseif LeerColumna == 3
                    [~, ~] = readSet(FileID,  PuntosIV); % Salto la 2� columna
                    [Data, readFlag] = readSet(FileID,  PuntosIV); % Guardo la 3� columna
                else
                    brake
                end
                
                if readFlag
                    ColIda = ColIda+1;
                    IdaIda(:,ColIda) = Data;
                end
            end
        else
%             for c = 2:ColumnasBLQ % En caso de que haya m�s cosas guardadas por ristra
%                 readSet(FileID,  PuntosIV); % Ventilamos la cabecera y leemos las IV en cada ristra del BLQ con la funci�n readSet
%             end
        end
% -------------------------------------------------------------------------
    % Ahora leemos el resto de curvas, saltando convenientemente las que no
    % nos interesen al inicio del BLQ.
    elseif NumeroCurva < initialPoint % Las primeras curvas que no valen
        for c = 1:ColumnasBLQ    
            readSet(FileID,  PuntosIV);  % Hay que leerlas pero pasamos de ellas y no las guardamos 
        end
         
% -------------------------------------------------------------------------
    % Y finalmente leemos el resto de curvas que s� nos interesan y las
    % guardamos en las matrices de salida.
    else
        for c = 2:ColumnasBLQ-1 % Notar que ahora empezamos de 1 porque tambi�n hay que leer el voltaje en cada curva aunque no lo guardemos      
           [~, ~] = readSet(FileID, PuntosIV); % Dr Pepe: Esto lee el voltaje y sudamos de el.
           
           if LeerColumna == 2
               [Data, readFlag] = readSet(FileID,  PuntosIV); % Guardo la 2� columna
               [~, ~] = readSet(FileID,  PuntosIV); % Salto la 3� columna
           elseif LeerColumna == 3
               [~, ~] = readSet(FileID,  PuntosIV); % Salto la 2� columna
               [Data, readFlag] = readSet(FileID,  PuntosIV); % Guardo la 3� columna
           else
               brake
           end

%            [Data, readFlag] = readSet(FileID, PuntosIV); % Esto lee la corriente y guardamos
           
           NumeroCurvaG = NumeroCurva - initialPoint+1; % Este es el contador que determina si toca guardar esa ristra o no
       
           % [~, ~] = readSet(FileID, PuntosIV); Si hay mas de dos
           % columnas, hay que meter tantos readSet como columnas haya
           % demas. Hay que tener cuidado donde se guarda la corriente. Por
           % ejemplo, si el blq guarda: Voltaje, Corriente, Z, al final de
           % este for, hay que poner un readSet. Si fuese Voltaje, Z y
           % Corriente, habr� que poner el readSet antes de que guarde los
           % datos de corriente.
            
            if readFlag
                if mod(floor((NumeroCurvaG +1)/(2*Columnas)),2) == 0
                    if mod(NumeroCurvaG +1,2) == 0 && Eleccion(1) == 1    
                        ColIda = ColIda + 1;
                        IdaIda(:,ColIda) = Data;
                    else
                        if mod(NumeroCurva+1,2) ~= 0 && Eleccion(2) == 1
                            ColIV = ColIV + 1;
                            IdaVuelta(:,ColIV) = Data;
                        end
                    end
                else
                    if mod(NumeroCurvaG+1,2) == 0 && Eleccion(3) == 1
                        ColVI = ColVI + 1;
                        VueltaIda(:,ColVI) = Data;
                    else
                        if mod(NumeroCurva+1,2) ~= 0 && Eleccion(4) == 1
                            ColVV = ColVV + 1;
                            VueltaVuelta(:,ColVV) = Data;
                        end
                    end
                end
            end
        end
    end
end
% -------------------------------------------------------------------------
    % Ahora toca reordenar las matrices de salida para que todas 'empiecen'
    % y 'acaben' en los mismos valores de voltaje y posici�n
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