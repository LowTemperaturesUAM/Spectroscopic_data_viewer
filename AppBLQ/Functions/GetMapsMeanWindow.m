function [Maps] = GetMapsMeanWindow(V,Curves,E,DeltaE,Row,Col)
%Obtains maps from a set of curves by averaging voltage points around an
%energy window defined as (E-DeltaE,E+DeltaE). For averaging windows lower
%than 2*(Vi-V(i-1)), this method is equivalent to nearest point
%interpolation
Index = cellfun(@(E) find(E - DeltaE < V & ...
    E + DeltaE > V),num2cell(E)', 'UniformOutput',false);
MapsAUX = cellfun(@(x) mean(Curves(x,:),1), Index,'UniformOutput',false);
Maps = cellfun(@(x) reshape(x,[Col,Row]).',MapsAUX, 'UniformOutput',false);
end