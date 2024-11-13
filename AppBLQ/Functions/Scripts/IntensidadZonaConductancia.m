
Prueba=MapasConductanciaEqualizados{20};
Prueba(150:250,160:250)=0;
figure (56)
imagesc(Prueba);
a=gca;
a.YDir ='Normal';

%%
Intensidad=zeros(1,length(Energia));
for k=1:length(Energia)
    Intensidad(k) = mean(mean(MapasConductanciaEqualizados{k}(150:250,160:250)));
end

figure (67)
plot(Energia,Intensidad*1000,'o')
a=gca;
a.LineWidth = 2;
FontWeight='bold';
a.XLim=[-89 89];