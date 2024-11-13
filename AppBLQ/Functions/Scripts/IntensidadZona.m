
Prueba=TransformadasSimetrizadas{41};
Prueba(137:140,140:143)=0;
figure (55)
imagesc(Prueba);
a=gca;
a.YDir ='Normal';

%%
Intensidad=zeros(1,length(Energia));
for k=1:length(Energia)
    Intensidad(k)=mean(mean(TransformadasSimetrizadas{k}(137:140,140:143)))
end

figure (67)
plot(Energia,Intensidad/1e-4,'o')
a=gca;
