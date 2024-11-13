function NewCell = MedianCell(Cell,window)
    NewCell = cellfun(@(x) medfilt2(x, [1 1]*(2*window+1),'symmetric'),...
        Cell,UniformOutput=false);
end