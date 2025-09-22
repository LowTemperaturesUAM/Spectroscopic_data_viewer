function recoverIVfromrectangles(ax,Info)
try %if the variable is not in workspace it would fail
    Rectangles = evalin("base","AvgRectAreas");
    Filas = numel(Info.DistanciaFilas);
    Columnas = numel(Info.DistanciaColumnas);
    %Check for second deriv maps
    if isfield(Info,'MatrizSecondDeriv')
        
        SecondDeriv = true;
    else
        SecondDeriv = false;
    end
    for i =1:size(Rectangles,1)
        Inicio = Rectangles(i,1:2);
        Final = Rectangles(i,3:4);
        %Convert pixels to distances
        x1 = Inicio(1)/Columnas*Info.DistanciaColumnas(end);
        y1 = Inicio(2)/Filas*Info.DistanciaFilas(end);
        x2 = Final(1)/Columnas*Info.DistanciaColumnas(end);
        y2 = Final(2)/Filas*Info.DistanciaFilas(end);
        [X,Y] = meshgrid(1:Columnas,Filas:-1:1);
        Coordenadas = reshape(1:Filas*Columnas,Columnas,Filas);
        Coordenadas = rot90(Coordenadas); % Indices of every curve in image
        Coordenadas = Coordenadas(X>=Inicio(1) & X<=Final(1) & Y>=Inicio(2) & Y<=Final(2));
        %Apply to conductance
        MeanCond = mean(Info.MatrizNormalizada(:,Coordenadas),2);
        CondFig = plotMeanCurv2(ax,Info.Voltaje,MeanCond,Inicio,Final,'Conductance');
        % Plot the corresponding square
        hold(ax,'on')
        area = plot(ax,[x1 x2 x2 x1 x1],[y1 y1 y2 y2 y1],LineWidth=2);
        area.Tag = 'meandI/dVFig';
        %Apply to current
        MeanCurrent = mean(Info.MatrizCorriente(:,Coordenadas),2);
        CurrentFig = plotMeanCurv2(ax,Info.Voltaje,MeanCurrent,Inicio,Final,'Current');
        if SecondDeriv %Do it for the second derivative, if present
            MeanSecond = mean(Info.MatrizSecondDeriv(:,Coordenadas),2);
            SecondFig = plotMeanCurv2(ax,Info.Voltaje,MeanSecond,Inicio,Final,'Second');
        end
    end
    if SecondDeriv
        linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes,SecondFig.CurrentAxes],'x')
    else
        linkaxes([CondFig.CurrentAxes,CurrentFig.CurrentAxes],'x')
    end
catch
    disp('The variable AvgRectAreas is not present on the workspace')
end
end