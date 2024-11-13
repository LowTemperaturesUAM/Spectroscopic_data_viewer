function [Division, BA] = MapDivision(Cell, Ref, shift=eps)
% Takes a cell array of length L with matrices and divides them 
% simetrically respect to Ref. If Ref is not given, round(L/2) is used.
% An additional shift can be given to the matrices before dividing to avoid
% divergences.


L = length(Cell);
numdifs =  min(abs([1,length(L)]-Ref)) + 1; 
% Initialize
Division = cell(1,numdifs);
BA = cell(1,numdifs);
% Define first cell as ones (division by oneself)
Division{1} = ones(size(Cell{1}));
BA{1} = zeros(size(Cell{1}));

for i=2:numdifs % El num max de mapas dependerá del num de elementos de Energia entre 0 y extremo mas cercano
    Division{i}=(Cell{Ref+i-1} + shift) ./ ...
        (Cell{Ref-i+1} + shift); % Divido + entre -
    BA{i} = atand(sqrt(Division{i}));
end


end