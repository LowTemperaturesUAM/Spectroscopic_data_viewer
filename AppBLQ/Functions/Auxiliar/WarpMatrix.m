function [CellWarped] = WarpMatrix(Cell,XShear,YShear,YXratio,Info)

Columnas = length(Info.DistanciaFourierColumnas);
Filas    = length(Info.DistanciaFourierFilas);
tform = affine2d ([1,YShear,0;-XShear,YXratio,0;0,0,1]);
CellWarped = Cell;

for k=1:length(Info.Energia)
    CellWarpedAUX = imwarp(Cell{k},tform);
    [FilasCellWarped, ColumnasCellWarped] = size(CellWarpedAUX);
    CentroX = floor(ColumnasCellWarped/2);
    CentroY = floor(FilasCellWarped/2);
    CellWarpedZoom = CellWarpedAUX(CentroY-Filas/2+1:CentroY+Filas/2,CentroX-Columnas/2+1:CentroX+Columnas/2);
    CellWarped{k}=CellWarpedZoom;
end

    clear CellWarpedAUX CellWarpedZoom ;
    clear CentroX CentroY FilasCellWarped ColumnasCellWarped;
    
end