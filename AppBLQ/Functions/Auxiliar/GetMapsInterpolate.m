function [Maps] = GetMapsInterpolate(V,Curves,E,Row,Col,method)
%Obtains maps from a set of curves by interpolating the values at the given
%energies using the method provided as the input
%We need to convert the array to a cell first
MapsAUX = cellfun(@(E) interp1(V,Curves,E,method), num2cell(E)','UniformOutput',false);
Maps = cellfun(@(x) reshape(x,[Col,Row]).',MapsAUX, 'UniformOutput',false);
end