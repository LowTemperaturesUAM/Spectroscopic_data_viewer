function Contrast = autoContrastCell(Cell,Threshold)
% Applies autoContrast function to each matrix of the cell array Cell,
% with parameter Threshold. 
% Cell must be a 1xN or Nx1 cell array. 
% Output Contrast will be a 2xN matrix, where first row is lower value.
arguments
    Cell (:,1)
    Threshold
end

Contrast = transpose(cell2mat(cellfun(@(M) autoContrast(M,Threshold),...
    Cell,UniformOutput=false)));

% Contrast = zeros([2,size(Cell,1)]);
% for i = 1:length(Cell)
%     Map = Cell{i};
%     [Count,edges] = histcounts(Map,Normalization = "cdf");
%     [Row,Column] = size(Map);
%     if any(isnan(Map),'all')
%         Badpts = sum(~isnan(Map),"all");
%         Count = Count*Row*Column/Badpts;
%     end
% 
%     if any(Count<Threshold,'all')
%         Min = max(edges(Count<Threshold));
%     else
%         Min = edges(1);
%     end
%     if any(Count>(1-Threshold),'all')
%         Max = min(edges(Count>(1-Threshold)));
%     else
%         Max = edges(end);
%     end
%     Contrast(:,i) = [Min Max];
% end

end
