function Result = diagonalProfile(Info,opt)
arguments
    Info struct
    opt.FigNumber = 54535
end
if rem(length(Info.DistanciaFilas),2)
    LongitudPerfil = length(Info.DistanciaFilas)+1; %Poner ese +1 sólo si se ha ajustado el (0,0) previamente en QPIStudy.m
else
    LongitudPerfil = length(Info.DistanciaFilas);
end

    Perfiles = zeros(length(Info.Energia),LongitudPerfil);

for k=1:length(Info.Energia)
    for i=1:LongitudPerfil
    Perfiles(k,i) = Info.Transformadas{k}(i,i);
    end
end
Posiciones = sqrt((Info.DistanciaFourierFilas*2*Info.ParametroRedFilas).^2 + ...
    (Info.DistanciaFourierColumnas*2*Info.ParametroRedColumnas).^2)/sqrt(2) .* ...
    sign(Info.DistanciaFourierFilas*2*Info.ParametroRedFilas + ...
    Info.DistanciaFourierColumnas*2*Info.ParametroRedColumnas);
if opt.FigNumber>0
    a=figure(opt.FigNumber);
    a.Name='Diagonal Profile';
    imagesc(Info.DistanciaFourierFilas*2*Info.ParametroRedFilas,Info.Energia,Perfiles)
    % imagesc(Posiciones,Info.Energia,Perfiles)
    axis([-1 1 min(Info.Energia) max(Info.Energia)]);
    % axis([0 1 -85 85]);
    b=gca;
    b.Colormap = Info.Colormap;
    b.YDir='normal';
    b.XColor = [0 0 0];
    b.YColor = [0 0 0];
    b.YLabel.String = '\fontsize{18} Energy (meV)';
    % b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
    % b.XLabel.String = '\fontsize{18} q_{x} (nm^-^1)';
    xlabel('\fontsize{18} q_{x} (\surd{2}\pi/a)');
    b.LineWidth = 2;
    b.FontSize = 14;
    b.FontName = 'Arial';
    b.FontWeight = 'bold';
    b.TickDir = 'out';
    % title('Diagonal profile')
    % b.Position = b.OuterPosition;
    % b.CLim=[minimo maximo];
    %b.CLim=[min(min(Perfiles)) max(max(Perfiles))];
    b.CLim = Info.ContrastFFT(:,(end+1)/2); %Usamos el contraste a 0 mV para empezar
    %implementar la posibilidad de ajustar los limites de la figura (x,y y color)
    %como argumentos opcionales

    b.XLim = [-1 1];
end

QPI.Map = Perfiles;
QPI.K = sqrt(Info.DistanciaFourierFilas.^2 + Info.DistanciaFourierColumnas.^2);
QPI.q = sqrt((Info.DistanciaFourierFilas*2*Info.ParametroRedFilas).^2 + ...
    (Info.DistanciaFourierColumnas*2*Info.ParametroRedColumnas).^2);
QPI.Energy = Info.Energia;

if nargout == 0
    assignin('base','QPIDiagonal',QPI)
else
    Result = QPI;
end
end