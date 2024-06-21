function [radii, Average,angles] = radialAverage_real(M,X,Y, opt)
arguments
    M double {mustBeFinite}
    X double {mustBeVector,mustBeFinite}
    Y double {mustBeVector,mustBeFinite}
    opt.center {mustBeVector,mustBeFinite} = [0,0]
    opt.radii {mustBeVector,mustBeFinite} = 0:1:max(abs(X),abs(Y),'all')
    opt.angles {mustBeVector,mustBeFinite} = 0:0.1:359.9 
end
if size(M,2) ~= numel(X) || size(M,1) ~= numel(Y)
    return
end
angles = sort(opt.angles);
if abs(diff(angles([1, end]))/360 - 1) < 5*eps
    disp('Complete cycle')
    % Make sure that in a complete cycle there are odd number of points.
    if ~mod(numel(angles),2)
        disp('Convert to odd length')
        angles = linspace(angles(1),angles(end),numel(angles)+1);
    end
    % Remove last value as it repeats the first one.
    angles(end) = [];
end

Average = nan(1,length(opt.radii));
idx = 0;

for r = opt.radii
    idx = idx+1;

    % Avoid rounding error in first pixel when r==0.5
    if abs(r-0.5)<6*eps
        r = 0.5-5*eps;
    end
    
    % Store circle coordinates
    x = opt.center(1) + r.*cosd(angles);
    y = opt.center(2) + r.*sind(angles);
    % size(X')
    % size(x)

    % Convert to pixels
    [~,xpix] = min(X'-x,[],ComparisonMethod="abs");
    [~,ypix] = min(Y'-y,[],ComparisonMethod="abs");
     
    pixels = ([xpix;ypix].');

    % Exclude pixels outside the image
    condOutside = any(pixels>fliplr(size(M)) | pixels<1, 2);
    pixels(condOutside,:) = [];

    % Replace pixel with linear index. Since 2nd dimension becomes X and
    % 1st dimension becomes Y, the order is switched.
    pixelInd = sub2ind(size(M), pixels(:,2), pixels(:,1));

    Average(idx) = sum(M(pixelInd))./numel(pixelInd);
    %Average(idx) = sum(M(pixelInd)); %To check absolute value

end
nancount = nnz(isnan(Average));
% Give as output array values without NaN in the average
radii = opt.radii(~isnan(Average));  
Average = Average(~isnan(Average));

% Inform how many circles are outside the image. 
if nancount
    disp(['There are ', num2str(nancount), ' distance values outside the image.'])
end

end