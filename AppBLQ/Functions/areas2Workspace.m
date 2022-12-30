function areas2Workspace(Name,number)
%Exports the position of the averaged regions into the workspace 
% variable given by Name. Additionally, you can set a particular figure
% number in case multiple are open

%The funtion only extracts this data from figures created on blqApp with
%the correct figure name (meandI/dVFig or meanIVFig) and containing the
%area data. If the data is not present or the figure is not of this type,
%the funtion will display a warning 

switch nargin
    case 2
        %Check if a conductance figure is available first
        a = findobj('Type','Figure','Name','meandI/dVFig','Number',number);
        if ~isempty(a)
            %This is the new name for the conductance figure.
            % We know this will contain the data and we assume the field
            % exist
            assignin('base', Name, a(1).UserData.areas)
        else
            %Fallback to generic IV figure
            a = findobj('Type','Figure','Name','meanIVFig','Number',number);
            if ~isempty(a)
                %We have to check if the field is presents, because older
                %figures don't contain this info
                if isfield(a(1).UserData, 'areas')
                    assignin('base', Name, a(1).UserData.areas)
                else
                    disp('No position data is available')
                end
            else
                warning(sprintf(['No Figure %i was found ' ...
                    'or doesn''t contain suitable data'],number))
            end
        end
    otherwise % if no number is given, it takes the first figure that if finds
        a = findobj('Type','Figure','Name','meandI/dVFig');

        if ~isempty(a)
            %This is the new name for the conductance figure.
            % We know this will contain the data and we assume the field
            % exist
            assignin('base', Name, a(1).UserData.areas)
        else
            %Fallback to generic IV figure
            a = findobj('Type','Figure','Name','meanIVFig');
            if ~isempty(a)
                %We have to check if the field is presents, because older
                %figures don't contain this info
                if isfield(a(1).UserData, 'areas')
                assignin('base', Name, a(1).UserData.areas)
                else
                    disp('No position data is available')
                end
            else
                warning('No figure was found')
            end
        end
        if numel(a)>1
            disp(['There are multiple figures available.' ...
                ' You might want to manually select one'])
        end
end
end