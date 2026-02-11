function [MatrizNormalizada] = NormalizeJunction(Vset,Curves,CurrentMap,opts)
arguments
    Vset (1,1) double {mustBeVector}
    Curves double {mustBeFinite}
    CurrentMap double {mustBeFinite}
    opts.Type (1,:) char {mustBeMember(opts.Type,{'Conductance','Current'})}= 'Conductance'
end
%Poor man's Juction normalization
%proper way should use a linear fit near voltage set point.

if (numel(CurrentMap)~=size(Curves,2))
    error('The current map provided is not the right size')
end

if isvector(CurrentMap)
    %Its provided as a vector already, and we just need to orient it properly
    Iset = reshape(CurrentMap,[1 numel(CurrentMap)]);
elseif ismatrix(CurrentMap)
    %Otherwise, its a 2D map and we have to transpose first
    Iset = reshape(CurrentMap.',[1,numel(CurrentMap)]);
else
    error(['The shape of the current map cannot be handled, please consider' ...
        ' using the matrix or a linear vector instead'])
end

G = Iset./Vset; %Calculate the juction conductance
MatrizNormalizada = Curves./G;
    