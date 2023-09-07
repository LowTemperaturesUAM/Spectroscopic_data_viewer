function Info = energyDiff(app, Info, Offset)
% Substracts MapasConductancias with opposites signs in energy
% Offset - Para mover el cero, por si la curva no está centrada (en num de elementos de vector)

Energia = Info.Energia; % Extraigo el vector Energia del Infostruct
MapasConductancia = Info.MapasConductancia;

 
%Zero = ceil(0.5*length(Energia)) + Offset; % Defino el cero como el punto medio del bias
[ZeroValue,Zero] = min(abs(Energia)); % Hallo la posicion del 0
if ZeroValue
    warning("Minimum energy is not 0.");
end

%Number of difference maps, including 0 energy. It assumes 0 not centered
numdifs = min(abs([1,length(Energia)]-Zero)) + 1; 

% Initialize fields Resta and Division
Resta = cell(1,numdifs);
Division = cell(1,numdifs);
% Difference with oneself
Resta{1} = zeros(size(MapasConductancia{1}));
Division{1} = ones(size(MapasConductancia{1}));

% Shift to avoid infinity when dividing
shift = 0.1;
for i=2:numdifs % El num max de mapas dependerá del num de elementos de Energia entre 0 y extremo mas cercano
    Resta{i}=MapasConductancia{Zero+i-1}-MapasConductancia{Zero-i+1}; % Resto - de +
    Division{i}=(MapasConductancia{Zero+i-1} + shift) ./ ...
        (MapasConductancia{Zero-i+1} + shift); % Divido + entre -
end

% EnergiaResta = Energia(Zero:end) - Energia(Zero); % Creo un vector para saber el abs(Energia) en cada imagen
% 
% if length(EnergiaResta)~=numdifs
%     warning('El vector EnergiaResta no tiene longitud numdifs') % Saco un mensaje de aviso si no coinciden. Si continuas da error.
% end

% Place calculated matrices into InfoStruct
Info.Restas = Resta;
Info.RestasFFT = cellfun(@fft2d,Info.Restas, 'UniformOutput', false);
Info.Division = Division;
Info.DivisionFFT = cellfun(@fft2d,Info.Division, 'UniformOutput', false);

% Obtain default contrast values for Difference maps
value = app.LimitsSlider.Value;
Info.ContrastRestasReal = [-value; value] .* ones(2,numdifs);

% Obtain default contrast values for Division maps
value = app.LimitsSlider.Value;
Info.ContrastDivisionReal = [-value; value] .* ones(2,numdifs);

% Delete center peak of FFT.
[Filas, Columnas] = size(Info.RestasFFT{1});
for i=1:length(Info.RestasFFT)
    Info.RestasFFT{i}(floor(Filas/2)+1, floor(Columnas/2)+1) = 0;
    Info.DivisionFFT{i}(floor(Filas/2)+1, floor(Columnas/2)+1) = 0;
end

% Constrast for FFT 
minValue = 0;
maxValue = max(cell2mat(Info.RestasFFT), [], 'all');
Info.ContrastRestasFFT = [minValue; maxValue] .* ones(2,numdifs);

maxValue = max(cell2mat(Info.DivisionFFT), [], 'all');
Info.ContrastDivisionFFT = [minValue; maxValue] .* ones(2,numdifs);

end