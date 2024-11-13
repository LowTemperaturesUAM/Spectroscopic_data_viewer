function exportCellMaps(Cell,Info,isReal,Format,Path,options)
arguments
    Cell cell
    Info struct
    isReal logical
    Format {mustBeNumeric}
    Path  {mustBeFolder}
    options.FileType (1,:) char = 'png'
    options.Prefix char = ''
end

Energy = Info.Energia;
Colormap = Info.Colormap;
if isReal
    X = Info.DistanciaColumnas;
    Y = Info.DistanciaFilas;
    Contrast = Info.ContrastReal;
    XLim = Info.XLimReal;
    YLim = Info.YLimReal;
else
    X = Info.DistanciaFourierColumnas;
    Y = Info.DistanciaFourierFilas;
    Contrast = Info.ContrastFFT;
    XLim = Info.XLimFFT;
    YLim = Info.YLimFFT;
end
if Format == 0 %Just the maps
    exportMapsIndexed(Cell,Energy,Contrast,Colormap,Path)
    return

elseif Format == 3 %Group all maps in a single image
    OutputImg = mapTiling(Cell,Contrast,Energy,Colormap);
    imwrite(OutputImg,Colormap, ...
        [Path,filesep,'CombinedMaps','.',options.FileType])
    return

elseif Format == 4 %Make Video with Maps as frames. Default 7 FPS
    mapVideo(Cell,Contrast,Energy,Colormap, ...
        'Filename',[Path,filesep,options.Prefix,'MapVideo','.','avi'], ...
        'Framerate',7,'ColorbarVisible',false,'getFrame','figure');
    return
end

NCell = length(Info.Energia);
SaveFigure = figure;
SaveFigure.Visible = 'off';
colormap(Info.Colormap);
imagesc(X,Y,Cell{1})
SaveFigure.Children.CLim = Contrast(:,1);
SaveFigure.Children.XLim =  XLim;
SaveFigure.Children.YLim =  YLim;
SaveFigure.Children.YDir = 'normal';
SaveFigure.Children.FontSize = 20;
SaveFigure.Children.DataAspectRatio = [1,1,1];
SaveFigure.Children.TickDir = 'out';
SaveFigure.Children.XTickLabel = SaveFigure.Children.YTickLabel;
title([num2str(Info.Energia(1)), ' mV']);

if Format == 1 %Disable axis if specified
    SaveFigure.Children.XTick = [];
    SaveFigure.Children.YTick = [];
    SaveFigure.Children.XTickLabel = [];
    SaveFigure.Children.YTickLabel = [];
end

for i = 1:NCell
    SaveFigure.Children.Children.CData = Cell{i};
    SaveFigure.Children.CLim = Contrast(:,i);
    name = num2str(Info.Energia(i));
    name = strrep(name,'.',',');
    title([name,' mV'])
    exportgraphics(SaveFigure.Children,[Path,filesep,options.Prefix,...
        name,'.',options.FileType],'Resolution',250)
end
close(SaveFigure)