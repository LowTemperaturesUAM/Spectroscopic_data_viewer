function [Struct] = changeCurves(App, Struct)

Columnas = Struct.Columnas;
Filas = Struct.Filas;
NumeroCurvasValue = App.CurvestoshowEditField.Value;

% Random index for curve selection
MatrizCorrienteTest = Struct.MatrizCorriente(:,randi(Filas*Columnas,1,NumeroCurvasValue));
        
Struct.MatrizCorrienteTest = MatrizCorrienteTest;

end