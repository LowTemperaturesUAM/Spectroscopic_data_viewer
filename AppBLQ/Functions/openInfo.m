%Abre un archivo InfoStruct y lo almacena en una variable interna de la
%aplicación [Info] y en el workspace general [InfoStructOriginal]
function [Info,Settings] = openInfo()
[File,Path] = uigetfile('*.mat');
% disp(File)
if ~isequal(File,0)
    File = load([Path,File]);
    Info = File.InfoStruct;
    if isfield(File,'Struct')%exist('File.Struct','var')
        Settings = File.Struct;
        %disp('Loaded analysis info')
    else
        Settings = struct();
        %disp('No file information available')
    end
else
    Settings = struct();
    Info= struct();
    % assignin('base','InfoStructOriginal',Info);
end
end