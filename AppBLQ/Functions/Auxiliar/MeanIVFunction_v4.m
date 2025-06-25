function NewFig = MeanIVFunction_v4(ax, Rectangulo, Matrix, V, DistanciaFilas, DistanciaColumnas, Type)
arguments
    ax  matlab.graphics.axis.Axes
    Rectangulo (1,4)%% check the exact size of this
    Matrix {mustBeFinite,mustBeReal}
    V {mustBeVector}
    DistanciaFilas {mustBeReal,mustBeVector}
    DistanciaColumnas {mustBeReal,mustBeVector}
    Type {mustBeMember(Type,{'Current','Conductance','Second'})}
end

Columnas = numel(DistanciaColumnas);
Filas = numel(DistanciaFilas);

% Turn Rectangulo coordinates into pixels
Rectangulo1([1 3]) = Columnas.*Rectangulo([1 3])./(DistanciaColumnas(end) );
Rectangulo1([2 4]) = Filas.*Rectangulo([2 4])./(DistanciaFilas(end) );
Inicio = [round(Rectangulo1(1)), round(Rectangulo1(2))];
Final = [round(Rectangulo1(1) + Rectangulo1(3)), round(Rectangulo1(2) + Rectangulo1(4))];

% Obtain indices of curves selected with rectangle
[X,Y] = meshgrid(1:Columnas,Filas:-1:1);
Coordenadas = reshape((1:Filas*Columnas),Columnas,Filas);
Coordenadas = rot90(Coordenadas); % Indices of every curve in image
Coordenadas = Coordenadas(X>=Inicio(1) & X<=Final(1) & Y>=Inicio(2) & Y<=Final(2));

% Check if the area covers at least two points
if length(Coordenadas)>1
AvgCur = mean(Matrix(:,Coordenadas),2);

NewFig = plotMeanCurv2(ax,V,AvgCur,Inicio,Final,Type);
% Place figure inside screen if otherwise
movegui(NewFig);

x1=Rectangulo(1);
y1=Rectangulo(2);
a1=Rectangulo(3);
b1=Rectangulo(4);

hold(ax, 'on');

if strcmp(Type,'Conductance') % This condition makes it so the rectangle is only made once
    area = plot(ax,[x1 x1+a1 x1+a1 x1 x1], [y1 y1 y1+b1 y1+b1 y1],'LineWidth',2);
    area.Tag = NewFig.Name;
end

end