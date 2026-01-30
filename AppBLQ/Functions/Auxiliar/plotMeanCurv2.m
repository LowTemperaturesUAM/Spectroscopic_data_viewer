function [meanIVFig] = plotMeanCurv2(ax,Voltaje,Curve,Inicio,Final,Type)
%Check if the figure already exists or we are creating it know
switch Type
    case 'Current'
        isNewFig = ~ishandle(37289);
        meanIVFig = figure(37289);
        meanIVFig.Name = 'meanIVFig';
        %first time we open it, we would like to place them side by side
        condExist = ishandle(37290);
        if condExist && isNewFig
            % condFig = figure(37290);
            condFig =findobj('Type','Figure','Number',37290);
            meanIVFig.Position(1) = condFig.Position(1)+condFig.Position(3);
            %move it into the display in case it was placed out of borders
            movegui(meanIVFig)
            % figure()
        end
    case 'Conductance'
        isNewFig = ~ishandle(37290);
        meanIVFig = figure(37290);
        meanIVFig.Name = 'meandI/dVFig';
        meanIVFig.CloseRequestFcn = 'kill_v2';
    case 'Second'
        isNewFig = ~ishandle(37291);
        meanIVFig = figure(37291);
        meanIVFig.Name = 'meand2I/dV2Fig';
        %first time we open it, we would like to place them side by side
        condExist = ~ishandle(37290);
        if condExist && isNewFig
            % condFig = figure(37290);
            condFig =findobj('Type','Figure','Number',37290);
            meanIVFig.Position(1) = condFig.Position(1)-condFig.Position(3);
            %move it into the display in case it was placed out of borders
            movegui(meanIVFig)
        end
end

hold on
a=meanIVFig.CurrentAxes;
a.ColorOrder = ax.ColorOrder;
if isNewFig %if it was just created then set the callback and interactions
    meanIVFig.KeyPressFcn = @KeyPressSpectraFcn;
    a.Interactions = [zoomInteraction regionZoomInteraction rulerPanInteraction];
end

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