function meanConductance(Info)
Filas = length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);
PuntosIV = length(Info.Voltaje);

curva = zeros(PuntosIV,2);
curva(:,1) = Info.Voltaje;

for k=1:PuntosIV
    Matriz3D(:,:,k) = reshape(Info.MatrizNormalizada(k,:),Filas,Columnas);
    curva(k,2) = mean(mean(Matriz3D(:,:,k)));
end

% curva(:,2) = curva(:,2)*1e3;%para que esté en [nS]

%Plot conductance
figure (8984)
plot(Info.Voltaje(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada)...
    ,curva(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada,2),'o-','MarkerSize',8,'MarkerFaceColor','auto')
% maximo = abs(Info.Energia(1));
% plotPoints = ceil(maximo*PuntosIV/Info.Bias);
% plot(Info.Voltaje(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)),...
%     curva(Info.PuntosIV/2-round(plotPoints/2):Info.PuntosIV/2+round(plotPoints/2)));

b=gca;
% a.XLim = [-95 95];
b.Children.LineWidth = 2;
b.Children.Color = [0 0 0];
b.FontName = 'Arial';
b.FontWeight = 'bold';
b.FontSize = 16;
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.XLabel.String = '\fontsize{18} Voltage (mV)';
b.YLabel.String = '\fontsize{18} Normalized conductance';
b.TickLength(1) = 0.02;
% b.YLabel.String = 'Normalized conductance';

assignin('base','curvaConductancia',curva);
end