function [CellSmooth] = GaussSmooth(Cell, Value, ~)

CellSmooth = Cell;

for k=1:length(Cell)
   CellSmooth{k} = imgaussfilt(Cell{k},Value);
end