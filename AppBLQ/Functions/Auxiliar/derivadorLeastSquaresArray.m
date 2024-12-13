function [derivMatrix] = derivadorLeastSquaresArray(derivPts,Matrix,x)
arguments
    derivPts {mustBeInteger,mustBePositive,mustBeScalarOrEmpty}
    Matrix
    x {mustBeVector}
end

%%
% INPUT:
%   derivPts: number of points to use to calculate de derivative window
%   Matrix: array containing the curves to use in the calculation, as colunm
%       vectors
%   x: column vector with the values of the x axis of all the curves to derivate
%
% OUTPUT:
%   derivMatrix: array containing the derivatives of each of the column vectors
%   in Matrix


[IV, IMG] = size(Matrix);

derivMatrixAUX = zeros(IV-2*derivPts,IMG);      % Definimos la matriz de salida

for c = 1+derivPts:IV-derivPts

    Numerador = zeros(1,IMG);
    Ajuste = zeros(1,IMG);
    Denominador = 0;
    for k = -derivPts:derivPts
        Numerador = Numerador + Matrix(c+k,:)*(x(c+k)-x(c));
        Denominador = Denominador + (x(c+k)-x(c))*(x(c+k)-x(c));
    end

    Ajuste(:) = Numerador(:)./Denominador;
    derivMatrixAUX(c-derivPts,:) = Ajuste(:);

end


clear c k Numerador Denominador Ajuste Pasox;

% Amplio la derivMatrix para que tenga las dimensiones originales.
% Simplemente los primeros y ultimos puntos de la derivada son iguales que
% el ultimo y primer punto de la matriz. Por comodidad en la visualización
% y el tratamiento de los datos

% derivMatrixAUX = derivMatrix;
derivMatrix = zeros(IV,IMG);
derivMatrix(1+derivPts:IV-derivPts,:) = derivMatrixAUX;

for i = 1:derivPts
    derivMatrix(i,:) = derivMatrixAUX(1,:);
    derivMatrix(IV-(i-1),:) = derivMatrixAUX(end,:);
end

clear i derivMatrixAUX