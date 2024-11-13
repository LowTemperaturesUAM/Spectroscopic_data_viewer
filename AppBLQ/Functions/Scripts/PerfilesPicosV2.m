Kind = 'Vertical';

Map = QPI0.(Kind).Map;
K = QPI0.(Kind).K;
%fl = QPI.(Kind).Fit;
%K = linspace(-256/75.3, +256/75.3, 513)*0.384;
Energy = QPI0.(Kind).Energy;


%%
% Map filtered
a = figure(57);
Map1 =rescale(Map);
 imagesc(K, Energy, Map1)
%pcolor(K, Energy, Map1)
for i = 1:size(Map1,1)
 C1Fit(i,:) = smoothdata(Map(i,:),'gaussian',4);
 C{i} = smoothdata(Map(i,:),'gaussian',4);
end

 imagesc(K, Energy, C1Fit)
% xlabel('Radial Momentum (\pi /a)')
 %ylabel('Energy (mV)')
%colormap(jet)
set(gca,'YDir','normal')
a.Children.FontSize = 10;
a.Children.CLim = [10  80];
a.Children.XLim = [-1.42 1.42];
%a.Children(12).XTick = [ -0.6 -0.4 -0.2 0 0.2 0.4 0.6 ];






%% Choose Peaks 


f = figure; 
f.UserData.Points = [0 0];
f.UserData.Energy = Energy;
f.UserData.number = 1;

f.WindowButtonDownFcn = 'SaveClick';
f.WindowKeyPressFcn = @PassNumber;
% 

 f.UserData.C = C;
 f.UserData.X = K;
%f.UserData.Peaks = QPI.(Kind).Peaks;
 %f.UserData.Peaks =Pik;
    plot(K, C{1}, '.-')
    title(['Energy: ', num2str(Energy(1))])
    axis square
xlim([-1.42 1.42])
  


q10 = f.UserData.Points;





%% Observe chosen points
figure(21)
hold on
plot( f.UserData.Points(2:end, 2),f.UserData.Points(2:end, 1), 'o')
% xlim([-0.6 0])

%% Save peaks


QPI0.(Kind).Peaks{1} =[ f.UserData.Points(2:end, 2),f.UserData.Points(2:end, 1)];


%% Only chosen

EnergyC = [-25 -20 -17 -5 4 6 9 15 18 19 20 24 25];


EnergyC = Energy;

figure(28)
hold on
Curvas = [1:57];
color = winter(length(Curvas));
color1 = gray(length(Curvas));
cont = 20;
paso = 0.000;
    color = [{[1 0 0]}, {[0 1 0]}, {[0 0 1]}, {[0 0 0]},  {[0 1 1]}];
figure(145)
for i = 1:length(EnergyC)

    header{2*i} = [num2str(EnergyC(i))]
    inE = find(Energy == EnergyC(i));
% newcolor = [propo(Curvas(i),:)'.*color1(i,1), propo(Curvas(i),:)'.*color1(i, 2), propo(Curvas(i),:)'.*color1(i, 3)];
% newcolor = [propo(Curvas(i),:)', propo(Curvas(i),:)', propo(Curvas(i),:)'];
  C1 = smoothdata(Map(inE,:),'gaussian',8);

  ToSave(1:length(K),i) = [C1'];
  for j = 1:5
      if find(QPI.Vertical.Peaks{j}(:,2) == Energy(inE))
        
          indice = find(QPI.Vertical.Peaks{j}(:,2) == Energy(inE));
          points{j} = QPI.Vertical.Peaks{j}(indice,1) ;
          [~, indiceK] = min( abs(points{j} -K));
          
      else
          points{j} = 0;
          [~, indiceK] = min(abs(points{j} -K));
      end
  end



 % C1Fit = smoothdata(Map(Curvas(i),:),'gaussian',20);


if i ==36
    
    plot(K, C1+ i*paso, '.-', 'Color', 'r', 'lineWidth', 2, 'MarkerSize', 10)
    hold on
    for j = 1:5
        if points{j}
           plot(points{j}, C1(indiceK) + i*paso, 'ro')
        end
    
    end
    
else
    
plot(K, C1+ i*paso, '.-', 'Color', 'k', 'lineWidth', 2, 'MarkerSize', 10)
hold on

    for j = 1:5
        if points{j}
           %plot(points{j}, C1(indiceK)+i*paso, 'ro', 'MarkerFaceColor',color{j})
        end
    
    end

end
% plot(K, CFit+ i*0.003, '.-', 'Color', 'r', 'lineWidth', 2, 'MarkerSize', 10)
% hold on
% 
 %scatter(KRadio*pi, C+ i*0.003, 10, newcolor, 'filled', 'MarkerEdgeColor', 'k' )

%plot3(KRadio2*pi, linspace(i*0.01,i*0.01, length(KRadio2)),Map2(Curvas(i),:)  , '.-', 'Color', color(i, :), 'lineWidth', 3, 'MarkerSize', 20 )

hold on
Energy(inE)

end
axis square
xlim([-0.5 0.5])
% 
Savheader = [header; num2cell(ToSave)];
SaveH = cell2table(Savheader);
writetable(SaveH,'0T.txt')






