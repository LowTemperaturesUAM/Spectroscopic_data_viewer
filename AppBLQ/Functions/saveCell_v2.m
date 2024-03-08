function saveCell_v2(Cell, Info, flag, type)
% Saves maps in Cell as images, allowing for axes or title to be removed.
% Needs Infostruct as input to specify units, number of images and colormap

NCell = length(Info.Energia);

PathName = uigetdir;

for i = 1:NCell 
    SaveFigure         = figure;
    SaveFigure.Visible = 'off';
    colormap(Info.Colormap);
    
    if flag %Real
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
            title([num2str(Info.Energia(i)), ' mV']);
            %SaveFigure.Children.Position= [0.1 0.1 0.85 0.75];

    end
    
    SaveFigure.Children.DataAspectRatio = [1,1,1];
    
    name = num2str(Info.Energia(i));
    name = strrep(name,'.',',');
    %print(SaveFigure,[PathName,filesep, name],'-dpng','-noui')
    exportgraphics(SaveFigure,[PathName,filesep, name,'.png'],'Resolution',200)
end