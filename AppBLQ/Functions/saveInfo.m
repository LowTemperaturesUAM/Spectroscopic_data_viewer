function saveInfo(App, FullStruct)

% global Transformadas
% global DistanciaFourierColumnas
% global DistanciaFourierFilas
% global DistanciaColumnas
% global DistanciaFilas
% global Energia
% global TamanhoRealColumnas
% global TamanhoRealFilas
% global ParametroRedColumnas
% global ParametroRedFilas
% global MatrizNormalizada
% global MapasConductancia
% global Voltaje
% global PuntosDerivada
% global SaveFolder
% evalin('base','PuntosDerivada')
% Transformadas                           = evalin('base','Transformadas');
% MapasConductancia                       = evalin('base','MapasConductancia');
% 
% InfoStruct.DistanciaFourierColumnas     = evalin('base','DistanciaFourierColumnas');
% InfoStruct.DistanciaFourierFilas        = evalin('base','DistanciaFourierFilas');
% InfoStruct.DistanciaColumnas            = evalin('base','DistanciaColumnas');
% InfoStruct.DistanciaFilas               = evalin('base','DistanciaFilas');
% InfoStruct.Energia                      = evalin('base','Energia');
% InfoStruct.TamanhoRealColumnas          = evalin('base','TamanhoRealColumnas');
% InfoStruct.TamanhoRealFilas             = evalin('base','TamanhoRealFilas');
% InfoStruct.ParametroRedColumnas         = evalin('base','ParametroRedColumnas');
% InfoStruct.ParametroRedFilas            = evalin('base','ParametroRedFilas');
% InfoStruct.MatrizCorriente              = evalin('base','MatrizCorriente');
% InfoStruct.MatrizNormalizada            = evalin('base','MatrizNormalizada');
% InfoStruct.PuntosDerivada               = evalin('base','PuntosDerivada');
% InfoStruct.Voltaje                      = evalin('base','Voltaje');
% InfoStruct.Bias                         = InfoStruct.Voltaje(1);
% InfoStruct.Colormap                     = bone;

% %Pasamos 'Transformadas' y 'MapasConductancia' a una cell mejor
% %estructurada
% MapasConductanciaNuevo = cell(1,length(InfoStruct.Energia));
% TransformadasNuevo = cell(1,length(InfoStruct.Energia));
% for k=1:length(InfoStruct.Energia)
%     MapasConductanciaNuevo{k} = MapasConductancia{k};
%     TransformadasNuevo{k} = Transformadas{k};
% end
% InfoStruct.MapasConductancia = MapasConductanciaNuevo;
% InfoStruct.Transformadas = TransformadasNuevo;


% %save([FilePath, 'infostruct.mat'], 'InfoStruct');

% Choose the name of the saved infostruct
InfoStruct = App.InfoStruct;
if isfield(FullStruct,'SaveFolder')
    %[SaveFolder] = uigetdir(FullStruct.SaveFolder,'Save InfoStruct');
    [StructName, SaveFolder] = uiputfile('*.mat','Save Struct',...
        [FullStruct.SaveFolder filesep 'infostruct.mat']);
else %if we don't have a directory, we just default to the current one
    %[SaveFolder] = uigetdir('','Save InfoStruct');
    [StructName, SaveFolder] = uiputfile('*.mat','Save Struct','infostruct.mat');
end
% generate another copy of Struct with just the relevant fields
savefields = {'FileName','Campo',...
              'Temperatura','Filas',...
              'Columnas','IV'};
allfields = fieldnames(FullStruct);
if ~isequal(StructName,0)
    if all(isfield(FullStruct,savefields))
        %Remove all fields but the ones we want to save
        Struct = rmfield(FullStruct,allfields(~ismember(allfields,savefields)));
        %save([SaveFolder filesep 'infostruct.mat'], 'InfoStruct','Struct');
        save([SaveFolder StructName], 'InfoStruct','Struct');
        msgbox('InfoStruct succesfully saved with info.','You are amazing','help')
    else
        %save([SaveFolder filesep 'infostruct.mat'], 'InfoStruct');
        save([SaveFolder StructName], 'InfoStruct');
        msgbox('InfoStruct succesfully saved.','You are amazing','help')
    end
end
end