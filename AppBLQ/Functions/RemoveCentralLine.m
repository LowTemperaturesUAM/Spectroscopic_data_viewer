function [CellRemoved] = RemoveCentralLine(Cell, ~, V, H)
% V y H son variables lógicas
[Filas,Columnas] = size(Cell{1});

CellRemoved = Cell;

for k=1:length(Cell)
    %---------
    %Vertical
    %---------
    if V
        CellRemoved{k}(:,floor(Columnas/2)+1) = mean([CellRemoved{k}(:,floor(Columnas/2)),...
            CellRemoved{k}(:,floor(Columnas/2)+2)],2);
    end

    %----------
    %Horizontal
    %----------
    if H
        CellRemoved{k}(floor(Filas/2)+1,:) = mean([CellRemoved{k}(floor(Filas/2),:);...
            CellRemoved{k}(floor(Filas/2)+2,:)],1);
    end
end

