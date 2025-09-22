function Out = removeBadPoints(Matrix,Mask,opts)
arguments
    Matrix {mustBeFinite}
    Mask {mustBeLogical}
    opts.InterpMethod {mustBeMember(opts.InterpMethod,...
        {'linear','nearest','natural'})} = 'natural'
end
%This function removes bad datapoints from the matrix and interpolates the new values
%using the rest of the image
%INPUTS:
%Matrix: image to be fixed
%Mask: logical array of the same size of the image. Datapoints to be replaced
%are marked as true
%optionally, you can specify the interpolation method used to calculate the new
%points. By default it uses natural interpolation
if all(size(Matrix) ~= size(Mask))
    error('The input mask does not match the size of the matrix')
end
[X,Y] = ndgrid(1:size(Matrix,1),1:size(Matrix,2));
rowMat = Matrix(~Mask);
NewGrid = scatteredInterpolant(X(~Mask),Y(~Mask),rowMat,opts.InterpMethod);

rowOut = NewGrid(X(:),Y(:));
Out = reshape(rowOut,size(Matrix));


end