%Cuando sueltas el boton del raton segun que boton haya estado pulsado te
%hace ciertas acciones

%Ademas te da una salida con el boton que se ha pulsado por ultima vez y
%si el raotn se ha movido o no desde que se clico hasta que se desclico, de
%esta manera se pueden colocar un funciones extra en el codigo a usar sin
%tener que cambair este
function [ax, Button, Movimiento] = Up_v2(Fig)

[ax, In] = chooseAxes_v2(Fig); 

%Elige el eje donde esta el raton
%ax = Fig.UserData.Axes;


%Fig.UserData.Pressing                                                   
if ax~=0
Puntero = ax.CurrentPoint;                                                  %Guardo la posicion del puntero al soltar
Puntero = Puntero(1,1:2);                                                   %Me quedo con el X e Y
Origin = ax.UserData.Origin;                            %Me guardo la posicion donde se dio el primer click en Down
                                              
Comprobacion = (mean(Puntero - Origin)); 
%Esto es para saber si se ha movido algo o no.

    if Comprobacion
 
    eraseObjects(ax, 'rectangle');                                              %Borro el ultimo recuadro
    end
%ultimoClick = Fig.SelectionType;
Button = Fig.SelectionType;                                                 %Guardo la info de que click se ha dado en el raton
% Esta variable ya tiene el tipo de click, no hace falta definirla en cada case.

Movimiento = logical(Comprobacion); % Sale 0 solo si Comprobacion == 0, i.e. si no se ha movido.

switch Button                                                          % Segun que click distintas acciones
    case 'alt'    %Boton Derecho
                %[ax, In] = chooseAxes(Fig);
               
                if Movimiento
                    
                else
                    
                    if In 
                    ax.XLim = ax.UserData.XLimO;                             %Si das a boton derecho te recupera el XLim e YLim Original
                    ax.YLim = ax.UserData.YLimO;
                    drawnow
                    end
                end
                
            
    case 'normal' %Boton izquierdo                                          %Si das al boton normal y te has movido un poco te cambia el XLim e YLim al XLimC e YLimC
                if Movimiento                                             % guardado dinamicamente en el Current
                    
                    if ax.UserData.XLimC(2) > ax.UserData.XLimC(1) && ax.UserData.YLimC(2)> ax.UserData.YLimC(1) ...                                          
                        
                        ax.XLim = ax.UserData.XLimC;
                        ax.YLim = ax.UserData.YLimC;
                    end     
                else
                    %disp('No te moviste!');                                 %Si no te has movido puedes poner acciones extras
                    
                end
                
    case 'open'   %Doble Click                                               %Si se hace Doble Click    
                  disp('Double Click!') 
                  if Movimiento
                      
                  else
                      
                  end                  
                  
    case 'extend' %Central                                                  %Si se da al central
        if Movimiento   % No se define bien porque se mueven los ejes con el raton
                  ax.XLim = ax.UserData.XLimC ; % Creo que esto corrige los ejes si se desfasan al raton
                  ax.YLim = ax.UserData.YLimC ;
        end
        % Redefino Movimiento para este boton como el cambio en los ejes
        Movimiento = any(ax.XLim ~= ax.UserData.XLimDown) || ...
                    any(ax.YLim ~= ax.UserData.YLimDown);
        if Movimiento
            
        else
            
        end
end
else
 ax = 0;
 Button = 0;
 Movimiento =0;  
end

Fig.UserData.Pressing =0;                                                   %Y se vuelve a no pulsar

    