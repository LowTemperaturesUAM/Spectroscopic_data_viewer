function Data = loadIMG(Name,Path,readimg)
% Function to read old .img topography files
% INPUT:
% Name: Name of the file to be read
% Path: Path of the file, not including the name
% readimg(optional): if set to false, the datamatrix will not be read
%                    if set to true or not provided, it will read the
%                    datamatrix normally
% OUTPUT:
% Data: struct containing the fields
%   identifier,version: int32 values about the type of file
%   day,month,year: date the image was taken
%   tstart: initial time of day in seconds the image was started
%   time: time elapsed during the image adquisition in seconds
%   xrange,yrange : initial and final position of in metesr on each axis
%   rows,cols : pixel dimensions of the image
%   padding: padding bytes of the image header
%   comment: comment string of the image header
%   image: matrix containing the image data in meters or amps, for
%           topography or current maps, respectively
%   direction: (Forth/Back) image scanning direction, if available
%   type: Current/Topo type of image contained in the file


if nargin == 3
    if islogical(readimg)
    readall = readimg;
    elseif isscalar(readimg)
        readall = (readimg~=0);
    else
        warning('The value provived to readimg is not a logical value or scalar')
        Data = struct();
        return
    end
else 
    readall = true;
end

FileIMG=fopen([Path Name],'r');
Data = struct();
% identifier and version
b1 = fread(FileIMG,2,'int32');
Data.identifier = b1(1);
Data.version = b1(2);
% day, month and year
Date = fread(FileIMG,3,'uint16=>double');
Data.day = Date(1); %day of the month: [1,31]
Data.month = Date(2); %month of the year: [1,12]
Data.year = Date(3); 
% moment and time (seconds of day and final-start)
time = fread(FileIMG,2,'double');
Data.tstart = time(1); %seconds of day at the start of the image
Data.time = time(2); %time elapsed in seconds during the image adquisition
% Xstart, Xend in meters
RealXLim = fread(FileIMG,2,'double');
Data.xrange = RealXLim; %Initial and final position in meters on the X axis
% Ystart, Yend in meters
RealYLim = fread(FileIMG,2,'double');
Data.yrange = RealYLim; %Initial and final position in meters on the Y axis
% Struct.TamanhoRealColumnas = diff(RealXLim)*1e9;
% Struct.TamanhoRealFilas = diff(RealYLim)*1e9;
Msize = fread(FileIMG,2,'int32=>double');
% if Msize(1)==Msize(2)
%     TopoLineas=Msize(1);
% end
Data.rows = Msize(1);
Data.cols = Msize(2);
% empty space
Data.padding = fread(FileIMG,450,'char*1=>uchar')'; %raw values on the header padding
% Comment
comment = fread(FileIMG,512,'char*1=>char').';
comment = deblank(comment); %remove trailing null characters
Data.comment = convertCharsToStrings(comment);
% Extract whether is back or forth image from the name, if possible
Type = Name(end-5:end-4);
switch Type
    case 'ih' %Topography forward
        Data.direction = 'Forth';
        Data.type = 'Topo';
    case 'vh' %Topography backward
        Data.direction = 'Back';
        Data.type = 'Topo';
    case 'ic' %Current forward
        Data.direction = 'Forth';
        Data.type = 'Current';
    case 'vc' %Current backward
        Data.direction = 'Back';
        Data.type = 'Current';
    otherwise %if the name is different, we just leave it blank
        Data.direction = [];
        Data.type = [];
end
if readall
    try
        Matrix = fread(FileIMG,Msize.','single=>double');
        Data.image = rot90(Matrix,-1);
    catch
        warning('The image could not be read.')
        Data.image = [];
    end
else
    Data.image = [];

end