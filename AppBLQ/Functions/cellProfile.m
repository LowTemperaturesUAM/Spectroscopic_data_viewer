function [ProfileCell,xp,yp,w] = cellProfile(Cell,start1,start2,final1,opt)
arguments
    Cell cell
    start1 (:,2) {mustBeFinite}
    start2 (:,2) {mustBeFinite}
    final1 (:,2) {mustBeFinite}
    opt.Method {mustBeMember(opt.Method,{'nearest','bilinear','bicubic'})} = 'bilinear'
    opt.XLim (:,2) {mustBeFinite} = [0, size(Map,2)] 
    opt.YLim (:,2) {mustBeFinite} = [0, size(Map,1)]
end
%Assume all cells have equal size and dimensions
ProfileCell = cell(size(Cell));
[ProfileCell{1},xp,yp,w] = multiprofile(Cell{1},start1,start2,final1,...
    Method=opt.Method,XLim=opt.XLim,YLim=opt.YLim);
for i = 2:numel(Cell)
    ProfileCell{i} = multiprofile(Cell{i},start1,start2,final1,...
    Method=opt.Method,XLim=opt.XLim,YLim=opt.YLim);
end

end