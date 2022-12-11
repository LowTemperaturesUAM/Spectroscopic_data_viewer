function [CellFlatten] = FlattenCell(Cell, flag, Info)

CellFlatten = Cell;

for k=1:length(Cell)
    ValorNormSup = max(max(Cell{k}));
    ValorNormInf = min(min(Cell{k}));
    
    NormValue = ValorNormSup - ValorNormInf;
    
    CellFlatten{k} = Flatten(Cell{k},flag);
    
    MaxFlatten = max(max(CellFlatten{k}));
    MinFlatten = min(min(CellFlatten{k}));
    NormFlatten = MaxFlatten-MinFlatten;
    
    CellFlatten{k} = (((CellFlatten{k} - MinFlatten)./NormFlatten)*NormValue) + ValorNormInf;
end
end