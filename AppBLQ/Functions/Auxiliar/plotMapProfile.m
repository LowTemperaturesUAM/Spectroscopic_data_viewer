function figProfile = plotMapProfile(ProfileData,opts)
arguments
    ProfileData struct
    opts.CLim (1,2) {mustBeVector,mustBeFinite}
    opts.FigNumber {mustBePositive,mustBeInteger}= 233 
    opts.profileMagnitude {mustBeMember(opts.profileMagnitude,...
        {'Conductance','Current','d2I/dV2','NormCond','Topo'})} = 'Conductance'
    opts.Colormap = []
end
figProfile = figure(opts.FigNumber);
clf(figProfile)
figProfile.Color = [1 1 1];
ax = axes('Parent',figProfile,'FontSize',14,'FontName','Arial','FontWeight','bold');
hold(ax,'on');

%Set the color if it was provided
if ~isempty(opts.Colormap)
    ax.Colormap = opts.Colormap;
end
plot(ax,ProfileData.Distance,ProfileData.mapProfile,'k--');
scatter(ax,ProfileData.Distance,ProfileData.mapProfile,100,'Filled',...
    'CData',ProfileData.mapProfile);
box(ax,"on")

%set the Contrast if it was provided
if isfield(opts,'CLim')
    ax.CLim = opts.CLim;
end

ax.LineWidth = 2;
ax.TickLength(1) = 0.015;
ax.XColor = 'k';
ax.YColor = 'k';
hold(ax,"off")

% create the labels according to the type of data being displayed
ax.XLabel.String = 'Distance (nm)';
ax.XLabel.FontSize = 16;
switch opts.profileMagnitude
    case 'Current'
        ax.YLabel.String = 'Current (nA)';
    case {'Conductance','NormCond'}
        ax.YLabel.String = 'Normalize conductance';
    case 'd2I/dV2'
        ax.YLabel.String = 'd2I/dV2';
    case 'Topo'
        ax.YLabel.String = 'Height (nA)';
end
ax.YLabel.FontSize = 16;
end