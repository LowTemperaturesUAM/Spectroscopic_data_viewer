function curvaUnicaFig = curvaUnicaPA_v4(ax, pointer, V, Matrix, XVect, YVect, isReal, Type)
%Programa que pinta una unica curva seleccionada con el puntero
arguments
    ax  matlab.graphics.axis.Axes
    pointer (1,2)
    V {mustBeVector}
    Matrix {mustBeFinite,mustBeReal}
    XVect {mustBeReal,mustBeVector}
    YVect {mustBeReal,mustBeVector}
    isReal logical
    Type {mustBeMember(Type,{'Current','Conductance','Second'})}
end

% Asegurarse que Voltaje es columna
if isrow(V)
    V = V';
end

Columnas = length(XVect);

CoorX = pointer(1,1);
CoorY = pointer(1,2);

%Paso las input a pixeles para elegir el numero de puntos e el perfil
[~, PixelX] = min(abs(CoorX-XVect));
[~, PixelY] = min(abs(CoorY-YVect));

% b=findobj('Name', 'mainFig');

if isReal
    switch Type
        case 'Current'
            curvaUnicaFig = figure(122);
            curvaUnicaFig.Name = 'singleIVFig'; %not working at the moment
        case 'Conductance'
            curvaUnicaFig = figure(120);
            curvaUnicaFig.Name = 'singledI/dVFig';
            display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
                '] \\ Indice = ',num2str((PixelY-1)*Columnas+PixelX)]);
        case 'Second'
            curvaUnicaFig = figure(123);
            curvaUnicaFig.Name = 'singled2I/dV2Fig';
    end
else
    curvaUnicaFig = figure(121);
    curvaUnicaFig.Name = 'FFTPointFig';
    display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
        '] \\ Indice = ',num2str((PixelY-1)*Columnas+PixelX)]);
end
% Aseguro que figura entra en pantalla
movegui(curvaUnicaFig);

CurvaUnica = Matrix(:,(PixelY-1)*Columnas+PixelX);

hold on
a = curvaUnicaFig.CurrentAxes;

% for i=1:length(PixelX)
a.ColorOrder = ax.ColorOrder;
switch Type
    case 'Conductance'
        a.ColorOrderIndex = ax.ColorOrderIndex;
    case 'Current'
        switch ax.ColorOrderIndex
            case 1
                a.ColorOrderIndex = length(ax.ColorOrder);
            otherwise
                a.ColorOrderIndex = ax.ColorOrderIndex-1;
        end
    case 'Second'
        switch ax.ColorOrderIndex
            case 1
                a.ColorOrderIndex = length(ax.ColorOrder);
            otherwise
                a.ColorOrderIndex = ax.ColorOrderIndex-1;
        end
end

plot(a,V,CurvaUnica,'-','LineWidth',2);


xlim([min(V),max(V)]);

a.XLimitMethod = 'tight';
a.FontWeight = 'bold';
a.LineWidth = 2;
a.FontName = 'Arial';
a.FontSize = 16;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.Box = 'on';
a.TickLength(1) = 0.02;
if isReal
    switch Type
        case 'Current'
            a.YLabel.String = 'Current (nA)';
        case 'Conductance'
            a.YLabel.String = 'dI/dV'; % should consider if it was normalized
        case 'Second'
            a.YLabel.String = 'd^2I/dV^2';
    end
    a.YLabel.FontSize = 18;
    a.XLabel.String = 'Voltage (mV)';
    a.XLabel.FontSize = 18;
else
    a.YLabel.String = 'FFT Intensity (A.U.)';
    a.YLabel.FontSize = 18;
    a.XLabel.String = 'Voltage (mV)';
    a.XLabel.FontSize = 18;
end



Data = [V CurvaUnica];

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
        % if Type
        switch Type
            case 'Current'
                uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleIV'));
            case 'Conductance'
                uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleConductance'));
            case 'Second'
                uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleSecondDeriv'));
        end
    else
        uicontrol(curvaUnicaFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
            'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('FFTptnvsE'));
    end
end

if ~isReal
    curvaUnicaFig.CloseRequestFcn = 'killFFT_v2';
elseif isReal && strcmp(Type,'Conductance')
    curvaUnicaFig.CloseRequestFcn = 'kill_v2';
end

hold(ax,'on');
if strcmp(Type,'Conductance')
    cross = plot(ax,CoorX,CoorY,'x','MarkerSize',10,'LineWidth',2);
    cross.Tag = curvaUnicaFig.Name;
end

end