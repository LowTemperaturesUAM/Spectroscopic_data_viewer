function [radii, Average] = radialAverage_angular(M, center, radii, angles)
% Calculates radial profile from a 2D matrix. It can be selected the
% origin, size and direction of the profile.

%-------------------------------------------------------------------------
%   Inputs:
%   M           : 2D Matrix to calculate profile
%   center      : 1x2 Array of the origin of the radial profile in pixels
%           The 1st value corresponds to X, which is the matrix's column, 
%           and the 2nd value is Y, the matrix's row.
%   radii       : Array of distances in pixels for which to perform average
%   
%   angles      : Array of angles over which to perform the average.
%           They should have an odd number of points (even number of intervals).
%           Number of angle points should increase with total size, so it does
%           not skip many values

%-------------------------------------------------------------------------
% Default values
center_default = ceil(fliplr(size(M)+1)/2);
%rad_default = linspace(0, ceil(min(size(M)/2)), length(M));
rad_default = 0:1:sqrt(sum(size(M).^2))/2-1;

% Assume a complete radial average and avoid repeating 0 degrees.
ang_default = 0:0.1:359.9; 

if nargin < 2 || isempty(center)
    center = center_default;
else
    center = round(center);
end

if nargin < 3 || isempty(radii)
    radii = rad_default;
end

if nargin < 4 || isempty(angles)
    angles = ang_default;
else
    angles = sort(angles);


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

end

Average = nan(1,length(radii));
idx = 0;

% Calculate circle arcs for every radius
for r = radii
    idx = idx+1;

    % Avoid rounding error in first pixel when r==0.5
    if abs(r-0.5)<6*eps
        r = 0.5-5*eps;
    end
    
    % Store circle coordinates
    x = center(1) + r.*cosd(angles);
    y = center(2) + r.*sind(angles);

    % Obtain pixel coordinates over which the arc passes through
    pixels = round([x; y]');

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
radii = radii(~isnan(Average));    
Average = Average(~isnan(Average));

% Inform how many circles are outside the image. 
if nancount
    disp(['There are ', num2str(nancount), ' distance values outside the image.'])
end
end

