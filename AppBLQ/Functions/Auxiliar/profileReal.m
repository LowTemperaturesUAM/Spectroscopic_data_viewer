function profileReal(ax, Struct, k)

Energia = Struct.Energia(k);
Voltaje = Struct.Voltaje;
MapasConductancia = Struct.MapasConductancia;
DistanciaFilas = Struct.DistanciaFilas;
DistanciaColumnas = Struct.DistanciaColumnas;
if isfield(Struct,'Type')
    switch Struct.Type
        case 'Conductance'
            MatrizNormalizada = Struct.MatrizNormalizada;
        case 'Current'
            MatrizNormalizada = Struct.MatrizCorriente;
    end
else
    MatrizNormalizada = Struct.MatrizNormalizada;
end

LineObj = findobj(ax,'Tag','lineProfile');
if isempty(LineObj)
    return
else
    Position = LineObj(1).Position; %Take the last drawn profile
    XinicioFinal = Position(:,1);
    YinicioFinal = Position(:,2);
    [DistanciaPerfil,PerfilActual, ~] = perfilIVPA_v3(MapasConductancia{k},...
        Voltaje,MatrizNormalizada, DistanciaColumnas, DistanciaFilas,...
        XinicioFinal,YinicioFinal,ax.Colormap);
    
    %   REPRESENTACION PERFIL A LA ENERGIA SELECCIONADA
    % ----------------------------
    if isfield(Struct,'Type')
        switch Struct.Type
            case 'Conductance'
                FigPerfil = figure(233);
                clf(FigPerfil)
                FigPerfil.Color = [1 1 1];
                EjePerfil = axes('Parent',FigPerfil,'FontSize',14,'FontName','Arial','FontWeight','bold');
                hold(EjePerfil,'on');
                plot(DistanciaPerfil,PerfilActual,'k--','Parent',EjePerfil);
                scatter(DistanciaPerfil,PerfilActual,100,'Filled','CData',PerfilActual,...
                    'Parent',EjePerfil);
                ylabel(EjePerfil,['Normalized conductance (',num2str(Energia),' mV)'],'FontSize',16);
                xlabel(EjePerfil,'Distance (nm)','FontSize',16);
                box on;
                a=gca;
                a.Colormap = ax.Colormap;
                a.LineWidth = 2;
                a.TickLength(1) = 0.015;
                a.XColor = 'k';
                a.YColor = 'k';
                hold(EjePerfil,'off');
            case 'Current'
                FigPerfil = figure(233);
                clf(FigPerfil)
                FigPerfil.Color = [1 1 1];
                EjePerfil = axes('Parent',FigPerfil,'FontSize',14,'FontName','Arial','FontWeight','bold');
                hold(EjePerfil,'on');
                plot(DistanciaPerfil,PerfilActual,'k--','Parent',EjePerfil);
                scatter(DistanciaPerfil,PerfilActual,100,'Filled','CData',PerfilActual,...
                    'Parent',EjePerfil);
                ylabel(EjePerfil,['Current (',num2str(Energia),' mV)'],'FontSize',16);
                xlabel(EjePerfil,'Distance (nm)','FontSize',16);
                box on;
                a=gca;
                a.Colormap = ax.Colormap;
                a.LineWidth = 2;
                a.TickLength(1) = 0.015;
                a.XColor = 'k';
                a.YColor = 'k';
                hold(EjePerfil,'off');
        end
    else
        FigPerfil = figure(233);
        clf(FigPerfil)
        FigPerfil.Color = [1 1 1];
        EjePerfil = axes('Parent',FigPerfil,'FontSize',14,'FontName','Arial','FontWeight','bold');
        hold(EjePerfil,'on');
        plot(DistanciaPerfil,PerfilActual,'k--','Parent',EjePerfil);
        scatter(DistanciaPerfil,PerfilActual,100,'Filled','CData',PerfilActual,...
            'Parent',EjePerfil);
        ylabel(EjePerfil,['Normalized conductance (',num2str(Energia),' mV)'],'FontSize',16);
        xlabel(EjePerfil,'Distance (nm)','FontSize',16);
        box on;
        a=gca;
        a.Colormap = ax.Colormap;
        a.LineWidth = 2;
        a.TickLength(1) = 0.015;
        a.XColor = 'k';
        a.YColor = 'k';
        hold(EjePerfil,'off');
    end
% uicontrol(meanIVFig,'Style', 'pushbutton', 'String', '<html>Curves to<br>Workspace',...
%                 'Position', [1 1 60 50], 'Callback', @(src,eventdata)curves2Workspace('meanIVRegion'));

%     FigSurfPerfil = figure('Color',[1 1 1]);
%         FigSurfPerfil.Position = [367   286   727   590];
%         EjeSurfPerfil = axes('Parent',FigSurfPerfil,'FontSize',16,'FontName','Arial',...
%             'Position',[0.158351084541563 0.1952 0.651099711483654 0.769800000000001],...
%             'CameraPosition',[0 0 5],...
%             'YTick',[]);
%         hold(EjeSurfPerfil,'on');
%         surf(Voltaje,DistanciaPerfil,CurvasPerfil','Parent',EjeSurfPerfil,'MeshStyle','row',...
%             'FaceColor','interp');
%         xlabel(EjeSurfPerfil,'Bias voltage (mV)','FontSize',18,'FontName','Arial');
%             EjeSurfPerfil.XLim = [min(Voltaje) max(Voltaje)];
%         ylabel(EjeSurfPerfil,'Distance (nm)','FontSize',18,'FontName','Arial','Rotation',90);
%             EjeSurfPerfil.YLim = [min(DistanciaPerfil), max(DistanciaPerfil)];
%         EjeSurfPerfil.ZTick = [];
%         hold(EjeSurfPerfil,'off');
end
end