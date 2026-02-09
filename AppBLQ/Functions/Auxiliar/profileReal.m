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

    %Obtain the simultaneous profile of the map and all the curves
    ProfileStruct = spectraProfile(MapasConductancia{k},Voltaje,MatrizNormalizada,...
        XinicioFinal,YinicioFinal,XCoords = DistanciaColumnas, YCoords = DistanciaFilas);
    %Create the different representation of the obtained data
    FigMap = plotSpectraProfile2D(ProfileStruct,Colormap= ax.Colormap);
    FigSurf = plotSpectraProfile3D(ProfileStruct,Colormap= ax.Colormap);

    if isfield(Struct,'Type')
        FigLine = plotMapProfile(ProfileStruct,profileMagnitude=Struct.Type,...
            Colormap=ax.Colormap,CLim=ax.CLim);
    else
        FigLine = plotMapProfile(ProfileStruct,Colormap=ax.Colormap,CLim=ax.CLim);
    end
    %relocate the figures for easier visualization
    FigSurf.Position(1) = FigMap.Position(1);
    FigSurf.Position(2) = FigMap.Position(2) - FigMap.Position(4)-85;
    %Shift back into the display, just in case the position doesn't fit
    movegui(FigSurf)
    %Add the energy corresponding to the provided map
    FigLine.Name = sprintf('Profile at %.2f mV',Energia);

    Data = struct();
    Data.Distance = ProfileStruct.Distance';
    Data.DistanceX = ProfileStruct.DistanceX';
    Data.DistanceY = ProfileStruct.DistanceY';
    Data.Data = ProfileStruct.generalProfile;

    Data.XCoordinates = XinicioFinal;
    Data.XYCoordinates = YinicioFinal;
    %We can take the X and XY coordinates, and get back the line position, in
    %order to place it in the exact same place again to repeat the profile
    %Add button to the colorplot, that allows to export the data into the
    %workspace
    uicontrol(FigMap,'Style', 'pushbutton', 'String', '<html>Profile to<br>Workspace',...
                'Position', [1 1 60 50], 'Callback',...
                {@profile2Workspace,'lineProfileReal',Data});
end
end

function profile2Workspace(~,~,name,data)
    assignin('base',name,data)
end