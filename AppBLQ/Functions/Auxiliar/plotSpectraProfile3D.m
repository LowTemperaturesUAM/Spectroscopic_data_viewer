function fig3D = plotSpectraProfile3D(ProfileData,opts)
arguments
    ProfileData struct
    opts.Colormap  = []
    opts.curveType {mustBeMember(opts.curveType,{'IV','IZ'})} = 'IV'
    opts.FigNumber = 0;
    %opts.FigureHandle matlab.ui.Figure = figure
end

% Create surface 3D figure from the curve profile
if opts.FigNumber >0
    fig3D = figure(opts.FigNumber);
else
    fig3D = figure;
end
fig3D.Color = [1 1 1];

ax3D = axes('Parent',fig3D,'FontSize',16,'FontName','Arial',...
    'Position',[0.158351084541563 0.1952 0.651099711483654 0.769800000000001],...
    'CameraPosition',[0 0 5]);

hold(ax3D,'on');

% Create surf
surf(ProfileData.CurveX,ProfileData.Distance,...
    ProfileData.generalProfile.','Parent',ax3D,'MeshStyle','row',...
    'FaceColor','interp');
%Grab the provided colormap, or use the default instead
if ~isempty(opts.Colormap)
    fig3D.Colormap = opts.Colormap;
end
hold(ax3D,'off');

switch opts.curveType
    case 'IV'
        ax3D.XLabel.String = 'Voltage (mV)';
    case 'IZ'
        ax3D.XLabel.String = 'Displacement (Å)';
end

ax3D.XLabel.FontSize = 18;
ax3D.XLim = [min(ProfileData.CurveX) max(ProfileData.CurveX)];

ax3D.YLabel.String = 'Distance (nm)';
ax3D.YLabel.FontSize = 18;
ax3D.YLabel.Rotation = 90;

ax3D.YLim = [min(ProfileData.Distance), max(ProfileData.Distance)];

ax3D.ZTick = [];
end