function rmLastIV(ax)
% ax.Children
%Find the rectangles or points present over the map and delete the last drawn
objects = findobj(ax,'Type','Line');
if ~isempty(objects)
    %Check what kind of data the last object corresponds to
    switch objects(1).Tag
        case 'meandI/dVFig'
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
        case 'singledI/dVFig'
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

            %Do the same for the current and conductance figures
            CondFig = findobj('Type','Figure','Name','singledI/dVFig','Number',120);
            if ~isempty(CondFig)
                Curves = findobj(CondFig.Children,'Type','Line');
                delete(Curves(1))
                %Also remove the curves and the location from the UserData
                CondFig.UserData.curves = CondFig.UserData.curves(:,1:end-2);
                CondFig.UserData.points = CondFig.UserData.points(1:end-1,:);
                CondFig.UserData.coords = CondFig.UserData.coords(1:end-1,:);
            end
            CurrentFig = findobj('Type','Figure','Name','singleIVFig','Number',122);
            if ~isempty(CurrentFig)
                Curves = findobj(CurrentFig.Children,'Type','Line');
                delete(Curves(1))
                %Also remove the curves and the location from the UserData
                CurrentFig.UserData.curves = CurrentFig.UserData.curves(:,1:end-2);
                CurrentFig.UserData.points = CurrentFig.UserData.points(1:end-1,:);
                CurrentFig.UserData.coords = CurrentFig.UserData.coords(1:end-1,:);
            end
        case 'FFTPointFig'
            ax.UserData.Rectangle = [];
            %Revert the colororderindex to the last value, checking if we wrapped
            %around back to the first color
            switch ax.ColorOrderIndex
                case 1
                    ax.ColorOrderIndex   = length(ax.ColorOrder);
                otherwise
                    ax.ColorOrderIndex = ax.ColorOrderIndex-1;
            end

            %Do the same for the plotted line
            FFTFig = findobj('Type','Figure','Name','FFTPointFig','Number',121);
            if ~isempty(FFTFig)
                Curves = findobj(FFTFig.Children,'Type','Line');
                delete(Curves(1))
                %Also remove the curves and the rectangle from the UserData
                FFTFig.UserData.curves = FFTFig.UserData.curves(:,1:end-2);
                FFTFig.UserData.points = FFTFig.UserData.points(1:end-1,:);
                FFTFig.UserData.coords = FFTFig.UserData.coords(1:end-1,:);
            end
    end
    %Remove the object now that the data has been cleared
    delete(objects(1))
end
end