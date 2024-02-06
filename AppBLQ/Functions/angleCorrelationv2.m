function angleCorrelationv2(Info,k,opts)
arguments
    Info struct
    k (1,1) double {mustBeInteger,mustBePositive}
    opts.Ver string {mustBeMember( opts.Ver,["builtin","serial","opencl"] )} = "builtin"
    opts.Device (1,1) double {mustBeInteger,mustBePositive} = 1
end
% New revision of angle correlation function, using ACF implementation for
% better performance and improved results


% Calculate the autocorrelation and the radial average
fprintf('Calculating autocorrelation for %.2g meV\n', Info.Energia(k))

tic
switch opts.Ver
    case "builtin"
        ACF = autocorr_builtin(Info.MapasConductancia{k});
    case "serial"
        ACF = autocorr_stat(Info.MapasConductancia{k});
    case "opencl"
        % Can be sped up using openCL, if available
        ACF = autocorr_stat_opencl(Info.MapasConductancia{k},opts.Device);
end

[avg_ACF,Rpix]=average_ACF(ACF, 0:0.1:359.9);
toc
%Assuming the pixels are square (or nearly square)
%Which is usually valid for real images (not FFT)
RealSize = min(Info.TamanhoRealColumnas, Info.TamanhoRealFilas);
PixSize = min(size(Info.MapasConductancia{k}));
R = RealSize*Rpix./PixSize;
%Calculate the upper limit for the range of values, avoiding the middle
%value, plus 50% headroom, if it doesn't exceed 1
% UpperLim = max(avg_ACF(normalize(R,'range')>1/PixSize));
UpperLim = min(max(avg_ACF(Rpix>1))*1.50,1);


%Angle plot
G1X = zeros(length(avg_ACF),180);

for i=1:180
    %average over an angle of one degree around a center value i-1
    %sampled every 0.1 degrees
    G1X(:,i) = average_ACF(ACF,-(i-1.5:0.1:i-0.5)+90);
    %Putting the minus here gives the correct criteria for the angle
    %(clockwise and starting from the first quadrant
end
G1X_360 = [G1X,G1X];


% %Plot the autocorrelation map
figure('Name','Angle Correlation Map');
imagesc([-1,1]*Info.TamanhoRealColumnas,[-1,1]*Info.TamanhoRealFilas,ACF)
colorbar
% axis square
ax1=gca;
ax1.YDir = 'normal';
ax1.DataAspectRatio = [1 1 1];
xlabel(ax1,'Displacement (nm)')
ylabel(ax1,'Displacement (nm)')
title(ax1,sprintf('%.2g meV',Info.Energia(k)))
ax1.CLim(1) = max(-UpperLim,ax1.CLim(1));
ax1.CLim(2) = UpperLim;
crameri('vik','pivot',0)

%Plot the radial average
figure('Name','ACF radial average');
plot(R,avg_ACF,'r', LineWidth=1)
ax2=gca;
ax2.XLimitMethod = 'tight';
ax2.YLimitMethod = 'tight';
ax2.YLim(2) = UpperLim;
xlabel(ax2,'Distance (nm)')
ylabel(ax2,'ACF (a.u)')
title(ax2,sprintf('%.2g meV',Info.Energia(k)))

%Plot the angular representation
figure('Name','Angle plot');
imagesc([0,360],[0,RealSize],G1X_360)
colorbar
ax3=gca;
ax3.YDir = 'normal';
ax3.XTick = 0:90:360;
ax3.CLim(1) = max(-UpperLim,ax3.CLim(1));
ax3.CLim(2) = UpperLim;
xlabel(ax3,'Angle')
ylabel(ax3,'Distance (nm)')
title(ax3,sprintf('%.2g meV',Info.Energia(k)))
crameri('vik','pivot',0)


% Save Struct to workspace
CorrelationStruct.G1X_360 = G1X_360;
CorrelationStruct.G1X_XCoord = ax3.Children.XData;
CorrelationStruct.G1X_YCoord = ax3.Children.YData;
CorrelationStruct.angle_avg = [R.',avg_ACF.'];
CorrelationStruct.corr_matrix = ACF;
CorrelationStruct.matrix_XCoord = ax1.Children.XData;
CorrelationStruct.matrix_YCoord = ax1.Children.YData;


assignin('base','CorrelationStruct',CorrelationStruct);

end