function exportCellMaps(Cell,Info,isReal,type,Path,options)
arguments
    Cell cell
    Info struct
    isReal logical
    type {mustBeNumeric}
    Path  {mustBeFolder}
    options.FileType (1,:) char = 'png'
    options.Prefix char = ''
end
NCell = length(Info.Energia);

% Path = uigetdir;

SaveFigure = figure;
SaveFigure.Visible = 'off';
colormap(Info.Colormap);
for i = 1:NCell
    if isReal %Real
        imagesc(Info.DistanciaColumnas, Info.DistanciaFilas, Cell{i});
        SaveFigure.Children.CLim = Info.ContrastReal(:,i);
        SaveFigure.Children.XLim =  Info.XLimReal;
        SaveFigure.Children.YLim =  Info.YLimReal;
    else %FFT
        imagesc(Info.DistanciaFourierColumnas, Info.DistanciaFourierFilas, Cell{i});
        SaveFigure.Children.CLim = Info.ContrastFFT(:,i);
        SaveFigure.Children.XLim =  Info.XLimFFT;
        SaveFigure.Children.YLim =  Info.YLimFFT;
    end
    SaveFigure.Children.YDir = 'normal';
    SaveFigure.Children.FontSize = 20;

    %------------------Choose whatever you prefer--------------------------   
    switch type
        case 0 % NO TITLE NO AXES NO BORDERS
            SaveFigure.Children.Position =  SaveFigure.Children.OuterPosition;
            SaveFigure.Children.XTick = [];
            SaveFigure.Children.YTick = [];
            SaveFigure.Children.XTickLabel = [];
            SaveFigure.Children.YTickLabel = [];
        
        case 1 % ONLY TITLE
            title([num2str(Info.Energia(i)), ' mV']);
            %SaveFigure.Children.Position= [0.0 0.0 1 0.94];
            SaveFigure.Children.XTick = [];
            SaveFigure.Children.YTick = [];
            SaveFigure.Children.XTickLabel = [];
            SaveFigure.Children.YTickLabel = [];
    
        case 2 % WITH TITLE AND AXES
            % We can probably remove this option and add a scalebar instead
            title([num2str(Info.Energia(i)), ' mV']);
    end
    
    SaveFigure.Children.DataAspectRatio = [1,1,1];
    
    name = num2str(Info.Energia(i));
    name = strrep(name,'.',',');
    exportgraphics(SaveFigure,[Path,filesep, name,'.',options.FileType],'Resolution',200)
    clf(SaveFigure)
end
close(SaveFigure)