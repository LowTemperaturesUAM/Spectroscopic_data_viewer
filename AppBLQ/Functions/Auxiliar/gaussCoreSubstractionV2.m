function [FilterMaps] = gaussCoreSubstractionV2(Maps,row,col,sigma)
arguments
    Maps
    row double {mustBeVector}
    col double {mustBeVector}
    sigma double {mustBePositive,mustBeFinite}
end
% Applies a filter to remove a gaussian core from an FFT map or a cell array of
% FFT maps. The maps are expected to be fftshifted beforehand

%Convert Sigma to pixels 
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

x0 = find(row == 0);
y0 = find(col == 0);
x = (1:1:numel(row))';
y = (1:1:numel(col));
MatrizFiltroFFT = -expm1(-((x-x0)/(sqrt(2)*sigmapix(1))).^2-((y-y0)/(sqrt(2)*sigmapix(end))).^2);

if iscell(Maps)
    FilterMaps = cellfun(@(x) x.*MatrizFiltroFFT,Maps,UniformOutput=false);
elseif ismatrix(Maps)
    FilterMaps = Maps.*MatrizFiltroFFT;
else
    error('The provided input is not an array or a cell array')
end

end