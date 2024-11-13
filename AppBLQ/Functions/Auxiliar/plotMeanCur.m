function [meanIVFig] = plotMeanCur(ax,Voltaje,Curve,Inicio,Final,isCurrent)
if isCurrent
    meanIVFig = figure(37289);
    meanIVFig.Name = 'meanIVFig';
else
    meanIVFig = figure(37290);
    meanIVFig.Name = 'meandI/dVFig';
end

if ~isCurrent
    meanIVFig.CloseRequestFcn = 'kill_v2';
end

hold on
a=meanIVFig.CurrentAxes;

if isCurrent
    switch ax.ColorOrderIndex
        case 1
            a.ColorOrderIndex = length(a.ColorOrder);
        otherwise
            a.ColorOrderIndex = ax.ColorOrderIndex-1;
    end
else
    a.ColorOrderIndex = ax.ColorOrderIndex;
end
%     a.ColorOrderIndex = ax.ColorOrderIndex;
plot(a,Voltaje, Curve,'-','LineWidth',2)

if ~isCurrent
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
    % a.YLabel.String = 'Conductance(\muS)';
    a.YLabel.String = '\fontsize{18} Normalized conductance';
else
    a.XLabel.String = '\fontsize{18} Voltage (mV)';
    % a.YLabel.String = 'Conductance(\muS)';
    a.YLabel.String = '\fontsize{18} Current (nA)';
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
    if ~isCurrent
        uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
            'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanConductanceRegion'));
    else
        uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
            'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanIVRegion'));
    end
end