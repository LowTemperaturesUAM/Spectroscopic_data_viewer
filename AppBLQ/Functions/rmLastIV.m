function rmLastIV(ax)
% ax.Children
%Find the rectangles present over the map and delete the last drawn
rectangles = findobj(ax,'Type','Line');
if ~isempty(rectangles)
    %Remove the rectangle from userdata
    ax.UserData.Rectangle = [];
    %Revert the colororderindex to the last value, checking if we wrapped
    %around back to the first color
    switch ax.ColorOrderIndex
        case 1
            ax.ColorOrderIndex   = length(ax.ColorOrder);
        otherwise
            ax.ColorOrderIndex = ax.ColorOrderIndex-1;
    end
    delete(rectangles(1))
    %Do the same for the current and conductance figures
    CondFig = findobj('Type','Figure','Name','meandI/dVFig','Number',37290);
    if ~isempty(CondFig)
        Curves = findobj(CondFig.Children,'Type','Line');
        delete(Curves(1))
        %Also remove the curves and the rectangle from the UserData
        CondFig.UserData.curves = CondFig.UserData.curves(:,1:end-2);
        CondFig.UserData.areas = CondFig.UserData.areas(1:end-1,:);
    end
    CurrentFig = findobj('Type','Figure','Name','meanIVFig','Number',37289);
    if ~isempty(CurrentFig)
        Curves = findobj(CurrentFig.Children,'Type','Line');
        delete(Curves(1))
        %Also remove the curves and the rectangle from the UserData
        CurrentFig.UserData.curves = CurrentFig.UserData.curves(:,1:end-2);
        CurrentFig.UserData.areas = CurrentFig.UserData.areas(1:end-1,:);
    end
end
end