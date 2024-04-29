function [writerObj] = mapVideo(Maps,contrastLim,Energia,cmap,options)

% INPUTS
% Maps             Cell array with the maps to create video, Each cell is an indexed image that
%                   makes a frame of the video
% Energia           Array with energy value. Each one defines a frame.
% contrastLim       2xN Matrix with min and max values for contrast
% cmap              Colormap to use in maps

% "Framerate"       % Frames/maps per second
% "Colormap"        % Colormap matrix to use
% "Filename"        String with name of the video file MAKE SAVEFILE LATER

% OUTPUT
% writerObj         Video object


%--------------------------------------------------------------------------
arguments
    Maps cell
    % Optional arguments
    contrastLim (2,:) double = [0 eps]'
    Energia (1,:) double = 1:length(Maps)   
    cmap (:, 3) double = viridis
    % Name-Value arguments
    options.Framerate (1,1) double {mustBePositive} = length(Maps)/3 % Frames per second by default
    options.Filename string = "TestVid.avi"
    options.Title
    options.AxesVisible logical = 1
    options.ColorbarVisible logical = 1
    options.getFrame {mustBeMember(options.getFrame,{'axes','figure'})}
    options.Axes
    options.Compression
    % options.VideoProfile string = 'Motion JPEG AVI'
end

% Default values
bar_check = false;
doAxes = false;

%------------------------
% nvar = nargin - length(varargin); % Number of variables outside varargin
nvar = nargin;

% Define figure. Hidden, but it slows down the performance
fig = figure('Visible','off');

% Check appropiate size of inputs
if length(Maps) ~= length(Energia)
    error("Length of Energy does not match number of Maps");
end
% Take contrast limits as extreme values of each map when not given an
% input
if nvar < 2 || isequal(contrastLim,[0 eps]')
    cMax = cellfun(@(x) max(x,[],'all'),Maps,'UniformOutput',true);
    cMin = cellfun(@(x) min(x,[],'all'),Maps,'UniformOutput',true);
    contrastLim = [cMin;cMax];
end
if ~isempty(contrastLim) && (numel(contrastLim) == 2)
    % contrastLim = reshape(contrastLim, [2 1]); % Check column vector
    contrastLim = contrastLim.*ones(2,length(Maps)); % Expand

elseif ~isempty(contrastLim) && (size(contrastLim,2) ~= length(Maps))
    error("Columns of Contrast do not match number of Maps");
end


% if nvar < 4
%     cmap = colormap;
% end

% names = varargin(1:2:end);
% values = varargin(2:2:end);
% propNames = ["Framerate","Filename", "Title", "Axes", "Colorbar"];
% 
% for k = 1:numel(names)   
%     switch validatestring(names{k},propNames)        
%         case "Colorbar"
%             if values{k}=="on"
%                 %colorbar(gca);
%                 bar_check = 1;
%             end       
%         case "Framerate"
%             fRate = values{k};
% 
%         case "Filename"
%             filename = values{k};
% 
%         case "Axes"
%             doAxes = values{k};
%     end
% end

%--------------------------------------------------------------------------
nummaps = length(Maps);
% [Lx,Ly] = size(Maps{1});

% Initialize video object
writerObj = VideoWriter(options.Filename); % Create a video
writerObj.FrameRate = options.Framerate; %Framerate
open(writerObj); 

try % Check if there are errors to close the file
    im = imagesc(Maps{1});
    colormap(fig,cmap);
    set(gca,{'YDir','DataAspectRatio'},{'normal', [1 1 1]});

    % if ~doAxes
    %     set(gca,'YTick',[],'XTick',[],'XLabel',[],'YLabel',[]);
    % end

    %colorbar;
    if options.ColorbarVisible
        colorbar(gca);
    end
    % Axes
    if ~options.AxesVisible
        set(gca,'YTick',[],'XTick',[],'XLabel',[],'YLabel',[]);
    end
    hold on
    for n = 1:nummaps
        % Change content of axes and title each frame
        im.CData = Maps{n};
        im.Parent.CLim = [contrastLim(:,n)];
        im.Parent.Title.String = "E = "+Energia(n)+" meV";
        drawnow;
        % save frame
        if isequal(options.getFrame,'figure')
            % frame = getframe(gcf);
            frame=im2frame(print('-RGBImage','-r120'));
        elseif isequal(options.getFrame,'axes')
            frame = getframe;
        end
        
        writeVideo(writerObj, frame);
    end
    hold off
catch ME
    disp('ERROR')
    close(writerObj);

    if writerObj.FrameCount == 0
        clear writerObj
        delete(options.Filename);
        return
    end
end

close(fig)
close(writerObj);

end