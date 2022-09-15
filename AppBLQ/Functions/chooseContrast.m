function [contrastValues] = chooseContrast(testContrast, minLimit, maxLimit)
%   testContrast is an array of 2 values, corresponding to the Min and Max
%   contrast values, used as a test.
% This function checks if testContast is indeed between The Min and max
% Limits. If this is not the case, it gives the corresponding limit.
contrastValues = testContrast;
limits = [minLimit; maxLimit];
checkInside = testContrast >= minLimit & testContrast <= maxLimit;
contrastValues(~checkInside) = limits(~checkInside);

end

