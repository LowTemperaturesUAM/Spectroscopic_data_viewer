function meanIV(Info)
Filas = length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);
PuntosIV = length(Info.Voltaje);

curvaCorriente = zeros(PuntosIV,2);
curvaCorriente(:,1) = Info.Voltaje;

for k=1:PuntosIV
    Matriz3DCorriente(:,:,k) = reshape(Info.MatrizCorriente(k,:),Filas,Columnas);
    curvaCorriente(k,2) = mean(mean(Matriz3DCorriente(:,:,k)));
end

%Plot current
figure (8983)
plot(Info.Voltaje,curvaCorriente(:,2),'o-','MarkerSize',8,'MarkerFaceColor','auto')

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
b.YLabel.String = '\fontsize{18} Current (nA)';
b.TickLength(1) = 0.02;

assignin('base','curvaCorriente',curvaCorriente);
end