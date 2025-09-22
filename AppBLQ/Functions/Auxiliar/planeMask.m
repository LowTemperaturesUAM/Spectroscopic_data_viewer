function NewMatrix = planeMask(Matrix, Mask, opts)
arguments
    Matrix {mustBeReal,mustBeFinite}
    Mask = zeros(size(Matrix),'logical')
    opts.KeepOffset {mustBeLogical} = true
end
% This function fits the input matrix to a global plane, and returns the matrix
% with the plane substracted
% INPUT:
% Matrix: the desired matrix to be fit
% Mask: an logical array of the same size of Matrix with the points to be
% discarded in the fit set to true. By default, the function will consider all
% the image points (i.e. full matrix set as false)
% Optional arguments:
% KeepOffset: If true, the average value of the matrix is not substracted
[Row,Col] = size(Matrix);
[x, y ] = meshgrid(1:Row,1:Col);
X = [ones(Row*Col,1),x(:),y(:)];
M = X(~Mask(:),:)\Matrix(~Mask(:));
if opts.KeepOffset %ignore the constant term in the fit
    NewMatrix = Matrix - reshape(X(:,2:3)*M(2:3),Row,Col);
else
    NewMatrix = Matrix - reshape(X*M,Row,Col);
end

end