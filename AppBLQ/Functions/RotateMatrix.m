function [CellRotated] = RotateMatrix(Cell, Angle)
[Filas,Columnas] = size(Cell);


CellRotated = Cell;

for k=1:length(Cell)
    TransformadasRotadaAUX = imrotate(Cell{k},Angle); 
        [FilasMatrizRotada, ColumnasMatrizRotada] = size(TransformadasRotadaAUX);
        CentroX = floor(ColumnasMatrizRotada/2);
        CentroY = floor(FilasMatrizRotada/2);
    MatrizRotadaZoom = TransformadasRotadaAUX(CentroY-Filas/2+1:CentroY+Filas/2,CentroX-Columnas/2+1:CentroX+Columnas/2);
        CellRotated{k} = MatrizRotadaZoom;
        
       
end