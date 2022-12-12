function MeanIVFunction_v2(ax, Rectangulo, MatrizNormalizada, Voltaje, Columnas, Filas, DistanciaColumnas, isCond)

% Turn Rectangulo coordinates into pixels
Rectangulo1 = Columnas.*Rectangulo./(DistanciaColumnas(end) );
Inicio = [round(Rectangulo1(1)), round(Rectangulo1(2))];
Final = [round(Rectangulo1(1) + Rectangulo1(3)), round(Rectangulo1(2) + Rectangulo1(4))];

% Obtain indices of curves selected with rectangle
[X,Y] = meshgrid(1:Columnas,Filas:-1:1);
Coordenadas = reshape([1:Filas*Columnas],Columnas,Filas);
Coordenadas = rot90(Coordenadas); % Indices of every curve in image
Coordenadas = Coordenadas(X>=Inicio(1) & X<=Final(1) & Y>=Inicio(2) & Y<=Final(2));

if length(Coordenadas)>1
% I rename variable mean to Mean to avoid conflict with the function.
Mean = mean(MatrizNormalizada(:,Coordenadas),2);

%assignin('base','mean',[Voltaje, mean])
% b=findobj('Name', 'mainFig');
if isCond
    meanIVFig = figure(37289);
else
    meanIVFig = figure(37290);
end

if ~isCond
    meanIVFig.CloseRequestFcn = 'kill_v2';
end

meanIVFig.Name = 'meanIVFig';

hold on
a=meanIVFig.CurrentAxes;
% a.ColorOrder = jet(50);
if ~isCond
    a.ColorOrderIndex = ax.ColorOrderIndex;
else
    switch ax.ColorOrderIndex
        case 1
            a.ColorOrderIndex   = length(a.ColorOrder);
        otherwise
            a.ColorOrderIndex = ax.ColorOrderIndex-1;
    end
end

% plot(Voltaje(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada), mean(1+Info.PuntosDerivada:length(Info.Voltaje)-Info.PuntosDerivada),'-','LineWidth',2)
plot(a,Voltaje, Mean,'-','LineWidth',2)
if ~isCond
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
    % a.YLabel.String = 'Conductance(\muS)';
    a.YLabel.String = '\fontsize{18} Normalized conductance';
else
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
    % a.YLabel.String = 'Conductance(\muS)';
    a.YLabel.String = '\fontsize{18} Current (nA)';
end
a.XLimitMethod = 'tight';
% a.Children.LineWidth = 2;
% a.Children.Color = [0 0 0];
a.FontWeight = 'bold';
a.LineWidth = 2;
a.FontName = 'Arial';
a.FontSize = 16;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.Box = 'on';
a.TickLength(1) = 0.02;
%plot(Voltaje(5:60),curva(5:60))
%ylim([0 , 2])

curves = [Voltaje Mean];

if ~isfield(meanIVFig.UserData, 'curves')
    meanIVFig.UserData.curves = curves;
else
    meanIVFig.UserData.curves = [meanIVFig.UserData.curves curves];
end
    
if ~isCond
    uicontrol('Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanConductanceRegion'));
else
    uicontrol('Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanIVRegion'));
end

x1=Rectangulo(1);
y1=Rectangulo(2);
a1=Rectangulo(3);
b1=Rectangulo(4);

% b=findobj('Name', 'mainFig');
hold(ax, 'on');

if ~isCond % This condition makes it so the rectangle is only made once
    area = plot(ax,[x1 x1+a1 x1+a1 x1 x1], [y1 y1 y1+b1 y1+b1 y1],'LineWidth',2);
end

area.Tag = 'meanIVFig';
% rectangle('Position',Rectangulo,'EdgeColor','white')
end