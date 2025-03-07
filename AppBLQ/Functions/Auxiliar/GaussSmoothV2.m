function FilterMaps = GaussSmoothV2(Maps,row,col,sigma,opts)
arguments
    Maps
    row double {mustBeVector}
    col double {mustBeVector}
    sigma double {mustBePositive,mustBeFinite}
    opts.Padding string {mustBeMember(opts.Padding,{'circular','replicate','symmetric','value','average'})} = 'replicate'
    opts.PaddingValue (1,1) double {mustBeFinite} = 0;
end
%convert the width of the distribution to pixel units
if numel(sigma)>2
    error('The standard deviation of the filter must be a scalar or a 2 element vector')
end
drow = abs(row(2)-row(1));
dcol = abs(col(2)-col(1));
srow = sigma(1)/drow;
scol = sigma(end)/dcol;

%Check if the standard deviation is square or not
if abs((srow-scol)/scol)<1e-3
    sigmapix = srow;
else
    sigmapix = [srow,scol];
end
meanFlag = false;
switch opts.Padding
    case {'circular','replicate','symmetric'}
        Method = opts.Padding;
    case 'average'
        meanFlag = true;
    otherwise
        Method = opts.PaddingValue;
end
if iscell(Maps)
    %assume all maps in the cell have equal size
    Size = floor(size(Maps{1})/2); %Take half the image size
    Size = Size + mod(Size+1,2); %Make sure its odd in size
    if meanFlag
        FilterMaps = cellfun(@(M) imgaussfilt(M,sigmapix,Padding=mean(M,"all"),...
            FilterSize=Size),Maps,UniformOutput=false);
    else
        FilterMaps = cellfun(@(M) imgaussfilt(M,sigmapix,Padding=Method,FilterSize=Size),...
            Maps,UniformOutput=false);
    end
elseif ismatrix(Maps)
    Size = floor(size(Maps)/2)+1;
    if meanFlag 
        Method = mean(M,"all");
    end
    FilterMaps = imgaussfilt(Maps,sigmapix,Padding=Method,FilterSize=Size);
else
    error('The provided input is not an array or a cell array')
end
end