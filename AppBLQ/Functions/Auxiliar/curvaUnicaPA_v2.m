function curvaUnicaPA_v2(ax, puntero, Voltaje, MatrizNormalizada, VectorTamanhoX, VectorTamanhoY, isReal, isCurrent)
%Programa que te printa las curvas elegidas con el puntero

Columnas = length(VectorTamanhoX);

% display(['VectorTamanhoY = ',num2str(VectorTamanhoY)]);
% display(['VectorTamanhoX = ',num2str(VectorTamanhoX)]);

% hold on

%imagesc(vectorTamanho, vectorTamanho, conductanceMap)
%axis square
%colorbar

%src.conductanceMap = conductanceMap;
%src.matrizVoltaje = matrizVoltaje;
%src.matrizNormalizada = matrizNormalizada;
%size = 11.7; % tamaño en nm de la imagen (creo?)

 
 %[XinicioFinal,YinicioFinal] = puntosRaton(); %LLama a la funcion con la que se escogen los puntos
 %conversor = abs(ConductanceMap(1,length(ConductanceMap(1,:)))-ConductanceMap(1,1))/length(ConductanceMap(1,:));
 
    CoorX = puntero(1,1);
	CoorY = puntero(1,2);
 
 %Paso las input a pixeles para elegir el numero de puntos e el perfil
 
    PixelX = zeros(length(CoorX),1);
    PixelY = zeros(length(CoorY),1);
    
for i =1:length(CoorX)
    [~, PixelX(i)] = min(abs(CoorX(i)-VectorTamanhoX));
    [~, PixelY(i)] = min(abs(CoorY(i)-VectorTamanhoY));
end
% b=findobj('Name', 'mainFig');

if isReal
    if isCurrent
        curvaUnicaPlot = figure(122);
    else
        curvaUnicaPlot = figure(120);
        display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
            '] \\ Indice = ',num2str((PixelY(i)-1)*Columnas+PixelX(i))]);
    end
else
    curvaUnicaPlot = figure(121);
    display(['RS Pixel = [',num2str(PixelX),',',num2str(PixelY),...
            '] \\ Indice = ',num2str((PixelY(i)-1)*Columnas+PixelX(i))]);
    % curvaUnicaPlot.Position = [20 300 460 410];
    
end
%Paso los valores directamente a vectores para que sea mas facil de
%entender:
%     (PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i)
%     size(MatrizNormalizada)
    ConductanciaCurvaUnica = MatrizNormalizada(:,(PixelY(i)-1)*Columnas+PixelX(i));
%     ConductanciaCurvaUnica = smooth(MatrizNormalizada(:,(PixelYinicioFinal(i)-1)*Columnas+PixelXinicioFinal(i)));


for i=1:length(PixelX)
    hold on
    if ~isCurrent
        curvaUnicaPlot.Children(end).ColorOrderIndex = ax.ColorOrderIndex;
    else
        switch ax.ColorOrderIndex
            case 1
                curvaUnicaPlot.Children(end).ColorOrderIndex = length(ax.ColorOrder);
            otherwise
                curvaUnicaPlot.Children(end).ColorOrderIndex = ax.ColorOrderIndex-1;
        end
    end
    
    FigCurvas = plot(Voltaje,ConductanciaCurvaUnica,'-','LineWidth',2);
%         FigCurvas.Color = color(i,:);
         
        xlabel('Energy (meV)','FontSize',18);
        xlim([min(Voltaje),max(Voltaje)]);
        
        if ~isCurrent
            ylabel('Normalized conductance','FontSize',18);
        else
            ylabel('Current (nA)','FontSize',18);
        end
%             
    
        title(num2str(Columnas*(PixelY(i)-1)+ PixelX(i)));
    
        legend off; box on;
        set(gcf,'color',[1 1 1]); % quita el borde gris
        set(gca,'FontWeight','bold');
        set(gca,'FontSize',14);
        set(gca,'FontName','Arial');
        set(gca,'LineWidth',2);
        set(gca,'TickLength',[0.02 0.01]);
%         FigCurvas.Name = 'curvaUnicaFig';
end

curves = [Voltaje ConductanciaCurvaUnica];

if ~isfield(curvaUnicaPlot.UserData, 'curves')
    curvaUnicaPlot.UserData.curves = curves;
else
    curvaUnicaPlot.UserData.curves = [curvaUnicaPlot.UserData.curves curves];
end
    
if ~isCurrent
    uicontrol('Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleConductance'));
else
    uicontrol('Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
    'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('singleIV'));
end
%ConductanceMap(PixelYinicioFinal,PixelXinicioFinal)
% uicontrol('Style', 'pushbutton', 'String', 'Save',...
%         'Position', [400 120 50 20],...
%         'Callback', @(src,eventdata)saveData(src,eventdata,ConductanceMap,PixelXinicioFinal,...
%                         PixelYinicioFinal, Voltaje, ConductanciaCurvaUnica));
%                     
% uicontrol('Style', 'text', 'String', num2str(Columnas*(PixelYinicioFinal(i)-1)+ PixelXinicioFinal(i)),...
%         'Position', [400 180 50 20],...
%         'Callback', @(src,eventdata)saveData(src,eventdata,ConductanceMap,...
%         PixelXinicioFinal, PixelYinicioFinal));
curvaUnicaPlot.Name = 'curvaUnicaFig';
if isReal
    if ~isCurrent
        curvaUnicaPlot.CloseRequestFcn = 'kill_v2';
    end
else
    curvaUnicaPlot.CloseRequestFcn = 'killFFT_v2';
end
% a=findobj('Name', 'mainFig');
hold(ax,'on');
if ~isCurrent
    cross = plot(ax,CoorX,CoorY,'x','MarkerSize',10,'LineWidth',2);
    cross.Tag = 'curvaUnicaFig';
end

end