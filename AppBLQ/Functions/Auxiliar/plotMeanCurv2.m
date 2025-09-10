function [meanIVFig] = plotMeanCurv2(ax,Voltaje,Curve,Inicio,Final,Type)
switch Type
    case 'Current'
        meanIVFig = figure(37289);
        meanIVFig.Name = 'meanIVFig';
    case 'Conductance'
        meanIVFig = figure(37290);
        meanIVFig.Name = 'meandI/dVFig';
        meanIVFig.CloseRequestFcn = 'kill_v2';
    case 'Second'
        meanIVFig = figure(37291);
        meanIVFig.Name = 'meand2I/dV2Fig';
end
meanIVFig.KeyPressFcn = @KeyPressSpectraFcn;
hold on
a=meanIVFig.CurrentAxes;
a.ColorOrder = ax.ColorOrder;
a.Interactions = [zoomInteraction regionZoomInteraction rulerPanInteraction];
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
plot(a,Voltaje, Curve,'-','LineWidth',2)


a.XLimitMethod = 'tight';
a.FontWeight = 'bold';
a.LineWidth = 2;
a.FontName = 'Arial';
a.FontSize = 16;
a.XColor = [0 0 0];
a.YColor = [0 0 0];
a.Box = 'on';
a.TickLength(1) = 0.02;
switch Type
    case 'Current'
        a.YLabel.String = 'Current (nA)';
    case 'Conductance'
        a.YLabel.String = 'dI/dV'; % should consider if it was normalized
    case 'Second'
        a.YLabel.String = 'd^2I/dV^2';
end
a.XLabel.String = 'Voltage (mV)';
a.XLabel.FontSize = 18;

Data = [Voltaje Curve];

if ~isfield(meanIVFig.UserData, 'curves')
    meanIVFig.UserData.curves = Data;
else
    meanIVFig.UserData.curves = [meanIVFig.UserData.curves Data];
end
%Add new field to save the rectangle locations
if ~isfield(meanIVFig.UserData, 'areas')
    meanIVFig.UserData.areas = [Inicio, Final];
else
    meanIVFig.UserData.areas = [meanIVFig.UserData.areas;[Inicio, Final]];
end


% Check if the button is present before drawing a new one
if isempty(findobj(meanIVFig,'Type','UIControl'))
    switch Type
        case 'Current'
            uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanIVRegion'));
        case 'Conductance'
            uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanConductanceRegion'));
        case 'Second'
            uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanSecondDerivRegion'));
    end

end