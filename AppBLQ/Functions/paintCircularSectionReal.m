function [Section]=paintCircularSectionReal(angles,ax,center, Rmax,format)
arguments
    angles double {mustBeVector}
    ax = gca
    center double {mustBeVector} = [0,0]
    Rmax double {mustBeScalarOrEmpty} = 0
    format.FaceColor = 'r'
    format.EdgeColor = 'r'
    format.FaceAlpha = 0.2
end
% Plots a semitransparent color filled circular section.

% INPUTS:
    % ax    : Axes where the figure is painted.
    % center: Array with coordinates of the center for the circle in real units. [X0,Y0]
    % Rmax  : Radius of the circle in pixels.
    % angle : Array containing the start and end angles in degrees. This values will
    % be taken modulo 360

%-----------------------------------------------------------------------

% Create arrays to plot
Nang = 100; % Number of points to paint angles

if angles(1)<angles(2)
    angles = wrapTo360(angles);
else
    angles = wrapTo180(angles);
end
ang = linspace(angles(1),angles(2),Nang);

% fill to the nearest edge of the window if no radius is provided
if Rmax == 0
    Rmax = abs(min([ax.XLim-center(2), ax.YLim-center(1)],[],ComparisonMethod="abs"));
end
% Cartesian coord for the arc
x = center(1) + Rmax.*cosd(ang);
y = center(2) + Rmax.*sind(ang);
% If the circle is not complete, we add the middle point as well
if diff(angles) < 360
    x = [center(1), x];
    y = [center(2), y];
end

% Paint section in given axes.
hold(ax,"on")
Section = fill(ax,x,y,format.FaceColor,...
    FaceAlpha=format.FaceAlpha,EdgeColor=format.EdgeColor);
hold(ax,"off")

end
