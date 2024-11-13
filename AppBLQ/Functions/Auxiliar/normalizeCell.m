function [NormalCell] = normalizeCell(Cell)
NormalCell = cellfun(@(x) x/mean(x,"all",'omitnan'),Cell,UniformOutput=false);
end