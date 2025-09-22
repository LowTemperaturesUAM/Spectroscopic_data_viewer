function [OutMat,Offset] = FlattenParabola(Matrix,Mask,opts)
arguments
    Matrix
    Mask = zeros(size(Matrix),'logical')
    opts.direction {mustBeMember(opts.direction,{'horizontal','vertical','both'})} = 'horizontal'
    opts.BadPoints {mustBeMember(opts.BadPoints,{'ignore','move'})} = 'move'
    opts.KeepOffset {mustBeLogical} = true
end
% Flatten a map removing parabolas line by line using an optional mask.
% The mask is a logical array the size of the image with values set to true if
% they want to be discarded. By default, they are all set to false so the whole
% image is considered
[Row,Col] = size(Matrix);
%Check that the size of the mask is the same as the image
if any([Row,Col] ~= size(Mask))
    error('Incorrect mask size')
end

switch opts.direction
    case 'horizontal' %have to flip the matrix back and forth
        if any(all(Mask,2))
            error(['The mask provided marks a whole row or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each row'])
        end
        X = [ones(Col,1),(1:Col).',(1:Col).'.^2];
        Ms = zeros(3,Row);
        for i=1:Row
            Ms(:,i) = X(~Mask(i,:),:)\Matrix(i,~Mask(i,:)).';
        end
        Offset = mean(Ms(1,:));
        OutMat = Matrix - (X*Ms).';

    case 'vertical'
        if any(all(Mask,1))
            error(['The mask provided marks a whole column or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each column'])
        end
        X = [ones(Row,1),(1:Row).',(1:Row).'.^2];
        Ms = zeros(3,Col);
        for i=1:Col
            Ms(:,i) = X(~Mask(:,i),:)\Matrix(~Mask(:,i),i);
        end
        Offset = mean(Ms(1,:));
        OutMat = Matrix - X*Ms;

    case 'both' %apply row and col sequentially
        if any(all(Mask,1)) || any(all(Mask,2))
            error(['The mask provided marks a whole row or column or the map ' ...
                'The algorithm will not work. Make sure at least one ' ...
                'point remais usable on each row and column'])
        end

        Xr = [ones(Col,1),(1:Col).',(1:Col).'.^2];
        Msr = zeros(3,Row);
        for i=1:Row
            Msr(:,i) = Xr(~Mask(i,:),:)\Matrix(i,~Mask(i,:)).';
        end
        Offset = mean(Msr(1,:));
        TempMat = Matrix - (Xr*Msr).';

        Xc = [ones(Row,1),(1:Row).',(1:Row).'.^2];
        Msc = zeros(3,Col);
        for i=1:Col
            Msc(:,i) = Xc(~Mask(:,i),:)\TempMat(~Mask(:,i),i);
        end
        OutMat = TempMat - Xc*Msc;
end
%Add the overall image offset back if selected
if opts.KeepOffset
    OutMat = OutMat + Offset;
end
%Restore the masked points to the original values if selected
switch opts.BadPoints
    case 'ignore'
        OutMat(Mask) = Matrix(Mask); 
end

end