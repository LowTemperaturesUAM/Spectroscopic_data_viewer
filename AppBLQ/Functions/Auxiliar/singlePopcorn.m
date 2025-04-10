function [MatrizTopoCorr] = singlePopcorn(MatrizTopo,sigma)
% singlePopcorn(M,sigma) makes the 'popcorn filter' to the matrix M. It
% consists in replacing values outside LIM with the average of a 3x3 window 
% around the values, excluding those outside LIM. The interval LIM is 
% defined as the mean value of M +/- its standard deviation times the input
% sigma, i.e. [mean-sigma*std, mean+sigma*std].


    L=length(MatrizTopo);
    M=mean(MatrizTopo,"all");
    S=std(MatrizTopo,1,'all');
    % Initialize results and auxiliar matrix
    MatrizTopoCorr=MatrizTopo;
    BadPointsMatrix=ones(L,'logical'); % Determines which values to replace

    % Check if values are outside the specified limits. If so, BadPoint=0
    for i=1:L
        for j=1:L
            if MatrizTopo(i,j) > M+sigma*S || MatrizTopo(i,j) < M-sigma*S
                BadPointsMatrix(i,j)=0;
            end
        end
    end
    % Or, in 1 line
    % BadPointsMatrix(MatrizTopo>M+sigma*S | MatrizTopo<M-sigma*S) = 0;

    for i=2:L-1
        for j=2:L-1
            if ~BadPointsMatrix(i,j) % Value needs correction
                % Window around value with not valid pixels turned 0
                neigh=MatrizTopo(i-1:i+1,j-1:j+1).*BadPointsMatrix(i-1:i+1,j-1:j+1);

                % Number of valid values in window
                window = sum(BadPointsMatrix(i-1:i+1,j-1:j+1),"all");

                % If no point in window is valid, use average of already
                % corrected neighbour pixels (should be 3 pixels, as it is
                % still running).
                if window == 0 % All window is not valid values.
                    MatrizTopoCorr(i,j) = 0;
                    MatrizTopoCorr(i,j) = sum(MatrizTopoCorr(i-1:i,j-1:j),"all")/3;
                else
                    % Corrected value as average of valid points in window
                    MatrizTopoCorr(i,j)=sum(neigh,'all')/window;
                end
            end
        end
    end
    assert(~any(isnan(MatrizTopoCorr),'all'),'The matrix includes some NaN values')
end