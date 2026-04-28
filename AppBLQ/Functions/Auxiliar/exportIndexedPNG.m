function exportIndexedPNG(Map,Contrast,Colormap,Path,Name,options)
arguments
    Map double {mustBeFinite,mustBeNonempty}
    Contrast (2,1) double
    Colormap (:,3) double {mustBeNonnegative,mustBeLessThanOrEqual(Colormap,1)}
    Path  {mustBeFolder}
    Name char
    options.FileType (1,:) char = 'png'
    options.Prefix char = ''
    options.Rescaling {mustBeInteger,mustBePositive} = 1;
end

% Export single map as indexed images
% The images are exported on the given Path with the name given by each
% value of Energy.
%
% Maps: Array containing a map
% Contrast: Limits set for the values to apply the colormaps
% Colormap: Colorscale to the applied
% Path: Destination folder
%
% --Optional arguments--
% FileType: file extension of the image type to be used for the output
% (default: 'png')
% Prefix: optional string to be placed at the beginning of each file name
% Rescaling: every pixel of the image gets repeated n times along each axis,
% to obtain an equivalent image with a larger size. 

% Examples:
%   exportMapsIndexed(Maps,Energy,ContrastReal,viridis,'.',Prefix='Map_',FileType='tif')
%   exportMapsIndexed(InfoStruct.Transformadas,InfoStruct.Energia,...
%       InfoStruct.ContrastReal,InfoStruct.Colormap,uigetdir)

Path = fileparts(Path); %Removes trailing slash if present.
[~,Name] = fileparts(Name); %Removes the extension, if present
if options.Rescaling > 1
    Scalar = ones(options.Rescaling);
    Map =  kron(Map,Scalar);
end

% Convert to grayscale in the desired contrast range
% We also need to flip vertically to be consistent with the graphs
Cspan = size(Colormap,1)-1;
OutputImg = flipud(1 + Cspan*mat2gray(Map,Contrast.'));
imwrite(OutputImg,Colormap, ...
    [Path,filesep,options.Prefix,Name,'.',options.FileType])
% be more explicit about what kind of image we are going to export
% BitDepth = 1,2,4,8 % depending on the colomap size, we can choose
% Software = 'blqApp' %embed the software used to create the image
% Comment = ?¿ %we could add the voltage so its always there?
