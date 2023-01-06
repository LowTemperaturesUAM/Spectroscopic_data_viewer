function [InfoStruct] = RecorteQPI(y1,y2,x1,x2,Info)
for k=1:length(Info.Energia)
    Mapas1{k} = Info.MapasConductancia{k}(x1:x2,y1:y2);
    Transformadas1{k} = fft2d(Mapas1{k});
end

InfoStruct1 = Info;
InfoStruct1.MapasConductancia = Mapas1;
InfoStruct1.Transformadas = Transformadas1;

InfoStruct1.TamanhoRealColumnas = Info.TamanhoRealColumnas*...
    size(InfoStruct1.MapasConductancia{1},1)/size(Info.MapasConductancia{1},1);
InfoStruct1.TamanhoRealFilas = Info.TamanhoRealFilas*...
    size(InfoStruct1.MapasConductancia{1},2)/size(Info.MapasConductancia{1},2);

%Obtain the size from the cut down maps
Filas = size(InfoStruct1.MapasConductancia{1},1);
Columnas = size(InfoStruct1.MapasConductancia{1},2);

TamanhoPixelFilas = InfoStruct1.TamanhoRealFilas/Filas;
TamanhoPixelColumnas = InfoStruct1.TamanhoRealColumnas/Columnas;

Filas = length(Mapas1{1});
Columnas = Filas;

InfoStruct1.DistanciaColumnas = TamanhoPixelColumnas*(1:1:Columnas);
InfoStruct1.DistanciaFilas = TamanhoPixelFilas*(1:1:Filas);
    
InfoStruct1.DistanciaFourierColumnas = (1/InfoStruct1.TamanhoRealColumnas)*(1:1:Columnas);
InfoStruct1.DistanciaFourierFilas = (1/InfoStruct1.TamanhoRealFilas)*(1:1:Filas);

% Centering reciprocal space units
% ------------------------------------------------------------------------
	InfoStruct1.DistanciaFourierColumnas = InfoStruct1.DistanciaFourierColumnas - InfoStruct1.DistanciaFourierColumnas(floor(Columnas/2)+1); 
    InfoStruct1.DistanciaFourierFilas = InfoStruct1.DistanciaFourierFilas - InfoStruct1.DistanciaFourierFilas(floor(Filas/2)+1);
%-------------------------------------------------------------------------

OldFilas = length(Info.DistanciaFilas);
OldColumnas = length(Info.DistanciaColumnas);
PuntosIV = length(Info.Voltaje);

% for k=1:PuntosIV %very slow
%     Matriz3D(:,:,k) = reshape(Info.MatrizNormalizada(k,:),OldFilas,OldColumnas);
% %     Matriz3D(:,:,k) = Matriz3D(:,:,k)';
%     Matriz3DRecortada(:,:,k) = Matriz3D(y1:y2,x1:x2,k);
%     MatrizNormalizadaRecortada(k,:) = reshape(Matriz3DRecortada(:,:,k),1,(x2-x1+1)*(y2-y1+1));
% end

% should use a function for the conversion instead
Matriz3D = reshape(Info.MatrizNormalizada,[PuntosIV,OldColumnas,OldFilas]);
Matriz3D = permute(Matriz3D,[2,3,1]);
Matriz3D = pagetranspose(Matriz3D);
Matriz3DRecortada = Matriz3D(y1:y2,x1:x2,:);
Matriz3DRecortada = pagetranspose(Matriz3DRecortada);
Matriz3DRecortada = permute(Matriz3DRecortada,[3,1,2]);
MatrizNormalizadaRecortada = reshape(Matriz3DRecortada,[PuntosIV,Filas*Columnas] );


% for k=1:PuntosIV
%     Matriz3D(:,:,k) = reshape(Info.MatrizCorriente(k,:),OldFilas,OldColumnas);
% %     Matriz3D(:,:,k) = Matriz3D(:,:,k)';
%     Matriz3DRecortada(:,:,k) = Matriz3D(y1:y2,x1:x2,k);
%     MatrizCorrienteRecortada (k,:) = reshape(Matriz3DRecortada(:,:,k),1,(x2-x1+1)*(y2-y1+1));
% end


Matriz3D = reshape(Info.MatrizCorriente,[PuntosIV,OldColumnas,OldFilas]);
Matriz3D = permute(Matriz3D,[2,3,1]);
Matriz3D = pagetranspose(Matriz3D);
Matriz3DRecortada = Matriz3D(y1:y2,x1:x2,:);
Matriz3DRecortada = pagetranspose(Matriz3DRecortada);
Matriz3DRecortada = permute(Matriz3DRecortada,[3,1,2]);
MatrizCorrienteRecortada = reshape(Matriz3DRecortada,[PuntosIV,Filas*Columnas] );

InfoStruct1.MatrizNormalizada = MatrizNormalizadaRecortada;
InfoStruct1.MatrizCorriente = MatrizCorrienteRecortada;
InfoStruct = InfoStruct1;
end