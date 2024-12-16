function secondDeriv(derivPts,Info,opts)
arguments
    derivPts {mustBePositive,mustBeFinite}
    Info struct
    opts.Voltage double = 0
end
[Row,Col] = size(Info.MapasConductancia{1});
dMap = singleDerivMap(Info.Voltaje,Info.MatrizNormalizada,...
    derivPts,opts.Voltage,Row,Col);

f = figure(Name='Second derivative');
f.Position(3:4)=[1000,435];
tiledlayout(1,2,TileSpacing="compact",Padding="compact")
nexttile
imagesc([0,1]*Info.TamanhoRealColumnas,[0,1]*Info.TamanhoRealFilas,dMap)
set(gca,'YDir','normal','DataAspectRatio',[1 1 1])
crameri('vik','pivot',0)
colorbar
axis off

nexttile
histogram(dMap)

