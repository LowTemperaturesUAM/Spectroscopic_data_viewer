function [Section]=paintCircularSection(ax,center_pix, Rmax, angle)
% Plots a semitransparent color filled circular section.

% INPUTS:
    % ax    : Axes where the figure is painted.
    % center_pix: Array with pixel position of the circle center. [X0,Y0]
    % Rmax  : Radius of the circle in pixels.
    % angle : Array with the section angular limits in degrees. [theta1, theta2]
%      Should not abarc more than 1 cycle

%-----------------------------------------------------------------------

% Obtain number of rows and columns of image
[numRow, numCol] = size(ax.Children(end).CData);
% Obtain value limits
xSize = diff(ax.Children(end).XData([1 end]));
ySize = diff(ax.Children(end).YData([1 end]));
% Calculate pixel size
PixSize = xSize/(numCol-1);

% Convert distances from pixel to  real units
Rmax_real = Rmax * PixSize;
center = [ax.Children(end).XData(center_pix(1)),...
    ax.Children(end).YData(center_pix(2))];

% Create arrays to plot
Nang = 100; % Number of points to paint angles

if angle(2) < angle(1)
    angle(2) = angle(2)+360;
end
ang = linspace(angle(1),angle(2),Nang);

% Cartesian coord for the arc
x = center(1) + Rmax_real.*cosd(ang);
y = center(2) + Rmax_real.*sind(ang);

% Paint section in given axes.
hold(ax,"on")
Section = fill(ax, [center(1), x],[center(2), y],'r',...
    'FaceAlpha',0.2,'EdgeColor','r');
hold(ax,"off")

end
