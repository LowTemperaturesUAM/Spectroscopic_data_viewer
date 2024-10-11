% ----------------------------------------
%   SIMETRIZAR TRANSFORMADAS DE FOURIER
% ----------------------------------------
%
% DESCRIPCIÓN:
% ------------------------------
% Simetrización de las 2D-FFT, tomando el centro en el punto
% floor(Filas)/2+1,floor(Columnas)/2+1. 
% ENTRADAS:
% ------------------------------
% Maps: CellArray creado con el escript de análisis que
%                           contiene las 2D-FFT que queremos simetrizar.
%
% Angulo: ángulo en grados sobre el que se hace la simetrización.
%
% Type: tipo de simetrización que se quiere llevar a cabo.
%       Type = 'Hor+Ver' -> Simetría Hermann (dos espejos)
%       Type = 'Vertical' -> Simetría espejando (vertical)
%       Type = 'C4' -> Simertías C4
%       Type = 'C6' -> Simertías C6
%       Type = 'C3' -> Simertías C3
% ------------------------------
%
%
% SALIDA:
% ------------------------------
% Symmetric : Contiene las matrices simetrizadas en el
%             eje seleccionado y orientadas del mimo modo
%             que las originales. Conservan también su
%             tamaño en pixeles para simplificar el
%             tratamiento en posteriores funciones pese a
%             que las zonas de los bordes generadas con
%             las distintas rotaciones no tienen sentido.
%

function [Symmetric] = simetrizarFFTv2(Cell,Type)
arguments
    Cell cell
    Type {mustBeMember(Type,{'Vertical','Horizontal','C3','C4','C6'})}
end

[Filas, Columnas] = size(Cell{1});

% Comprobamos si tiene un numero par de puntos, si lo es añadimos una linea
% extra para que el origen siempre quede en el centro
if mod(Filas,2)==0 && mod(Columnas,2) == 0
    Cell = cellfun(@(x) x([1:end 1],[1:end 1]),Cell,UniformOutput=false);
elseif mod(Filas,2)==0
    Cell = cellfun(@(x) x([1:end 1],:),Cell,UniformOutput=false);
elseif mod(Columnas,2)==0
    Cell = cellfun(@(x) x(:,[1:end 1]),Cell,UniformOutput=false);
end

switch Type
    case 'Vertical'
        Symmetric = cellfun(@(x) 0.5*(x+flipud(x)),Cell,UniformOutput=false);

     case 'Hor+Ver'
        Symmetric = cellfun(@(x) 0.5*(x+flipud(x)),Cell,UniformOutput=false);
        Symmetric = cellfun(@(x) 0.5*(x+fliplr(x)),Symmetric,UniformOutput=false);

    case {'C3','C3h'}
        M1 = cellfun(@(x) 0.5*(x+flipud(x)),Cell,UniformOutput=false);
        M2 = cellfun(@(x) imrotate(x,120,"crop"),M1,UniformOutput=false);
        M3 = cellfun(@(x) imrotate(x,240,"crop"),M1,UniformOutput=false);
        Symmetric = cellfun(@(a,b,c) (a+b+c)/3,M1,M2,M3,UniformOutput=false);

    case {'C4','C4h'}
        M1 = cellfun(@(x) 0.5*(x+flipud(x)),Cell,UniformOutput=false);
        M2 = cellfun(@(x) imrotate(x,90,"crop"),M1,UniformOutput=false);
        M3 = cellfun(@(x) imrotate(x,180,"crop"),M1,UniformOutput=false);
        M4 = cellfun(@(x) imrotate(x,270,"crop"),M1,UniformOutput=false);
        Symmetric = cellfun(@(a,b,c,d) (a+b+c+d)/4,M1,M2,M3,M4,UniformOutput=false);
        
    case {'C6','C6h'}
        M1 = cellfun(@(x) 0.5*(x+flipud(x)),Cell,UniformOutput=false);
        M2 = cellfun(@(x) imrotate(x,60,"crop"),M1,UniformOutput=false);
        M3 = cellfun(@(x) imrotate(x,120,"crop"),M1,UniformOutput=false);
        M4 = cellfun(@(x) imrotate(x,180,"crop"),M1,UniformOutput=false);
        M5 = cellfun(@(x) imrotate(x,240,"crop"),M1,UniformOutput=false);
        M6 = cellfun(@(x) imrotate(x,300,"crop"),M1,UniformOutput=false);
        Symmetric = cellfun(@(a,b,c,d,e,f) (a+b+c+d+e+f)/6,...
            M1,M2,M3,M4,M5,M6,UniformOutput=false);
    otherwise
        disp('Unknown type of symmetry')
        Symmetric = Cell;
end
% Si hemos añadido una linea extra, la quitamos para mantener las
% dimensiones originales
if mod(Filas,2)==0 && mod(Columnas,2) == 0
    Symmetric = cellfun(@(x) x(1:end-1,1:end-1),Symmetric,UniformOutput=false);
elseif mod(Filas,2)==0
    Symmetric = cellfun(@(x) x(1:end-1,:),Symmetric,UniformOutput=false);
elseif mod(Columnas,2)==0
    Symmetric = cellfun(@(x) x(:,1:end-1),Symmetric,UniformOutput=false);
end

end
