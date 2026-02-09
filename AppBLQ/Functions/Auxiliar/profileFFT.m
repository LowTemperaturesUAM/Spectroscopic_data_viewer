function profileFFT(ax, Struct, k)

Energia = Struct.Energia;
Transformadas = Struct.Transformadas;
DistanciaFourierFilas = Struct.DistanciaFourierFilas;
DistanciaFourierColumnas = Struct.DistanciaFourierColumnas;
% Rows = length(DistanciaFourierFilas);
% Cols = length(DistanciaFourierColumnas);
[Rows,Cols] = size(Transformadas{1});
%Convert FFT maps to curves
Curves = toCurves(Transformadas,numel(Energia),Rows,Cols);


LineObj = findobj(ax,'Tag','lineProfile');
if isempty(LineObj)
    return
else
    Position = LineObj(1).Position;
    XinicioFinal = Position(:,1);
    YinicioFinal = Position(:,2);
    ProfileStruct = spectraProfile(Transformadas{k},Energia,Curves,...
        XinicioFinal,YinicioFinal,XCoords = DistanciaFourierColumnas, YCoords = DistanciaFourierFilas);

    FigMap = plotSpectraProfile2D(ProfileStruct,Colormap= ax.Colormap);
    FigSurf = plotSpectraProfile3D(ProfileStruct,Colormap= ax.Colormap);


    FigLine = plotMapProfile(ProfileStruct,Colormap=ax.Colormap,...
        CLim=ax.CLim,FigNumber=234);
    

    %Swap the axis to the reciprocal units
    FigMap.CurrentAxes.YLabel.String = 'Distance (2\pi/nm)';
    FigSurf.CurrentAxes.YLabel.String = 'Distance (2\pi/nm)';
    FigLine.CurrentAxes.XLabel.String = 'Distance (2\pi/nm)';
    FigLine.CurrentAxes.YLabel.String = 'Intensity';

    %relocate the figures for easier visualization
    FigSurf.Position(1) = FigMap.Position(1);
    FigSurf.Position(2) = FigMap.Position(2) - FigMap.Position(4)-85;
    %Shift back into the display, just in case the position doesn't fit
    movegui(FigSurf)
    %Add the energy corresponding to the provided map
    FigLine.Name = sprintf('Profile at %.2f mV',Energia(k));
    Data = struct();
    Data.Distance = ProfileStruct.Distance';
    Data.DistanceX = ProfileStruct.DistanceX';
    Data.DistanceY = ProfileStruct.DistanceY';
    Data.Data = ProfileStruct.generalProfile;

    Data.XCoordinates = XinicioFinal;
    Data.XYCoordinates = YinicioFinal;

    uicontrol(FigMap,'Style', 'pushbutton', 'String', '<html>Profile to<br>Workspace',...
        'Position', [1 1 60 50], 'Callback',...
        {@profile2Workspace,'lineProfileFFT',Data});

end
end
function Curves = toCurves(Maps,pts,Rows,Cols)
    Maps = reshape(Maps,[1 1 numel(Maps)]);
    Temp = cell2mat(Maps);
    Temp = pagetranspose(Temp);
    Temp = permute(Temp,[3,1,2]);
    Curves = reshape(Temp,[pts,Cols*Rows]);

    clear Temp
end

function profile2Workspace(~,~,name,data)
    assignin('base',name,data)
end