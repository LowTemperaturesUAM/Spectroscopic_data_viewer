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
FullName =[Path,filesep,Name,'.gif'];
N = size(Colormap,1)-1;
CellContrast = mat2cell(Contrast.',ones([numel(Cell),1]),2);
New = cellfun(@(M,C)flipud(1+N*mat2gray(M,C.')),...
    Cell,CellContrast,UniformOutput=false);
IMGs =cell2mat(reshape(New,[1 1 1 numel(New)]));

imwrite(IMGs,Colormap,FullName,DelayTime = opts.DelayTime,LoopCount =opts.LoopCount)
end