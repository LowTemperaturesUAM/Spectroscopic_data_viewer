function qanisotropy(Info,q)
LineasPromedio=1;
    
    LongitudPerfil = length(Info.DistanciaFourierFilas);
    Perfiles = zeros(length(Info.Energia),LongitudPerfil);
    
    step = Info.DistanciaFourierColumnas(2)-Info.DistanciaFourierColumnas(1);
    FourierLength=numel(Info.DistanciaFourierColumnas);
    b=1;

for n=floor(FourierLength/2):FourierLength
   if abs(abs(Info.DistanciaFourierColumnas(n))-q)<step
       elem(b)=n;
       b=b+1;
   end
end

jj=1;
for m=0+90:360+90
    for k=1:length(Info.Energia)
        TransfRot{k}=imrotate(Info.Transformadas{k},m,'crop');
        Perfilillo=zeros(2*LineasPromedio+1,LongitudPerfil);
        cont=1;
        for n=-LineasPromedio:LineasPromedio
            Perfilillo(cont,:)=TransfRot{k}(n+floor(LongitudPerfil/2)+1,:);
            cont=cont+1;
        end
        Perfiles(k,:) = (mean(Perfilillo,1));
        for i=1:length(elem)
            Perfil(:,i)=Perfiles(:,elem(i));
        end
        Perfiltot(:,jj)=mean(Perfil,2);
    end
    jj=jj+1;
end
PerfiltotPlot=0.5*(Perfiltot+flipud(Perfiltot));
ax=0:360;
a=figure;
% imagesc(ax,flipud(Info.Energia),Perfiltot)
imagesc(flipud(Info.Energia),[0,360],Perfiltot')
% axis([0 360 0 10]);
b=gca;

b.Colormap = Info.Colormap;
b.YDir='normal';
b.XLabel.String = '\fontsize{18} Energy (meV)';
b.YLabel.String = '\fontsize{18} \Theta (deg)';
b.LineWidth = 2;
b.FontWeight = 'bold';
b.XColor = 'k';
b.YColor = 'k';
b.FontSize = 14;
b.FontName = 'Arial';
b.YTick = 0:90:360;
% title('q anisotropy')
end