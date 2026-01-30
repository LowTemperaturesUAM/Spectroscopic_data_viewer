function [profile,xp,yp,w]=multiprofile(Map,start1,start2,final1,opt)
arguments
    Map {mustBeFinite}
    start1 (:,2) {mustBeFinite}
    start2 (:,2) {mustBeFinite}
    final1 (:,2) {mustBeFinite}
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.XLim (:,2) {mustBeFinite} = [0, size(Map,2)] 
    opt.YLim (:,2) {mustBeFinite} = [0, size(Map,1)]
end
% INPUTS:
% Map: Target image for the profile
% start1: (x,y) coordinates of the starting point of the first profile
% start2: (x,y) coordinates of the starting point of the last profile
% final1: (x,y) coordinates of the final point of the first profile
%   this three coordilates uniquely define a paralelogram as well as a direction
%   where the averaged profile will be calculated
% OPTIONAL INPUTS
% Method: choose the method of interpolation for the profiles values
% XLim: Coordinates of the first and last point of the image along the x
% direction.By default, first and last are place at the origin and the number
% of columns of the image respectively
% YLim: Coordinates of the first and last point of the image along the y
% direction. By default, first and last are place at the origin and the number
% of rows of the image respectively
%
% OUTPUTS:
% profile: averaged profile on the desired area
% xp: x coordinates of each point for the first profile taken
% yp: y coordinates of each point for the first profile taken
% w: number of profiles used for the average
%
% The remaining point of the paralelogram can be easily obtained using the
% expresion:
%   final2 = final1+start2-start1
% The angle with the x axis (clockwise) can also be obtain using:
%   theta = atan2d(final1(2)-start1(2),final1(1)-start1(1))



%obtain the start coordinates for each of the line profiles
%we simulate a profile on the perpendicular direction and let the function
%heuristics choose how many profiles to take
[xq,yq,~] = improfile(opt.XLim,opt.YLim,Map,...
    [start1(1),start2(1)],[start1(2),start2(2)]);
w = numel(xq);

%take the first profile and obtain the coordinates along the line
[xp,yp,profile] = improfile(opt.XLim,opt.YLim,Map,...
    [start1(1),final1(1)],[start1(2),final1(2)],opt.Method);
offset = final1-start1; %coordinate offset between start and end of each profile
for i = 2:numel(xq)
    inew = [xq(i),yq(i)];
    fnew = [xq(i),yq(i)]+offset;
    profile = profile + improfile(opt.XLim,opt.YLim,Map,...
    [inew(1),fnew(1)],[inew(2),fnew(2)],opt.Method);
end
profile = profile/w;
end