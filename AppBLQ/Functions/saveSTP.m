function saveSTP(Path,Map,RowSize,ColSize,unitlabel,opt)
arguments
    Path {mustBeNonzeroLengthText}
    Map double {mustBeFinite,mustBeReal}
    RowSize {mustBeNonnegative,mustBeFinite}
    ColSize {mustBeNonnegative,mustBeFinite}
    unitlabel {mustBeNonzeroLengthText} = 'a.u.'
    opt.Real logical = true;
end
[filepath,name,ext]=fileparts(Path);
if ~isempty(filepath) && ~isfolder(filepath)
    error('Invalid path, folder %s cannot be found',filepath)
elseif ~isempty(ext) && ~strcmp(ext,'.stp')
    disp('Wrong extension!')
    return
end

if isempty(ext)
    stpID=fopen([Path '.stp'],'w');
else
    stpID=fopen(Path,'w');
end
fprintf(stpID,'WSxM file copyright UAM\r\n');
fprintf(stpID,'SxM Image file\r\n');
fprintf(stpID,'Image header size: 0\r\n');
fprintf(stpID,'[Control]\r\n\r\n');
if opt.Real
    fprintf(stpID,'    X Amplitude: %.2f nm\r\n',ColSize);
    fprintf(stpID,'    Y Amplitude: %.2f nm\r\n',RowSize);
else
    fprintf(stpID,'    X Amplitude: %.4f 1/nm\r\n',ColSize);
    fprintf(stpID,'    Y Amplitude: %.4f 1/nm\r\n',RowSize);
end
fprintf(stpID,'\r\n[General Info]\r\n\r\n'); %µ char(181)
fprintf(stpID,'    Image Data Type: double\r\n');
fprintf(stpID,'    Number of rows: %i\r\n    Number of columns: %i\r\n',size(Map));
fprintf(stpID,'    Z Amplitude: 1 %s\r\n',unitlabel);
fprintf(stpID,'[Miscellaneous]\r\n\r\n');
fprintf(stpID,'    Saved with version: blqApp\r\n');
fprintf(stpID,'    Z Scale Factor: 1\r\n');
fprintf(stpID,'    Z Scale Offset: 0\r\n');
fprintf(stpID,'\r\n[Header end]\r\n');
fwrite(stpID,rot90(Map),'double','l');
fclose(stpID);

fprintf('Image saved as %s\n', [name ext])
end
