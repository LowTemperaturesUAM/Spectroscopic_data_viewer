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
    [Ny,Nx] = size(Info.MapasConductancia{1});
    IV =numel(Info.Voltaje);
end

mapNr = numel(Info.MapasConductancia);
Vbias = Info.Bias;

f = uifigure;
f.Name = 'Info';
if isfield(opts,'Position')
    f.Position(1:2) = opts.Position;
end
f.Position(3) = 240;
f.Position(4) = 190;
topRow = f.Position(4)-30;
hRow = 15;
wRow = 210;
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
%Get the value an change to the most fitting units
dV = abs(diff(Info.Voltaje([1 end])))/(IV-1);
if dV<0.1
    CurveData = sprintf('Curve size: %d pts (%.4g \x00B5V/pt)',IV,dV*1e3);
else
    CurveData =sprintf('Curve size: %d pts (%.4g mV/pt)',IV,dV);
end
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = CurveData);
i = i +1;
if isfield(Info,'Direction')
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Scan direction: %s',Info.Direction));
i = i +1;
end
if isfield(Info,'Type')
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Map Type: %s',Info.Type));
i = i +1;
end
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = sprintf('Set Point Bias: %.3g mV',Vbias));
i = i +1;


if ~isempty(Struct)
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20], Text = sprintf('Temperature: %g K',Struct.Temperatura));
i = i +1;
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20], Text = sprintf('Field: %g T',Struct.Campo));
i = i +1;
end

if isfield(Info,'PuntosDerivada')
    derivPts = Info.PuntosDerivada;
    width = abs(diff(Info.Voltaje(1:2)))*derivPts;
    if width <0.5
        WidthData = sprintf('Energy Width: %.4g %ceV (%d pts)',width*1e3,char(0xB5),derivPts);
    else
        WidthData = sprintf('Energy Width: %.4g meV (%d pts)',width,derivPts);
    end
    uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],Text = WidthData);
    i = i +1;
end

dE = abs(diff(Info.Energia(1:2)));
if dE <0.2
    EnergyData = sprintf('Map Spacing: %.4g %ceV',dE*1e3,char(0xB5)) ;
else
    EnergyData = sprintf('Map Spacing: %.4g meV',dE) ;
end
uilabel(f,Position=[lPad,topRow - i*hRow, wRow, 20],...
    Text = EnergyData);
% i = i +1;


% uiwait(f)


end
