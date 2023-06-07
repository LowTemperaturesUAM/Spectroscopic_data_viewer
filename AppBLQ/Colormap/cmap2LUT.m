% Converts a given colormap matrix into a .lut file to for use in WSxM
% Example: cmap2LUT(parula,'Parula')
% Arguments: 
%   cmap: colormap matrix in standard form used in MATLAB

%   outputfile: string or character vector containing the name of the file
%       without the extension. File paths can also be included, but users
%       be warned as the output file will be overwritten
function cmap2LUT(cmap,outputfile)
R=255-floor(255*cmap(:,1));
G=255-floor(255*cmap(:,2));
B=255-floor(255*cmap(:,3));
N = size(cmap,1);
L = round(linspace(0,255,N));
fileID = fopen([outputfile,'.lut'],'w');
toph =sprintf('WSxM file copyright UAM\r\n');
toph = [toph,sprintf('New Format Palette. 2001\r\n')];
hcolors = '';
if 128>=N
    hcolors = [hcolors,sprintf('[Blue Info]\r\n\r\n')];
    for i=1:length(B)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L(i)),...
        sprintf(' %u)\r\n' ,B(i))];
    end
    hcolors = [hcolors,sprintf('    Number of Control Points: %u\r\n\r\n',i)];

    hcolors = [hcolors,sprintf('[Green Info]\r\n\r\n')];
    for i=1:length(G)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L(i)),...
        sprintf(' %u)\r\n' ,G(i))];
    end
    hcolors = [hcolors,sprintf('    Number of Control Points: %u\r\n\r\n',i)];

    hcolors = [hcolors,sprintf('[Red Info]\r\n\r\n')];
    for i=1:length(R)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L(i)),...
        sprintf(' %u)\r\n' ,R(i))];
    end
    hcolors = [hcolors,sprintf('    Number of Control Points: %u\r\n\r\n',i)];



% elseif 256<=N

else %if the number of points is larger, we have to downsample the map
    n=ceil(N/128);
    hcolors = [hcolors,sprintf('[Blue Info]\r\n\r\n')];
    for i=1:ceil(length(B)/n)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L((i-1)*n+1)),...
        sprintf(' %u)\r\n' ,B((i-1)*n+1))];
    end
    %Always include the very last point
    hcolors = [hcolors,sprintf('    Control Point %u:', i),...
    sprintf(' (%u ,', 255),...
    sprintf(' %u)\r\n' ,B(end)),...
    sprintf('    Number of Control Points: %u\r\n\r\n',i+1)];

    hcolors = [hcolors,sprintf('[Green Info]\r\n\r\n')];
    for i=1:ceil(length(G)/n)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L((i-1)*n+1)),...
        sprintf(' %u)\r\n' ,G((i-1)*n+1))];
    end
    %Always include the very last point
    hcolors = [hcolors,sprintf('    Control Point %u:', i),...
    sprintf(' (%u ,', 255),...
    sprintf(' %u)\r\n' ,G(end)),...
    sprintf('    Number of Control Points: %u\r\n\r\n',i+1)];



    hcolors = [hcolors,sprintf('[Red Info]\r\n\r\n')];
    for i=1:ceil(length(R)/n)
        hcolors = [hcolors,sprintf('    Control Point %u:', i-1),...
        sprintf(' (%u ,', L((i-1)*n+1)),...
        sprintf(' %u)\r\n' ,R((i-1)*n+1))];
    end
    %Always include the very last point
    hcolors = [hcolors,sprintf('    Control Point %u:', i),...
    sprintf(' (%u ,', 255),...
    sprintf(' %u)\r\n' ,R(end)),...
    sprintf('    Number of Control Points: %u\r\n\r\n',i+1)];

end
hcolors = [hcolors,sprintf('[Palette Generation Settings]\r\n\r\n'),...
    sprintf('    Derivate Mode for the last blue Point: Automatic\r\n'),...
    sprintf('    Derivate Mode for the last green Point: Automatic\r\n'),...
    sprintf('    Derivate Mode for the last red Point: Automatic\r\n'),...
    sprintf('    Is there a particular palette index colored?: No\r\n'),...
    sprintf('    Smooth Blue: No\r\n'),...
    sprintf('    Smooth Green: No\r\n'),...
    sprintf('    Smooth Red: No\r\n\r\n')];

hcolors = [hcolors,sprintf('[Header end]\r\n')];

%Calculate the size of the text
hsize = numel(toph)+numel(hcolors)+23;
%Add the size of the number itself
hsize = numel(num2str(hsize)) + hsize;
toph = [toph,sprintf('Image header size: %u\r\n\r\n', hsize)];

fwrite(fileID,toph,"char");
fwrite(fileID,hcolors,"char");
fclose(fileID);
