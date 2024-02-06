function ACF = autocorr_builtin(A)
% -------------------------------------------------------
% Compute the statistical 2D autocorrelation of a matrix.
% -------------------------------------------------------
%
% ACF = autocorr_stat(A)
%
% Input
% -----
%
% A: Input matrix (must be 2D matrix)
% The input can be a gpuArray
%
% Output
% ------
%
% ACF: Output 2D auto-correlation (size(ACF) = 2 * size(A) - 1)

%Initialize output matrix
if isgpuarray(A)
    ACF = zeros(2 * size(A) - 1,"gpuArray");
else
    ACF = zeros(2 * size(A) - 1);
end

row0 = ceil(size(ACF, 1) / 2);
col0 = ceil(size(ACF, 2) / 2);
%Center value
ACF(row0,col0) = corr2(A,A);
%Along the major axis
for i = 1:size(A,1)-1
   ACF(row0+i,col0) = corr2(A(1:end-i,:),A((1+i):end,:));
   ACF(row0-i,col0) = ACF(row0+i,col0);
end
for j =1:size(A,2)-1
   ACF(row0,col0+j) = corr2(A(:,1:end-j),A(:,(1+j):end));
   ACF(row0,col0-j) = ACF(row0,col0+j);
end
%Everything else
for i = 1:size(A,1)-1
    for j = 1:size(A,2)-1
        ACF(row0+i,col0+j) = corr2(A(1:end-i,1:end-j),A((1+i):end,(1+j):end));
        ACF(row0-i,col0-j) = ACF(row0+i,col0+j);
        ACF(row0+i,col0-j) = corr2(A(1:end-i,(1+j):end),A((1+i):end,1:end-j));
        ACF(row0-i,col0+j) = ACF(row0+i,col0-j);
    end
end