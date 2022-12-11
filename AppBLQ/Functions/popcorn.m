function CellPopcorn = popcorn(Cell,sigma,Info)
CellPopcorn = Cell;

for k=1:length(Cell)
    MatrizTopo = Cell{k};
    L=length(MatrizTopo);
    M=mean(mean(MatrizTopo));
    S=std(MatrizTopo,1,'all');
    MatrizTopoCorr=MatrizTopo;
    BadPointsMatrix=ones(L);
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
                MatrizTopoCorr(i,j)=sum(sum(neigh))/(sum(sum(BadPointsMatrix(i-1:i+1,j-1:j+1))));
            else
                MatrizTopoCorr(i,j)=MatrizTopo(i,j);
            end
        end
    end
    CellPopcorn{k}=MatrizTopoCorr;
end

end