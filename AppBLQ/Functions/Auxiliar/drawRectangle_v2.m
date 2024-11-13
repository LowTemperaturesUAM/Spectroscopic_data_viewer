%Funcion para dibujar rectangulo dando el origen y el tamaño
function [Out] = drawRectangle_v2(ax, OriginX, OriginY, SizeX, SizeY)
    
  
    if SizeX >=0 && SizeY >=0
       Out=  rectangle(ax, 'Position', [OriginX ,OriginY , SizeX, SizeY], 'EdgeColor','r');

    end
    
    if SizeX <0 && SizeY <0
      
        Out = rectangle(ax, 'Position', [OriginX- abs(SizeX) ,OriginY - abs(SizeY), abs(SizeX),abs(SizeY)],'EdgeColor','r');
    end
    if SizeX >=0 && SizeY <0
     
        Out = rectangle(ax, 'Position', [OriginX ,OriginY - abs(SizeY), abs(SizeX),abs(SizeY)], 'EdgeColor','r');
    end
    
    if SizeX <0 && SizeY >=0
       
       Out =  rectangle(ax, 'Position', [OriginX- abs(SizeX) ,OriginY , abs(SizeX),abs(SizeY)],'EdgeColor','r');
    end
end

    
    