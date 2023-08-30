function exportMapsIndexed(Cell,Energy,Contrast,Colormap,Path,options)
arguments
    Cell cell
    Energy (1,:) double
    Contrast (2,:) double
    Colormap (:,3) double {mustBeNonnegative,mustBeLessThanOrEqual(Colormap,1)}
    Path  {mustBeFolder}
    options.FileType (1,:) char = 'png'
    options.Prefix char = ''
end
% Export maps on a cell array as indexed images
% The images are exported on the given Path with the name given by each
% value of Energy.
%
% Cell: Cell array containing each of the maps
% Energy: Vector with the energy values of each map
% Contrast: Limits set for the values to apply the colormaps
% Colormap: Colorscale to the applied
% Path: Destination folder
%
% --Optional arguments--
% FileType: file extension of the image type to be used for the output
% (default: 'png')
% Prefix: optional string to be placed at the beginning of each file name
%
% Examples:
%   exportMapsIndexed(Maps,Energy,ContrastReal,viridis,'.',Prefix='Map_',FileType='tif')
%   exportMapsIndexed(InfoStruct.Transformadas,InfoStruct.Energia,...
%       InfoStruct.ContrastReal,InfoStruct.Colormap,uigetdir)

for k = 1:length(Cell)
    % Convert to grayscale in the desired contrast range
    % We also need to flip vertically to be consistent with the graphs
    Cspan = size(Colormap,1)-1;
    OutputImg = flipud(1 + Cspan*mat2gray(Cell{k},Contrast(:,k).'));

    name = num2str(Energy(k));
    name = strrep(name,'.',',');
    imwrite(OutputImg,Colormap, ...
        [Path,filesep,options.Prefix,name,'.',options.FileType])
end

end