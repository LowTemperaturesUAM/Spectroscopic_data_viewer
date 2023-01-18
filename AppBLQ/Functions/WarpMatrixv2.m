function [CellWarped] = WarpMatrixv2(Cell,XShear,YShear,YXratio,Info)
%We need to find out how to allow values for XYratio lower than 1
Columnas = length(Info.DistanciaFourierColumnas)
Filas    = length(Info.DistanciaFourierFilas)
tform = affine2d([1,YShear,0;-XShear,YXratio,0;0,0,1]);
%The first element is the equivalent parameter for XYratio but for the
%x-axis. We keep it in one as we only want to change the relative size of
% one axis to the other

    CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
        Cell,UniformOutput = false);
    %We calculate this for every map, but we can probably assume they are
    %all the same
%     CentroY = cellfun(@(x) size(x,1),...
%         CellWarpedAUX,UniformOutput = false);
%     CentroX = cellfun(@(x) size(x,2),...
%         CellWarpedAUX,UniformOutput = false);
    [TestFilas, TestColumnas] = size(CellWarpedAUX{1})
    %Compare if both are even/odd of othewise.
    parityFilas = mod(TestFilas,2) - mod(Filas,2);
   
    if parityFilas == 1 % Original was even, now its odd
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestFilas+1)/TestFilas)
        % tform = affine2d([1,YShear,0;-XShear,YXratio*(TestFilas+1)/TestFilas,0;0,0,1]);
        tform.T(2,2) = YXratio*(TestFilas+1)/TestFilas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        disp('New size:')
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1})
        %Sanity check
        assert((mod(TestFilas,2) - mod(Filas,2))==0)

    elseif parityFilas == -1 %Original was odd, now is even
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestFilas-1)/TestFilas)
        % tform = affine2d([1,YShear,0;-XShear,YXratio*(TestFilas-1)/TestFilas,0;0,0,1]);
        tform.T(2,2) = YXratio*(TestFilas-1)/TestFilas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        disp('New size:')
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1})
        %Sanity check
        assert((mod(TestFilas,2) - mod(Filas,2))==0)
    end

    parityColumnas = mod(TestColumnas,2) - mod(Columnas,2);


    if parityColumnas == 1 % Original was even, now its odd
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestColumnas+1)/TestColumnas)
%         tform = affine2d([1,YShear,0;-XShear,YXratio,0;0,0,1]);
        tform.T(1,1) = (TestColumnas+1)/TestColumnas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        disp('New size:')
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1})
        %Sanity check
        assert((mod(TestFilas,2) - mod(Filas,2))==0)

    elseif parityColumnas == -1 %Original was odd, now is even
        %We change the scaling slightly to make sure they match
        fprintf('Rescale by a factor %g\n',(TestColumnas-1)/TestColumnas)
%         tform = affine2d([1,YShear,0;-XShear,YXratio*(TestFilas-1)/TestFilas,0;0,0,1]);
        tform.T(1,1) = (TestColumnas-1)/TestColumnas;
        CellWarpedAUX = cellfun(@(x) imwarp(x,tform),...
            Cell,UniformOutput = false);
        disp('New size:')
        [TestFilas, TestColumnas] = size(CellWarpedAUX{1})
        %Sanity check
        assert((mod(TestFilas,2) - mod(Filas,2))==0)
    end
    
    NewFilas = TestFilas;
    NewColumnas = TestColumnas;
    CentroY = floor(NewFilas/2);
    CentroX = floor(NewColumnas/2);

    %In order to allow values of YXRatio lower than 1, we have to make
    %sure we fill the missing part of the matrix with zeros
    %We have to compare the number of rows of the initial image and the
    %warped one to see if it shrank or not. In the columns, its always
    %larger as we are only applying a shear transform
    if NewFilas >= Filas
    CellWarped = cellfun(@(x) ...
        x(CentroY-Filas/2+1:CentroY+Filas/2,...
        CentroX-Columnas/2+1:CentroX+Columnas/2),CellWarpedAUX,...
        UniformOutput = false);
    else
        CellWarped = cellfun(@(x) zeros(size(x)),Cell,UniformOutput=false);
        ptgap = (Filas-NewFilas)/2;
        for k = 1:numel(CellWarped)
            CellWarped{k}(1+ptgap:end-ptgap,:) = ...
                CellWarpedAUX{k}(:,CentroX-Columnas/2+1:CentroX+Columnas/2);
        end

    end
    
    clear CellWarpedAUX CellWarpedZoom ;
    clear CentroX CentroY FilasCellWarped ColumnasCellWarped;
    
end