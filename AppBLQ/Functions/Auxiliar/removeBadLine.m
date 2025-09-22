function Out = removeBadLine(Matrix,LinesToRemove,opts) %we could add cols as another argument later
arguments
    Matrix {mustBeFinite,mustBeReal}
    LinesToRemove (1,:) {mustBeInteger,mustBePositive}
    opts.InterpMethod {mustBeMember(opts.InterpMethod,...
        {'linear','nearest','next','previous','pchip','cubic','spline','makima'})} ...
        = 'makima'
    opts.axis {mustBeMember(opts.axis,{'rows','columns'})} = 'rows'
end
%This function removes bad lines from the matrix and interpolates the new values
%using the rest of the image
%INPUTS:
%Matrix: image to be fixed
%LinesToRemove: Column vector of the rows/columns to be removed. By default it
%assumes row wise, but can be set using the option axis
%optionally, you can specify the interpolation method used to calculate the new
%points. By default it uses makima
[N,M] = size(Matrix);
FullRows = 1:N;
FullCols = 1:M;
switch opts.axis
    case 'rows'
        NewRows = FullRows(all(FullRows ~= LinesToRemove',1));
        temp = Matrix(NewRows,FullCols);
        NewGrid = griddedInterpolant({NewRows,FullCols},temp,opts.InterpMethod);
        Out = NewGrid({FullRows,FullCols});
    case 'columns'
        NewCols = FullCols(all(FullCols ~= LinesToRemove',1));
        temp = Matrix(FullRows,NewCols);
        size(temp)
        NewGrid = griddedInterpolant({FullRows,NewCols},temp,opts.InterpMethod);
        Out = NewGrid({FullRows,FullCols});
end
