function [Struct] = changeCurves(App, Struct)

Columnas = Struct.Columnas;
Filas = Struct.Filas;
NumeroCurvasValue = App.CurvestoshowEditField.Value;

i = 1+round(rand(NumeroCurvasValue,1)*(Columnas-1)); % Random index for curve selection
j = 1+round(rand(NumeroCurvasValue,1)*(Filas-1));    % Random index for curve selection

MatrizCorrienteTest = zeros(length(Struct.Voltaje),NumeroCurvasValue);
        
for count = 1:NumeroCurvasValue
    MatrizCorrienteTest(:,count) = Struct.MatrizCorriente(:,(Filas*(j(count)-1)+ i(count)));
end
clear i j;
Struct.MatrizCorrienteTest = MatrizCorrienteTest;

end