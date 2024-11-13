function [Matriz] = maps2curves(Cell,Info)
    pts = numel(Info.Voltaje);
    Row = numel(Info.DistanciaFilas);
    Col = numel(Info.DistanciaColumnas);
    Cell = reshape(Cell,[1 1 numel(Cell)]);
    MatrizPrevia = cell2mat(Cell);
    MatrizPrevia = pagetranspose(MatrizPrevia);
    MatrizPrevia = permute(MatrizPrevia,[3,1,2]);
    Matriz = reshape(MatrizPrevia,[pts,Col*Row]);
    clear MatrizPrevia pts Row Col
end