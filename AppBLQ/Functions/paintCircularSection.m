function [Section]=paintCircularSection(ax,center, Rmax, angle)
% Plots a semitransparent color filled circular section.

% INPUTS:
    % ax    : Axes where the figure is painted.
    % center: Array with position of the circle center. [X0,Y0]
    % Rmax  : Radius of the circle
    % angle : Array with the section angular limits in degrees. [theta1, theta2]

%-----------------------------------------------------------------------

% Create arrays to plot
Nang = 100; % Number of points to paint angles
ang = linspace(angle(1),angle(2),Nang);

% Cartesian coord for the arc
x = center(1) + Rmax.*cosd(ang);
y = center(2) + Rmax.*sind(ang);

% Paint section in given axes.
hold(ax,"on")
Section = fill(ax, [center(1), x],[center(2), y],'r',...
    'FaceAlpha',0.2,'EdgeColor','r');
hold(ax,"off")

end
