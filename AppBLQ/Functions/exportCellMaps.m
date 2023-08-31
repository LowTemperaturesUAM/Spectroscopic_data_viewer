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
end

NCell = length(Info.Energia);
SaveFigure = figure;
SaveFigure.Visible = 'off';
colormap(Info.Colormap);
% if isReal %Real
%     imagesc(Info.DistanciaColumnas, Info.DistanciaFilas, Cell{1});
%     SaveFigure.Children.CLim = Info.ContrastReal(:,1);
%     SaveFigure.Children.XLim =  Info.XLimReal;
%     SaveFigure.Children.YLim =  Info.YLimReal;
% else %FFT
%     imagesc(Info.DistanciaFourierColumnas, Info.DistanciaFourierFilas, Cell{1});
%     SaveFigure.Children.CLim = Info.ContrastFFT(:,1);
%     SaveFigure.Children.XLim =  Info.XLimFFT;
%     SaveFigure.Children.YLim =  Info.YLimFFT;
% end
imagesc(X,Y,Cell{1})
SaveFigure.Children.CLim = Contrast(:,1);
SaveFigure.Children.XLim =  XLim;
SaveFigure.Children.YLim =  YLim;
SaveFigure.Children.YDir = 'normal';
SaveFigure.Children.FontSize = 20;
SaveFigure.Children.DataAspectRatio = [1,1,1];
SaveFigure.Children.TickDir = 'out';
SaveFigure.Children.XTickLabel = SaveFigure.Children.YTickLabel;
% switch Format
%     case 0 % NO TITLE NO AXES NO BORDERS
% %         SaveFigure.Children.Position =  SaveFigure.Children.OuterPosition;
%         SaveFigure.Children.XTick = [];
%         SaveFigure.Children.YTick = [];
%         SaveFigure.Children.XTickLabel = [];
%         SaveFigure.Children.YTickLabel = [];

%     case 1 % ONLY TITLE
%         title([num2str(Info.Energia(1)), ' mV']);
%         SaveFigure.Children.XTick = [];
%         SaveFigure.Children.YTick = [];
%         SaveFigure.Children.XTickLabel = [];
%         SaveFigure.Children.YTickLabel = [];

%     case 2 % WITH TITLE AND AXES
%         title([num2str(Info.Energia(1)), ' mV']);

    %Add anothe option for addin just a scalebar?
% end

title([num2str(Info.Energia(1)), ' mV']);
if Format == 1
    SaveFigure.Children.XTick = [];
    SaveFigure.Children.YTick = [];
    SaveFigure.Children.XTickLabel = [];
    SaveFigure.Children.YTickLabel = [];
end
for i = 1:NCell
    SaveFigure.Children.Children.CData = Cell{i};
    SaveFigure.Children.CLim = Contrast(:,i);
%     if isReal %Real
%         SaveFigure.Children.CLim = Info.ContrastReal(:,i);
%     else %FFT
%         SaveFigure.Children.CLim = Info.ContrastFFT(:,i);
%     end
    name = num2str(Info.Energia(i));
    name = strrep(name,'.',',');
    title([name,' mV'])
%     if Format == 1 || Format ==2
%         title([name,' mV'])
%     end
    exportgraphics(SaveFigure.Children,[Path,filesep,options.Prefix,...
        name,'.',options.FileType],'Resolution',250)
end
close(SaveFigure)