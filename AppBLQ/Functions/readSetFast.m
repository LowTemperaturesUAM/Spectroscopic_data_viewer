%Esto telee columnas del BLQ, ya sean voltaje o corriente, o cualquier otra
%cosa. Vale para BLQs de cualquier electronica. 

function [Data, readFlag] = readSetFast(FileID, NumeroFilas,DataFormat,Factor)
        %En una espectro, toda esta informacion deberia ser la misma en
        %cada curva, y estamos gastando el 70% del tiempo de ejecucion de
        %esta funcion en ello
        fseek(FileID,128,'cof'); %skip everything 
        % If we want to get the prefactor for this particular curve, we do this
        % instead of skipping everything
        % fseek(FileID,20,'cof');
        % Factor = fread(FileID,1,'float64')
        % fseek(FileID,100,'cof');
        switch DataFormat % Abrimos la IV propiamente dicha y extraemos sus datos en la matriz 'Data'
        	case 0
            	Data = Factor*(Offset + Start + (Size/NumeroFilas)*(0:(NumeroFilas-1)));   
                Data = Data';
                readFlag = 1;
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