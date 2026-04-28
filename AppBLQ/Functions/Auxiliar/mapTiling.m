function TileImg = mapTiling(Cell,Contrast,Energy,cmap,opt)
arguments
    Cell (:,1) cell
    Contrast (2,:) double
    Energy double {mustBeVector}
    cmap (:,3) double
    opt.BorderSize double = [20,2]
    opt.BackgroundColor = 'w'
    opt.AddLabels = 'true'
end
%NOTE: an option to filter the amount of maps might be interesting, as
%well as allowing for manual control for the layout.
CellContrast = transpose(num2cell(Contrast,1));
Aux = cellfun(@(I,Limits) rescale(I,InputMin=Limits(1),InputMax=Limits(2)),...
    Cell,CellContrast,UniformOutput=false);
Aux = cellfun(@(I) gray2ind(I,size(cmap,1)),Aux,UniformOutput=false);
Aux = cellfun(@(I) flipud(I),Aux,UniformOutput=false);
%We stitch all the images together
TileImg = imtile(Aux,cmap,BorderSize=opt.BorderSize,...
    BackgroundColor=opt.BackgroundColor);

if numel(opt.BorderSize) == 2
    Hborder = opt.BorderSize(2);
    Vborder = opt.BorderSize(1);
elseif numel(opt.BorderSize) == 1
    [Hborder,Vborder] = deal(opt.BorderSize);
else
    warning('Border size input is not correct. It must be a scalar or a 2 element vector. Input will be replaced by the default values')
    Hborder = 2;
    Vborder = 20;
end


if opt.AddLabels
    TileAux = circshift(TileImg,Vborder,1);
    Himg = size(Cell{1},2);
    Vimg = size(Cell{1},1);
    TileSize = size(TileAux);
    GridRow = TileSize(1)/(Vimg+2*Vborder);
    GridCol = TileSize(2)/(Himg+2*Hborder);
    FontSize = 30; %Default font size
    examplelabel = sprintf('%.2f meV',min(Energy));
    % Check the length of the text and make a rough estimation of whether
    % it will fit on the tile or not assuming the width of the caracters is 2/3
    % of its height
    if FontSize*length(examplelabel)*2/3> Himg
        FontSize = floor(Himg/length(examplelabel)*3/2);
    end
    for k = 1:numel(Cell)
        [i,j] = ind2sub([GridCol,GridRow],k);
        i = i-1;
        j = j-1;
        TxtPos = [Hborder + floor(Himg/2)+1+i*(2*Hborder+Himg),Vborder+j*(2*Vborder+Vimg)];
        % NOTE: this function requires the Computer Vision Toolbox
        % We might want to think of an alternative at some point
       
        TileAux = insertText(TileAux,TxtPos,sprintf('%.2f meV',Energy(k)),...
            TextColor = 'black',BoxColor = 'white',FontSize= FontSize,...
            BoxOpacity=0,AnchorPoint= 'Center',Font='Arial');
    end
    TileImg = TileAux;
end