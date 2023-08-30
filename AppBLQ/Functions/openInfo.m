function [Info,Settings] = openInfo(File,Path)
File = load([Path,File]);
if isfield(File,'InfoStruct') && isstruct(File.InfoStruct)
    Info = File.InfoStruct;
else
    Info = struct([]);
end
if isfield(File,'Struct') && isstruct(File.Struct)
    Settings = File.Struct;
else
    Settings = struct([]);
end
end