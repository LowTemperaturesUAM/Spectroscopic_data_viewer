function horizontalProfile(Info)
%LineasPromedio = 3;
% if rem(length(Info.DistanciaColumnas),2)
%     LongitudPerfil = length(Info.DistanciaColumnas)+1; %Poner ese +1 sólo si se ha ajustado el (0,0) previamente en QPIStudy.m
% else
%     LongitudPerfil = length(Info.DistanciaColumnas);
% end
LongitudPerfil = length(Info.DistanciaFourierColumnas);
Perfiles = zeros(length(Info.Energia),LongitudPerfil);
%Perfiles2 = zeros(length(Energia),LongitudPerfil);

for k=1:length(Info.Energia)
    Perfiles(k,:) = Info.Transformadas{k}(length(Info.DistanciaColumnas)/2+1,:)';
    %Perfiles2(k,:) = TransformadasSimetrizadas{k}(:,1+Filas/2);
    %Perfiles(k,1:LongitudPerfil-1)= diff(Perfiles(k,:));
end

% mediaTotal = mean(mean(Perfiles));
% FlattenMatrix=Perfiles;
% for i = 1:length(Perfiles(:,1))
%                FlattenMatrix(:,i) = FlattenMatrix(:,i) - (mean(FlattenMatrix(:,i)) - mediaTotal);
% end
% PerfilesPromedio = (Perfiles + Perfiles2)/2;
% PerfilesFlatten=Flatten(Perfiles,[1,1]);

a=figure(54534);
a.Name='Horizontal Profile';

a=figure;
%surf((ParametroRed/TamanhoReal)*(1:LongitudPerfil-1),Energia,Perfiles(:,1:LongitudPerfil-1))

%imagesc(Info.DistanciaFourierColumnas.*Info.ParametroRedColumnas,Info.Energia,Perfiles);

imagesc(Info.DistanciaFourierColumnas*2*Info.ParametroRedFilas,Info.Energia,Perfiles);  %Para redes cuadradas

%imagesc(Info.DistanciaFourierColumnas.*2*Info.ParametroRedColumnas.*2./sqrt(3),Info.Energia,Perfiles);
%%Para redes hexagonales, con los picos de Bragg en la vertical


axis([-1/(2*Info.ParametroRedColumnas) 1/(2*Info.ParametroRedColumnas) min(Info.Energia) max(Info.Energia)]);
% axis([0 1 min(Info.Energia) max(Info.Energia)]);
%axis([0 1 -85 85]);
b=gca;
b.Colormap = Info.Colormap;
b.YDir='normal';
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.YLabel.String = '\fontsize{18} Energy (meV)';
% b.XLabel.String = '\fontsize{18} k_{y} (\pi/b)';
b.XLabel.String = '\fontsize{18} q_{y} (\pi/b)';
b.LineWidth = 2;
b.FontWeight = 'bold';
b.FontName = 'Arial';
b.FontSize = 14;
b.TickDir = 'out';
% title('Horizontal profile');
% b.Position = b.OuterPosition;
%b.CLim=[0 0.15];
%b.CLim=[min(min(Perfiles)) max(max(Perfiles))];
b.CLim = Info.ContrastFFT(:,(end+1)/2); %Usamos el contraste a 0 mV para empezar
%colormap gray
b.Children.XData = b.Children.XData./max(b.XLim); 
b.XLim = [-1 1];

QPI.Horizontal.Map = Perfiles;
QPI.Horizontal.K = Info.DistanciaFourierFilas;
QPI.Horizontal.Energy = Info.Energia;

assignin('base','QPI0',QPI)
end