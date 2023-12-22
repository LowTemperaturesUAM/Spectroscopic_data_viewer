function [Info] = gapMap(Info,Range,Threshold,NumDeriv)
% Range - Max Voltage value of gap size. It will look below Range for size.
% Threshold - Minimun ratio allowed for gap deepness

% I REMOVE RangeMin AND USE RANGE INSTEAD
%----------------------------------------------------------------------
Filas =  length(Info.DistanciaFilas);
Columnas = length(Info.DistanciaColumnas);
V = Info.Voltaje;
% [~,NCurves] = size(Info.MatrizNormalizada);
Curves = Info.MatrizNormalizada;

% Range = 0.5; %mV
% Threshold = 1.5; %Para el ratio entre el máximo y el mínimo

% Max value for derivative value. Use it to remove noise.
Threshold_deriv = 3 / (Range/3); 
Mask_idx = find(abs(V) <= Range); % Voltage indices between range
Mask = abs(V) <= Range;
% MaskMin = abs(Info.Voltaje) < Range;

% for i=1:NCurves    
%     [Value1,Gap1] = max(Info.MatrizNormalizada(Mask1,i));
%     [Value2,Gap2] = max(Info.MatrizNormalizada(Mask2,i));
%     [Value3,~] = min(Info.MatrizNormalizada(MaskMin,i));
%     
%     Ratio = (((Value1 + Value2)/2)-Value3)/abs(Value3);
%     if Ratio < Threshold
%         VectorGap(i) = 0;
%     else
%         VectorGap(i) = (abs(Info.Voltaje(Mask1(Gap1))) + abs(Info.Voltaje(Mask2(Gap2))))/2;
%     end
% end

% Derivative
ddI = derivadorLeastSquaresPA(NumDeriv,Curves,V,Filas,Columnas);
% Calculate peaks of derivative and take voltage position 
[Val1,Gap1] = max(ddI(Mask_idx,:));
[Val2,Gap2] = min(ddI(Mask_idx,:));

VectorGap = mean([abs(V(Mask_idx(Gap1))), abs(V(Mask_idx(Gap2)))],2);
VectorVal = mean([abs(Val1);abs(Val2)],1);

% Use minima of curve to remove shallow gaps
[Value3] = min(Curves(Mask,:),[],1);
Ratio = (1-Value3)./abs(Value3);

% Turn to 0 really small gaps and noise
VectorGap(Ratio<Threshold | VectorVal>Threshold_deriv) = 0;

% Reshape array into matrix and transpose
MapaGap = reshape(VectorGap,[Columnas,Filas]);
MapaGap = MapaGap';

% Plot the map
fig = figure;
imagesc(Info.DistanciaColumnas,Info.DistanciaFilas,MapaGap,[0 Range]);
xlabell('X'); ylabel('Y');
set(fig.Children,'YDir','normal','DataAspectRatio',[1 1 1]);
% fig.Children.CLim = CScale;
colormap viridis

Info.MapaGap = MapaGap;
end