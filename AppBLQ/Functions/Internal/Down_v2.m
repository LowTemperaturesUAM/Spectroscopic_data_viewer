%Funcion para colocar en WindowsDownButton de la figure del GUI
function  Down_v2(Fig)
    [ax, In] = chooseAxes_v2(Fig);             %Segun la posicion del raton detecto el Axes.
                                            %Si esta dentro de algun Axes.
    if In 

        Origin =ax.CurrentPoint;            %Guardo la posicion de ese click como referencia
        ax.UserData.Origin = Origin(1,1:2); %Lo guardo en el UserData como Origin la X y la Y.
        Fig.UserData.Pressing =1;           %Para estar seguro que se ha pulsado
        Fig.UserData.Axes = ax;            %Guarda en que Axes se ha pulsado

  
    if ~isfield(ax.UserData, 'XLimO')                                            %Guarda el primer XLim e YLim para tenerlo siempre porque
    ax.UserData.XLimO = ax.XLim;                                             %en el mmomento en que entra se crea el UserData.XLim y 
    ax.UserData.YLimO = ax.YLim;                                             %no se puede volver a entrar hasta que se cierra el programa
   % fig.UserData.Pressing     = 0;     

    end
    
    ax.UserData.XLimDown = ax.XLim;    % Guarda los ejes en el momento de pulsar
    ax.UserData.YLimDown = ax.YLim;
    
    end



