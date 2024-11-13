function [CellRotated] = RotateMatrixv2(Cell, Angle)
% General matrix rotation function for a Cell array of maps
% Here we assume that out center point is not relevant and we simply apply
% the rotation as is, and return maps with the same size
CellRotated = cellfun(@(x) imrotate(x,Angle,'crop'),...
    Cell,UniformOutput=false);
end
