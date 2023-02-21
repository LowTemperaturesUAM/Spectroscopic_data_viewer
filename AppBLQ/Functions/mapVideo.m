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
% Default values
fRate = 4; % Frames per second by default
filename = 'TestVid.avi';


%------------------------
nvar = nargin - length(varargin); % Number of variables outside varargin


% Define figure. Hidden, but it slows down the performance
fig = figure("Visible","off");

% Check appropiate size of inputs
if length(Maps) ~= length(Energia)
    error("Length of Energy does not match number of Maps");
end
if size(contrastLim,2) ~= length(Energia)
    error("Columns of Contrast do not match number of Maps");
end

% Take contrast limits as extreme values of each map when not given an
% input
if nvar < 3
    cMax = cellfun(@(x) max(x,[],'all'),Maps,'UniformOutput',true);
    cMin = cellfun(@(x) min(x,[],'all'),Maps,'UniformOutput',true);
    contrastLim = [cMax;cMin];
end
if nvar < 4
    cmap = colormap;
end

names = varargin(1:2:end);
values = varargin(2:2:end);

for k = 1:numel(names)
    
    switch names{k}
        
        case "Colorbar"
            if values{k} || values{k}=="on"
                colorbar;
            end       
        case "Framerate"
            fRate = values{k};

        case "Filename"
            filename = values{k};
    end
end

%--------------------------------------------------------------------------
%cmap = InfoStruct.Colormap;
%Maps = InfoStruct.Restas;
%contrastLim = InfoStruct.ContrastRestasReal;
%Energia = InfoStruct.Energia;

nummaps = length(Maps);
[Lx,Ly] = size(Maps{1});


writerObj = VideoWriter(filename); % Create a video
writerObj.FrameRate = fRate; %Framerate
open(writerObj); 

try % Check if there are errors to close the file
imagesc(1:Lx,Ly:-1:1,flipud(Maps{1}));
colormap(fig,cmap);
set(gca,{'YDir','DataAspectRatio'},{'normal', [1 1 1]});

%colorbar;
hold on
for n = 1:nummaps
    imagesc(flipud(Maps{n}))
    caxis([contrastLim(:,n)])
    title('E = '+string(Energia(n))+' meV')
    frame = getframe(fig);
    writeVideo(writerObj, frame);
end
hold off
catch 
    close(writerObj);
    if writerObj.FrameCount == 0
        clear writerObj
        delete(filename);
        return
    end
end

close(writerObj);
end