function Output=spectraProfile(Map,CurveParameter,CurveMatrix,Xstartfinal, Ystartfinal,opts)
arguments
    Map {mustBeFinite}
    CurveParameter {mustBeFinite,mustBeVector}
    CurveMatrix {mustBeFinite}
    Xstartfinal (2,1) {mustBeFinite}
    Ystartfinal (2,1) {mustBeFinite}
    opts.XCoords {mustBeVector, mustBeFinite} = 0
    opts.YCoords {mustBeVector,mustBeFinite} = 0
    opts.Method {mustBeMember(opts.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
end
% INPUT:
% Map:              Target image for the profile
% CurveParameter:  Paremeter being varied in CurveMatrix (i.e. Voltage)
% CurveMatrix:      Matrix containing the linearly indexed curves associated to
%                   each point in Map
% Xstartfinal, Ystartfinal: x and y coordinates of the start and final point of
%                   the profile
% OPTIONS:
% Method:           Method of interpolation for obtaining the profile
% XCoords, YCoords: x and y coordinates of each point of the image Map. If none
%                   is provided, it uses the image pixels as coordinates
% ---------------------------------------------------
% OUTPUT:
% Struct containing the fields:
% Distance:         Distance of each point of the profile to the initial point
% mapProfile:       Profile values of the provided image
% generalProfile:   Profile values of the given curves
% DistanceX:        Position of each point of the profile to de initial point on
%                   the x axis
% DistanceY:        Position of each point of the profile to de initial point on
%                   the y axis

[IV, points] = size(CurveMatrix);
[Rows,Cols]=size(Map);
%Check that the size of the image and the provided curve matrix match
if points ~= Rows*Cols
    error("The provided map and curves don't have the same size. Please check your inputs")
end


if opts.XCoords == 0
    Xrange = [1, size(Map,2)] ;
else
    Xrange = opts.XCoords([1 end]);
end

if opts.YCoords == 0
    Yrange =  [1, size(Map,1)];
else
    Yrange = opts.YCoords([1 end]);
end


% [CoordenadasX,CoordenadasY,Perfil] = improfile(Xrange,Yrange,Map,XinicioFinal,...
%     YinicioFinal,nPuntosPerfil,'bilinear');
[Xpos,Ypos,mapProfile] = improfile(Xrange,Yrange,Map,Xstartfinal,...
    Ystartfinal,opts.Method);

%obtain coordinates refered to the starting point of the profile
DistanceX = Xpos-Xpos(1);
DistanceY = Ypos-Ypos(1);
Distance= sqrt(DistanceX.^2+DistanceY.^2);

%Obtain the profiles for the curves provided
generalProfile = cell2mat( cellfun(@(M) improfile(Xrange,Yrange,M,Xstartfinal,...
    Ystartfinal,opts.Method).',toMaps(CurveMatrix,IV,Rows,Cols),UniformOutput=false));

%Collect all the output to a struct;
Output = struct();
Output.Distance = Distance;
Output.mapProfile = mapProfile;
Output.generalProfile = generalProfile;
Output.DistanceX = DistanceX;
Output.DistanceY = DistanceY;
Output.CurveX = CurveParameter;
end


function [Cell] = toMaps(Curves,pts,Rows,Cols)
% [Cell] = toMaps(Matriz,Info) turns the curves in array Curves to a
% cell array with maps. Matriz is ptsx(RowsxCols), while Cell will be a
% ptsIVx1 array.

% Reshape Matriz into a Map-like array, with dim 3 as Voltage
Temp = reshape(Curves,[pts,Cols,Rows]);
Temp = permute(Temp,[2,3,1]);
Temp = pagetranspose(Temp);

Cell = mat2cell(Temp,Rows,Cols,ones(1,pts));
Cell = squeeze(Cell);

clear Temp
end
