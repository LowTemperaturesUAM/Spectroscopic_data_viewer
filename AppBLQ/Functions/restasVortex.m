function Info = restasVortex(app, Info, Offset)
% Substracts MapasConductancias with opposites signs in energy
% Offset - Para mover el cero, por si la curva no está centrada (en num de elementos de vector)

Energia = Info.Energia; % Extraigo el vector Energia del Infostruct
MapasConductancia = Info.MapasConductancia;

 
%Zero = ceil(0.5*length(Energia)) + Offset; % Defino el cero como el punto medio del bias
[ZeroValue,Zero] = min(abs(Energia)); % Hallo la posicion del 0
if ZeroValue
    warning("Minimum energy is not 0.");
end
%numdifs = ceil(0.5*length(Energia)); %Numero de mapas de diferencias de conductancia, incluyendo 0
%Numero de mapas de diferencias de conductancia, incluyendo 0. Se considera
%0 no centrado
numdifs = min(abs([1,length(Energia)]-Zero)) + 1; 
Resta = cell(1,numdifs);
for i=1:numdifs % El num max de mapas dependerá del num de elementos de Energia entre 0 y extremo mas cercano
    Resta{i}=MapasConductancia{Zero+i-1}-MapasConductancia{Zero-i+1}; % Resto - de +
end

% EnergiaResta = Energia(Zero:end) - Energia(Zero); % Creo un vector para saber el abs(Energia) en cada imagen
% 
% if length(EnergiaResta)~=numdifs
%     warning('El vector EnergiaResta no tiene longitud numdifs') % Saco un mensaje de aviso si no coinciden. Si continuas da error.
% end

Info.Restas = Resta;
Info.RestasFFT = cellfun(@fft2d,Info.Restas, 'UniformOutput', false);

% Obtain default contrast values for Difference maps

value = app.LimitsSlider.Value;
Info.ContrastRestasReal = [-value; value] .* ones(2,numdifs);

[Filas, Columnas] = size(Info.RestasFFT{1});
for i=1:length(Info.RestasFFT)
    Info.RestasFFT{i}(floor(Filas/2)+1, floor(Columnas/2)+1) = 0;
end
%minValue = min(cell2mat(Info.RestasFFT), [], 'all');
minValue = 0;
maxValue = max(cell2mat(Info.RestasFFT), [], 'all');

Info.ContrastRestasFFT = [minValue; maxValue] .* ones(2,numdifs);

end