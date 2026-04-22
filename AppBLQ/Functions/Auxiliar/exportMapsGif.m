function exportMapsGif(Cell,Contrast,Colormap,Path,Name,opts)
arguments
    Cell cell
    Contrast (2,:) double
    Colormap (:,3) double {mustBeNonnegative,mustBeLessThanOrEqual(Colormap,1)}
    Path  {mustBeFolder}
    Name
    opts.DelayTime = 0.2
    opts.LoopCount = Inf
end
% New = rescale(Map,InputMin=0,InputMax=1);
FullName =[Path,filesep,Name,'.gif'];
N = size(Colormap,1)-1;
% for k = 1:numel(Cell)
%     New = flipud(1+N*mat2gray(Cell{k},Contrast(:,k).'));
%     % New = uint8(flipud(N*mat2gray(Cell{k},Contrast(:,k).')));
%     min(New,[],'all')
%     max(New,[],'all')
%     whos('New')
%     % ColorImg = ind2rgb(New,Colormap);
%     imwrite(New,Colormap,FullName,WriteMode ="append")
% end

% celldisp(mat2cell(Contrast,2,ones([numel(Cell),1])))
% New = cellfun(@(C)flipud(1+N*mat2gray(C,Contrast(:,1).')),Cell,UniformOutput=false);
CellContrast = mat2cell(Contrast.',ones([numel(Cell),1]),2);
New = cellfun(@(M,C)flipud(1+N*mat2gray(M,C.')),...
    Cell,CellContrast,UniformOutput=false);
IMGs =cell2mat(reshape(New,[1 1 1 numel(New)]));

imwrite(IMGs,Colormap,FullName,DelayTime = opts.DelayTime,LoopCount =opts.LoopCount)
end