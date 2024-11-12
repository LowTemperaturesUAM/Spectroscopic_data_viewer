function curvaUnicaFig = curvaUnicaPA_v3(ax, puntero, Voltaje, Matriz, VectorTamanhoX, VectorTamanhoY, isReal, isCurrent)
%Programa que pinta una unica curva seleccionada con el puntero

% Asegurarse que Voltaje es columna
if isrow(Voltaje)
    Voltaje = Voltaje';
end

Columnas = length(VectorTamanhoX);

CoorX = puntero(1,1);
CoorY = puntero(1,2);

%Paso las input a pixeles para elegir el numero de puntos e el perfil
[~, PixelX] = min(abs(CoorX-VectorTamanhoX));
[~, PixelY] = min(abs(CoorY-VectorTamanhoY));

% b=findobj('Name', 'mainFig');

if isReal
    if isCurrent
        curvaUnicaFig = figure(122);
        curvaUnicaFig.Name = 'singleIVFig'; %not working at the moment
    else
        curvaUnicaFig = figure(120);
        curvaUnicaFig.Name = 'singledI/dVFig';
        display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
            '] \\ Indice = ',num2str((PixelY-1)*Columnas+PixelX)]);
    end
else
    curvaUnicaFig = figure(121);
    curvaUnicaFig.Name = 'FFTPointFig';
    display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
        '] \\ Indice = ',num2str((PixelY-1)*Columnas+PixelX)]);
end
% Aseguro que figura entra en pantalla
movegui(curvaUnicaFig);

CurvaUnica = Matriz(:,(PixelY-1)*Columnas+PixelX);

hold on
a = curvaUnicaFig.CurrentAxes;

% for i=1:length(PixelX)

if isCurrent
    switch ax.ColorOrderIndex
        case 1
            a.ColorOrderIndex = length(ax.ColorOrder);
        otherwise
            a.ColorOrderIndex = ax.ColorOrderIndex-1;
    end
else
    a.ColorOrderIndex = ax.ColorOrderIndex;
end

plot(a,Voltaje,CurvaUnica,'-','LineWidth',2);


if isReal
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
else
    xlabel(a,'Energy (meV)','FontSize',18)
end
xlim([min(Voltaje),max(Voltaje)]);

if isReal
    if ~isCurrent
        a.YLabel.String = '\fontsize{18} Normalized conductance';
    else
        a.YLabel.String = '\fontsize{18} Current (nA)';
    end
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
else
    a.YLabel.String = '\fontsize{18} FFT Intensity (A.U.)';
    a.XLabel.String = '\fontsize{18} Energy (meV)';
end

a.XLimitMethod = 'tight';
a.FontWeight = 'bold';
a.LineWidth = 2;
a.FontName = 'Arial';
a.FontSize = 16;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.Box = 'on';
a.TickLength(1) = 0.02;
a.XLabel.FontSize = 18;

Data = [Voltaje CurvaUnica];

if ~isfield(curvaUnicaFig.UserData, 'curves')
    curvaUnicaFig.UserData.curves = Data;
else
    curvaUnicaFig.UserData.curves = [curvaUnicaFig.UserData.curves Data];
end
%Add new field to save the point locations. Add also axis coordinates
if ~isfield(curvaUnicaFig.UserData, 'points')
    curvaUnicaFig.UserData.points = [PixelX, PixelY];
    curvaUnicaFig.UserData.coords = [CoorX, CoorY];

else
    curvaUnicaFig.UserData.points = [curvaUnicaFig.UserData.points;[PixelX, PixelY]];
    curvaUnicaFig.UserData.coords = [curvaUnicaFig.UserData.coords;[CoorX, CoorY]];
end

if isempty(findobj(curvaUnicaFig,'Type','UIControl'))
    if isReal
        if isCurrent
            uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleIV'));
        else
            uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleConductance'));
        end
    else
        uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
            'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('FFTptnvsE'));
    end
end

if ~isReal
    curvaUnicaFig.CloseRequestFcn = 'killFFT_v2';
elseif isReal && ~isCurrent
    curvaUnicaFig.CloseRequestFcn = 'kill_v2';
end

hold(ax,'on');
if ~isCurrent
    cross = plot(ax,CoorX,CoorY,'x','MarkerSize',10,'LineWidth',2);
    cross.Tag = curvaUnicaFig.Name;
end

end