function angleCorrelation(Info,k)

MatrizTopo = Info.MapasConductancia{k};

tam=length(MatrizTopo);
tam_diag=ceil(sqrt(2)*tam);
NX=zeros(tam_diag,180);
I1promX=NX;
I2promX=NX;
var1promX=NX;
var2promX=NX;

fprintf('Calculating autocorrelation for %.2g meV\n', Info.Energia(k))
waitw = waitbar(0,'Calculating autocorrelation',Name='Please, wait',...
    CreateCancelBtn=@(~,~)setappdata(gcbf,'canceling',1));
setappdata(waitw,'canceling',0);
tic
for i1=1:tam
%     disp(['k = ',num2str(k),'; i1 = ',num2str(i1)])
    if getappdata(waitw,'canceling')
        delete(waitw)
        disp('Operation cancelled')
        return
    end
    if mod(i1,10) == 0
        waitbar(0.5*i1/tam,waitw)
    end
    for j1=1:tam
        for i2=1:tam
            for j2=1:tam
                r=ceil(sqrt((i1-i2)^2+(j1-j2)^2));
                if r~=0
                    if j2==j1
                        ang=90;
                    elseif i2==i1
                        ang=180;
                    else
                        ang=ceil(atand((i1-i2)/(j2-j1)));
                        if ang<=0
                            ang=ang+180;
                        end
                    end
                    I1promX(r,ang)=I1promX(r,ang)+MatrizTopo(i1,j1);
                    I2promX(r,ang)=I2promX(r,ang)+MatrizTopo(i2,j2);
                    var1promX(r,ang)=var1promX(r,ang)+MatrizTopo(i1,j1)^2;
                    var2promX(r,ang)=var2promX(r,ang)+MatrizTopo(i2,j2)^2;
                    NX(r,ang)=NX(r,ang)+1;
                end
            end
        end
    end
end

SX=zeros(tam_diag,180);
G1X=SX;
G2X=SX;
I1=SX;
I2=SX;
I1prom_finX=(1./NX).*I1promX;
I2prom_finX=(1./NX).*I2promX;
var1prom_finX=((1./NX).*var1promX)-(I1prom_finX.^2);
var2prom_finX=((1./NX).*var2promX)-(I2prom_finX.^2);



for i1=1:tam
%     disp(['k = ',num2str(k),'; i2 = ',num2str(i1)])
    if getappdata(waitw,'canceling')
        delete(waitw)
        disp('Operation cancelled')
        return
    end
    if mod(i1,10) == 0
        waitbar((1+i1/tam)*0.5,waitw)
    end
    for j1=1:tam
        for i2=1:tam
            for j2=1:tam
                r=ceil(sqrt((i1-i2)^2+(j1-j2)^2));
                if r~=0
                    if j2==j1
                        ang=90;
                    elseif i2==i1
                        ang=180;
                    else
                        ang=ceil(atand((i1-i2)/(j2-j1)));
                        if ang<=0
                            ang=ang+180;
                        end
                    end
                SX(r,ang)=SX(r,ang)+((MatrizTopo(i1,j1)-I1prom_finX(r,ang))*(MatrizTopo(i2,j2)-I2prom_finX(r,ang)))/(sqrt(var1prom_finX(r,ang))*sqrt(var2prom_finX(r,ang)));
                end
            end
        end
    end
end
toc
delete(waitw)

mult=1;
for n=1:tam_diag
    for m=1:180
        if NX(n,m)==0
            NX(n,m)=1;
            G1X(n,m)=mult.*(1./NX(n,m)).*SX(n,m);
        else
            G1X(n,m)=mult.*(1./NX(n,m)).*SX(n,m);
        end
    end
end
Matriz_Existe_Angulo=zeros(tam,180);
for p=1:180
    for q=1:tam
        if G1X(q,p)==0
            Matriz_Existe_Angulo(q,p)=0;
        else
            Matriz_Existe_Angulo(q,p)=1;
        end
    end
end
Nnorm=sum(Matriz_Existe_Angulo,2);
G1X_prom=sum(G1X(1:tam,:),2);
G1X_prom_norm=G1X_prom./Nnorm;
G1X_plot=G1X(1:tam,180:-1:1);

G1X_360=[G1X_plot,G1X_plot];

G1X_polar=(flipud(G1X_360))';
[nrow, ncol] = size(G1X_polar);
radii = repmat( ncol : -1 : 1, nrow, 1);
theta = repmat( (0:nrow-1).' ./ (nrow-1) * 2 * pi, 1, ncol);
[x, y] = pol2cart(theta, radii);
min_x = min(x(:));
min_y = min(y(:));
round_matrix = accumarray( [round( y(:) - min_y) + 1, round( x(:) - min_x) + 1], G1X_polar(:), [], @mean );

%   El programa tiene fundamentalmente tres output relevantes:
%   - G1X_360 es la matriz de la ACF de dimensión [tam X 360], donde cada 
%   (i,j) representa las correlaciones totales  en la imagen a un determinado
%   (r,theta). En este caso las filas representarían distancia creciente y
%   las columnas ángulos. Hay elementos cero en esta matriz porque puede
%   ser que no exista ningún par de pixeles a una determinada distancia y
%   ángulo, esto pasa especialmente para distancias cortas.
%   - G1X_prom_norm es un vector que expresa la autocorrelación como
%   función de la distancia, sumando todos ángulos y normalizando por los
%   elementos distintos de cero de G1X_360. Podría hacerse también para
%   todas las distancias en función del ángulo, solamente cambiando la
%   suma de Nnorm, que son los elementos distintos de cero, calculados en
%   Matriz_Existe_Angulo.
%   - round_matrix simplemente coge G1X_360 y le aplica una transformación
%   de warping para convertirla en una "imagen" de autocorrelación donde el
%   centro de la matriz es distancia cero y crece hacia los bordes.

% Lo pinto todo

TamanhoReal = Info.TamanhoRealFilas; % Si no fuera cuadrada habría que ver si filas o columnas
%
figure
imagesc(MatrizTopo)
xlabel('Distance (nm)')
ylabel('Distance (nm)')
colorbar

ax1=gca;
ax1.YDir = 'normal';
axis square

ax1.Children.XData = [0, TamanhoReal];
ax1.Children.YData = [0, TamanhoReal];

ax1.XLim = [0, TamanhoReal];
ax1.YLim = [0, TamanhoReal];
ax1.CLim = [Info.ContrastReal(1,k), Info.ContrastReal(2,k)];

ax1.Colormap = Info.Colormap;

figure
imagesc(G1X_360)
xlabel('Angle')
ylabel('Distance (nm)')
colorbar

ax2=gca;
ax2.YDir = 'normal';

ax2.XTick = 0:90:360;
ax2.Children.YData = [0, TamanhoReal];
ax2.YLim = [0, TamanhoReal];

ax2.Colormap = Info.Colormap;

figure
plot(G1X_prom_norm,'r','linewidth',1)
xlabel('Distance (nm)')
ylabel('ACF (a.u.)')
axis([0 tam min(G1X_prom_norm) max(G1X_prom_norm)])
ax3 = gca;
ax3.Children.XData = TamanhoReal.*ax3.Children.XData./tam;
ax3.XLim = [0, TamanhoReal];

figure
imagesc(round_matrix)
xlabel('Distance (nm)')
ylabel('Distance (nm)')
% colormap inferno
colorbar
ax4=gca;
ax4.YDir = 'normal';
axis('square')

ax4.Children.XData = [-TamanhoReal, TamanhoReal];
ax4.Children.YData = [-TamanhoReal, TamanhoReal];

ax4.XLim = [-TamanhoReal, TamanhoReal];
ax4.YLim = [-TamanhoReal, TamanhoReal];

ax4.Colormap = Info.Colormap;

% Save Struct to workspace
CorrelationStruct.G1X_360 = G1X_360;
CorrelationStruct.G1X_XCoord = ax2.Children.XData;
CorrelationStruct.G1X_YCoord = ax2.Children.YData;
CorrelationStruct.angle_avg = [ax3.Children.XData.',G1X_prom_norm];
CorrelationStruct.corr_matrix = round_matrix;
CorrelationStruct.matrix_XCoord = ax4.Children.XData;
CorrelationStruct.matrix_YCoord = ax4.Children.YData;

assignin('base','CorrelationStruct',CorrelationStruct);

end