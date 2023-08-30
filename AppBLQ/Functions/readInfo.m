function [Info,Settings] = readInfo()
try
    Var1 = evalin('base', 'InfoStruct');
    if isstruct(Var1)
        Info = Var1;
    else
        Info = struct([]);
    end
catch
    Info = struct([]);
end
try
    Var2 = evalin('base', 'Struct');
    if isstruct(Var2)
        Settings = Var2;
    else
        Settings = struct([]);
    end
catch
    Settings = struct([]);
end
end