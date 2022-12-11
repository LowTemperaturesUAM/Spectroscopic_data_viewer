function [Cell] = curves2maps(Matriz,Info)
    pts = numel(Info.Voltaje);
    Row = numel(Info.DistanciaFilas);
    Col = numel(Info.DistanciaColumnas);
    MatrizNueva = reshape(Matriz,[pts,Col,Row]);
    MatrizNueva = permute(MatrizNueva,[2,3,1]);
    MatrizNueva = pagetranspose(MatrizNueva);
    Cell = mat2cell(MatrizNueva,Row,Col,ones(1,pts));
    clear MatrizNueva pts Row Col
end