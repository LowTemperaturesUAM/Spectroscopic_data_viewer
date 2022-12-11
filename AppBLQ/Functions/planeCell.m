function [CellPlane] = planeCell(Cell, Info)

CellPlane = Cell;

Columnas = length(Info.DistanciaColumnas);
Filas = length(Info.DistanciaFilas);

[y, x] = meshgrid(1:Filas, 1:Columnas);
X = [ones(Filas*Columnas, 1), x(:), y(:)];

for k=1:length(Cell)
    M = X\Cell{k}(:);
    Plane = reshape(X*M, Columnas, Filas);  
    
    CellPlane{k} = Cell{k}-Plane;
end
end

%%WTF is this calculation?? I don't understand how it even works