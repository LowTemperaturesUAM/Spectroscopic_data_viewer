%Esto telee columnas del BLQ, ya sean voltaje o corriente, o cualquier otra
%cosa. Vale para BLQs de cualquier electronica. 

function [Data, readFlag,DataFormat,Factor] = readSet(FileID, NumeroFilas)
            TamanhoDatos =  fread(FileID, 2, 'uint16'); % Nos da el formato de los datos
            DataFormat =  TamanhoDatos(2);
        fread(FileID, 2, 'int32'); % Hay que leer esto que no sabemos lo que es
        %Primer entero es el tipo de dato (Corriente, Voltaje...)
        %El segundo es el numero de promedios
        hofss      =  fread (FileID, 4, 'float64'); % Esto contiene varios datos del experimento en cada curva
            Offset =  hofss(1);
            Factor =  hofss(2); % este valor es un float64, al multiplicarlo, todos los datos serán float... hay que sacarlo de aquí      
            Start  =  hofss(3); 
            Size   =  hofss(4);
        fread(FileID,84,'uchar'); % Esto también hay que leerlo y no sabemos lo que es   
        %En una espectro, toda esta informacion deberia ser la misma en
        %cada curva, y estamos gastando el 70% del tiempo de ejecucion de
        %esta funcion en ello
        switch DataFormat % Abrimos la IV propiamente dicha y extraemos sus datos en la matriz 'Data'
        	case 0
            	Data = Factor*(Offset + Start + (Size/NumeroFilas)*(0:(NumeroFilas-1)));   
                Data = Data';
                readFlag = 0;
            case 1
                Data = Factor*(fread (FileID, NumeroFilas, 'int8')); 
                readFlag = 1;
            case 2
                Data = Factor*(fread (FileID, NumeroFilas, 'int16'));
                readFlag = 1;
            case 4
                Data = Factor*(fread (FileID, NumeroFilas, 'float32'));  
                readFlag = 1;
            case 8 
                Data = Factor*(fread (FileID, NumeroFilas, 'float64'));
                readFlag = 1;
            otherwise
                disp('Wrong data format!');
                Data = 0;
        end
        if Data(1) == 0
            readFlag = 0;
        end
end