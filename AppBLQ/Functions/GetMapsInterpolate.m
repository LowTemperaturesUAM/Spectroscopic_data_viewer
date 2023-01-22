function [Maps] = GetMapsInterpolate(V,Curves,E,Row,Col,method)
%Obtains maps from a set of curves by interpolating the values at the given
%energies using the method provided as the input
MapsAUX = cellfun(@(Y) interp1(V,Y,E,method), Curves,'UniformOutput',false);
Maps = cellfun(@(x) reshape(x,[Col,Row]).',MapsAUX, 'UniformOutput',false);
end