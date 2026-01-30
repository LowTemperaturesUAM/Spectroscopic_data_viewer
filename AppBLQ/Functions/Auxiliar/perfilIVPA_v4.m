function [Distancia, Perfil, MatrizSurf,fig,FigSurfPerfil] = perfilIVPA_v4(Map,Voltage,CurveMatrix,...
    XCoords, YCoords, Xstartfinal, Ystartfinal,opts)
arguments
    Map {mustBeFinite}
    Voltage (:,1) double {mustBeFinite,mustBeVector}
    CurveMatrix {mustBeFinite}
    XCoords {mustBeVector, mustBeFinite}
    YCoords {mustBeVector,mustBeFinite}
    Xstartfinal (2,1) {mustBeFinite}
    Ystartfinal (2,1) {mustBeFinite}
    opts.ColorScale (:,3) {mustBeInRange(opts.ColorScale,0,1)}
end
% INPUT: 
% Map:              Target image for the profile
% Voltage:          Voltage values for CurveMatrix
% CurveMatrix:      Matrix containing the linearly indexed curves associated to
%                   each point in Map
% XCoords, YCoords: x and y coordinates of each point of the image Map
% Xstartfinal, Ystartfinal: x and y coordinates of the start and final point of
% the profile
% OPTIONS:
% Colorscale:       Nx3 matrix containing the colormap to be used in the figures 
% ---------------------------------------------------


[IV, ~] = size(CurveMatrix);
% Rows       = length(VectorTamanhoY);
% Cols    = length(VectorTamanhoX);
[Rows,Cols]=size(Map);
Method = 'bilinear';



% nPuntosPerfil = NrPoints;
Xrange = XCoords([1 end]);
Yrange = YCoords([1 end]);


% [CoordenadasX,CoordenadasY,Perfil] = improfile(Xrange,Yrange,Map,XinicioFinal,...
%     YinicioFinal,nPuntosPerfil,'bilinear');
[CoordenadasX,CoordenadasY,Perfil] = improfile(Xrange,Yrange,Map,Xstartfinal,...
    Ystartfinal,'bilinear');

%obtain coordinates refered to the starting point of the profile
DistanciaX = CoordenadasX-CoordenadasX(1);
DistanciaY = CoordenadasY-CoordenadasY(1);
Distancia = sqrt(DistanciaX.^2+DistanciaY.^2);

%Obtain the profiles for the curves provided 
MatrizSurf = cell2mat( cellfun(@(M) improfile(Xrange,Yrange,M,Xstartfinal,...
    Ystartfinal,Method).',toMaps(CurveMatrix,IV,Rows,Cols),UniformOutput=false));

%Add color visualizaton as well as 3D surface for the curves along the profile
% ------------------------------------------------------------------
%Create 2D color figure
fig = figure;
 
imagesc(Voltage,Distancia,MatrizSurf');
colormap(opts.ColorScale)

xlabel ('\fontsize{18} Voltage (mV)')
ylabel ('\fontsize{18} Distance (nm)')

b=fig.Children;
b.YDir = 'normal';
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.LineWidth = 2;
b.FontName = 'Arial';
b.FontSize = 14;
b.FontWeight = 'bold';
b.TickDir = 'out';
b.TickLength(1) = 0.015;

% % Create surface 3D figure
FigSurfPerfil = figure('Color',[1 1 1]);
% Create axes
EjeSurfPerfil = axes('Parent',FigSurfPerfil,'FontSize',16,'FontName','Arial',...
    'Position',[0.158351084541563 0.1952 0.651099711483654 0.769800000000001],...
    'CameraPosition',[0 0 5]);

hold(EjeSurfPerfil,'on');
FigSurfPerfil.Position(1) = fig.Position(1) ;
FigSurfPerfil.Position(2) = fig.Position(2) - fig.Position(4)-85;
%Shift back into the display, just in case the position doesn't fit
movegui(FigSurfPerfil)

% Create surf
surf(Voltage,Distancia,MatrizSurf','Parent',EjeSurfPerfil,'MeshStyle','row',...
    'FaceColor','interp');
colormap(opts.ColorScale)
hold(EjeSurfPerfil,'off');
% Create xlabel
xlabel(EjeSurfPerfil,'Bias voltage (mV)','FontSize',18,'FontName','Arial');
    EjeSurfPerfil.XLim = [min(Voltage) max(Voltage)];

% Create ylabel
ylabel(EjeSurfPerfil,'Distance (nm)','FontSize',18,'FontName','Arial','Rotation',90);
    EjeSurfPerfil.YLim = [min(Distancia), max(Distancia)];

% Create zlabel
EjeSurfPerfil.ZTick = [];
% caxis([0 10]);
% ----------------------------------------------------------------    


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