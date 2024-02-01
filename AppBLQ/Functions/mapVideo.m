function [writerObj] = mapVideo(Maps,Energia,contrastLim,cmap,varargin)

% INPUTS
% Maps             Cell array with the maps to create video
% Energia           Array with energy value. Each one defines a frame.
% contrastLim       Matrix with contrast limits for each energy
% cmap              Colormap to use in maps

% "Framerate"       % Frames/maps per second
% "Colormap"        % Colormap matrix to use
% "Filename"        String with name of the video file

% OUTPUT
% writerObj         Video object


%--------------------------------------------------------------------------
arguments
    Maps cell
    Energia (1,:) double
    contrastLim (2,:) double
    cmap (:, 3) double
end
arguments (Repeating)
    varargin
end

% Default values
fRate = 4; % Frames per second by default
filename = 'TestVid.avi';
bar_check = false;
doAxes = false;

%------------------------
nvar = nargin - length(varargin); % Number of variables outside varargin
if nvar < 2
    Energia = 1:length(Maps);
end

% Define figure. Hidden, but it slows down the performance
fig = figure(3);

% Check appropiate size of inputs
if length(Maps) ~= length(Energia)
    error("Length of Energy does not match number of Maps");
end
% Take contrast limits as extreme values of each map when not given an
% input

if nvar < 3 || isempty(contrastLim)
    cMax = cellfun(@(x) max(x,[],'all'),Maps,'UniformOutput',true);
    cMin = cellfun(@(x) min(x,[],'all'),Maps,'UniformOutput',true);
    contrastLim = [cMin;cMax];
end
if ~isempty(contrastLim) && (numel(contrastLim) == 2)
    contrastLim = reshape(contrastLim, [2 1]); % Check column vector
    contrastLim = contrastLim.*ones(2,length(Maps)); % Expand

elseif ~isempty(contrastLim) && (size(contrastLim,2) ~= length(Maps))
    error("Columns of Contrast do not match number of Maps");
end


if nvar < 4
    cmap = colormap;
end

names = varargin(1:2:end);
values = varargin(2:2:end);
propNames = ["Framerate","Filename", "Title", "Axes", "Colorbar"];

for k = 1:numel(names)   
    switch validatestring(names{k},propNames)        
        case "Colorbar"
            if values{k}=="on"
                %colorbar(gca);
                bar_check = 1;
            end       
        case "Framerate"
            fRate = values{k};

        case "Filename"
            filename = values{k};

        case "Axes"
            doAxes = values{k};
    end
end

%--------------------------------------------------------------------------
nummaps = length(Maps);
% [Lx,Ly] = size(Maps{1});

% Initialize video object
writerObj = VideoWriter(filename); % Create a video
writerObj.FrameRate = fRate; %Framerate
open(writerObj); 

try % Check if there are errors to close the file
    im = imagesc(Maps{1});
    colormap(fig,cmap);
    set(gca,{'YDir','DataAspectRatio'},{'normal', [1 1 1]});

    % if ~doAxes
    %     set(gca,'YTick',[],'XTick',[],'XLabel',[],'YLabel',[]);
    % end

    %colorbar;
    if bar_check
        colorbar(gca);
    end
    hold on
    for n = 1:nummaps
        % Change content of axes and title each frame
        im.CData = Maps{n};
        im.Parent.CLim = [contrastLim(:,n)];
        im.Parent.Title.String = "E = "+Energia(n)+" meV";
        drawnow;
        % save frame
        frame = getframe;
        writeVideo(writerObj, frame);
    end
    hold off
catch ME
    disp('ERROR')
    close(writerObj);

    if writerObj.FrameCount == 0
        clear writerObj
        delete(filename);
        return
    end
end

close(fig)
close(writerObj);
end