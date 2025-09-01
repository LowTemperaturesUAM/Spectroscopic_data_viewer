function [profile,xp,yp,w]=multiprofile(Map,start1,start2,final1,opt)
arguments
    Map double {mustBeFinite}
    start1 (:,2) {mustBeFinite}
    start2 (:,2) {mustBeFinite}
    final1 (:,2) {mustBeFinite}
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.XLim (:,2) {mustBeFinite} = [0, size(Map,2)] 
    opt.YLim (:,2) {mustBeFinite} = [0, size(Map,1)]
end
% [profile,xp,yp,w] = multiprofile(Map,start1,start2,final1,opt)
% final2 = final1+start2-start1;
% theta = atan2d(final1(2)-start1(2),final1(1)-start1(1));
%obtain the start coordinates for each of the line profiles
[xq,yq,~] = improfile(opt.XLim,opt.YLim,Map,...
    [start1(1),start2(1)],[start1(2),start2(2)]);
w = numel(xq);
%take the first profile and obtain the coordinates along the line
[xp,yp,profile] = improfile(opt.XLim,opt.YLim,Map,...
    [start1(1),final1(1)],[start1(2),final1(2)],opt.Method);
for i = 2:numel(xq)
    inew = [xq(i),yq(i)];
    fnew = [xq(i),yq(i)]-start1+final1;
    profile = profile + improfile(opt.XLim,opt.YLim,Map,...
    [inew(1),fnew(1)],[inew(2),fnew(2)],opt.Method);
end
profile = profile/w;
end