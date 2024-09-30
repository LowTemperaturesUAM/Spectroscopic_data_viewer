function InfoStruct = reCalculateMaps(InfoStruct)
%%
% Recalculate Maps from IV curves saved in InfoStruct.MatrizCorriente.
% Asks the user for the same parameters as when loading the blq:
%- Points in Derivative
%- Lower and Upper limits of curves
%- Energy Limits to make Energy maps
%- Interpolation Method
%- Energy intreval between maps
%- Energy interval for mean interpolation
%
% Normalization should be a feature. WIP (Check analyzeImages.m)
%%
% Avoid using function in Current maps
if isfield(InfoStruct,'Type')
    if ~strcmpi(InfoStruct.Type,'Conductance')
        error("This function should only be used in Conductance maps")
    end
else
    warning(['Map Type field missing. Remember that this function ' ...
        'should only be used in Conductance maps'])
end
%%-----------------------------------------------------------------------
out = customCurvesWindow(InfoStruct);
if isequal(out,0)
    return
else
%
% INPUT
% From uifig
ptsDeriv = out.NDeriv;
mapmethod = out.Method;
deltaE = out.deltaE;
upperCut = out.UpCut;
lowerCut = out.LowCut;
Energia = out.Emin:out.PasoMapa:out.Emax;

% Load curves from InfoStruct
IVcurves = InfoStruct.MatrizCorriente;

V = InfoStruct.Voltaje;
Filas = length(InfoStruct.DistanciaFilas);
Columnas = length(InfoStruct.DistanciaColumnas);


% recalculate derivative with ptosDeriv
if ptsDeriv >= numel(V)
    error("Number of derivative points exceeds array length");
end
MatrizConductancia = derivadorLeastSquaresPA(ptsDeriv,IVcurves,V, ...
    Filas,Columnas);


% opciones de normalizar------------------------------
normOpts = customNormalizeWindow;
switch normOpts.Range
    case "none"
        MatrizNormalizada = MatrizConductancia;
    otherwise
        MatrizNormalizada = NormalizeRange(normOpts.VNormSuperior, ...
            normOpts.VNormInferior,V,MatrizConductancia,...
            'Range',normOpts.Range);
end

% clear MatrizConductancia


% Reorder curves if blq was taken in Y direction. -------------------------
if strcmp(InfoStruct.Direction,'Y')
    ordenY = zeros(1,Filas*Columnas);
    for i = 1:Filas
        ordenY(1+(i-1)*Columnas:i*Columnas) = i:Filas:Filas*Columnas;
    end
    MatrizNormalizada = MatrizNormalizada(:,ordenY);
    IVcurves = IVcurves(:,ordenY);
end

% Limit Conductance Values----------------------------------------
MatrizNcut = MatrizNormalizada;
% Saturate Conductance values
MatrizNcut(MatrizNcut<lowerCut) = lowerCut;
MatrizNcut(MatrizNcut>upperCut) = upperCut;

% Turn matrix into maps-------------------------------------------
% Consider interpolation method (mean,nearest,linear...)???-----
% Determines Energia array

switch mapmethod
    case 'mean'
        MapasConductancia = GetMapsMeanWindow(V,MatrizNcut,Energia, ...
            deltaE,Filas,Columnas);
    case {'nearest','linear','makima'}
        MapasConductancia = GetMapsInterpolate(V,MatrizNcut,Energia, ...
            Filas,Columnas,mapmethod);
    case 'none'
        % use the raw voltages from the IV we have to make sure
        % the values are sorted from lowest to highest
        [Energia] = sort(Struct.Voltaje);
        Info = struct();
        Info.Voltage = V;
        Info.DistanciaFilas = 1:Filas;
        Info.DistanciaColumnas = 1:Columnas;

        MapasConductancia = curves2maps(MatrizNcut,Info);
        clearvars Info
end

%------------------------------------------------------------------
% Assign results to InfoStruct
[InfoStructAnalisis.MapasConductancia,...
InfoStruct.MapasConductancia,...
InfoData.MapasConductancia] = deal(MapasConductancia);

[InfoStruct.MatrizNormalizada] = MatrizNcut;
InfoStruct.Energia = Energia;
InfoStruct.PuntosDerivada = ptsDeriv;

end
end