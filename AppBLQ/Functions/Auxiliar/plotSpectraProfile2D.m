function fig2D = plotSpectraProfile2D(ProfileData,opts)
arguments
    ProfileData struct
    opts.Colormap  = []
    opts.curveType {mustBeMember(opts.curveType,{'IV','IZ'})} = 'IV'
    opts.FigNumber {mustBeInteger,mustBeNonnegative} = 0
    %opts.FigureHandle matlab.ui.Figure = figure
end
%Create 2D color figure from the curve profile
if opts.FigNumber >0
    fig2D = figure(opts.FigNumber);
else
    fig2D = figure;
end

imagesc(ProfileData.CurveX,ProfileData.Distance,...
    ProfileData.generalProfile.');

%Grab the provided colormap, or use the default instead
if ~isempty(opts.Colormap)
    fig2D.Colormap = opts.Colormap;
end

ax2D=fig2D.CurrentAxes;
ax2D.YDir = 'normal';
ax2D.XColor = [0 0 0];
ax2D.YColor = [0 0 0];
ax2D.LineWidth = 2;
ax2D.FontName = 'Arial';
ax2D.FontSize = 14;
ax2D.FontWeight = 'bold';
ax2D.TickDir = 'out';
ax2D.TickLength(1) = 0.015;

switch opts.curveType
    case 'IV'
        ax2D.XLabel.String = 'Voltage (mV)';
    case 'IZ'
        ax2D.XLabel.String = 'Displacement (Å)';
end
ax2D.XLabel.FontSize = 18;

ax2D.YLabel.String = 'Distance (nm)';
ax2D.YLabel.FontSize = 18;
end