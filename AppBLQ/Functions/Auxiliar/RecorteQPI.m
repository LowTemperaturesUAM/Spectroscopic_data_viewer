function [InfoStruct] = RecorteQPI(x1,x2,y1,y2,Info)
%Get the previous dimensions of the data
[OldFilas,OldColumnas] = size(Info.MapasConductancia{1});
PuntosIV = length(Info.Voltaje);
%Cut the maps and obtain the new fft maps
Info.MapasConductancia = cellfun(@(x) x(y1:y2,x1:x2),...
    Info.MapasConductancia,UniformOutput=false);
[Info.Transformadas,Info.Fase] = cellfun(@(x) fft2d(x),...
    Info.MapasConductancia,UniformOutput=false);
%Cut the topography as well if it's present
if isfield(Info,'Topo')
    Info.Topo  = Info.Topo(y1:y2,x1:x2);
end
%Obtain the size from the cut down maps
[Filas,Columnas] = size(Info.MapasConductancia{1});

Info.TamanhoRealColumnas = Info.TamanhoRealColumnas*Columnas/OldColumnas;
Info.TamanhoRealFilas = Info.TamanhoRealFilas*Filas/OldFilas;


TamanhoPixelFilas = Info.TamanhoRealFilas/Filas;
TamanhoPixelColumnas = Info.TamanhoRealColumnas/Columnas;

Info.DistanciaColumnas = TamanhoPixelColumnas*(1:1:Columnas);
Info.DistanciaFilas = TamanhoPixelFilas*(1:1:Filas);
    
Info.DistanciaFourierColumnas = (1/Info.TamanhoRealColumnas)*(1:1:Columnas);
Info.DistanciaFourierFilas = (1/Info.TamanhoRealFilas)*(1:1:Filas);

% Centering reciprocal space units
% ------------------------------------------------------------------------
Info.DistanciaFourierColumnas = Info.DistanciaFourierColumnas - Info.DistanciaFourierColumnas(floor(Columnas/2)+1);
Info.DistanciaFourierFilas = Info.DistanciaFourierFilas - Info.DistanciaFourierFilas(floor(Filas/2)+1);
%-------------------------------------------------------------------------


% should use a function for the conversion instead
Matriz3D = reshape(Info.MatrizNormalizada,[PuntosIV,OldColumnas,OldFilas]);
Matriz3D = permute(Matriz3D,[2,3,1]);
Matriz3D = pagetranspose(Matriz3D);
Matriz3DRecortada = Matriz3D(y1:y2,x1:x2,:);
Matriz3DRecortada = pagetranspose(Matriz3DRecortada);
Matriz3DRecortada = permute(Matriz3DRecortada,[3,1,2]);
MatrizNormalizadaRecortada = reshape(Matriz3DRecortada,[PuntosIV,Filas*Columnas] );


Matriz3D = reshape(Info.MatrizCorriente,[PuntosIV,OldColumnas,OldFilas]);
Matriz3D = permute(Matriz3D,[2,3,1]);
Matriz3D = pagetranspose(Matriz3D);
Matriz3DRecortada = Matriz3D(y1:y2,x1:x2,:);
Matriz3DRecortada = pagetranspose(Matriz3DRecortada);
Matriz3DRecortada = permute(Matriz3DRecortada,[3,1,2]);
MatrizCorrienteRecortada = reshape(Matriz3DRecortada,[PuntosIV,Filas*Columnas] );

Info.MatrizNormalizada = MatrizNormalizadaRecortada;
Info.MatrizCorriente = MatrizCorrienteRecortada;
InfoStruct = Info;
end