function [CellPlane] = planeCell(Cell, ~)

[Columnas,Filas] = size(Cell{1});

%create the grid to fit into a 2D plane
[y, x] = meshgrid(1:Filas, 1:Columnas);
X = [ones(Filas*Columnas, 1), x(:), y(:)];

%Get the plane parameters using least squares
%We use (:) to implicitly convert into a vector
M = cellfun(@(Y) X\Y(:),Cell,UniformOutput=false); 
%Substract the plane from each map
CellPlane = cellfun(@(C,Y) C - reshape(X*Y,Columnas,Filas),...
    Cell,M,UniformOutput=false);
end