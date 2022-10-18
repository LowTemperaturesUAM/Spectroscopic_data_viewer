function profileFFT(ax, Struct, k)
% punteroT = ax.CurrentPoint;

Energia = Struct.Energia;
Transformadas = Struct.Transformadas;
DistanciaFourierFilas = Struct.DistanciaFourierFilas;
DistanciaFourierColumnas = Struct.DistanciaFourierColumnas;
Filas = length(DistanciaFourierFilas);
Columnas = length(DistanciaFourierColumnas);
% SaveFolder = Struct.SaveFolder;
% global Tranformadas
% global Energia
% global Filas
% global Columnas
% global DistanciaFourierColumnas
% global DistanciaFourierFilas
% global SaveFolder
%     
% k = round(get(handles.energySlider,'Value'));

%     if isfield(Struct,'Puntero')
%     	Struct.PunteroFFT = [Struct.Puntero; punteroT(1,1), punteroT(1,2)];
%     else
%         Struct.PunteroFFT = [punteroT(1,1), punteroT(1,2)];
%     end
%     size(handles.Struct.PunteroFFT)

if ~strcmp(ax.Children(1).Tag,'lineProfile')
    return
else
    Position = ax.Children(1).Position;
    XinicioFinal = Position(:,1);
    YinicioFinal = Position(:,2);
    
Tranformadasf = zeros(Columnas,Filas,length(Energia));

    for i = 1:length(Energia)
        Tranformadasf(:,:,i) = Transformadas{i};
    end
    % Con esta vuelta de tuerca podemos usar las mismas funciones. Pasamos
    % los mapas de las FFT como ristras [length(Energia)xFilasxColumnas]
TranformadasfAUX = permute(Tranformadasf,[3 2 1]);
TranformadasfAUX = reshape(TranformadasfAUX,[length(Energia),Filas*Columnas]);

% [DistanciaPerfil,PerfilActual, CurvasPerfil] = perfilIVPA_v2(Transformadas{k}, Energia,TranformadasfAUX, DistanciaFourierColumnas, DistanciaFourierFilas,XinicioFinal,YinicioFinal);
[DistanciaPerfil,PerfilActual, ~] = perfilIVPA_v3(Transformadas{k}, Energia,TranformadasfAUX, DistanciaFourierColumnas, DistanciaFourierFilas,XinicioFinal,YinicioFinal,ax.Colormap);

%   REPRESENTACION PERFIL
    % ----------------------------
    FigPerfil = figure(233);
    clf(FigPerfil)
    FigPerfil.Color = [1 1 1];
    EjePerfil = axes('Parent',FigPerfil,'FontSize',14,'FontName','Arial','FontWeight','bold');
    hold(EjePerfil,'on');
    plot(DistanciaPerfil,PerfilActual,'k--','Parent',EjePerfil);
    scatter(DistanciaPerfil,PerfilActual,100,'Filled','CData',PerfilActual,...
        'Parent',EjePerfil);
    ylabel(EjePerfil,'Intensity','FontSize',16);
    xlabel(EjePerfil,'Distance (nm)','FontSize',16);
    box on;
    a=gca;
    a.Colormap = ax.Colormap;
    a.LineWidth = 2;
    a.TickLength(1) = 0.015;
    a.XColor = 'k';
    a.YColor = 'k';
    hold(EjePerfil,'off');

%     FigSurfPerfil = figure('Color',[1 1 1]);
%         FigSurfPerfil.Position = [367   286   727   590];
%         EjeSurfPerfil = axes('Parent',FigSurfPerfil,'FontSize',16,'FontName','Arial',...
%             'Position',[0.158351084541563 0.1952 0.651099711483654 0.769800000000001],...
%             'CameraPosition',[0 0 5],...
%             'YTick',[]);
%         hold(EjeSurfPerfil,'on');
%         surf(Energia,DistanciaPerfil,CurvasPerfil','Parent',EjeSurfPerfil,'MeshStyle','row',...
%             'FaceColor','interp');
%         xlabel(EjeSurfPerfil,'Bias voltage (mV)','FontSize',18,'FontName','Arial');
%             EjeSurfPerfil.XLim = [min(Energia) max(Energia)];
%         ylabel(EjeSurfPerfil,'Distance (nm)','FontSize',18,'FontName','Arial','Rotation',90);
%             EjeSurfPerfil.YLim = [min(DistanciaPerfil), max(DistanciaPerfil)];
%         EjeSurfPerfil.ZTick = [];
%         hold(EjeSurfPerfil,'off');
end