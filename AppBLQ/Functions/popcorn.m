function CellPopcorn = popcorn(Cell,sigma,~)
CellPopcorn = Cell;

for k=1:length(Cell)
    MatrizTopo = Cell{k};
    L=size(MatrizTopo,1);
    M=mean(MatrizTopo,"all");
    S=std(MatrizTopo,1,'all');
    MatrizTopoCorr=MatrizTopo;
    BadPointsMatrix=ones(L,'logical');
    for i=2:L-1
        for j=2:L-1
            if MatrizTopo(i,j) > M+sigma*S || MatrizTopo(i,j) < M-sigma*S
                BadPointsMatrix(i,j)=0;
            end
        end
    end

    for i=2:L-1
        for j=2:L-1
            if BadPointsMatrix(i,j)==0
                neigh=MatrizTopo(i-1:i+1,j-1:j+1).*BadPointsMatrix(i-1:i+1,j-1:j+1);
                window = sum(BadPointsMatrix(i-1:i+1,j-1:j+1),"all");
                if window ==0
                    MatrizTopoCorr(i,j) = 0;
                    MatrizTopoCorr(i,j) = sum(MatrizTopoCorr(i-1:i,j-1:j),"all")/3;
                else
                MatrizTopoCorr(i,j)=sum(neigh,"all")/(sum(BadPointsMatrix(i-1:i+1,j-1:j+1),"all"));
                end
            else
                MatrizTopoCorr(i,j)=MatrizTopo(i,j);
            end
        end
    end
%     assert(all(~(MatrizTopoCorr > M+sigma*S | MatrizTopoCorr < M-sigma*S),'all'),'Values are outside the specified limits')
    assert(any(isnan(MatrizTopoCorr),'all'),'The matrix includes some NaN values')
    CellPopcorn{k}=MatrizTopoCorr;
end

end