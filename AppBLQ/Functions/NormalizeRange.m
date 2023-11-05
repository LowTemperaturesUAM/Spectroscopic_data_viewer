function [MatrizNormalizada] = NormalizeRange(VoltajeSuperior,VoltajeInferior,Voltaje,MatrizConductancia,opts)
arguments
    VoltajeSuperior (1,1) double
    VoltajeInferior (1,1) double
    Voltaje double {mustBeVector}
    MatrizConductancia double {mustBeFinite}
    opts.Range (1,:) char {mustBeMember(opts.Range,{'both','single'})}= 'both'
end
% Esta función toma la derivada de una "matrizConductancia" y la normaliza
% a los valores correspondientes al promedio de los valores de la
% conductancia entre dos valores de voltaje dados: "voltajeSuperior" y
% "voltajeInferior".
%
% ENTRADA:
%   voltajeSuperior:    límite inferior de voltaje para el promedio de la
%                       normalización
%   voltajeInferior:    límite superior de voltaje para el promedio de la
%                       normalización
%   matrizVoltaje:      matriz con los voltajes
%   matrizConductancia: matriz con la conductancia
%
% SALIDA:
%   matrizNormalizada: matriz con los valores normalizados


if VoltajeInferior >= VoltajeSuperior
    errordlg('The provided range is not valid. %g must be larger than %g',VoltajeSuperior,VoltajeInferior)
%     return
end
[IV, ~] = size(MatrizConductancia);
switch opts.Range
    case 'both' %Take the range symmetrically in energy
        Indices1 = find(VoltajeSuperior > Voltaje(1:IV) & ...
            VoltajeInferior < Voltaje(1:IV));
        Indices2 = find(-VoltajeSuperior < Voltaje(1:IV) & ...
            -VoltajeInferior > Voltaje(1:IV));

        if (sum(Indices1)+sum(Indices2)) == 0
            errordlg('No datapoints exist in the provided range')
        end

        Norma1 = mean(MatrizConductancia(Indices1,:),1);
        Norma2 = mean(MatrizConductancia(Indices2,:),1);
        Norma = (Norma1(:,:) + Norma2(:,:))/2;

    case 'single' %take the range just on the given side
        Indices = find(VoltajeSuperior > Voltaje(1:IV) & VoltajeInferior < Voltaje(1:IV));

        if sum(Indices) == 0
            errordlg('No datapoints exist in the provided range')
        end

        Norma = mean(MatrizConductancia(Indices,:),1);
end

% If the input is a curve full of zeros, it would return NaN
% In this situation, it's better to output zeros instead so that we get
% a finite result and the FFT can be calculated
MatrizNormalizada = zeros(size(MatrizConductancia));
if size(MatrizConductancia(:,Norma~=0),2) > 0
    MatrizNormalizada(:,Norma~=0) = bsxfun(@rdivide,MatrizConductancia(:,Norma~=0),Norma(Norma~=0));
end