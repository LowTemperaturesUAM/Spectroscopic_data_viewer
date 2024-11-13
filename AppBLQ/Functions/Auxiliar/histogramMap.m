function histogramMap(Info,k)

fig = figure;
histogram(Info.MapasConductancia{k})

xlabel('\fontsize{18} Normalized conductance')
ylabel('\fontsize{18} Counts')

a = fig.Children;

a.XColor = 'k';
a.YColor = 'k';
a.FontSize = 16;
a.FontName = 'Arial';
a.FontWeight = 'bold';

a.Layer = 'Top';
a.LineWidth = 2;
a.TickLength(1) = 0.015;
