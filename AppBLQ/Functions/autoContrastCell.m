function Contrast = autoContrastCell(Cell,Threshold)
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
