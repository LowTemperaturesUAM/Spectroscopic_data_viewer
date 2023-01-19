function [CellRotated] = RotateMatrixFFT(Cell, Angle)
[Filas,Columnas] = size(Cell);
%if the matrix has even number of elements, we add an extra element at the
%end to keep the position of the center unchanged during the rotation
if mod(Filas,2)==0 && mod(Columnas,2) == 0
    CellRotated = cellfun(@(x) imrotate(x([1:end 1],[1:end 1]),Angle,'crop')...
        ,Cell,UniformOutput=false);
    CellRotated = cellfun(@(x) x(1:end-1,1:end-1),CellRotated,UniformOutput=false);
else
    CellRotated = cellfun(@(x) imrotate(x,Angle,'crop'),Cell,UniformOutput=false);
end
