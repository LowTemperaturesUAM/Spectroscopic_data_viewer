function [FlattenMatrix,Offset]= FlattenMask(Matrix,Mask,opts)
arguments
    Matrix
    Mask  = zeros(size(Matrix),'logical')
    opts.direction {mustBeMember(opts.direction,{'horizontal','vertical','both'})} = 'horizontal'
    opts.BadPoints {mustBeMember(opts.BadPoints,{'ignore','move'})} = 'move'
    opts.KeepOffset {mustBeLogical} = true
end
% Flatten a map removing offsets line by line using an optional mask.
% The mask is a logical array the size of the image with values set to true if
% they want to be discarded. By default, they are all set to false so the whole
% image is considered
[Row,Col] = size(Matrix);
%Check that the size of the mask is the same as the image
if any([Row,Col] ~= size(Mask))
    error('Incorrect mask size')
end

NanMatrix = Matrix;
NanMatrix(Mask)  = NaN;

Offset = mean(Matrix,"all","omitnan");
switch opts.direction
    case 'horizontal'
        if any(all(Mask,2))
            error(['The mask provided marks a whole row or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each row'])
        end
        FlattenMatrix = Matrix - mean(NanMatrix,2,"omitnan") ;
        % FlattenMatrix(Mask) = Matrix(Mask); %unaltered points
    case 'vertical'
        if any(all(Mask,1))
            error(['The mask provided marks a whole column or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each column'])
        end
        FlattenMatrix = Matrix - mean(NanMatrix,1,"omitnan");
        % FlattenMatrix(Mask) = Matrix(Mask); %unaltered points
    case 'both'
        if any(all(Mask,1)) || any(all(Mask,2))
            error(['The mask provided marks a whole row or column or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each row and column'])
        end
        FlattenMatrix = Matrix - mean(NanMatrix,2,"omitnan");
        FlattenMatrix = FlattenMatrix - mean(FlattenMatrix,1,"omitnan");
        % FlattenMatrix(Mask) = Matrix(Mask); %unaltered points
end
%Add the overall image offset back if selected
if opts.KeepOffset
    FlattenMatrix = FlattenMatrix + Offset;
end

%Restore the masked points to the original values if selected
switch opts.BadPoints
    case 'ignore'
        FlattenMatrix(Mask) = Matrix(Mask); %unaltered points
end

end
