function Result = angleProfile(Info,angle,opt)
arguments
    Info struct
    angle double {mustBeReal,mustBeScalarOrEmpty}
    opt.FigNumber {mustBePositive,mustBeInteger}= 54536
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.Mode {mustBeMember(opt.Mode,{'single','double'})} = 'double'
    opt.Lattice {mustBeMember(opt.Lattice,{'square','hexagonal'})} = 'square'
    opt.kLim {mustBeMember(opt.kLim,{'auto','bragg','brillouin'})} = 'bragg'
end

kmax = min(max(Info.DistanciaFourierColumnas), ...
    max(Info.DistanciaFourierFilas)); %Get the FFT limit for the smaller axis
%Make sure the profile always goes through the zero value
switch opt.Mode
    case 'double' %negative and positive K
        wrapAngle = wrapTo180(angle*2)/2; %allow only for half turn
        kmin = -kmax;
        xi = [kmin,kmax]*cosd(wrapAngle);
        yi = [kmin,kmax]*sind(wrapAngle);
    case 'single' %only to one side of the origin
        wrapAngle = wrapTo180(angle); %allow for the whole circunference
        kmin = 0;
        xi = [0,kmax]*cosd(wrapAngle);
        yi = [0,kmax]*sind(wrapAngle);
end

L1 = cosd(wrapAngle)*255;
L2 = sind(wrapAngle)*255;
%Make then odd integers
N1 = round(L1 + (mod(L1,2)<1));
N2 = round(L2 + (mod(L2,2)<1));
ProfileLength = max(N1,N2);

[xp,yp,~] = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{1},xi,yi,ProfileLength,opt.Method);


Profiles = zeros(length(Info.Energia),ProfileLength);
for k=1:numel(Info.Energia)
    Profiles(k,:) = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{k},xi,yi,ProfileLength,opt.Method);
end


%Save to a struct
QPI.Map = Profiles;
if all(sign(xp)==0)
    QPI.K = (sqrt(xp.^2+yp.^2).*sign(yp)).';
else
    QPI.K = (sqrt(xp.^2+yp.^2).*sign(xp)).';
end

%we always refer to the lattice parameter for the x axis
% that we commonly refer to as b
switch opt.Lattice
    case 'square'
        QPI.q = QPI.K*2*Info.ParametroRedColumnas;
    case 'hexagonal'
        QPI.q = QPI.K*2*Info.ParametroRedColumnas*sqrt(3)/2; %está al reves??
end
QPI.Energy = Info.Energia;
QPI.Angle = wrapAngle;

a = figure(opt.FigNumber);
a.Name = 'Angle Profile';
imagesc(QPI.q([1 end]),QPI.Energy([1 end]),Profiles)
b=a.CurrentAxes;
b.Colormap = Info.Colormap;
b.YDir='normal';
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.LineWidth = 2;
b.FontWeight = 'bold';
b.FontName = 'Arial';
b.FontSize = 14;
b.TickDir = 'out';
% Info.ContrastFFT(:,(end+1)/2)
b.CLim = Info.ContrastFFT(:,ceil((end+1)/2)); %Take the contrast from the map in the middle

b.YLabel.String = 'Energy (meV)';
b.YLabel.FontSize = 18;
switch opt.Lattice
    case 'square'
        b.XLabel.String = 'q_{\theta} (\pi/b)';
    case 'hexagonal'
        b.XLabel.String = 'q_{\theta} (\surd{3}/2 \pi/b)';
end
b.XLabel.FontSize = 18;

%Fix the limits with respect to the unit cell, or leave the auto otherwise
switch opt.kLim
    case 'bragg'
        switch opt.Mode
            case 'double' %negative and positive K
                b.XLim = [-2,2]; %up to the bragg peaks
            case 'single' %only to one side of the origin
                b.XLim = [-1,1]-sign(QPI.q(end)); %up to the bragg peaks on a single side
        end
    case 'brillouin'
        switch opt.Mode
            case 'double' %negative and positive K
                b.XLim = [-1,1]; %up to the edge of the 1st brillouin zone
            case 'single' %only to one side of the origin
                b.XLim = 0.5*([-1,1]-sign(QPI.q(end))); %up to the edge of the 1st BZ on a single side
        end
end

%Return the struct, or send it to the workspace if no output exist
if nargout == 0
    assignin('base','QPIAngle',QPI)
else
    Result = QPI;
end

end

