function readInfoStructParameters(Info,Struct,opts)
arguments
    Info struct
    Struct struct =struct([])
    opts.Position 
end
Lx = Info.TamanhoRealColumnas;
Ly = Info.TamanhoRealFilas;
if ~isempty(Struct)
    Nx = Struct.Columnas;
    Ny = Struct.Filas;
    IV = Struct.IV;
else
    [Ny,Nx] = size(Info.MapasCondutancia{1});
    IV =numel(Info.Voltaje);
end

mapNr = numel(Info.MapasConductancia);
derivPts = Info.PuntosDerivada;
direction = Info.Direction;
Vbias = Info.Bias;

f = uifigure;
f.Name = 'Info';
if isfield(opts,'Position')
    f.Position(1:2) = opts.Position;
end
f.Position(3) = 220;
f.Position(4) = 160;
topRow = f.Position(4)-30;
hRow = 15;
wRow = 180;
lPad = 20;
uilabel(f,Position=[lPad,topRow+5, wRow, 20],...
    Text = 'Image parameters',FontWeight='bold',FontSize=15);
i = 1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Image size (X,Y): (%d,%d)',Nx,Ny));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Real size: %.2fnm x %.2fnm',Lx,Ly));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Curve size: %d pts',IV));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Scan direction: %s',direction));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Map Type: %s',Info.Type));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Set Point Bias: %.2f mV',Vbias));
i = i +1;


if ~isempty(Struct)
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20], Text = sprintf('Temperature: %g K',Struct.Temperatura));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20], Text = sprintf('Field: %g T',Struct.Campo));
i = i +1;
end
% uiwait(f)


end
