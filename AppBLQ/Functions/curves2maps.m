function [Cell] = curves2maps(Matriz,Info)
% [Cell] = curves2maps(Matriz,Info) turns the curves in array Matriz to a
% cell array with maps. Matriz is ptsIVx(RowsxCols), while Cell will be a
% 1xptsIV array. The struct Info holds information of number of Rows,
% Columns and Voltage.

% Take parameters from Info
    pts = numel(Info.Voltaje);
    Row = numel(Info.DistanciaFilas);
    Col = numel(Info.DistanciaColumnas);
% Reshape Matriz into a Map-like array, with dim 3 as Voltage
    MatrizNueva = reshape(Matriz,[pts,Col,Row]);
    MatrizNueva = permute(MatrizNueva,[2,3,1]);
    MatrizNueva = pagetranspose(MatrizNueva);

    Cell = mat2cell(MatrizNueva,Row,Col,ones(1,pts));
    Cell = squeeze(Cell).';

    % Reorder maps in Cell in increasing order of Voltage
    [~,idx] = sort(Info.Voltaje,'ascend');
    Cell = Cell(idx);
    clear MatrizNueva pts Row Col
end