function killFFT_v2
a = gcf;
Fig2Close = a.Name;
delete(a)
ax = findall(0,'tag','FFTAxes');
%Vamos a borrar los cuadros de todos, para evitar confusiones
for ind = 1:size(ax,1)
    num = length(ax(ind).Children);
    j=0;
    borra = [];
    for i=1:num
         if strcmp(ax(ind).Children(i).Tag,Fig2Close)
            j = j+1;
            borra(j) = i;
         end   
    end
    delete(ax(ind).Children(borra))
    ax(ind).ColorOrderIndex = 1;
end

end