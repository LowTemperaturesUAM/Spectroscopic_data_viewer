fig = figure(2);
ax = fig.Children;

for i=1:5
    QPI.Vertical.Peaks{i}(:,1) = ax.Children(i).XData;
    QPI.Vertical.Peaks{i}(:,2) = ax.Children(i).YData;
% QPI.Vertical.Peaks{i} = 
end

%%
fig = gcf;
XData = fig.Children.Children.XData;
YData = fig.Children.Children.YData;
CData = fig.Children.Children.CData;

%%
CDataSmooth = imgaussfilt(CData,1);

fig = figure;

imagesc(XData,YData/0.35-0.73,CDataSmooth)
b = fig.Children;
b.YDir = 'normal';
colormap hot
b.CLim = [-0.01 0.05];

b.YLabel.String = '\fontsize{15} Distance (a_{0})';
% b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.XLabel.String = '\fontsize{15} Energy (meV)';
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.FontWeight = 'bold';
% b.XLim = [-1 1];
b.YLim = [0 5.25];
% b.CLim = [0 255];
set(gca ,'Layer', 'Top')
%%
fig = gcf;
fig.CloseRequestFcn = 'delete(fig)';
b = fig.Children(end);
Voltage = b.Children.XData;
Conductance = b.Children.YData;
%%
fig = figure;
hold on
plot(Voltage14,Conductance14*1000,'k','LineWidth',1.5)

ConductanceSmoothMal = imgaussfilt(Conductance14,10);
% plot(VoltageSmoothResized, ConductanceSmoothResized*1000,'r','LineWidth',1.5)
plot(Voltage14, ConductanceSmoothMal*1000,'r','LineWidth',1.5)

b = fig.Children;
b.Box = 'on';
b.YLabel.String = '\fontsize{15} Conductance (nS)';
% b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.XLabel.String = '\fontsize{15} Bias Voltage (mV)';
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.FontWeight = 'bold';
b.XLim = [-95 95];
% b.YLim = [0 5.25];
% b.CLim = [0 255];
set(gca ,'Layer', 'Top')

fig = figure;
hold on
ConductanceNorm = Conductance14-ConductanceSmoothMal;
plot(Voltage14,ConductanceNorm*1000,'b','LineWidth',1.5)

ConductanceNormSmooth = imgaussfilt(ConductanceNorm,10);
plot(Voltage14,ConductanceNormSmooth*1000,'r','LineWidth',1.5)
ConductanceNormNorm = ConductanceNorm-ConductanceNormSmooth;
plot(Voltage14,ConductanceNormNorm*1000,'k','LineWidth',1.5)

L=512;
Fs=512/(200);
f=Fs*(0:L/2)/L;

YTop1=fft(ConductanceNormNorm); 
P2Top1=abs(YTop1/L);
P1Top1=P2Top1(1:L/2+1);
P1Top1(2:end-1)=2*P1Top1(2:end-1);

figure
plot(f,P1Top1)

b = fig.Children;
b.Box = 'on';
b.YLabel.String = '\fontsize{15} Conductance (nS)';
% b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.XLabel.String = '\fontsize{15} Bias Voltage (mV)';
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.FontWeight = 'bold';
b.XLim = [-95 95];
% b.YLim = [0 5.25];
% b.CLim = [0 255];
set(gca ,'Layer', 'Top')
%%
fig = figure;
plot(Filter(:,1)*1e6,Filter(:,2),'k','LineWidth',1)
b = fig.Children;
b.Box = 'on';
b.YLabel.String = '\fontsize{12} Power (dB)';
% b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.XLabel.String = '\fontsize{12} Frequency (Hz)';
b.LineWidth = 1;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.FontWeight = 'bold';
b.XLim = [1000 1e10];
b.XScale = 'log';
b.YLim = [-60 5];
% b.CLim = [0 255];
set(gca ,'Layer', 'Top')
%%
fig = gcf;

Voltage14 = fig.Children.Children(end).XData;
Conductance14 = fig.Children.Children(end).YData;

Voltage11 = fig.Children.Children(1).XData;
Conductance11 = fig.Children.Children(1).YData;

%%
Normalization = 0.14;

Conductance14Norm = Conductance14/Normalization;
Conductance11Norm = Conductance11/Normalization;

fig = figure;
hold on

plot(Voltage11,Conductance11Norm,'LineWidth',1.5)
plot(Voltage14,Conductance14Norm,'LineWidth',1.5)

b = fig.Children;
b.Box = 'on';
b.YLabel.String = '\fontsize{15} Normalized Conductance (arb. units)';
% b.XLabel.String = '\fontsize{15} k_{x} (\pi/a)';
b.XLabel.String = '\fontsize{15} Energy (meV)';
b.LineWidth = 2;
b.XColor = [0 0 0];
b.YColor = [0 0 0];
b.FontWeight = 'bold';
b.XLim = [-97 97];
% b.XScale = 'log';
% b.YLim = [-60 5];
% b.CLim = [0 255];
set(gca ,'Layer', 'Top')
% b.XGrid = 'on';

%% Offsetear a mano

Offset11 = 0;
Offset14 = 0.1;

fig.Children.Children(end).YData = fig.Children.Children(end).YData + Offset11;
fig.Children.Children(1).YData = fig.Children.Children(1).YData + Offset14;

%% Phase difference maps
fig = gcf;
VectorIni = linspace(1.5,3,128);
VectorUp = linspace(3,2,128);
VectorDown = linspace(2,1,128);
VectorLast = linspace(1,1,128);
VectorNorm = [VectorIni VectorUp VectorDown VectorLast];
% fig.Children.Children.CData = fig.Children.Children.CData*2;
for i=1:512
    fig.Children.Children.CData(:,i) = fig.Children.Children.CData(:,i)./VectorNorm(i)*0.5;
end

%% Phase difference curves
%%
fig = gcf;
VectorIni = linspace(1.5,3,128);
VectorUp = linspace(3,2,128);
VectorDown = linspace(2,1,128);
VectorLast = linspace(1,1,128);
VectorNorm = [VectorIni VectorUp VectorDown VectorLast];
% fig.Children.Children.CData = fig.Children.Children.CData*2;
for i=1:512
    fig.Children(end).Children(1).YData(i) = fig.Children(end).Children(1).YData(i)./VectorNorm(i);
end
%%
Voltage = fig.Children(end).Children(1).XData;
Conductancia = fig.Children(end).Children(1).YData;

