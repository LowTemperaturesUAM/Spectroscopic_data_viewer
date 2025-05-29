function exportColorbar(Colormap,opts)
arguments
    Colormap (:,3) {mustBeFloat,mustBeInRange(Colormap,0,1,"inclusive")}
    opts.AspectRatio double {mustBePositive} = 6.5
    opts.LineWidth = 2.5
    opts.UpText char {mustBeTextScalar}= ''
    opts.DownText char {mustBeTextScalar} = ''
    opts.Format { mustBeMember(opts.Format,{'vector','image'})} = 'vector'
end
%NOTE: numbers can be directly input for the upper and lower labels of the
%colorbar, but they represent the corresponding ASCII character, not the actual
%numeric value if the literal number is desired, it must be converted to
%characters before hand using num2str or similar
%If you are working with divergent colormaps with a pivot point that doesn't lie
%in the middle, you should extract the colomap from the working axes and use it
%as input for this function. 
N = size(Colormap,1);
fig = figure(Visible="off",Units="centimeters",Position=[0,0,15,11]);
imagesc((1:N)')
ax = fig.CurrentAxes;
colormap(ax,Colormap)
ax.YDir = "normal";
ax.LineWidth = opts.LineWidth;
xticks(ax,'')
yticks(ax,'')
ax.PlotBoxAspectRatio = [1,opts.AspectRatio,1];
if size(opts.UpText) ~= 0
    text(ax,1,256+15,opts.UpText,HorizontalAlignment='center',...
    FontUnits='centimeters',FontSize=1);
end
if size(opts.DownText) ~= 0
    text(ax,1,1-15,opts.DownText,HorizontalAlignment='center',...
    FontUnits='centimeters',FontSize=1);
end
copygraphics(ax,BackgroundColor="none",ContentType=opts.Format,Resolution=200)
close(fig)
end