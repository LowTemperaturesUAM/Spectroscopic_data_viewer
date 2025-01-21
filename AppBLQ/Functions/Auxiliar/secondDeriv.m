function secondDeriv(derivPts,Info,opts)
arguments
    derivPts {mustBePositive,mustBeFinite}
    Info struct
    opts.Voltage double = 0
end
% Obtain Rows and Columns from a Map matrix
[Row,Col] = size(Info.MapasConductancia{1});

% In case there is an open map, use current energy for new Map
if ~isempty(findall(0,'Name','Analyze Real Maps'))
    f = findall(0,'Name','Analyze Real Maps');
    opts.Voltage = findobj(f(1),'Type','uiSpinner','BackgroundColor','k').Value;
end

% Calculate map of 2nd derivative
dMap = singleDerivMap(Info.Voltaje,Info.MatrizNormalizada,...
    derivPts,opts.Voltage(1),Row,Col);

% Create figure with map and histogram
f = figure(Name='Second derivative');
f.Position(3:4)=[1000,435];
tiledlayout(1,2,TileSpacing="compact",Padding="compact")
nexttile
imagesc([0,1]*Info.TamanhoRealColumnas,[0,1]*Info.TamanhoRealFilas,dMap)
set(gca,'YDir','normal','DataAspectRatio',[1 1 1])
crameri('vik','pivot',0)
colorbar
axis off
title(opts.Voltage(1)+" meV") % Indicate map energy

nexttile
histogram(dMap)

