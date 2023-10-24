function saveInfo(App, FullStruct)
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
        if App.EnableCompression.Checked
            save([SaveFolder StructName], 'InfoStruct','Struct');
        else
            save([SaveFolder StructName], 'InfoStruct','Struct','-nocompression');
        end
        msgbox('InfoStruct succesfully saved with info.','You are amazing','help')
    else
        if App.EnableCompression.Checked
            save([SaveFolder StructName], 'InfoStruct');
        else
            save([SaveFolder StructName], 'InfoStruct','-nocompression');
        end
        msgbox('InfoStruct succesfully saved.','You are amazing','help')
    end
end
end