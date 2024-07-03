function angleProfile(Info,angle,opt)
arguments
    Info struct
    angle double {mustBeReal,mustBeScalarOrEmpty}
    opt.FigNumber {mustBePositive,mustBeInteger}= 54536
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.Mode {mustBeMember(opt.Mode,{'single','double'})} = 'double'
    opt.Lattice {mustBeMember(opt.Lattice,{'square','hexagonal'})} = 'square'
end

kmax = min(max(Info.DistanciaFourierColumnas), ...
    max(Info.DistanciaFourierFilas));
switch opt.Mode
    case 'double' %negative and positive K
        %Doesn't go through 0
        % kmin = min(min(Info.DistanciaFourierColumnas), ...
        %     min(Info.DistanciaFourierFilas),ComparisonMethod="abs")
        wrapAngle = wrapTo180(angle*2)/2; %allow only for half turn
        kmin = -kmax;
    case 'single' %only to one side of the origin
        wrapAngle = wrapTo180(angle); %allow for the whole circunference
        kmin = 0;
end



xi = [kmin,kmax]*cosd(wrapAngle);
yi = [kmin,kmax]*sind(wrapAngle);

[xp,yp,profile] = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{1},xi,yi,opt.Method);
disp(size(profile))
LongitudPerfil = length(profile);
Perfiles = zeros(length(Info.Energia),LongitudPerfil);
for k=1:numel(Info.Energia)
    Perfiles(k,:) = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{k},xi,yi,opt.Method);
end




QPI.Map = Perfiles;
QPI.K = (sqrt(xp.^2+yp.^2).*sign(xp)).';
switch opt.Lattice
    case 'square'
        QPI.q = QPI.K*2*Info.ParametroRedColumnas;
    case 'hexagonal'
        QPI.q = QPI.K*2*Info.ParametroRedColumnas*2/sqrt(3);
end
QPI.Energy = Info.Energia;
QPI.Angle = wrapAngle;

a = figure(opt.FigNumber);
a.Name = 'Angle Profile';
imagesc(QPI.q([1 end]),QPI.Energy([1 end]),Perfiles)
b=gca;
b.Colormap = Info.Colormap;
b.YDir='normal';
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.YLabel.String = '\fontsize{18} Energy (meV)';
switch opt.Lattice
    case 'square'
        b.XLabel.String = '\fontsize{18} q_{\theta} (\pi/b)';
    case 'hexagonal'
        b.XLabel.String = '\fontsize{18} q_{\theta} (\sqrt(3)/2\pi/b)';
end
b.LineWidth = 2;
b.FontWeight = 'bold';
b.FontName = 'Arial';
b.FontSize = 14;
b.TickDir = 'out';
b.CLim = Info.ContrastFFT(:,(end+1)/2); %Usamos el contraste a 0 mV para empezar
switch opt.Mode
    case 'double' %negative and positive K
        b.XLim = [-2,2]; %up to the bragg peaks
    case 'single' %only to one side of the origin
        b.XLim = [-1,1]-sign(QPI.q(end)); %up to the bragg peaks on a single side
end

assignin('base','QPIAngle',QPI)
end

