function Result = verticalProfileV2(Info,opt)
arguments
    Info struct
    opt.FigNumber {mustBePositive,mustBeInteger} = 54533
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.Mode {mustBeMember(opt.Mode,{'single','double'})} = 'double'
    opt.Lattice {mustBeMember(opt.Lattice,{'square','hexagonal'})} = 'square'
    opt.kLim {mustBeMember(opt.kLim,{'auto','bragg','brillouin'})} = 'brillouin'
end

kmax = max(Info.DistanciaFourierFilas); %Get the FFT limit
switch opt.Mode
    case 'double' %negative and positive K
        kmin = -kmax;
        % There should be one more point on the negative side corresponding to the
        % Nyquist frequency, but its better to ignore it by default or we will go out of
        % bounds on the positive side
        %Just in case, we are going to fix the number of points of the profile,
        % because it seems to miss the middle sometimes...
        ProfileLength = numel(Info.DistanciaFourierFilas)-1;
    case 'single' %only to one side of the origin
        kmin = 0;
        ProfileLength = ceil(numel(Info.DistanciaFourierFilas)/2);
end

xi = [0,0];
yi = [kmin,kmax];

[~,yp,~] = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{1},xi,yi,ProfileLength,opt.Method);

Profiles = zeros(length(Info.Energia),ProfileLength);

for k=1:numel(Info.Energia)
    Profiles(k,:) = improfile(Info.DistanciaFourierColumnas([1 end]),...
    Info.DistanciaFourierFilas([1 end]),Info.Transformadas{k},xi,yi,ProfileLength,opt.Method);
end

%Save to a struct
QPI.Map = Profiles;
QPI.K = yp.';
%we always refer to the lattice parameter for the y axis
% that we commonly refer to as a
switch opt.Lattice
    case 'square'
        QPI.q = QPI.K*2*Info.ParametroRedFilas;
    case 'hexagonal'
        QPI.q = QPI.K*2*Info.ParametroRedFilas*sqrt(3)/2; %está al reves??
end
QPI.Energy = Info.Energia;


a = figure(opt.FigNumber);
a.Name = 'Vertical Profile';
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
        b.XLabel.String = 'q_{y} (\pi/a)';
    case 'hexagonal'
        b.XLabel.String = 'q_{y} (\surd{3}/2 \pi/a)';
end
b.XLabel.FontSize = 18;

%Fix the limits with respect to the unit cell, or leave the auto otherwise
switch opt.kLim
    case 'bragg'
        switch opt.Mode
            case 'double' %negative and positive K
                b.XLim = [-2,2]; %up to the bragg peaks
            case 'single' %only to one side of the origin
                b.XLim = [0,2]; %up to the bragg peaks on a single side
        end
            case 'brillouin'
        switch opt.Mode
            case 'double' %negative and positive K
                b.XLim = [-1,1]; %up to the bragg peaks
            case 'single' %only to one side of the origin
                b.XLim = [0,1]; %up to the bragg peaks on a single side
        end
end

%Return the struct, or send it to the workspace if no output exist
if nargout == 0
    assignin('base','QPIVertical',QPI)
else
    Result = QPI;
end

end

