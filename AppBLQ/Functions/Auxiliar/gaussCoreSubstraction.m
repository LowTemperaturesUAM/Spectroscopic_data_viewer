function [CellFiltered] = gaussCoreSubstraction(Cell,Sigma)

[Filas,Columnas] = size(Cell{1});

%Defino una Gaussiana con ancho menor que el de las cosas que nos
%   interesa ver. Sigma son los píxeles que podemos filtrar sin matar las
%   cosas que nos interesan.

x0 = floor(Columnas/2)+1;
y0 = floor(Filas/2)+1;
x = (1:1:Columnas);
y = (1:1:Filas)';

MatrizFiltroFFT = -expm1(-((x-x0)/(sqrt(2)*Sigma)).^2-((y-y0)/(sqrt(2)*Sigma)).^2);

CellFiltered = cellfun(@(x) x.*MatrizFiltroFFT,Cell,UniformOutput=false);
end